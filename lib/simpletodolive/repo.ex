defmodule Simpletodolive.Repo do
  use Ecto.Repo,
    otp_app: :simpletodolive,
    adapter: Ecto.Adapters.Postgres
end
