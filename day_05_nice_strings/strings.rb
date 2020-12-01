# frozen_string_literal: true

class Strings
  attr_reader :input
  def initialize
    @input = File.open('input.txt', 'r')
  end

  def parsed
    @parsed ||= input.each.map do |line|
      line.strip
    end
  end

  def nice_strings
    parsed.select do |string|
      string.scan(/[aeiou]/).count >= 3 &&
      string.scan(/([a-z])\1+/).count >= 1 &&
      string.scan(/(ab|cd|pq|xy)/).count == 0
    end
  end

  def nicer_strings
    parsed.select do |string|
      string.scan(/([a-z]).\1/).count >= 1 &&
      string.scan(/(..).*\1/).count >= 1
    end
  end
end

if $PROGRAM_NAME == __FILE__
  strings = Strings.new
  p strings.parsed.count
  p strings.nice_strings.count
  p strings.nicer_strings.count
end
