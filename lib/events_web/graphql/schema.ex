defmodule EventsWeb.Graphql.Schema do
  alias EventsWeb.Graphql.Resolver
  use Absinthe.Schema
  import_types(EventsWeb.Graphql.Types)

  query do
    field :guests, list_of(:guests) do
      async(fn -> resolve(&Resolver.guests/2) end)
    end

    field :events, list_of(:events) do
      async(fn -> resolve(&Resolver.events/2) end)
    end
  end

  mutation do
    field :create_guest, type: :guests do
      arg(:name, :string)
      arg(:email, :string)
      resolve(&Resolver.create_guest/2)
    end

    field :create_event, type: :events do
      arg(:name, :string)
      arg(:date_event, :string)
      resolve(&Resolver.create_event/2)
    end
  end
end
