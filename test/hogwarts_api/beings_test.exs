defmodule HogwartsApi.BeingsTest do
  use HogwartsApi.DataCase

  alias HogwartsApi.Beings

  describe "students" do
    alias HogwartsApi.Beings.Student

    import HogwartsApi.BeingsFixtures

    @invalid_attrs %{house: nil, name: nil, plot_armor: nil}

    test "list_students/0 returns all students" do
      student = student_fixture()
      assert Beings.list_students() == [student]
    end

    test "get_student!/1 returns the student with given id" do
      student = student_fixture()
      assert Beings.get_student!(student.id) == student
    end

    test "create_student/1 with valid data creates a student" do
      valid_attrs = %{house: :gryffindor, name: "some name", plot_armor: true}

      assert {:ok, %Student{} = student} = Beings.create_student(valid_attrs)
      assert student.house == :gryffindor
      assert student.name == "some name"
      assert student.plot_armor == true
    end

    test "create_student/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Beings.create_student(@invalid_attrs)
    end

    test "update_student/2 with valid data updates the student" do
      student = student_fixture()
      update_attrs = %{house: :slytherin, name: "some updated name", plot_armor: false}

      assert {:ok, %Student{} = student} = Beings.update_student(student, update_attrs)
      assert student.house == :slytherin
      assert student.name == "some updated name"
      assert student.plot_armor == false
    end

    test "update_student/2 with invalid data returns error changeset" do
      student = student_fixture()
      assert {:error, %Ecto.Changeset{}} = Beings.update_student(student, @invalid_attrs)
      assert student == Beings.get_student!(student.id)
    end

    test "delete_student/1 deletes the student" do
      student = student_fixture()
      assert {:ok, %Student{}} = Beings.delete_student(student)
      assert_raise Ecto.NoResultsError, fn -> Beings.get_student!(student.id) end
    end

    test "change_student/1 returns a student changeset" do
      student = student_fixture()
      assert %Ecto.Changeset{} = Beings.change_student(student)
    end
  end
end
