defmodule Simpletodolive.Repo.Migrations.AddTodos do
  use Ecto.Migration

  def up do
    create table(:todos) do
      add :title, :string, null: false
      add :is_finished, :boolean, default: false, null: false

      timestamps()
    end
  end

  def down do
    drop table(:todos)
  end
end
