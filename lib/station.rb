Station = Struct.new(:id, :city, :name, :lat, :long) do
  def distance_from(other)
    Math.sqrt((lat - other.lat) ** 2 + (long - other.long) ** 2)
  end

  def self.from_hash(hash)
    new.tap do |instance|
      instance.members.each { |name| instance[name] = hash[name] }
    end
  end
end
