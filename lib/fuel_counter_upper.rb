# 
class FuelCounterUpper
  def calculate(module_mass)
    (module_mass / 3).to_i - 2
  end

  def total_fuel(module_masses)
    total = 0
    module_masses.each do |mass|
      total += calculate(mass)
    end
    total
  end
end