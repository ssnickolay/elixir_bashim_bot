defmodule Listener do
  require Logger

  def listen(offset \\ 0, callback) do
    case Nadia.get_updates(limit: 10, timeout: 10, offset: offset) do
      {:ok, updates} ->
        handle_updates(updates, offset, callback)
      {:error, error} ->
        Logger.debug fn -> inspect(error) end
        listen(offset, callback)
    end
  end

  defp handle_updates([], offset, callback), do: listen(offset, callback)
  defp handle_updates(updates, _offset, callback) do
    Enum.each(updates, &callback.(&1))
    max = Enum.max_by(updates, &(&1.update_id), fn -> %{update_id: 0} end).update_id
    listen(max + 1, callback)
  end
end
