defmodule HogwartsApi.Beings do
  @moduledoc """
  The Beings context.
  """

  import Ecto.Query, warn: false
  alias HogwartsApi.Repo

  alias HogwartsApi.Beings.{Student, Professor}

  @doc """
  Returns the list of students.

  ## Examples

      iex> list_students()
      [%Student{}, ...]

  """
  def list_students(%{limit: limit, skip: skip}) do
    Repo.all(from(s in Student, limit: ^limit, offset: ^skip))
  end

  def students_connection(%{first: first} = args) when is_integer(first) and first >= 0 do
    limit = first + 1

    order_by =
      case args do
        %{sort: sort} when is_binary(sort) ->
          get_order_by(sort)

        _ ->
          [asc: :id]
      end

    students =
      case args do
        %{after: cursor} when is_binary(cursor) ->
          cursor = decode_cursor(cursor)
          Repo.all(Student |> apply_cursor(cursor, order_by, limit))

        _ ->
          Repo.all(from(s in Student, limit: ^limit))
      end

    edges =
      students |> Enum.map(&%{node: &1, cursor: encode_cursor(&1, order_by)}) |> Enum.take(first)

    page_info = %{
      has_next_page: length(students) > first,
      has_previous_page: args[:after] != nil,
      start_cursor: get_in(edges, [Access.at(0), :cursor]),
      end_cursor: get_in(edges, [Access.at(-1), :cursor])
    }

    {:ok, %{edges: edges, page_info: page_info}}
  end

  def students_connection(_), do: {:error, "Invalid arguments"}

  defp encode_cursor(node, order_by) do
    order_by
    |> Map.new(fn {_, key} -> {key, get_in(node, [Access.key!(key)])} end)
    |> Jason.encode!()
    |> Base.url_encode64(padding: false)
  end

  defp apply_cursor(query, cursor, order_by, limit) do
    Enum.reduce(order_by, query, fn
      # {:asc, :id}, query -> where(query, [s], field(s, :id) > ^cursor[get_string_field(:id)]) |> or_where([s], field(s, ^key) == ^ field(s, :id) > ^cursor[get_string_field(:id)]))
      # {:desc, :id}, query -> where(query, [s], field(s, :id) < ^cursor[get_string_field(:id)])
      {:asc, key}, query -> where(query, [s], field(s, ^key) >= ^cursor[get_string_field(key)])
      {:desc, key}, query -> where(query, [s], field(s, ^key) <= ^cursor[get_string_field(key)])
    end)
    |> limit(^limit)
    |> order_by(^order_by)
  end

  defp decode_cursor(cursor) do
    cursor
    |> Base.url_decode64!(padding: false)
    |> Jason.decode!()
  end

  defp get_order_by(sort) do
    id_sort =
      case sort do
        "-" <> _rest -> :desc
        _ -> :asc
      end

    sort
    |> String.split(" ")
    |> Enum.map(fn
      "-" <> field -> {:desc, field_to_atom(field)}
      field -> {:asc, field_to_atom(field)}
    end)
    |> Enum.concat([{id_sort, :id}])
  end

  defp field_to_atom("name"), do: :name
  defp field_to_atom("id"), do: :id

  defp get_string_field(:name), do: "name"
  defp get_string_field(:id), do: "id"

  def student_count() do
    Repo.one!(from(s in Student, select: count(s.id)))
  end

  def list_sections_for_student(%Student{} = student) do
    Repo.preload(student, :sections) |> Map.get(:sections)
  end

  def list_professors(%{limit: limit, skip: skip}) do
    Repo.all(from(p in Professor, limit: ^limit, offset: ^skip))
  end

  @doc """
  Gets a single student.

  Raises `Ecto.NoResultsError` if the Student does not exist.

  ## Examples

      iex> get_student!(123)
      %Student{}

      iex> get_student!(456)
      ** (Ecto.NoResultsError)

  """
  def get_student!(id), do: Repo.get!(Student, id)
  def get_professor!(nil), do: nil
  def get_professor!(id), do: Repo.get!(Professor, id)

  @doc """
  Creates a student.

  ## Examples

      iex> create_student(%{field: value})
      {:ok, %Student{}}

      iex> create_student(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_student(attrs \\ %{}) do
    result =
      %Student{}
      |> Student.changeset(attrs)
      |> Repo.insert()

    case result do
      {:ok, student} ->
        # Enqueue the welcome email job
        IO.puts("got here, boiiii")

        %{student_id: student.id}
        |> HogwartsApi.Workers.StudentWelcomeEmail.new()
        |> Oban.insert()

        {:ok, student}

      error ->
        error
    end
  end

  @doc """
  Updates a student.

  ## Examples

      iex> update_student(student, %{field: new_value})
      {:ok, %Student{}}

      iex> update_student(student, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_student(%Student{} = student, attrs) do
    student
    |> Student.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a student.

  ## Examples

      iex> delete_student(student)
      {:ok, %Student{}}

      iex> delete_student(student)
      {:error, %Ecto.Changeset{}}

  """
  def delete_student(%Student{} = student) do
    Repo.delete(student)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking student changes.

  ## Examples

      iex> change_student(student)
      %Ecto.Changeset{data: %Student{}}

  """
  def change_student(%Student{} = student, attrs \\ %{}) do
    Student.changeset(student, attrs)
  end
end
