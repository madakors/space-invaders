# frozen_string_literal: true

require 'spec_helper'
require './lib/radio'

RSpec.describe Radio do
  subject(:radio) { described_class.new(input) }

  describe '.new' do
    context 'when pattern is invalid' do
      let(:input) { ['--ooooooo--', '---o-o', '---oo-oo---'] }

      it 'raises an error' do
        expect { subject }.to raise_error(Radio::InvalidRadioPattern,
                                          'Nonuniform pattern supplied')
      end

      context 'when pattern is valid' do
        let(:input) { ['--ooooooo--', '---oo-oo---'] }

        it 'returns an instance' do
          expect(subject).to be_a(Radio)
        end
      end
    end
  end

  describe '#segment' do
    let(:input) { ['--ooooooo--', '---oo-oo---'] }
    let(:width) { 3 }
    let(:segments) do
      {
        0 => ['--o', '-oo', 'ooo', 'ooo', 'ooo', 'ooo', 'ooo', 'oo-', 'o--'],
        1 => ['---', '--o', '-oo', 'oo-', 'o-o', '-oo', 'oo-', 'o--', '---']
      }
    end

    it 'yields segments' do
      radio.segment(3) do |segment, row, column|
        expect(segment).to eq(segments[row][column])
      end
    end
  end

  describe '#each_with_index' do
    let(:input) { ['--ooooooo--', '---oo-oo---'] }

    it 'delegates to the instance variable' do
      expect(radio.instance_variable_get('@radio')).to receive(:each_with_index).once

      radio.each_with_index
    end
  end
end
