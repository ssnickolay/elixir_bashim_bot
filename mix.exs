defmodule ElixirBashimBot.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_bashim_bot,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: [main_module: ElixirBashimBot],
     deps: deps()]
  end

  def application do
    [applications: [:logger, :nadia, :httpoison]]
  end

  defp deps do
    [
      {:nadia, "~> 0.4.2"},
      {:httpoison, "~> 0.12"},
      {:floki, "~> 0.17.0"},
      {:codepagex, "~> 0.1.4"},
    ]
  end
end
