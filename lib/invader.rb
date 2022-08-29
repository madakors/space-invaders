class Invader
  InvalidInvaderPattern = Class.new(StandardError)

  def self.build(pattern:)
    new(pattern)
  end

  def initialize(pattern)
    @pattern = pattern
    @segment = 0
    raise InvalidInvaderPattern, 'Nonuniform pattern supplied' unless valid?
  end

  def head
    @pattern.first
  end

  def height
    @pattern.length
  end

  def width
    head.length
  end

  def next_segment
    return nil if @segment == @pattern.length

    segment = @pattern[@segment]
    @segment += 1
    segment
  end

  def next_segment?
    @segment < @pattern.length - 1
  end

  attr_reader :pattern

  private

  def valid?
    @pattern.all? { |sub| sub.length == @pattern.first.length }
  end
end
