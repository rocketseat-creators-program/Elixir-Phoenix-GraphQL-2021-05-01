defmodule EventsWeb.ActivityControllerTest do
  use EventsWeb.ConnCase

  alias Events.Activities
  alias Events.Activities.Activity

  @create_attrs %{
    date_event: ~N[2010-04-17 14:00:00],
    description: "some description",
    events: "some events",
    is_active: true,
    name: "some name"
  }
  @update_attrs %{
    date_event: ~N[2011-05-18 15:01:01],
    description: "some updated description",
    events: "some updated events",
    is_active: false,
    name: "some updated name"
  }
  @invalid_attrs %{date_event: nil, description: nil, events: nil, is_active: nil, name: nil}

  def fixture(:activity) do
    {:ok, activity} = Activities.create_activity(@create_attrs)
    activity
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all activities", %{conn: conn} do
      conn = get(conn, Routes.activity_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create activity" do
    test "renders activity when data is valid", %{conn: conn} do
      conn = post(conn, Routes.activity_path(conn, :create), activity: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.activity_path(conn, :show, id))

      assert %{
               "id" => id,
               "date_event" => "2010-04-17T14:00:00",
               "description" => "some description",
               "events" => "some events",
               "is_active" => true,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.activity_path(conn, :create), activity: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update activity" do
    setup [:create_activity]

    test "renders activity when data is valid", %{
      conn: conn,
      activity: %Activity{id: id} = activity
    } do
      conn = put(conn, Routes.activity_path(conn, :update, activity), activity: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.activity_path(conn, :show, id))

      assert %{
               "id" => id,
               "date_event" => "2011-05-18T15:01:01",
               "description" => "some updated description",
               "events" => "some updated events",
               "is_active" => false,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, activity: activity} do
      conn = put(conn, Routes.activity_path(conn, :update, activity), activity: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete activity" do
    setup [:create_activity]

    test "deletes chosen activity", %{conn: conn, activity: activity} do
      conn = delete(conn, Routes.activity_path(conn, :delete, activity))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.activity_path(conn, :show, activity))
      end
    end
  end

  defp create_activity(_) do
    activity = fixture(:activity)
    %{activity: activity}
  end
end
