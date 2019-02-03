defmodule RouterExample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(scheme: :http, plug: RouterExample.Router, options: [port: application_port()])
    ]

    opts = [strategy: :one_for_one, name: RouterExample.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp application_port do
    System.get_env()
    |> Map.get("PORT", "4001")
    |> String.to_integer()
  end
end
