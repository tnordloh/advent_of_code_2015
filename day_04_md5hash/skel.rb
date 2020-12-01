# frozen_string_literal: true

class Skel
  attr_reader :input
  require 'digest'
  def initialize
    @input = "bgvyzdsv"
  end

  def parsed
    input
  end

  def find_five_zeroes
    x = 1
    while x <= 1_000_000_000 do
      y = Digest::MD5.hexdigest(input + x.to_s)
      if (y.start_with?("00000"))
        require 'pry' ; binding.pry
        return x
      else
        x += 1
      end
    end
  end

  def find_six_zeroes
    x = 1
    while x <= 1_000_000_000 do
      y = Digest::MD5.hexdigest(input + x.to_s)
      if (y.start_with?("000000"))
        return x
      else
        x += 1
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  puts Skel.new.find_five_zeroes
  puts Skel.new.find_six_zeroes
end
