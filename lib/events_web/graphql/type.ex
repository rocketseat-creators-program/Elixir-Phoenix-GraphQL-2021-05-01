defmodule EventsWeb.Graphql.Types do
  use Absinthe.Schema.Notation

  object :guests do
    field :id, :id
    field :name, :string
    field :email, :string
  end

  object :events do
    field :id, :id
    field :name, :string
    field :date_event, :string
  end
  
end
