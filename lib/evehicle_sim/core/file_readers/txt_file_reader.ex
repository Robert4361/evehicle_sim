defmodule EvehicleSim.Core.FileReaders.TxtFileReader do
  def open_file(file_name) do
    File.stream!(Path.expand("files/#{file_name}"))
    |> Enum.map(fn row ->
      row
      |> String.trim()
      |> String.split("=")
      |> List.to_tuple()
    end)
  end
end
