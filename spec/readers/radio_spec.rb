# frozen_string_literal: true

require 'spec_helper'
require './lib/readers/radio'
require './lib/radio'

RSpec.describe Readers::Radio do
  subject(:reader) { described_class.new(input) }

  describe '#load' do
    context "when input file doesn't exist" do
      let(:input) { 'foo' }

      it 'raises an error' do
        expect { subject.load }.to raise_error(Readers::Radio::InvalidRadioFileError,
                                               'Radio input file is missing')
      end
    end

    context 'when input file is empty' do
      let(:input) { File.join(File.expand_path(File.dirname(File.dirname(__FILE__))), '/fixtures/empty') }

      it 'raises an error' do
        expect { subject.load }.to raise_error(Readers::Radio::InvalidRadioFileError,
                                               'No radio loaded')
      end
    end

    context 'when input file is valid' do
      let(:input) { File.join(File.expand_path(File.dirname(File.dirname(__FILE__))), '/fixtures/radio_input') }

      it 'returns a list of parsed invaders' do
        expect(subject.load).to be_a(Radio)
      end
    end
  end
end
