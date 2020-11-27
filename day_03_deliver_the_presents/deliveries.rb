# frozen_string_literal: true

require 'set'
class Deliveries
  attr_reader :input
  def initialize
    @input = File.open('input.txt')
  end

  def parsed
    @parsed ||= input.read.strip.split('')
  end

  def deliver(directions: parsed)
    horizontal_index = 0
    vertical_index = 0
    directions.each_with_object(Set[[0, 0]]) do |char, a|
      case char
      when '<'
        horizontal_index -= 1
      when '>'
        horizontal_index += 1
      when '^'
        vertical_index += 1
      when 'v'
        vertical_index -= 1
      end
      a.add [horizontal_index, vertical_index]
    end
  end
end

if $PROGRAM_NAME == __FILE__
  deliveries = Deliveries.new
  p deliveries.deliver.size
  robo_santa, santa = deliveries.parsed.each_slice(2).to_a.transpose
  robo_deliveries = deliveries.deliver(directions: robo_santa)
  santa_deliveries = deliveries.deliver(directions: santa)
  p robo_deliveries.merge(santa_deliveries).size
end
