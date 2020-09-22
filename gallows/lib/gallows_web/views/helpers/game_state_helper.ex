defmodule Gallows.Views.Helpers.GameStateHelper do
  import Phoenix.HTML, only: [raw: 1]

  @responses %{
    :won => {:success, "You Won!"},
    :lost => {:danger, "Sorry you lost."},
    :good_guess => {:success, "Good guess!"},
    :bad_guess => {:warning, "That was a bad guess."},
    :already_used => {:info, "This letter has already been used."}
  }
  def game_state(state) do
    @responses[state]
    |> alert()
  end

  def words_so_far(tally) do
    tally.letters
    |> Enum.join(" ")
  end

  defp alert(nil), do: ""

  defp alert({class, message}) do
    """
    <div class="alert alert-#{class}">
      #{message}
    </div>
    """
    |> raw()
  end
end
