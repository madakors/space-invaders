# frozen_string_literal: true

require'pry'
module Readers
  # Reader for invaders input
  class Invaders
    SEPARATOR = '~~~~'

    InvalidInvadersFileError = Class.new(StandardError)

    def initialize(input)
      @input = input
      @invaders = []
      @separator_count = 0
      @invader = []
    end

    def load
      raise InvalidInvadersFileError, 'Invaders input file is missing' unless File.exist?(@input)

      load_invaders

      raise InvalidInvadersFileError, 'No invaders loaded' if @invaders.empty?

      @invaders.map { |invader| Invader.new(invader) }
    end

    private

    def load_invaders
      File.foreach(@input).with_index do |line, index|
        line.chomp!
        raise InvalidInvadersFileError, 'Missing separator' if index.zero? && line != SEPARATOR

        if line == SEPARATOR
          @separator_count += 1
        elsif line == ''
          next
        else
          @invader << line
        end

        if @separator_count.even?
          @invaders << @invader
          @invader = []
        end
      end
    end
  end
end
