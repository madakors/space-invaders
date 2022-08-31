# frozen_string_literal: true

require 'singleton'

# Class for comparing a radio segment with an invader line.
# It can also determine if the number of differences exceed the allowed limit
class SpotterAlgorithm
  include Singleton

  def valid?(value)
    value <= limit
  end

  def spot(radio_segment, invader_line)
    radio_segment == invader_line ? 0 : 1
  end

  private

  LIMIT = 5

  private_constant :LIMIT

  def limit
    @limit ||= LIMIT
  end
end
