defmodule Events.Repo.Migrations.CreateActivities do
  use Ecto.Migration

  def change do
    create table(:activities) do
      add :name, :string
      add :date_event, :date

      timestamps()
    end
  end
end
