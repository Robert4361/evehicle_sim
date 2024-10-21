defmodule EvehicleSim.Core.Radar do
  alias __MODULE__

  @type t :: %Radar{
          id: integer(),
          max_speed: integer(),
          max_duration: integer(),
          max_distance: integer(),
          radar_address: String.t(),
          gps_width: float(),
          gps_length: float()
        }
  defstruct [
    :id,
    :max_speed,
    :max_duration,
    :max_distance,
    :radar_address,
    :gps_width,
    :gps_length
  ]

  @spec new([{String.t(), String.t()}]) :: t()
  def new(radar_info) do
    fields =
      radar_info
      |> Map.new(fn {key, value} -> {String.to_atom(key), cast_value(key, value)} end)

    struct(__MODULE__, fields)
  end

  defp cast_value("id", value), do: String.to_integer(value)
  defp cast_value("max_speed", value), do: String.to_integer(value)
  defp cast_value("max_duration", value), do: String.to_integer(value)
  defp cast_value("max_distance", value), do: String.to_integer(value)
  defp cast_value("gps_width", value), do: String.to_float(value)
  defp cast_value("gps_length", value), do: String.to_float(value)

  defp cast_value(_key, value), do: value
end
