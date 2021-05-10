defmodule EventsWeb.Graphql.EventInfo do
  alias Events.Activities.Activity
  alias Events.Guests.Guest
  alias Events.EventsGuests
  alias Events.Repo

  import Ecto.Query

  def get_event_guests(args) do
    from(
      e in EventsGuests,
      join: a in Activity,
      on: e.event_id == a.id,
      join: g in Guest,
      on: e.guest_id == g.id,
      where: a.id == ^args,
      select: g
    )
    |> Repo.all()
  end

  # GUESTS
  def get_guests, do: Repo.all(Guest)

  def create_guest(args) do
    %Guest{}
    |> Guest.changeset(args)
    |> Repo.insert()
  end

  # Event
  def get_events, do: Repo.all(Activity)

  def create_event(args) do
    %Activity{}
    |> Activity.changeset(args)
    |> Repo.insert()
  end
end
