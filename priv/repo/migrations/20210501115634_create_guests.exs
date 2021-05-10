defmodule Events.Repo.Migrations.CreateGuests do
  use Ecto.Migration

  def change do
    create table(:guests) do
      add :name, :string
      add :email, :string

      timestamps()
    end
  end
end
