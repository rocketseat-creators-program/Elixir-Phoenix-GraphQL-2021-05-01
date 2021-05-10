defmodule EventsWeb.Router do
  use EventsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", EventsWeb do
    pipe_through :api

    resources "/events", ActivityController
    resources "/guests", GuestController
  end

  forward "/graph", Absinthe.Plug, schema: EventsWeb.Graphql.Schema

  forward "/graphiql", Absinthe.Plug.GraphiQL, schema: EventsWeb.Graphql.Schema
end
