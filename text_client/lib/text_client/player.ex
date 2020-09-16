defmodule TextClient.Player do

  alias TextClient.State

  # won, lost, good guess, bad guess, already used, initializing
  def play(%State{tally: %{game_state: :won}}) do
    exit_with_message("You Won!")
  end

  def play(%State{tally: %{game_state: :lost}}) do
    exit_with_message("Sorry you lost.")
  end

  def play(game = %State{tally: %{game_state: :good_guess}}) do
    continue_with_message(game, "Good Guess!")
  end

  def play(game = %State{tally: %{game_state: :bad_guess}}) do
    continue_with_message(game, "That was a bad Guess.")
  end

  def play(game) do
    continue(game)
  end

  def continue(game) do
    game
    |> display()
    |> prompt()
    |> make_move()
    |> play()
  end

  def display(game) do
    game
  end

  def prompt(game) do
    game
  end

  def make_move(game) do
    game
  end

  def continue_with_message(game, message) do
    IO.puts(message)
    continue(game)
  end

  defp exit_with_message(message) do
    IO.puts(message)
    exit(:normal)
  end

end
