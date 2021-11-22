defmodule ParserPoc do
  import NimbleParsec
  @moduledoc """
  Documentation for `ParserPoc`.
  """

  text = ascii_string([not: ?\s], min: 1)

  defparsec :ast, 
    repeat(text)
      |> repeat(text)
      |> ignore(string(" "))
      |> (string("is a"))
      |> ignore(string(" "))
      |> repeat(text)
  
  def ast_parse(str) do
    case ast(str) do
      {:ok, [variable, _relation, concept], _,_,_,_} -> {
        %{
          left: variable,
          rigth: concept,
        }
      }
      {:error} -> {:error, :wrong_format}
    end
  end

  # ParserPoc.ast_parse("$taxpayer is a User")
end
