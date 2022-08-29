# frozen_string_literal: true

require 'spec_helper'
require './lib/invader'

RSpec.describe Invader do
  subject(:invader) { described_class.new(pattern) }

  describe '.new' do
    context 'when pattern is invalid' do
      let(:pattern) { ['--ooooooo--', '---o-o', '---oo-oo---'] }

      it 'raises an error' do
        expect { subject }.to raise_error(Invader::InvalidInvaderPattern,
                                          'Nonuniform pattern supplied')
      end

      context 'when pattern is valid' do
        let(:pattern) { ['--ooooooo--', '---oo-oo---'] }

        it 'returns an instance' do
          expect(subject).to be_a(Invader)
        end
      end
    end
  end
end
