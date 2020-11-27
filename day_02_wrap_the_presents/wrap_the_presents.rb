# frozen_string_literal: true

class WrapThePresents
  attr_reader :input
  def initialize
    @input = File.open('input.txt', 'r')
  end

  def dimensions
    @dimensions ||= input.each.map { |l|
      l.chomp.split('x').map(&:to_i).sort
    }
  end

  def wrapping_paper
    dimensions.map { |line|
      line.combination(2)
      .map { |x, y| x * y }
      .zip([3, 2, 2])
      .map { |x, y| x * y }
      .sum
    }.sum
  end

  def ribbon
    ribbon_perimeter + bow
  end

  private

  def bow
    dimensions.map { |line| line.reduce(:*) }.sum
  end

  def ribbon_perimeter
    dimensions.map { |line| (line[0] + line[1]) * 2 }.sum
  end
end

if $PROGRAM_NAME == __FILE__
  presents = WrapThePresents.new
  p presents.wrapping_paper
  p presents.ribbon
end
