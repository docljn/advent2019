# 
require 'csv'
require 'pry'
require 'pry-byebug'

class FuelCounterUpper

  def from_file(file_path)
    rows = read_file(file_path)
    array = rows.flatten
    total_fuel(array)
  end

  def calculate(module_mass)
    (module_mass.to_i / 3).to_i - 2
  end

  def total_fuel(module_masses)
    total = 0
    module_masses.each do |mass|
      total += calculate(mass)
    end
    total
  end

  def read_file(file_path)
    CSV.read(file_path)
  end
end