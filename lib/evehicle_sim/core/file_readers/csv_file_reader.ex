defmodule CsvFileReader do
  @type csv_header() :: [String.t()]
  @type csv_data() :: [String.t()]

  @spec open_file(String.t()) :: [csv_header() | csv_data()]
  def open_file(file_name) do
    File.stream!(Path.expand("files/#{file_name}"))
    |> Enum.map(fn row ->
      row
      |> String.trim()
      |> String.split(",")
    end)
  end
end
