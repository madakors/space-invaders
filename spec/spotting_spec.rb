# frozen_string_literal: true

require 'spec_helper'
require './lib/spotting'
require './lib/invader'
require './lib/invader_iterator'
require './lib/spotter_algorithm'

RSpec.describe Spotting do
  subject(:spotting) { described_class.new(invader, column, row) }

  let(:column) { 0 }
  let(:row) { 0 }
  let(:invader) { Invader.new(invader_pattern) }
  let(:invader_pattern) do
    [
      '--o-----o--',
      '---o---o---',
      '--ooooooo--',
      '-oo-ooo-oo-',
      'ooooooooooo',
      'o-ooooooo-o',
      'o-o-----o-o',
      '---oo-oo---'
    ]
  end
  let(:radio_feed) do
    [
      '-----------'
    ]
  end
  let(:algorithm) { SpotterAlgorithm.instance }

  describe '#verify' do
    context "when column is different from starting position's column" do
      it 'does not verify feed' do
        expect(algorithm).to_not receive(:spot)

        spotting.verify(radio_feed.first, 1)
      end

      context 'when spotting complete' do
        it 'does not verify feed' do
          allow(spotting).to receive(:complete?).and_return(true)

          expect(algorithm).to_not receive(:spot)

          spotting.verify(radio_feed.first, 1)
        end
      end

      context 'when column matches starting position and not complete' do
        before do
          allow(algorithm).to receive(:spot).and_return(0)
        end

        it 'verifies feed' do
          expect(algorithm).to receive(:spot).once

          spotting.verify(radio_feed.first, 0)
        end
      end
    end
  end

  describe '#valid?' do
    let(:difference) { 1 }

    before { spotting.instance_variable_set('@difference', difference) }

    it 'verifies that the difference is valid with the algorithm' do
      expect(algorithm).to receive(:valid?).with(difference).once

      spotting.valid?
    end
  end

  describe '#invalid?' do
    before { allow(spotting).to receive(:valid?).and_return(false) }

    it 'calls valid? and denies its result' do
      expect(spotting).to receive(:valid?).once

      expect(spotting.invalid?).to be(true)
    end
  end

  describe 'complete?' do
    let(:iterator) { instance_double(InvaderIterator, next?: true) }

    before { spotting.instance_variable_set('@iterator', iterator) }

    it 'checks if the invader interactor has next step' do
      expect(iterator).to receive(:next?)

      expect(spotting.complete?).to be(false)
    end
  end

  describe 'contains?' do
    # for the existing invader, position is: {x_start:0, y_start: 0, x_end: 10, y_end: 7}
    context 'when point outside of spot position' do
      it 'returns false' do
        expect(spotting.contains?(11, 0)).to be(false)
      end
    end

    context 'when point inside of spot position' do
      it 'returns true' do
        expect(spotting.contains?(5, 0)).to be(true)
      end
    end
  end
end
