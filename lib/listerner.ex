defmodule Listener do
  require Logger

  def listen(offset \\ 0, callback) do
    case Nadia.get_updates(limit: 10, timeout: 10, offset: offset) do
      {:ok, updates} ->
        case updates do
          [] -> listen(offset, callback)
          upds ->
            Enum.each(upds, &callback.(&1))
            max = Enum.max_by(upds, fn(upd) -> upd.update_id end, fn -> 0 end).update_id
            listen(max + 1, callback)
        end

      {:error, error} ->
        Logger.debug fn -> inspect(error) end
        listen(offset, callback)
    end
  end
end