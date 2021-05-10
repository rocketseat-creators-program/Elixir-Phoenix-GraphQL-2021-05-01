defmodule Events.Repo.Migrations.CreateEventsGuests do
  use Ecto.Migration

  def change do
    create table(:events_guests) do
      add :event_id, references(:activities, on_delete: :nothing)
      add :guest_id, references(:guests, on_delete: :nothing)

      timestamps()
    end

    create index(:events_guests, [:event_id])
    create index(:events_guests, [:guest_id])
  end
end
