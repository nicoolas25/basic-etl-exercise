require "stations"

RSpec.describe "Stations" do
  subject(:collection) { Stations.from_csv("./spec/fixtures/example.csv") }

  it "contains Station elements" do
    expect(collection.size).to eq 4
    collection.each do |element|
      expect(element).to be_a Station
    end
  end

  describe "find(conditions)" do
    let(:conditions) { { name: "Lyon-Part-Dieu" } }

    subject(:result) { collection.find(conditions) }

    it "returns a station matching the given conditions" do
      expect(result).to be_a Station
      expect(result.id).to eq 4
    end

    context "when there is no match" do
      let(:conditions) { { name: "Massy-Palaiseau" } }

      it { is_expected.to be_nil }
    end
  end

  describe "closest(reference_station)" do
    let(:reference_station) { collection.find(name: "Lyon-Part-Dieu") }

    subject(:closest_station) { collection.closest(reference_station) }

    it "returns the closest station to the reference_station in collection" do
      expected_station = collection.find(name: "Paris-Gare-de-Lyon")
      expect(closest_station).to be expected_station
    end
  end
end
