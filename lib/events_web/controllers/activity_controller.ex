defmodule EventsWeb.ActivityController do
  use EventsWeb, :controller

  alias Events.Activities
  alias Events.Activities.Activity

  action_fallback EventsWeb.FallbackController

  def index(conn, _params) do
    activities = Activities.list_activities()
    render(conn, "index.json", activities: activities)
  end

  def create(conn, %{"activity" => activity_params}) do
    with {:ok, %Activity{} = activity} <- Activities.create_activity(activity_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.activity_path(conn, :show, activity))
      |> render("show.json", activity: activity)
    end
  end

  def show(conn, %{"id" => id}) do
    activity = Activities.get_activity!(id)
    render(conn, "show.json", activity: activity)
  end

  def update(conn, %{"id" => id, "activity" => activity_params}) do
    activity = Activities.get_activity!(id)

    with {:ok, %Activity{} = activity} <- Activities.update_activity(activity, activity_params) do
      render(conn, "show.json", activity: activity)
    end
  end

  def delete(conn, %{"id" => id}) do
    activity = Activities.get_activity!(id)

    with {:ok, %Activity{}} <- Activities.delete_activity(activity) do
      send_resp(conn, :no_content, "")
    end
  end
end
