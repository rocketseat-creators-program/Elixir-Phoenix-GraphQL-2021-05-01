defmodule EventsWeb.GuestController do
  use EventsWeb, :controller

  alias Events.Guests
  alias Events.Guests.Guest

  action_fallback EventsWeb.FallbackController

  def index(conn, _params) do
    guests = Guests.list_guests()
    render(conn, "index.json", guests: guests)
  end

  def create(conn, %{"guest" => guest_params}) do
    with {:ok, %Guest{} = guest} <- Guests.create_guest(guest_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.guest_path(conn, :show, guest))
      |> render("show.json", guest: guest)
    end
  end

  def show(conn, %{"id" => id}) do
    guest = Guests.get_guest!(id)
    render(conn, "show.json", guest: guest)
  end

  def update(conn, %{"id" => id, "guest" => guest_params}) do
    guest = Guests.get_guest!(id)

    with {:ok, %Guest{} = guest} <- Guests.update_guest(guest, guest_params) do
      render(conn, "show.json", guest: guest)
    end
  end

  def delete(conn, %{"id" => id}) do
    guest = Guests.get_guest!(id)

    with {:ok, %Guest{}} <- Guests.delete_guest(guest) do
      send_resp(conn, :no_content, "")
    end
  end
end
