defmodule ElixirBashimBot do
  require Logger

  def main(args) do
    args |> process_args
  end

  defp process_args(args) do
    case OptionParser.parse(args, switches: [token: :string], aliases: [t: :token]) do
      {[], [], []} ->
        IO.puts("Token must be provided")
        System.halt(1)
      {options, [], []} ->
        Application.put_env(:codepagex, :encodings, [ :ascii, :ololo ])
        Application.put_env(:nadia, :token, options[:token])
        Listener.listen(0, &handle_update/1)
    end
  end

  defp handle_update(%Nadia.Model.Update{message: %Nadia.Model.Message{chat: chat, text: text}}) when text != nil do
    { command, args } = parse_command(text)
    ElixirBashimBot.Commands.handle_command(chat.id, command, args)
  end

  defp handle_update(_) do
    :ok
  end

  defp parse_command("/" <> rest) do
    [head|tail] = String.split(rest, " ")
    {head, tail}
  end

  defp parse_command(_) do
    {nil, []}
  end
end
