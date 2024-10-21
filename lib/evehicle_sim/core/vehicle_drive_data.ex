defmodule EvehicleSim.Core.VehicleDriveData do
  alias __MODULE__

  @type t :: %VehicleDriveData{
          milliseconds_since_epoch: integer(),
          speed: float(),
          watt: float(),
          ampere: float(),
          altitude: float(),
          gps_speed: float(),
          vehicle_body_temperature: integer(),
          battery_percentage: integer(),
          battery_voltage: float(),
          battery_capacity: integer(),
          battery_temperature: integer(),
          remaining_mileage: float(),
          total_mileage: float(),
          latitude: float(),
          longitude: float()
        }

  defstruct [
    :milliseconds_since_epoch,
    :speed,
    :watt,
    :ampere,
    :altitude,
    :gps_speed,
    :vehicle_body_temperature,
    :battery_percentage,
    :battery_voltage,
    :battery_capacity,
    :battery_temperature,
    :remaining_mileage,
    :total_mileage,
    :latitude,
    :longitude
  ]

  @fields [
    :milliseconds_since_epoch,
    :speed,
    :watt,
    :ampere,
    :altitude,
    :gps_speed,
    :vehicle_body_temperature,
    :battery_percentage,
    :battery_voltage,
    :battery_capacity,
    :battery_temperature,
    :remaining_mileage,
    :total_mileage,
    :latitude,
    :longitude
  ]

  @spec new(String.t()) :: t()
  def new(row_data) do
    fields =
      row_data
      |> Enum.zip(@fields)
      |> Enum.into(%{}, fn {value, key} -> {key, cast_value(key, value)} end)

    struct(__MODULE__, fields)
  end

  defp cast_value(:milliseconds_since_epoch, value), do: String.to_integer(value)
  defp cast_value(:speed, value), do: String.to_float(value)
  defp cast_value(:watt, value), do: String.to_float(value)
  defp cast_value(:ampere, value), do: String.to_float(value)
  defp cast_value(:altitude, value), do: String.to_float(value)
  defp cast_value(:gps_speed, value), do: String.to_float(value)
  defp cast_value(:vehicle_body_temperature, value), do: String.to_integer(value)
  defp cast_value(:battery_percentage, value), do: String.to_integer(value)
  defp cast_value(:battery_voltage, value), do: String.to_float(value)
  defp cast_value(:battery_capacity, value), do: String.to_integer(value)
  defp cast_value(:battery_temperature, value), do: String.to_integer(value)
  defp cast_value(:remaining_mileage, value), do: String.to_float(value)
  defp cast_value(:total_mileage, value), do: String.to_float(value)
  defp cast_value(:latitude, value), do: String.to_float(value)
  defp cast_value(:longitude, value), do: String.to_float(value)

  defp cast_value(_, value), do: value
end
