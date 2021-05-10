defmodule EventsWeb.PageController do
  use EventsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
