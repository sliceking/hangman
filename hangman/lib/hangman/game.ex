defmodule Hangman.Game do
  defstruct letters: [],
            game_state: :initializing,
            turns_left: 7

  def new_game() do
    %Hangman.Game{
      letters: Dictionary.random_word() |> String.codepoints()
    }
  end

  def make_move(game = %{ game_state: state }, _guess) when state in [:won, :lost] do
    { game, tally(game) }
  end

  def tally(game) do
    123
  end
end
