defmodule RouterExample.Stubs do
  def portfolio_entries do
    for x <- 1..10, do: %{name: "Project #{x}", image: "https://picsum.photos/400/300/?random"}
  end

  def submit_contact(params) do
    IO.inspect(params)
  end
end
