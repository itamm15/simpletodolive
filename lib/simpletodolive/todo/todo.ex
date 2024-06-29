defmodule Simpletodolive.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :title, :string
    field :is_finished, :boolean, default: false

    timestamps()
  end

  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:title, :is_finished])
    |> validate_required([:title, :is_finished])
  end
end
