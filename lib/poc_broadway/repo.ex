defmodule PocBroadway.Repo do
  use Ecto.Repo,
    otp_app: :poc_broadway,
    adapter: Ecto.Adapters.Postgres
end
