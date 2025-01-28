defmodule HogwartsApi.SchedulingTest do
  use HogwartsApi.DataCase

  alias HogwartsApi.Scheduling

  describe "rooms" do
    alias HogwartsApi.Scheduling.Room

    import HogwartsApi.SchedulingFixtures

    @invalid_attrs %{cursed: nil, haunted: nil, hexed: nil, number: nil, secret_passage: nil, static: nil}

    test "list_rooms/0 returns all rooms" do
      room = room_fixture()
      assert Scheduling.list_rooms() == [room]
    end

    test "get_room!/1 returns the room with given id" do
      room = room_fixture()
      assert Scheduling.get_room!(room.id) == room
    end

    test "create_room/1 with valid data creates a room" do
      valid_attrs = %{cursed: true, haunted: true, hexed: true, number: "some number", secret_passage: true, static: true}

      assert {:ok, %Room{} = room} = Scheduling.create_room(valid_attrs)
      assert room.cursed == true
      assert room.haunted == true
      assert room.hexed == true
      assert room.number == "some number"
      assert room.secret_passage == true
      assert room.static == true
    end

    test "create_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Scheduling.create_room(@invalid_attrs)
    end

    test "update_room/2 with valid data updates the room" do
      room = room_fixture()
      update_attrs = %{cursed: false, haunted: false, hexed: false, number: "some updated number", secret_passage: false, static: false}

      assert {:ok, %Room{} = room} = Scheduling.update_room(room, update_attrs)
      assert room.cursed == false
      assert room.haunted == false
      assert room.hexed == false
      assert room.number == "some updated number"
      assert room.secret_passage == false
      assert room.static == false
    end

    test "update_room/2 with invalid data returns error changeset" do
      room = room_fixture()
      assert {:error, %Ecto.Changeset{}} = Scheduling.update_room(room, @invalid_attrs)
      assert room == Scheduling.get_room!(room.id)
    end

    test "delete_room/1 deletes the room" do
      room = room_fixture()
      assert {:ok, %Room{}} = Scheduling.delete_room(room)
      assert_raise Ecto.NoResultsError, fn -> Scheduling.get_room!(room.id) end
    end

    test "change_room/1 returns a room changeset" do
      room = room_fixture()
      assert %Ecto.Changeset{} = Scheduling.change_room(room)
    end
  end

  describe "sections" do
    alias HogwartsApi.Scheduling.Section

    import HogwartsApi.SchedulingFixtures

    @invalid_attrs %{semester: nil, time: nil}

    test "list_sections/0 returns all sections" do
      section = section_fixture()
      assert Scheduling.list_sections() == [section]
    end

    test "get_section!/1 returns the section with given id" do
      section = section_fixture()
      assert Scheduling.get_section!(section.id) == section
    end

    test "create_section/1 with valid data creates a section" do
      valid_attrs = %{semester: "some semester", time: "some time"}

      assert {:ok, %Section{} = section} = Scheduling.create_section(valid_attrs)
      assert section.semester == "some semester"
      assert section.time == "some time"
    end

    test "create_section/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Scheduling.create_section(@invalid_attrs)
    end

    test "update_section/2 with valid data updates the section" do
      section = section_fixture()
      update_attrs = %{semester: "some updated semester", time: "some updated time"}

      assert {:ok, %Section{} = section} = Scheduling.update_section(section, update_attrs)
      assert section.semester == "some updated semester"
      assert section.time == "some updated time"
    end

    test "update_section/2 with invalid data returns error changeset" do
      section = section_fixture()
      assert {:error, %Ecto.Changeset{}} = Scheduling.update_section(section, @invalid_attrs)
      assert section == Scheduling.get_section!(section.id)
    end

    test "delete_section/1 deletes the section" do
      section = section_fixture()
      assert {:ok, %Section{}} = Scheduling.delete_section(section)
      assert_raise Ecto.NoResultsError, fn -> Scheduling.get_section!(section.id) end
    end

    test "change_section/1 returns a section changeset" do
      section = section_fixture()
      assert %Ecto.Changeset{} = Scheduling.change_section(section)
    end
  end

  describe "course_books" do
    alias HogwartsApi.Scheduling.CourseBook

    import HogwartsApi.SchedulingFixtures

    @invalid_attrs %{}

    test "list_course_books/0 returns all course_books" do
      course_book = course_book_fixture()
      assert Scheduling.list_course_books() == [course_book]
    end

    test "get_course_book!/1 returns the course_book with given id" do
      course_book = course_book_fixture()
      assert Scheduling.get_course_book!(course_book.id) == course_book
    end

    test "create_course_book/1 with valid data creates a course_book" do
      valid_attrs = %{}

      assert {:ok, %CourseBook{} = course_book} = Scheduling.create_course_book(valid_attrs)
    end

    test "create_course_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Scheduling.create_course_book(@invalid_attrs)
    end

    test "update_course_book/2 with valid data updates the course_book" do
      course_book = course_book_fixture()
      update_attrs = %{}

      assert {:ok, %CourseBook{} = course_book} = Scheduling.update_course_book(course_book, update_attrs)
    end

    test "update_course_book/2 with invalid data returns error changeset" do
      course_book = course_book_fixture()
      assert {:error, %Ecto.Changeset{}} = Scheduling.update_course_book(course_book, @invalid_attrs)
      assert course_book == Scheduling.get_course_book!(course_book.id)
    end

    test "delete_course_book/1 deletes the course_book" do
      course_book = course_book_fixture()
      assert {:ok, %CourseBook{}} = Scheduling.delete_course_book(course_book)
      assert_raise Ecto.NoResultsError, fn -> Scheduling.get_course_book!(course_book.id) end
    end

    test "change_course_book/1 returns a course_book changeset" do
      course_book = course_book_fixture()
      assert %Ecto.Changeset{} = Scheduling.change_course_book(course_book)
    end
  end

  describe "student_sections" do
    alias HogwartsApi.Scheduling.StudentSection

    import HogwartsApi.SchedulingFixtures

    @invalid_attrs %{}

    test "list_student_sections/0 returns all student_sections" do
      student_section = student_section_fixture()
      assert Scheduling.list_student_sections() == [student_section]
    end

    test "get_student_section!/1 returns the student_section with given id" do
      student_section = student_section_fixture()
      assert Scheduling.get_student_section!(student_section.id) == student_section
    end

    test "create_student_section/1 with valid data creates a student_section" do
      valid_attrs = %{}

      assert {:ok, %StudentSection{} = student_section} = Scheduling.create_student_section(valid_attrs)
    end

    test "create_student_section/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Scheduling.create_student_section(@invalid_attrs)
    end

    test "update_student_section/2 with valid data updates the student_section" do
      student_section = student_section_fixture()
      update_attrs = %{}

      assert {:ok, %StudentSection{} = student_section} = Scheduling.update_student_section(student_section, update_attrs)
    end

    test "update_student_section/2 with invalid data returns error changeset" do
      student_section = student_section_fixture()
      assert {:error, %Ecto.Changeset{}} = Scheduling.update_student_section(student_section, @invalid_attrs)
      assert student_section == Scheduling.get_student_section!(student_section.id)
    end

    test "delete_student_section/1 deletes the student_section" do
      student_section = student_section_fixture()
      assert {:ok, %StudentSection{}} = Scheduling.delete_student_section(student_section)
      assert_raise Ecto.NoResultsError, fn -> Scheduling.get_student_section!(student_section.id) end
    end

    test "change_student_section/1 returns a student_section changeset" do
      student_section = student_section_fixture()
      assert %Ecto.Changeset{} = Scheduling.change_student_section(student_section)
    end
  end
end
