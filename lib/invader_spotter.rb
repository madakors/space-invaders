# frozen_string_literal: true

# Takes an invader and tries to spot in the radio feed using.
class InvaderSpotter
  def initialize(invader, radio)
    @invader = invader
    @radio = radio

    @spottings = Spottings.new
  end

  def scan
    scan_for_invader

    @spottings.complete
  end

  private

  def scan_for_invader
    @radio.iterate(@invader.width) do |radio_segment, row_index, column_index|
      @spottings.add(Spotting.new(@invader, column_index, row_index)) if head_matches?(radio_segment)

      @spottings.verify(radio_segment, column_index, algorithm)
      @spottings.cleanup!
    end
  end

  def head_matches?(radio_segment)
    algorithm.call(radio_segment, @invader.head).zero?
  end

  def algorithm
    @algorithm ||= ->(radio_segment, invader_line) { radio_segment == invader_line ? 0 : 1 }
  end
end
