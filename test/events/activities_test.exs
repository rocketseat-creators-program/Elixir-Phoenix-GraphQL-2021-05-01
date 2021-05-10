defmodule Events.ActivitiesTest do
  use Events.DataCase

  alias Events.Activities

  describe "activities" do
    alias Events.Activities.Activity

    @valid_attrs %{
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

    def activity_fixture(attrs \\ %{}) do
      {:ok, activity} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Activities.create_activity()

      activity
    end

    test "list_activities/0 returns all activities" do
      activity = activity_fixture()
      assert Activities.list_activities() == [activity]
    end

    test "get_activity!/1 returns the activity with given id" do
      activity = activity_fixture()
      assert Activities.get_activity!(activity.id) == activity
    end

    test "create_activity/1 with valid data creates a activity" do
      assert {:ok, %Activity{} = activity} = Activities.create_activity(@valid_attrs)
      assert activity.date_event == ~N[2010-04-17 14:00:00]
      assert activity.description == "some description"
      assert activity.events == "some events"
      assert activity.is_active == true
      assert activity.name == "some name"
    end

    test "create_activity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Activities.create_activity(@invalid_attrs)
    end

    test "update_activity/2 with valid data updates the activity" do
      activity = activity_fixture()
      assert {:ok, %Activity{} = activity} = Activities.update_activity(activity, @update_attrs)
      assert activity.date_event == ~N[2011-05-18 15:01:01]
      assert activity.description == "some updated description"
      assert activity.events == "some updated events"
      assert activity.is_active == false
      assert activity.name == "some updated name"
    end

    test "update_activity/2 with invalid data returns error changeset" do
      activity = activity_fixture()
      assert {:error, %Ecto.Changeset{}} = Activities.update_activity(activity, @invalid_attrs)
      assert activity == Activities.get_activity!(activity.id)
    end

    test "delete_activity/1 deletes the activity" do
      activity = activity_fixture()
      assert {:ok, %Activity{}} = Activities.delete_activity(activity)
      assert_raise Ecto.NoResultsError, fn -> Activities.get_activity!(activity.id) end
    end

    test "change_activity/1 returns a activity changeset" do
      activity = activity_fixture()
      assert %Ecto.Changeset{} = Activities.change_activity(activity)
    end
  end
end
