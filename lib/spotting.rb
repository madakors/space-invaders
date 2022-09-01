# frozen_string_literal: true

# Class that verifies that radio feed segments match an invader pattern.
# It iterates through an invader pattern and marks the spotting either valid
# or invalid based on the algorithm's output. Only segments that match the
# initial's column position are considered.
class Spotting
  def initialize(invader, column_index, row_index)
    @invader = invader
    @column_index = column_index
    @row_index = row_index
    @difference = 0
    mark_position
  end

  def verify(radio_segment, position)
    return if @column_index != position
    return if complete?

    @difference += SpotterAlgorithm.instance.spot(radio_segment, @iterator.next)
  end

  def valid?
    SpotterAlgorithm.instance.valid?(@difference)
  end

  def invalid?
    !valid?
  end

  def complete?
    !iterator.next?
  end

  def contains?(point_x, point_y)
    point_x >= @position[:x_start] && point_x <= @position[:x_end] &&
      point_y >= @position[:y_start] && point_y <= @position[:y_end]
  end

  private

  def iterator
    @iterator ||= InvaderIterator.new(@invader)
  end

  def mark_position
    @position = {
      x_start: @column_index,
      y_start: @row_index,
      x_end: @column_index + @invader.width - 1,
      y_end: @row_index + @invader.height - 1
    }
  end
end
