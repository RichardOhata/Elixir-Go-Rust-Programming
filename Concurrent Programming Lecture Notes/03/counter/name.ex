defmodule Name do
  # defstruct first: nil, last: nil
  defstruct [:first, :last]

  def new(first, last) do
    %Name{first: first, last: last}
  end
end
