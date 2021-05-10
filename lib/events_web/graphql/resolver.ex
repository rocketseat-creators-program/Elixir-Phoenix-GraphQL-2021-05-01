defmodule EventsWeb.Graphql.Resolver do
  alias Events.Activities.Activity
  alias Events.Guests.Guest
  alias EventsWeb.Graphql.EventInfo

  def get_event_guests(args) do
    {:ok, EventInfo.get_event_guests(args.id)}
  end

  # guests
  def guests(_args, _info) do
    {:ok, EventInfo.get_guests()}
  end

  def create_guest(args, _info) do
    with {:ok, guest} <- EventInfo.create_guest(args) do
      {:ok, guest}
    else
      {:error, error} -> {:error, "Fail to create new guest!!!"}
    end
  end

  # events
  def events(_args, _info) do
    {:ok, EventInfo.get_events()}
  end

  def create_event(args, _info) do
    with {:ok, event} <- EventInfo.create_event(args) do
      {:ok, event}
    else
      {:error, error} -> {:error, "Fail to create new event!!!"}
    end
  end
end
