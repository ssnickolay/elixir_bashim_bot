defmodule ElixirBashimBot.Commands do
  @help_message "Available commands:
  /random   - get random quote
  /get <ID> - get quote by ID
  /help     - this help message
  "

  def handle_command(chat_id, command = "random", args) do
    Nadia.send_message(chat_id, BashIM.get_random)
  end

  def handle_command(chat_id, command = "get", args = []) do
    Nadia.send_message(chat_id, "ID is missed")
  end

  def handle_command(chat_id, command = "get", args) do
    Nadia.send_message(chat_id, BashIM.get(hd(args)))
  end

  def handle_command(chat_id, command = "help", args) do
    Nadia.send_message(chat_id, @help_message)
  end

  def handle_command(chat_id, command, args) do
    Nadia.send_message(chat_id, 'Not a command. Send /help')
  end
end