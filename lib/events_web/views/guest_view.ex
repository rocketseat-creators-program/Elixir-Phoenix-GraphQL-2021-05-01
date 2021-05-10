defmodule EventsWeb.GuestView do
  use EventsWeb, :view
  alias EventsWeb.GuestView

  def render("index.json", %{guests: guests}) do
    %{data: render_many(guests, GuestView, "guest.json")}
  end

  def render("show.json", %{guest: guest}) do
    %{data: render_one(guest, GuestView, "guest.json")}
  end

  def render("guest.json", %{guest: guest}) do
    %{
      id: guest.id,
      name: guest.name,
      email: guest.email,
      birth_date: guest.birth_date,
      guests: guest.guests
    }
  end
end
