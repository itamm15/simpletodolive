defmodule SimpletodoliveWeb.TodoLive do
  use SimpletodoliveWeb, :live_view

  def render(assigns) do
    ~H"""
    <.button name="add-todo" phx-click={show_modal("add-todo")}>
      <%= gettext("Add Todo") %>
    </.button>
    <%= if @todos == [] do %>
      <%= gettext("No todos") %>
    <% else %>
      <div :for={todo <- @todos}>
        <%= todo.title %>
      </div>
    <% end %>
    <.add_todo_modal changeset={@changeset} />
    """
  end

  def mount(_params, _session, socket) do
    todos = Simpletodolive.Repo.all(Simpletodolive.Todo)
    changeset = Simpletodolive.Todo.changeset(%Simpletodolive.Todo{}, %{})

    assigns = socket |> assign(:todos, todos) |> assign(:changeset, to_form(changeset))

    {:ok, assigns}
  end

  def handle_event("save-todo", %{"todo" => todo}, socket) do
    %Simpletodolive.Todo{}
    |> Simpletodolive.Todo.changeset(todo)
    |> Simpletodolive.Repo.insert()
    |> case do
      {:ok, todo} ->
        changeset = Simpletodolive.Todo.changeset(%Simpletodolive.Todo{}, %{})

        socket =
          socket
          |> assign(:todos, [todo | socket.assigns.todos])
          |> assign(:changeset, to_form(changeset))

        {:noreply, socket}
      {:error, changeset} ->

    end
  end

  attr :changeset, :map, required: true

  defp add_todo_modal(assigns) do
    ~H"""
    <.modal id="add-todo">
      <.form
        for={@changeset}
        phx-submit="save-todo"
      >
        <.input field={@changeset[:title]} type="text" label="Title" />
        <.button phx-click={hide_modal("add-todo")}>Save Todo</.button>
      </.form>
    </.modal>
    """
  end
end
