# frozen_string_literal: true

# Value object for invader pattern
class Invader
  InvalidInvaderPattern = Class.new(StandardError)
  InvalidInvaderAccess = Class.new(StandardError)

  def initialize(pattern)
    @pattern = pattern
    raise InvalidInvaderPattern, 'Nonuniform pattern supplied' unless valid?
  end

  def head
    @pattern.first
  end

  def height
    @pattern.length
  end

  def pattern_at(index)
    raise InvalidInvaderAccess, "#{index} is out of bounds for this invader pattern" if index >= height

    @pattern[index]
  end

  def width
    head.length
  end

  attr_reader :pattern

  private

  def valid?
    @pattern.all? { |row| row.length == head.length }
  end
end
