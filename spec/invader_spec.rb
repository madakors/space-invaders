# frozen_string_literal: true

require 'spec_helper'
require './lib/invader'

RSpec.describe Invader do
  subject(:invader) { described_class.new(pattern) }

  let(:pattern) { ['--ooooooo--', '---oo-oo---'] }

  describe '.new' do
    context 'when pattern is invalid' do
      let(:pattern) { ['--ooooooo--', '---o-o', '---oo-oo---'] }

      it 'raises an error' do
        expect { invader }.to raise_error(Invader::InvalidInvaderPattern,
                                          'Nonuniform pattern supplied')
      end

      context 'when pattern is valid' do
        let(:pattern) { ['--ooooooo--', '---oo-oo---'] }

        it 'returns an instance' do
          expect(invader).to be_a(Invader)
        end
      end
    end
  end

  describe '#head' do
    it 'returns first row of the invader pattern' do
      expect(invader.head).to eq(pattern.first)
    end
  end

  describe '#height' do
    it 'returns the number of rows in the pattern' do
      expect(invader.height).to eq(pattern.length)
    end
  end

  describe '#width' do
    it 'returns the number of character in a pattern row' do
      expect(invader.width).to eq(pattern.first.length)
    end
  end

  describe '#pattern_at' do
    context 'when index is out of bounds' do
      let(:index) { pattern.length }

      it 'raises an error' do
        expect do
          invader.pattern_at(pattern.length)
        end.to raise_error(Invader::InvalidInvaderAccess, "#{index} is out of bounds for this invader pattern")
      end
    end

    context 'when index is within bounds' do
      let(:index) { pattern.length - 1 }

      it 'returns the line at index' do
        expect(invader.pattern_at(index)).to eq(pattern[index])
      end
    end
  end
end
