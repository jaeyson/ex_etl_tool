defmodule ExEtlTool.Connector do
  @moduledoc """
  Connector for MySQL and Postgres
  """

  @doc """
  Connect to a remote MySQL database. Returns either PID or `:error` atom.

  ## Examples

      iex> options = %{"username" => "mysql", "password" => "mysql", "hostname" => "localhost", "database" => "app_dev"}
      iex> pid = Connector.connect("mysql", options)
      #PID<0.695.0>

  """
  @spec connect(String.t(), map()) :: pid() | :error
  def connect("mysql", options) do
    username = options["username"]
    password = options["password"] || nil
    hostname = options["hostname"] || "localhost"
    database = options["database"] || nil

    port =
      options["port"]
      |> Kernel.||("")
      |> String.trim()
      |> Integer.parse()
      |> case do
        {int, _str} -> int
        :error -> 3306
      end

    options = [
      username: username,
      password: password,
      hostname: hostname,
      database: database,
      port: port,
      disconnect_on_error_codes: [404]
    ]

    case check_connection(hostname, port) do
      :ok ->
        {:ok, pid} = MyXQL.start_link(options)
        pid

      :error ->
        :error
    end
  end

  @doc """
  Check connection if alive. Returns either :ok or :error.
  """
  @spec check_connection(String.t(), integer()) :: :ok | :error
  def check_connection(hostname, port) do
    hostname = String.to_charlist(hostname)

    case :gen_tcp.connect(hostname, port, []) do
      {:ok, port} ->
        :gen_tcp.close(port)
        :ok

      {:error, _} ->
        :error
    end
  end

  # Multi.new()
  # |> Multi.update(
  #   :image_analytics,
  #   ImageAnalytics.changeset(image_analytics, image_analytics_attrs)
  # )
  # |> Multi.update(:image, Images.changeset(image, image_attrs))
  # |> Multi.run(:notify_user, fn repo, %{image: image} ->
  #   image =
  #     image
  #     |> repo.preload(:user)

  #   if image.image_status_id === featured do
  #     %{image.user.username => [image]}
  #     |> UserNotifier.notify_uploaded_images_to_users("featured")
  #   end

  #   unless image.generated_tags do
  #     {:ok, _} = Admin.generate_tags_and_description(image)
  #   end

  #   {:ok, image}
  # end)
  # |> Repo.transaction()
end
