# frozen_string_literal: true

require 'pry-byebug'

class Passcode

  attr_reader :code

  def initialize(code)
    @code = code
  end

  def valid?
    integer? && within_range? && double_digits? && !decrease?
  end

  def inspect
    code
  end

  private
  
  def integer?
    code.to_i == code
  end

  def within_range?
    code > 271_972 && code < 785_961
  end

  def double_digits?
    return false unless squeezed.to_i < code

    consecutive_chars = code.to_s.chars.chunk_while{|first, second| first == second }.map(&:count)

    return consecutive_chars.include?(2)
  end

  
  def decrease?
    return false if squeezed.length == 1

    numbers = squeezed.split(//)
    numbers.each_with_index do |number, index|
      next if index.zero?
      return true if number.to_i < numbers[index - 1].to_i
    end
    false
  end

  def squeezed
    @squeezed ||= code.to_s.squeeze
  end
end
