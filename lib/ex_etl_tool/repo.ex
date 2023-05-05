defmodule ExEtlTool.Repo do
  use Ecto.Repo,
    otp_app: :ex_etl_tool,
    adapter: Ecto.Adapters.Postgres
end
