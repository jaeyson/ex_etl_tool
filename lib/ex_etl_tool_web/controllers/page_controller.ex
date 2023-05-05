defmodule ExEtlToolWeb.PageController do
  use ExEtlToolWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
