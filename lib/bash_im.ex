defmodule BashIM do
  @urls %{
    random: "http://bash.im/random",
    quote: "http://bash.im/quote"
  }

  def get_random do
    @urls[:random]
    |> HTTPoison.get()
    |> handle_response()
  end

  def get(id) do
    [ @urls[:quote], id ]
    |> Enum.join("/")
    |> HTTPoison.get()
    |> handle_response()
  end

  defp handle_response({:ok, response}), do: {:ok, find_random(response.body)}
  defp handle_response({:error, _}), do: {:error, "error"}

  defp find_random(body) do
    try do
      result = body
               |> Floki.find("div.quote>div.text")
               |> Stream.map(&Floki.text/1)
               |> Stream.map(&Codepagex.to_string(&1, :"VENDORS/MICSFT/WINDOWS/CP1251"))
               |> Stream.filter(fn(x) -> elem(x, 0) == :ok end)
               |> Enum.random
      elem(result, 1)
    rescue
      _e in Enum.EmptyError ->
        "Not found"
    end
  end
end
