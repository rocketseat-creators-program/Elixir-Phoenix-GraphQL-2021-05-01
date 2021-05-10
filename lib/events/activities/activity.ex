defmodule Events.Activities.Activity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "activities" do
    field :date_event, :date
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(activity, attrs) do
    activity
    |> cast(attrs, [:name, :date_event])
    |> validate_required([:name, :date_event])
  end
end
