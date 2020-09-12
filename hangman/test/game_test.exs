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

  test "expects first time a letter is used it wont be used" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "expects second time a letter is used it will be used" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end
end
