defmodule EventsWeb.ActivityView do
  use EventsWeb, :view
  alias EventsWeb.ActivityView

  def render("index.json", %{activities: activities}) do
    %{data: render_many(activities, ActivityView, "activity.json")}
  end

  def render("show.json", %{activity: activity}) do
    %{data: render_one(activity, ActivityView, "activity.json")}
  end

  def render("activity.json", %{activity: activity}) do
    %{
      id: activity.id,
      name: activity.name,
      description: activity.description,
      date_event: activity.date_event,
      is_active: activity.is_active,
      events: activity.events
    }
  end
end
