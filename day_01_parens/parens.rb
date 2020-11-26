# frozen_string_literal: true

# parens
class Parens
  attr_reader :input
  def initialize
    @input = File.read('input.txt')
  end

  def final_floor
    input.delete(')').size - input.delete('(').size
  end

  def step(path)
    @path.chop == '(' ? +1 : -1
  end

  def steps_to_floor(floor)
    @input.chars.each.with_index(0).reduce(0) do |current_floor, (direction, index)|
      return index if current_floor == floor

      direction == '(' ? current_floor + 1 : current_floor - 1
    end
  end
end

if $PROGRAM_NAME == __FILE__
  parens = Parens.new
  # require 'pry'; binding.pry
  p parens.steps_to_floor(-1)
end
