defmodule Lec1 do
  @pi 3.14159

  def fact(n) do
    if n <= 0 do
      1
    else
      n * fact(n - 1)
    end
  end

  def fact2(n), do: fact2(n, 1)

  defp fact2(n, acc) do
    if n <= 0, do: acc, else: fact2(n - 1, n * acc)
  end

  def fact3(n) when n <= 0, do: 1

  def fact3(n), do: n * fact3(n - 1)

  def fizzbuzz1(n), do: fizzbuzz1(1, n)

  def fizzbuzz1(i, n) when i > n, do: :ok

  def fizzbuzz1(i, n) do
    IO.puts("test")
    cond do
      rem(i, 15) == 0 -> IO.puts("fizzbuzz")
      rem(i, 5) == 0 -> IO.puts("buzz")
      rem(i, 3) == 0 -> IO.puts("fizz")
      true -> IO.puts(i)
    end

    fizzbuzz1(i + 1, n)
  end

  def area(shape) do
    case shape do
      {:square, width} -> width * width
      {:circle, radius} -> @pi * radius * radius
      {:rectangle, width, height} -> width * height
      _ -> :unknown
    end
  end
end
