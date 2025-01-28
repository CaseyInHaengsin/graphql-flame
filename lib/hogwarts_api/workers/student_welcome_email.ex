defmodule HogwartsApi.Workers.StudentWelcomeEmail do
  use Oban.Worker, queue: :mailer
  require Logger

  @impl Oban.Worker
  def perform(job) do
    FLAME.call(HogwartsApi.Flamethrower, fn ->
      Logger.info("Starting welcome email job for student #{inspect(job)}")

      student = HogwartsApi.Beings.get_student!(job.args["student_id"])
      Logger.info("Found student: #{inspect(job.args)}")

      # Here you would implement your email sending logic
      # For example:
      # HogwartsApi.Mailer.deliver_welcome_email(student)
      # Absinthe.Subscription.publish(
      #   HogwartsApiWeb.Endpoint,
      #   "Welcome to Hogwarts, #{student.name}!",
      #   echo: "echo_topic"
      # )

      Logger.info("Completed welcome email job for student #{job.args["student_id"]}")
      :ok
    end)
  end
end
