defmodule Events.Repo do
  use Ecto.Repo,
    otp_app: :events,
    adapter: Ecto.Adapters.MyXQL
end
