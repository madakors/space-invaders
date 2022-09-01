# frozen_string_literal: true

# Print radio output and highlight the spotted invaders in blue
class Printer
  def initialize(radio, spottings)
    @radio = radio
    @spottings = spottings
  end

  def print
    @radio.each_with_index do |row, row_index|
      row.split('').each_with_index do |character, column_index|
        print_character(character, column_index, row_index)
      end
      Kernel.print("\n")
    end
  end

  private

  def print_character(character, column_index, row_index)
    if spotting_for(column_index, row_index)
      color { Kernel.print(character) }
    else
      Kernel.print(character)
    end
  end

  BLUE = 34

  private_constant :BLUE

  def color(color = BLUE)
    printf "\033[#{color}m"
    yield
    printf "\033[0m"
  end

  def spotting_for(column, row)
    @spottings.find_for(column, row)
  end
end
