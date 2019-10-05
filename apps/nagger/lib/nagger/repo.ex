defmodule Nagger.Repo do
  use Ecto.Repo,
    otp_app: :nagger,
    adapter: Ecto.Adapters.Postgres
end
