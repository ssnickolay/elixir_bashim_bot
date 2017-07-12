defmodule BashIM do
  @urls %{
    random: "http://bash.im/random",
    quote: "http://bash.im/quote"
  }

  def get_random do
    case HTTPoison.get(@urls[:random]) do
      {:ok, response} ->
        find_random(response.body)
      {:error, _} ->
        "error"
    end
  end

  def get(id) do
    case HTTPoison.get("#{@urls[:quote]}/#{id}") do
      {:ok, response} ->
          find_random(response.body)
      {:error, _} ->
        "error"
    end
  end

  def find_random(body) do
    try do
      result = body
               |> Floki.find("div.quote>div.text")
               |> Enum.map(&Floki.text/1)
               |> Enum.map(&Codepagex.to_string(&1, :"VENDORS/MICSFT/WINDOWS/CP1251"))
               |> Enum.filter(fn(x) -> elem(x, 0) == :ok end)
               |> Enum.random
      elem(result, 1)
    rescue
      _e in Enum.EmptyError ->
        "Not found"
    end
  end
end
