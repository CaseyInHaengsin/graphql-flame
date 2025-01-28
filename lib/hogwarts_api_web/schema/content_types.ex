defmodule HogwartsApiWeb.Schema.ContentTypes do
  use Absinthe.Schema.Notation

  interface :being do
    field :id, non_null(:id)
    field :name, :string

    resolve_type(fn
      %HogwartsApi.Beings.Student{} -> :student
      %HogwartsApi.Beings.Professor{} -> :professor
    end)
  end

  object :page_info do
    field :has_next_page, non_null(:boolean)
    field :has_previous_page, non_null(:boolean)
    field :start_cursor, :string
    field :end_cursor, :string
  end

  object :student_edge do
    field :node, non_null(:student)
    field :cursor, non_null(:string)
  end

  object :student_connection do
    field :edges, non_null(list_of(non_null(:student_edge))) do
      arg(:limit, :integer, default_value: 10)
      arg(:skip, :integer, default_value: 0)
    end

    field :page_info, non_null(:page_info)

    # field :total, non_null(:integer) do
    #   resolve(fn _, _, _ ->
    #     {:ok, HogwartsApi.Beings.student_count()}
    #   end)
    # end
  end

  object :student do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :house, non_null(:string)
    field :plot_armor, non_null(:boolean)

    field :sections, non_null(list_of(non_null(:section))) do
      resolve(fn user, _, _ ->
        {:ok, HogwartsApi.Beings.list_sections_for_student(user)}
      end)
    end

    interface(:being)
  end

  object :professor do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :is_animagus, non_null(:boolean)
    field :is_deatheater, non_null(:boolean)

    field :sections, non_null(list_of(non_null(:section))) do
      resolve(fn %{id: id}, _, _ ->
        {:ok, HogwartsApi.Scheduling.list_sections_for_professor(id)}
      end)
    end

    interface(:being)
  end

  object :book do
    field :id, non_null(:id)
    field :title, non_null(:string)
    field :author, non_null(:string)

    field :courses, non_null(list_of(non_null(:course))) do
      resolve(fn book, _, _ ->
        {:ok, HogwartsApi.Scheduling.load_courses_for_book(book)}
      end)
    end
  end

  object :course do
    field :id, non_null(:id)
    field :name, non_null(:string)

    field :sections, non_null(list_of(non_null(:section))) do
      resolve(fn course, _, _ ->
        {:ok, HogwartsApi.Scheduling.list_sections_for_course(course.id)}
      end)
    end

    field :books, non_null(list_of(non_null(:book))) do
      resolve(fn course, _, _ ->
        {:ok, HogwartsApi.Scheduling.load_books_for_course(course)}
      end)
    end

    # field :professor, :professor
    # field :students, list_of(:student)
    # field :books, list_of(:book)
  end

  object :room do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :cursed, non_null(:boolean)
    field :haunted, non_null(:boolean)
    field :hexed, non_null(:boolean)
    field :number, non_null(:string)
    field :secret_passage, non_null(:boolean)
    field :static, non_null(:boolean)

    field :sections, non_null(list_of(non_null(:section))) do
      resolve(fn room, _, _ ->
        {:ok, HogwartsApi.Scheduling.list_sections_for_room(room)}
      end)
    end
  end

  object :section do
    field :id, non_null(:id)
    field :semester, non_null(:string)
    field :time, non_null(:string)
    field :professor_id, non_null(:string)
    field :course_id, non_null(:string)
    field :room_id, non_null(:string)

    field :course, non_null(:course) do
      resolve(fn section, _, _ ->
        {:ok, HogwartsApi.Scheduling.get_course!(section.course_id)}
      end)
    end

    field :professor, :professor do
      resolve(fn
        %{professor_id: nil}, _, _ ->
          {:ok, nil}

        %{professor_id: id}, _, _ ->
          {:ok, HogwartsApi.Beings.get_professor!(id)}
      end)
    end

    field :room, :room do
      resolve(fn
        %{room_id: nil}, _, _ ->
          {:ok, nil}

        %{room_id: id}, _, _ ->
          {:ok, HogwartsApi.Scheduling.get_room!(id)}
      end)
    end

    field :students, non_null(list_of(non_null(:student))) do
      resolve(fn section, _, _ ->
        {:ok, HogwartsApi.Scheduling.list_students_for_section(section)}
      end)
    end
  end
end
