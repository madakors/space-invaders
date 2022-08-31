# frozen_string_literal: true

require 'spec_helper'
require './lib/invader'
require './lib/invader_iterator'
require './lib/invader_spotter'
require './lib/radio'
require './lib/spotting'
require './lib/spottings'

RSpec.describe InvaderSpotter do
  subject(:scanner) { described_class.new(invader, radio) }

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

  let(:invader) { Invader.new(invader_pattern) }
  let(:radio) { Radio.new(radio_feed) }

  describe '#scan' do
    context "when radio feed doesn't include an invader pattern" do
      let(:radio_feed) do
        [
          '----------',
          '----------'
        ]
      end

      it 'returns an empty result' do
        expect(scanner.scan).to eq([])
      end
    end

    context 'when radio feed contains one invader pattern' do
      let(:radio_feed) do
        [
          '-----------------',
          '-----o-----o-----',
          '------o---o------',
          '-----ooooooo-----',
          '----oo-ooo-oo----',
          '---ooooooooooo---',
          '---o-ooooooo-o---',
          '---o-o-----o-o---',
          '------oo-oo------',
          '-----------------'
        ]
      end

      it 'returns a single result' do
        expect(scanner.scan).to contain_exactly(be_a(Spotting))
      end
    end

    context 'when radio feed contains a different invader pattern' do
      let(:radio_feed) do
        [
          '--------------',
          '--------------',
          '------oo------',
          '-----oooo-----',
          '----oooooo----',
          '---oo-oo-oo---',
          '---oooooooo---',
          '-----o--o-----',
          '----o-oo-o----',
          '---o-o--o-o---',
          '--------------',
          '--------------'
        ]
      end

      it 'returns an empty result' do
        expect(scanner.scan).to eq([])
      end
    end

    context 'when radio feed contains multiple invader patterns' do
      let(:radio_feed) do
        [
          '----------------------------',
          '-----o-----o-------o-----o--',
          '------o---o---------o---o---',
          '-----ooooooo-------ooooooo--',
          '----oo-ooo-oo-----oo-ooo-oo-',
          '---ooooooooooo---ooooooooooo',
          '---o-ooooooo-o---o-ooooooo-o',
          '---o-o-----o-o---o-o-----o-o',
          '------oo-oo---------oo-oo---',
          '-----------o-----o----------',
          '------------o---o---------- ',
          '-----------ooooooo----------',
          '----------oo-ooo-oo---------',
          '---------ooooooooooo -------',
          '---------o-ooooooo-o--------',
          '---------o-o-----o-o--------',
          '------------oo-oo-----------',
          '----------------------------',
          '----------------------------'
        ]
      end

      it 'returns a multiple results' do
        expect(scanner.scan).to contain_exactly(be_a(Spotting), be_a(Spotting), be_a(Spotting))
      end
    end
  end
end
