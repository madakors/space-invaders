# frozen_string_literal: true

require 'forwardable'

# Class for radio feed
class Radio
  extend Forwardable

  InvalidRadioPattern = Class.new(StandardError)

  def initialize(input)
    @radio = input
    raise InvalidRadioPattern, 'Nonuniform pattern supplied' unless valid?
  end

  def segment(width, &block)
    normalised(width).each do |row_index, segments|
      segments.each_with_index do |segment, column_index|
        block.call(segment, row_index, column_index)
      end
    end
  end

  def_delegator :@radio, :each_with_index

  private

  def normalised(width)
    @radio.map.with_index { |row, index| [index, row.split('').each_cons(width).map(&:join)] }.to_h
  end

  def valid?
    @radio.all? { |radio_line| radio_line.length == @radio.first.length }
  end
end
