# frozen_string_literal: true

require './lib/fuel_counter_upper'

RSpec.describe FuelCounterUpper do
  let(:counter) { FuelCounterUpper.new }

  it 'returns 2 when given [12]' do
    expect(counter.total_fuel([12])).to eq 2
  end

  it 'returns 2 when given 14' do
    expect(counter.total_fuel([14])).to eq 2
  end

  it 'returns 4 when given [12, 14]' do
    expect(counter.total_fuel([12, 14])).to eq 4
  end

  context 'fuel has a mass' do
    it 'returns 966 when given 1969' do
      expect(counter.total_fuel([1969])).to eq 966
    end

    it 'returns 50,346 when given 100756' do
      expect(counter.total_fuel([100_756])).to eq 50_346
    end
  end

  it 'returns an answer when given a file' do
    expect(counter.from_file('./spec/module_masses.csv')).to be_truthy
  end
end
