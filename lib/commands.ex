defmodule ElixirBashimBot.Commands do
  @help_message "Available commands:
  /random   - get random quote
  /get <ID> - get quote by ID
  /help     - this help message
  "

  def handle_command(chat_id, "random", _args) do
    Nadia.send_message(chat_id, BashIM.get_random)
  end

  def handle_command(chat_id, "get", []) do
    Nadia.send_message(chat_id, "ID is missed")
  end

  def handle_command(chat_id, "get", args) do
    Nadia.send_message(chat_id, BashIM.get(hd(args)))
  end

  def handle_command(chat_id, "help", _args) do
    Nadia.send_message(chat_id, @help_message)
  end

  def handle_command(chat_id, _command, _args) do
    Nadia.send_message(chat_id, "Not a command. Send /help")
  end
end
