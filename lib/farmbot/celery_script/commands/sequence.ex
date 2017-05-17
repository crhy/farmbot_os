defmodule Farmbot.CeleryScript.Command.Sequence do
  @moduledoc """
    Sequence
  """

  alias Farmbot.CeleryScript.{Command, Ast}
  require Logger

  @behaviour Command

  @doc ~s"""
    Executes a sequence. this one is non blocking and needs to disapear.
      args: %{},
      body: [Ast.t]
  """
  @spec run(%{}, [Ast.t], Ast.context) :: Ast.context
  def run(args, body, context) do
    #TODO(connor) wait for all rpcs to be done first.
    # rebuild the ast node
    ast = %Ast{kind: "sequence", args: args, body: body}
    # Logger.debug "Starting sequence: #{inspect ast}"
    {:ok, pid} = Farmbot.SequenceRunner.start_link(ast)
    Farmbot.SequenceRunner.wait(pid)
  end
end
