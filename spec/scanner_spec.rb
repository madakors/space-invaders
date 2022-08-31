# frozen_string_literal: true

require 'spec_helper'
require './lib/invader'
require './lib/invader_spotter'
require './lib/radio'
require './lib/scanner'
require './lib/spottings'

RSpec.describe Scanner do
  subject(:scanner) { Scanner.new(radio, invaders) }

  let(:invaders) { [Invader.new(['-oo']), Invader.new(['-o-'])] }
  let(:radio) { Radio.new(['----']) }
  let(:invader_spotter_mock) { instance_double(InvaderSpotter, scan: []) }

  describe '#scan' do
    before do
      allow(InvaderSpotter).to receive(:new).and_return(invader_spotter_mock)
    end

    it 'creates a spotter for each invader' do
      expect(InvaderSpotter).to receive(:new).with(invaders.first, radio)
      expect(InvaderSpotter).to receive(:new).with(invaders[1], radio)

      scanner.scan
    end

    it 'returns an instance of Spottings' do
      expect(scanner.scan).to be_a(Spottings)
    end
  end
end
