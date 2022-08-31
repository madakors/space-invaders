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
end
