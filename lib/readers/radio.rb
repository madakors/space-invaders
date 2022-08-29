module Readers
  class Radio
    SEPARATOR = '~~~~'

    InvalidRadioFileError = Class.new(StandardError)

    def initialize(input)
      @input = input
      @radio_signals = []
    end

    def load
      load_radio_signals
      @radio_signals
    end

    private

    def load_radio_signals
      File.foreach(@input).with_index do |line, index|
        line.chomp!
        raise InvalidRadioFileError, 'Missing separator' if index.zero? && line != SEPARATOR

        @radio_signals << line unless line == SEPARATOR
      end
    end
  end
end
