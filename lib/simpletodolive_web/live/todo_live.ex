defmodule SimpletodoliveWeb.TodoLive do
  use SimpletodoliveWeb, :live_view

  def render(assigns) do
    ~H"""
    <% if @todos == [] do %>
      <%= gettext("No todos") %>
    <% else %>
      <div :for={todo <- @todos}>
        <%= todo.title %>
      </div>
    <% end %>
    """
  end

  def mount(_params, _session, socket) do
    todos = []
    {:ok, assign(socket, :todos, todos)}
  end
end
