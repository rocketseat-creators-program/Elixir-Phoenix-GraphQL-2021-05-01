defmodule Events.Guests.Guest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "guests" do
    field :email, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(guest, attrs) do
    guest
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
