# frozen_string_literal: true

class Skel
  attr_reader :input
  def initialize
    @input = File.read('input.txt')
  end
end

if $PROGRAM_NAME == __FILE__
  skel = Skel.new
end
