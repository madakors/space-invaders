# frozen_string_literal: true

# A simple iterator that can iterate through a given invader object
class InvaderIterator
  def initialize(invader)
    @invader = invader
    @index = 0
    @max_index = invader.height
  end

  def next
    return nil if @index == @max_index

    segment = @invader.pattern_at(@index)
    @index += 1
    segment
  end

  def next?
    @index < @max_index
  end
end
