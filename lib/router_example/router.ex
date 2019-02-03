defmodule RouterExample.Router do
  use Plug.Router

  alias RouterExample.Stubs

  @template_dir "lib/router_example/templates"

  plug Plug.Parsers,
    parsers: [:urlencoded, :json],
    pass: ["text/*"],
    json_decoder: Jason

  plug :match
  plug :dispatch

  get "/ping" do
    send_resp(conn, 200, "pong")
  end

  get "/" do
    render(conn, "index.html", portfolio: Stubs.portfolio_entries())
  end

  get "/contact" do
    render(conn, "contact.html")
  end

  post "/contact" do
    Stubs.submit_contact(conn.params)
    render_json(conn, %{message: "Thank you! We will get back to you shortly."})
  end

  match _ do
    send_resp(conn, 404, "Oh no! What you seek cannot be found.")
  end

  defp render(%{status: status} = conn, template, assigns \\ []) do
    body =
      @template_dir
      |> Path.join(template)
      |> String.replace_suffix(".html", ".html.eex")
      |> EEx.eval_file(assigns)

    send_resp(conn, (status || 200), body)
  end

  defp render_json(%{status: status} = conn, data) do
    body = Jason.encode!(data)
    send_resp(conn, (status || 200), body)
  end
end
