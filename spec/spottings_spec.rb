# frozen_string_literal: true

require 'spec_helper'
require './lib/spotting'
require './lib/spottings'

RSpec.describe Spottings do
  subject(:spottings) { described_class.from_array([invalid_spotting, valid_spotting]) }

  let(:invalid_spotting) do
    instance_double(Spotting, :verifiy, invalid?: true, valid?: false, complete?: false, contains?: true)
  end
  let(:valid_spotting) do
    instance_double(Spotting, :verify, invalid?: false, valid?: true, complete?: false, contains?: true)
  end

  describe '#add' do
    let(:spotting) { instance_double(Spotting) }

    it 'adds spotting to the collection' do
      expect { spottings.add(spotting) }.to change { spottings.count }.from(2).to(3)
    end
  end

  describe '#verify' do
    let(:radio_segment) { '----' }
    let(:column_index) { 1 }

    it 'calls every spotting with the given radio segment' do
      expect(invalid_spotting).to receive(:verify).with(radio_segment, column_index).once
      expect(valid_spotting).to receive(:verify).with(radio_segment, column_index).once

      spottings.verify(radio_segment, column_index)
    end
  end

  describe '#cleanup!' do
    it 'filters out invalid spottings' do
      expect { spottings.cleanup! }.to change { spottings.count }.from(2).to(1)
    end
  end

  describe '#complete' do
    let(:complete_spotting) { instance_double(Spotting, valid?: true, complete?: true) }

    before { spottings.add(complete_spotting) }

    it 'returns valid and complete spottings' do
      result = spottings.complete

      expect(result).to contain_exactly(complete_spotting)
    end
  end

  describe '#find_for' do
    let(:complete_spotting_1) { instance_double(Spotting, valid?: true, complete?: true, contains?: false) }
    let(:complete_spotting_2) { instance_double(Spotting, valid?: true, complete?: true, contains?: true) }
    let(:point_x) { 0 }
    let(:point_y) { 0 }

    before do
      spottings.add(complete_spotting_1)
      spottings.add(complete_spotting_2)
    end

    it 'returns a spotting that contains the given coordinates' do
      result = spottings.find_for(point_x, point_y)

      expect(result).to eq(complete_spotting_2)
    end
  end
end
