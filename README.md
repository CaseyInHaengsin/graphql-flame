# HogwartsApi

To start your Phoenix server:

- Run `mix setup` to install and setup dependencies
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix

# Book

- id
- title
- author

# Course

- id
- name

# CourseBook

- course_id
- book_id

# Student

- id
- name
- house
- plot_armor

# Professor

- id
- name
- house
- is_animagus
- is_deatheater

# Section

- id
- course_id
- professor_id
- room_id
- time
- Semester

# Room

- id
- number
- haunted
- cursed
- hexed
- secret_passage
- static

# StudentSection

- student_id
- course_id
