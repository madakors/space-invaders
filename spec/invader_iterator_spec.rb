# frozen_string_literal: true

require 'spec_helper'
require './lib/invader'
require './lib/invader_iterator'

RSpec.describe InvaderIterator do
  subject(:iterator) { described_class.new(invader) }

  let(:invader) { Invader.new(pattern) }
  let(:pattern) { ['--ooooooo--', '---oo-oo---'] }

  describe '#next' do
    context 'when iterator at the beginning' do
      it 'returns the first line of the invader pattern' do
        expect(iterator.next).to eq(invader.head)
      end
    end

    context 'when iterator has advanced' do
      before { iterator.next }

      it 'returns the next line of the invader pattern' do
        expect(iterator.next).to eq(invader.pattern_at(1))
      end
    end

    context 'when iterator has reached the end of the invader pattern' do
      before do
        iterator.next
        iterator.next
      end

      it 'returns nil' do
        expect(iterator.next).to be_nil
      end
    end
  end

  describe 'next?' do
    context 'when index is within bounds of the invader pattern' do
      it 'returns true' do
        expect(iterator.next?).to be true
      end
    end

    context 'when index is out of bounds of the invader pattern' do
      before do
        iterator.next
        iterator.next
      end

      it 'returns false' do
        expect(iterator.next?).to be false
      end
    end
  end
end
