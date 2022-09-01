# frozen_string_literal: true

# Main class of the application
class World
  def initialize(options)
    @input = options[:input]
    @precision = options[:precision] || 6

    SpotterAlgorithm.instance.limit = @precision.to_i
  end

  def draw
    spottings = scanner.scan
    Printer.new(radio, spottings).print
  end

  private

  def radio
    @radio ||= Readers::Radio.new(@input).load
  end

  def invaders
    @invaders ||= Readers::Invaders.new('inputs/invaders').load
  end

  def scanner
    @scanner ||= Scanner.new(radio, invaders)
  end
end
