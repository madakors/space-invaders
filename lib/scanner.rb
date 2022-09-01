# frozen_string_literal: true

# Scans the radio feed for invaders, using a dedicated spotter for each invader
class Scanner
  def initialize(radio, invaders)
    @radio = radio
    @invaders = invaders
  end

  def scan
    result = @invaders.map { |invader| InvaderSpotter.new(invader, @radio) }.map(&:scan)

    Spottings.from_array(result.flatten)
  end
end
