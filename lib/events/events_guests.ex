defmodule Events.EventsGuests do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events_guests" do
    field :event_id, :id
    field :guest_id, :id

    timestamps()
  end

  @doc false
  def changeset(events_guests, attrs) do
    events_guests
    |> cast(attrs, [])
    |> validate_required([])
  end
end
