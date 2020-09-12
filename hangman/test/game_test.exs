defmodule GameTest do
  use ExUnit.Case
  alias Hangman.Game

  test "expects new game to return a structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
  end

  test "expects game state isnt changed for a :won game" do
    for state <- [:won, :lost] do
      game = Game.new_game()
          |> Map.put(:game_state, state)

      assert {^game, _} = Game.make_move(game, "asdf")
    end
  end
end
