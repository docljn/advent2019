# frozen_string_literal: true

require 'passcode'

class PasscodeGenerator
  def for_range(lower_bound, upper_bound)
    codes = []
    (lower_bound..upper_bound).each do |number|
      passcode = Passcode.new(number)
      codes << passcode if passcode.valid?
    end
    codes
  end
end
