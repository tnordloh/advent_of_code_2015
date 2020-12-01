# frozen_string_literal: true

class LightGrid
  Instruction = Struct.new(:direction, :x_range, :y_range)
  attr_reader :input, :light_array
  def initialize
    @input = File.open('input.txt', 'r')
    execute
  end

  INSTRUCTIONS = {
    "toggle" => :toggle,
    "turn off" =>  :off,
    "turn on" => :on,
  }.freeze
  def parsed
    @parsed ||= input.each.map do |line|
      direction = INSTRUCTIONS.find { |k, _| line.include?(k) }.last
      box = line.scan(/\d+,\d+/).map { |directions| directions.split(',').map(&:to_i)}
      normalized_ranges = box[0].zip(box[1])
      x_range =  (normalized_ranges.dig(0, 0)..normalized_ranges.dig(0, 1))
      y_range =  (normalized_ranges.dig(1, 0)..normalized_ranges.dig(1, 1))
      # parse line here
      Instruction.new(direction, x_range, y_range)
    end
  end

  def execute
    @light_array ||= Hash.new { |hash, key| hash[key] = Array.new }
    parsed.each do |instruction|
      perform_action(instruction.x_range, instruction.y_range, instruction.direction)
    end
  end

  def lights_on
    light_array.values.count { |light|
      state = light.reduce(:off) { |acc, val|
        if val == :toggle
          acc == :off ? :on : :off
        else
          val
        end
      }
      state == :on
    }
  end

  def lite_brite
    light_array.values.sum { |light|
      brightness = light.reduce(0) { |acc, val|
        if val    == :toggle
          acc + 2
        elsif val == :on
          acc + 1
        elsif val == :off
          acc.zero? ? acc : acc - 1
        end
      }
    }
  end

  private

  def perform_action(x_range, y_range, direction)
    x_range.each do |x|
      y_range.each do |y|
        light_array[[x, y]] << direction
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  light_grid = LightGrid.new
  p light_grid.lights_on
  p light_grid.lite_brite
end
