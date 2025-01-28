defmodule HogwartsApi.BeingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HogwartsApi.Beings` context.
  """

  @doc """
  Generate a student.
  """
  def student_fixture(attrs \\ %{}) do
    {:ok, student} =
      attrs
      |> Enum.into(%{
        house: :gryffindor,
        name: "some name",
        plot_armor: true
      })
      |> HogwartsApi.Beings.create_student()

    student
  end
end
