defmodule HogwartsApi.Scheduling do
  @moduledoc """
  The Scheduling context.
  """

  import Ecto.Query, warn: false
  alias HogwartsApi.Repo

  alias HogwartsApi.Scheduling.{Room, Book, Course, Section}

  @doc """
  Returns the list of rooms.

  ## Examples

      iex> list_rooms()
      [%Room{}, ...]

  """
  def list_rooms do
    Repo.all(Room)
  end

  def list_sections_for_room(%Room{} = room) do
    Repo.preload(room, :sections) |> Map.get(:sections)
  end

  def list_students_for_section(%Section{} = section) do
    Repo.preload(section, :students) |> Map.get(:students)
  end

  def list_books do
    Repo.all(Book)
  end

  def load_books_for_course(%Course{} = course) do
    Repo.preload(course, :books) |> Map.get(:books)
  end

  def load_courses_for_book(%Book{} = book) do
    Repo.preload(book, :courses) |> Map.get(:courses)
  end

  @doc """
  Gets a single room.

  Raises `Ecto.NoResultsError` if the Room does not exist.

  ## Examples

      iex> get_room!(123)
      %Room{}

      iex> get_room!(456)
      ** (Ecto.NoResultsError)

  """
  def get_room!(id), do: Repo.get!(Room, id)

  @doc """
  Creates a room.

  ## Examples

      iex> create_room(%{field: value})
      {:ok, %Room{}}

      iex> create_room(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_room(attrs \\ %{}) do
    %Room{}
    |> Room.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a room.

  ## Examples

      iex> update_room(room, %{field: new_value})
      {:ok, %Room{}}

      iex> update_room(room, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_room(%Room{} = room, attrs) do
    room
    |> Room.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a room.

  ## Examples

      iex> delete_room(room)
      {:ok, %Room{}}

      iex> delete_room(room)
      {:error, %Ecto.Changeset{}}

  """
  def delete_room(%Room{} = room) do
    Repo.delete(room)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking room changes.

  ## Examples

      iex> change_room(room)
      %Ecto.Changeset{data: %Room{}}

  """
  def change_room(%Room{} = room, attrs \\ %{}) do
    Room.changeset(room, attrs)
  end

  alias HogwartsApi.Scheduling.Section

  @doc """
  Returns the list of sections.

  ## Examples

      iex> list_sections()
      [%Section{}, ...]

  """
  def list_sections do
    Repo.all(Section)
  end

  def list_sections_for_professor(id) do
    Repo.all(from s in Section, where: s.professor_id == ^id)
  end

  def list_sections_for_course(id) do
    Repo.all(from s in Section, where: s.course_id == ^id)
  end

  @doc """
  Gets a single section.

  Raises `Ecto.NoResultsError` if the Section does not exist.

  ## Examples

      iex> get_section!(123)
      %Section{}

      iex> get_section!(456)
      ** (Ecto.NoResultsError)

  """
  def get_section!(id), do: Repo.get!(Section, id)

  @doc """
  Creates a section.

  ## Examples

      iex> create_section(%{field: value})
      {:ok, %Section{}}

      iex> create_section(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_section(attrs \\ %{}) do
    %Section{}
    |> Section.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a section.

  ## Examples

      iex> update_section(section, %{field: new_value})
      {:ok, %Section{}}

      iex> update_section(section, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_section(%Section{} = section, attrs) do
    section
    |> Section.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a section.

  ## Examples

      iex> delete_section(section)
      {:ok, %Section{}}

      iex> delete_section(section)
      {:error, %Ecto.Changeset{}}

  """
  def delete_section(%Section{} = section) do
    Repo.delete(section)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking section changes.

  ## Examples

      iex> change_section(section)
      %Ecto.Changeset{data: %Section{}}

  """
  def change_section(%Section{} = section, attrs \\ %{}) do
    Section.changeset(section, attrs)
  end

  alias HogwartsApi.Scheduling.CourseBook

  @doc """
  Returns the list of course_books.

  ## Examples

      iex> list_course_books()
      [%CourseBook{}, ...]

  """
  def list_course_books do
    Repo.all(CourseBook)
  end

  @doc """
  Gets a single course_book.

  Raises `Ecto.NoResultsError` if the Course book does not exist.

  ## Examples

      iex> get_course_book!(123)
      %CourseBook{}

      iex> get_course_book!(456)
      ** (Ecto.NoResultsError)

  """
  def get_course_book!(id), do: Repo.get!(CourseBook, id)

  @doc """
  Creates a course_book.

  ## Examples

      iex> create_course_book(%{field: value})
      {:ok, %CourseBook{}}

      iex> create_course_book(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_course_book(attrs \\ %{}) do
    %CourseBook{}
    |> CourseBook.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a course_book.

  ## Examples

      iex> update_course_book(course_book, %{field: new_value})
      {:ok, %CourseBook{}}

      iex> update_course_book(course_book, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_course_book(%CourseBook{} = course_book, attrs) do
    course_book
    |> CourseBook.changeset(attrs)
    |> Repo.update()
  end

  def update_course(%HogwartsApi.Scheduling.Course{} = course, attrs) do
    course
    |> HogwartsApi.Scheduling.Course.changeset(attrs)
    |> Repo.update()
  end

  def get_course!(id) do
    Repo.get!(HogwartsApi.Scheduling.Course, id)
  end

  @doc """
  Deletes a course_book.

  ## Examples

      iex> delete_course_book(course_book)
      {:ok, %CourseBook{}}

      iex> delete_course_book(course_book)
      {:error, %Ecto.Changeset{}}

  """
  def delete_course_book(%CourseBook{} = course_book) do
    Repo.delete(course_book)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking course_book changes.

  ## Examples

      iex> change_course_book(course_book)
      %Ecto.Changeset{data: %CourseBook{}}

  """
  def change_course_book(%CourseBook{} = course_book, attrs \\ %{}) do
    CourseBook.changeset(course_book, attrs)
  end

  alias HogwartsApi.Scheduling.StudentSection

  @doc """
  Returns the list of student_sections.

  ## Examples

      iex> list_student_sections()
      [%StudentSection{}, ...]

  """
  def list_student_sections do
    Repo.all(StudentSection)
  end

  @doc """
  Gets a single student_section.

  Raises `Ecto.NoResultsError` if the Student section does not exist.

  ## Examples

      iex> get_student_section!(123)
      %StudentSection{}

      iex> get_student_section!(456)
      ** (Ecto.NoResultsError)

  """
  def get_student_section!(id), do: Repo.get!(StudentSection, id)

  @doc """
  Creates a student_section.

  ## Examples

      iex> create_student_section(%{field: value})
      {:ok, %StudentSection{}}

      iex> create_student_section(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_student_section(attrs \\ %{}) do
    %StudentSection{}
    |> StudentSection.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a student_section.

  ## Examples

      iex> update_student_section(student_section, %{field: new_value})
      {:ok, %StudentSection{}}

      iex> update_student_section(student_section, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_student_section(%StudentSection{} = student_section, attrs) do
    student_section
    |> StudentSection.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a student_section.

  ## Examples

      iex> delete_student_section(student_section)
      {:ok, %StudentSection{}}

      iex> delete_student_section(student_section)
      {:error, %Ecto.Changeset{}}

  """
  def delete_student_section(%StudentSection{} = student_section) do
    Repo.delete(student_section)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking student_section changes.

  ## Examples

      iex> change_student_section(student_section)
      %Ecto.Changeset{data: %StudentSection{}}

  """
  def change_student_section(%StudentSection{} = student_section, attrs \\ %{}) do
    StudentSection.changeset(student_section, attrs)
  end
end
