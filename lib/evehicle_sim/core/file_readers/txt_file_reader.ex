defmodule EvehicleSim.Core.FileReaders.TxtFileReader do
  def open_file(file_name) do
    path = Path.expand("files/#{file_name}")

    if File.exists?(path) do
      data =
        File.stream!(path)
        |> Enum.map(fn row ->
          row
          |> String.trim()
          |> String.split("=")
          |> List.to_tuple()
        end)
      {:ok, data}
    else
      {:error, :file_not_found}
    end
  end
end
