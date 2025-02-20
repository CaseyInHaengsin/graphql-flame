defmodule HogwartsApiWeb.Schema do
  use Absinthe.Schema

  import_types(HogwartsApiWeb.Schema.ContentTypes)
  # directive :connection_complexity do

  # end

  query do
    field :student_connection, non_null(:student_connection) do
      arg(:first, non_null(:integer))
      arg(:after, :string)
      arg(:sort, :string)

      complexity(fn %{first: limit}, _, complexity ->
        complexity.definition.selections
        |> Enum.map(fn
          %{name: "edges"} = field -> field.complexity * limit + 1
          field -> field.complexity
        end)
        |> Enum.sum()
      end)

      resolve(fn args, _ ->
        HogwartsApi.Beings.students_connection(args)
      end)
    end

    field :professors, non_null(list_of(non_null(:professor))) do
      arg(:limit, :integer, default_value: 10)
      arg(:skip, :integer, default_value: 0)

      resolve(fn args, _ ->
        {:ok, HogwartsApi.Beings.list_professors(args)}
      end)
    end

    field :sections, non_null(list_of(non_null(:section))) do
      resolve(fn _, _ ->
        {:ok, HogwartsApi.Scheduling.list_sections()}
      end)
    end
  end

  enum :house do
    value(:gryffindor)
    value(:hufflepuff)
    value(:ravenclaw)
    value(:slytherin)
  end

  mutation do
    field :echo, non_null(:string) do
      arg(:message, non_null(:string))

      resolve(fn %{message: message}, _ ->
        Absinthe.Subscription.publish(
          HogwartsApiWeb.Endpoint,
          message,
          echo: "echo_topic"
        )

        {:ok, message}
      end)
    end

    field :generate_pdf, non_null(:string) do
      arg(:url, non_null(:string))
      arg(:wait_for_attribute, :string)
      arg(:wait_for_type, :string)

      resolve(fn args, _ ->
        %{
          url: args.url,
          wait_for_attribute: args.wait_for_attribute,
          wait_for_type: args.wait_for_type
        }
        |> HogwartsApi.Workers.PdfGenerationWorker.new()
        |> Oban.insert()
        |> case do
          {:ok, _} ->
            {:ok, "PDF generation job enqueued"}

          {:error, _} ->
            {:error, "Failed to enqueue PDF generation job"}
        end
      end)
    end

    field :create_student, non_null(:student) do
      arg(:name, non_null(:string))
      arg(:house, non_null(:house))
      arg(:plot_armor, :boolean, default_value: false)

      resolve(fn args, _ ->
        case HogwartsApi.Beings.create_student(args) do
          {:ok, student} ->
            # Schedule the welcome email
            %{student_id: student.id}
            |> HogwartsApi.Workers.StudentWelcomeEmail.new()
            |> Oban.insert()

            {:ok, student}

          {:error, changeset} ->
            {:error,
             message: "Could not create student", details: format_changeset_errors(changeset)}
        end
      end)
    end
  end

  defp format_changeset_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end

  subscription do
    field :echo, non_null(:string) do
      config(fn _, _ ->
        IO.puts("yoyoyo")
        {:ok, topic: "echo_topic"}
      end)
    end

    field :export_complete, non_null(:export_result) do
      config(fn _, _ ->
        {:ok, topic: "export_complete_topic"}
      end)
    end
  end

  object :export_result do
    field :url, non_null(:string)
  end
end
