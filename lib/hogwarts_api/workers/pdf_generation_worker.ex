defmodule HogwartsApi.Workers.PdfGenerationWorker do
  use Oban.Worker, queue: :pdf_generation
  require Logger

  def perform(job) do
    FLAME.call(HogwartsApi.Flamethrower, fn ->
      Logger.info("Starting PDF generation job for #{inspect(job.args)}")
      url = job.args["url"]
      wait_for_attribute = job.args["wait_for_attribute"]
      wait_for_type = job.args["wait_for_type"]

      evaluate = %{
        expression: """
        const waitForAttribute = async (selector, attribute) => {
          while (!document.querySelector(selector)?.hasAttribute(attribute)) {
            await new Promise(resolve => requestAnimationFrame(resolve));
          }
        };
        waitForAttribute("#{wait_for_attribute}", "#{wait_for_type}");
        """
      }

      ChromicPDF.print_to_pdf({:url, url},
        evaluate: evaluate,
        output: fn path ->
          IO.inspect(path, label: "hey, woah")

          res =
            upload_file_to_s3(path, key = generate_safe_key(job.args["url"]))
            |> case do
              %{status_code: 200} -> key
              _ -> :error
            end

          case res do
            :error -> :error
            key -> generate_pdf_url(key)
          end
        end
      )
    end)
    |> case do
      {:ok, url} ->
        IO.inspect(url, label: "url - boiii")

        Absinthe.Subscription.publish(
          HogwartsApiWeb.Endpoint,
          %{url: url},
          export_complete: "export_complete_topic"
        )
        |> IO.inspect(label: "publish - hey")

        :ok

      :error ->
        :error
    end
  end

  def upload_file_to_s3(file, key) do
    IO.inspect(file, label: "File path")
    IO.inspect(key, label: "Key")

    operation =
      ExAws.S3.put_object(
        "hogwarts-test",
        key,
        File.read!(file),
        content_type: "application/pdf"
      )

    IO.inspect(operation, label: "S3 Operation")

    case ExAws.request(operation) do
      {:ok, response} ->
        IO.inspect(response, label: "S3 Success Response")
        response

      {:error, error} ->
        IO.inspect(error, label: "S3 Error")
        %{status_code: 500}
    end
  end

  def get_s3_object(key) do
    ExAws.S3.get_object("hogwarts-test", key)
    |> ExAws.request!()
  end

  def generate_pdf_url(key) do
    {:ok, url} =
      ExAws.S3.presigned_url(
        ExAws.Config.new(:s3),
        :get,
        "hogwarts-test",
        key,
        virtual_host: true,
        expires_in: 3600
      )

    url
  end

  defp generate_safe_key(url) do
    base = :crypto.hash(:sha256, url) |> Base.encode16(case: :lower)
    "pdfs/#{base}.pdf"
  end
end
