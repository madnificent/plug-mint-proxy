defmodule PlugMintProxyDebug do
  @moduledoc """
    Allows running the plug_mint_proxy directly in an example setting.
  """

  use Application
  require Logger

  def start(_type, _args) do
    public_port_env =
      System.get_env("PROXY_PORT") && elem(Integer.parse(System.get_env("PROXY_PORT")), 0)

    port = public_port_env || 8888

    children = [
      {ConnectionPool, {}},
      {Plug.Cowboy, scheme: :http, plug: PlugMintProxyExample, options: [port: port]}
    ]

    Logger.info("PlugMintProxy started on #{port}")

    Supervisor.start_link(children, strategy: :one_for_one)
  end

end
