defmodule EventsWeb.GuestControllerTest do
  use EventsWeb.ConnCase

  alias Events.Guests
  alias Events.Guests.Guest

  @create_attrs %{
    birth_date: ~N[2010-04-17 14:00:00],
    email: "some email",
    guests: "some guests",
    name: "some name"
  }
  @update_attrs %{
    birth_date: ~N[2011-05-18 15:01:01],
    email: "some updated email",
    guests: "some updated guests",
    name: "some updated name"
  }
  @invalid_attrs %{birth_date: nil, email: nil, guests: nil, name: nil}

  def fixture(:guest) do
    {:ok, guest} = Guests.create_guest(@create_attrs)
    guest
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all guests", %{conn: conn} do
      conn = get(conn, Routes.guest_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create guest" do
    test "renders guest when data is valid", %{conn: conn} do
      conn = post(conn, Routes.guest_path(conn, :create), guest: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.guest_path(conn, :show, id))

      assert %{
               "id" => id,
               "birth_date" => "2010-04-17T14:00:00",
               "email" => "some email",
               "guests" => "some guests",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.guest_path(conn, :create), guest: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update guest" do
    setup [:create_guest]

    test "renders guest when data is valid", %{conn: conn, guest: %Guest{id: id} = guest} do
      conn = put(conn, Routes.guest_path(conn, :update, guest), guest: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.guest_path(conn, :show, id))

      assert %{
               "id" => id,
               "birth_date" => "2011-05-18T15:01:01",
               "email" => "some updated email",
               "guests" => "some updated guests",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, guest: guest} do
      conn = put(conn, Routes.guest_path(conn, :update, guest), guest: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete guest" do
    setup [:create_guest]

    test "deletes chosen guest", %{conn: conn, guest: guest} do
      conn = delete(conn, Routes.guest_path(conn, :delete, guest))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.guest_path(conn, :show, guest))
      end
    end
  end

  defp create_guest(_) do
    guest = fixture(:guest)
    %{guest: guest}
  end
end
