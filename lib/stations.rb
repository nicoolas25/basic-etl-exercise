require "csv"
require "station"

class Stations

  include Enumerable

  extend Forwardable
  def_delegators :@stations, :each, :size

  def initialize(stations)
    @stations = stations
  end

  def find(fields_hash)
    @stations.find do |station|
      fields_hash.all? { |name, value| station[name] == value }
    end
  end

  def closest(reference_station)
    (@stations - [reference_station]).min_by do |station|
      station.distance_from(reference_station)
    end
  end

  def self.from_csv(filepath)
    stations = []
    CSV.foreach(filepath, csv_options) do |row|
      csv_coercion!(row)
      stations << Station.from_hash(row)
    end
    new(stations)
  end

  private

  def self.csv_options
    {
      col_sep: ";",
      headers: true,
      header_converters: :symbol,
    }
  end

  def self.csv_coercion!(row)
    row[:id] = row[:id].to_i
    row[:lat] = row[:lat].to_f
    row[:long] = row[:long].to_f
  end

end
