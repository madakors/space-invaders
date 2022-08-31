# frozen_string_literal: true

module Readers
  # Reader for radio input
  class Radio
    InvalidRadioFileError = Class.new(StandardError)

    def initialize(input)
      @input = input
      @radio = []
    end

    def load
      raise InvalidRadioFileError, 'Radio input file is missing' unless File.exist?(@input)

      load_radio_signals

      raise InvalidRadioFileError, 'No radio loaded' if @radio.empty?

      ::Radio.new(@radio)
    end

    private

    def load_radio_signals
      File.foreach(@input).with_index do |line, index|
        line.chomp!

        @radio << line
      end
    end
  end
end
