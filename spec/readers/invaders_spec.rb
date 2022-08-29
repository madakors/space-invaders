# frozen_string_literal: true

require 'spec_helper'
require './lib/readers/invaders'
require './lib/invader'

RSpec.describe Readers::Invaders do
  subject(:reader) { described_class.new(input) }

  describe '#load' do
    context "when input file doesn't exist" do
      let(:input) { 'foo' }

      it 'raises an error' do
        expect { subject.load }.to raise_error(Readers::Invaders::InvalidInvadersFileError,
                                               'Invaders input file is missing')
      end
    end

    context 'when input file is empty' do
      let(:input) { File.join(File.expand_path(File.dirname(File.dirname(__FILE__))), '/fixtures/empty') }

      it 'raises an error' do
        expect { subject.load }.to raise_error(Readers::Invaders::InvalidInvadersFileError,
                                               'No invaders loaded')
      end
    end

    context 'when input file is missing a separator' do
      let(:input) { File.join(File.expand_path(File.dirname(File.dirname(__FILE__))), '/fixtures/invaders_invalid') }

      it 'raises an error' do
        expect { subject.load }.to raise_error(Readers::Invaders::InvalidInvadersFileError,
                                               'Missing separator')
      end
    end

    context 'when input file is valid' do
      let(:input) { File.join(File.expand_path(File.dirname(File.dirname(__FILE__))), '/fixtures/invaders_input') }

      it 'returns a list of parsed invaders' do
        binding.pry
        expect(subject.load).to contain_exactly(be_a(Invader), be_a(Invader))
      end
    end
  end
end
