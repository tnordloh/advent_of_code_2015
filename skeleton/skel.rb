# frozen_string_literal: true

class FileName
  attr_reader :input
  def initialize
    @input = File.read('input.txt')
  end
end

if $PROGRAM_NAME == __FILE__
  p output = '01110110101001000'
  p length = 35_651_584
  output = EraseMyTracks.dragon_curve(output, length)
  p EraseMyTracks.checksum(output)
end
