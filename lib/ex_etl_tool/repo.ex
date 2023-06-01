defmodule ExEtlTool.MysqlRepo do
  use Ecto.Repo,
    otp_app: :ex_etl_tool,
    adapter: Ecto.Adapters.MyXQL,
    read_only: true
end

defmodule ExEtlTool.PostgresRepo do
  use Ecto.Repo,
    otp_app: :ex_etl_tool,
    adapter: Ecto.Adapters.Postgres
end
