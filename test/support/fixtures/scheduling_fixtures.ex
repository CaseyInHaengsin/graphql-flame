defmodule HogwartsApi.SchedulingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HogwartsApi.Scheduling` context.
  """

  @doc """
  Generate a room.
  """
  def room_fixture(attrs \\ %{}) do
    {:ok, room} =
      attrs
      |> Enum.into(%{
        cursed: true,
        haunted: true,
        hexed: true,
        number: "some number",
        secret_passage: true,
        static: true
      })
      |> HogwartsApi.Scheduling.create_room()

    room
  end

  @doc """
  Generate a section.
  """
  def section_fixture(attrs \\ %{}) do
    {:ok, section} =
      attrs
      |> Enum.into(%{
        semester: "some semester",
        time: "some time"
      })
      |> HogwartsApi.Scheduling.create_section()

    section
  end

  @doc """
  Generate a course_book.
  """
  def course_book_fixture(attrs \\ %{}) do
    {:ok, course_book} =
      attrs
      |> Enum.into(%{

      })
      |> HogwartsApi.Scheduling.create_course_book()

    course_book
  end

  @doc """
  Generate a student_section.
  """
  def student_section_fixture(attrs \\ %{}) do
    {:ok, student_section} =
      attrs
      |> Enum.into(%{

      })
      |> HogwartsApi.Scheduling.create_student_section()

    student_section
  end
end
