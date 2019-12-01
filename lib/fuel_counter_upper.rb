# frozen_string_literal: true

require 'csv'
require 'pry'
require 'pry-byebug'

class FuelCounterUpper
  def from_file(file_path)
    rows = read_file(file_path)
    array = rows.flatten
    total_fuel(array)
  end

  def total_fuel(module_masses)
    total = 0
    module_masses.each do |mass|
      total += calculate_recursive(mass)
    end
    total
  end

  def read_file(file_path)
    CSV.read(file_path)
  end

  private

  # def calculate(module_mass)
  #   total_fuel = 0
  #   fuel = fuel_for_mass(module_mass)
  #   while fuel.positive?
  #     total_fuel += fuel
  #     fuel = fuel_for_mass(fuel)
  #   end
  #   total_fuel
  # end

  def fuel_for_mass(mass)
    (mass.to_i / 3).to_i - 2
  end

  def calculate_recursive(module_mass)
    total_fuel = 0
    added_fuel = fuel_for_mass(module_mass)
    calculate_recursion(module_mass, total_fuel, added_fuel)
  end

  def calculate_recursion(module_mass, total_fuel, added_fuel)
    return total_fuel if added_fuel <= 0

    total_fuel += added_fuel
    added_fuel = fuel_for_mass(added_fuel)
    calculate_recursion(module_mass, total_fuel, added_fuel)
  end
end
