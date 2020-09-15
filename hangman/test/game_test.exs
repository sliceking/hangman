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

  test "expects first time a letter is used it wont be already_used" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "expects second time a letter is used it will be already_used" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "expects a good guess is recognized" do
    game = Game.new_game("wibble")
    {game, _tally} = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "expects guessing the full word is a won game" do
    game = Game.new_game("wibble")
    {game, _tally} = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    {game, _tally} = Game.make_move(game, "i")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    {game, _tally} = Game.make_move(game, "b")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    {game, _tally} = Game.make_move(game, "l")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    {game, _tally} = Game.make_move(game, "e")
    assert game.game_state == :won
    assert game.turns_left == 7
  end

  test "expects a bad guess to be recognized" do
    game = Game.new_game("wibble")
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "expects a lost game to be recognized" do
    game = Game.new_game("wibble")
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
    {game, _tally} = Game.make_move(game, "a")
    assert game.game_state == :bad_guess
    assert game.turns_left == 5
    {game, _tally} = Game.make_move(game, "q")
    assert game.game_state == :bad_guess
    assert game.turns_left == 4
    {game, _tally} = Game.make_move(game, "z")
    assert game.game_state == :bad_guess
    assert game.turns_left == 3
    {game, _tally} = Game.make_move(game, "p")
    assert game.game_state == :bad_guess
    assert game.turns_left == 2
    {game, _tally} = Game.make_move(game, "r")
    assert game.game_state == :bad_guess
    assert game.turns_left == 1
    {game, _tally} = Game.make_move(game, "t")
    assert game.game_state == :lost
  end
end
