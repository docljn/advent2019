require './lib/fuel_counter_upper'

RSpec.describe FuelCounterUpper do

  let(:counter) { FuelCounterUpper.new }

  it "returns 2 when given 12" do
    expect(counter.calculate(12)).to eq 2
  end

  it "returns 2 when given 14" do
    expect(counter.calculate(14)).to eq 2
  end

  it "returns 654 when given 1969" do
    expect(counter.calculate(1969)).to eq 654
  end

  it "returns 33583 when given 100756" do
    expect(counter.calculate(100_756)).to eq 33_583
  end

  it "returns 4 when given 12 and 14" do
    expect(counter.total_fuel([12, 14])).to eq 4
  end

  it "returns an answer when given a file" do
    expect(counter.from_file('./spec/module_masses.csv')).to be(0)
  end
end
