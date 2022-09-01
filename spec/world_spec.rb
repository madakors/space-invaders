# frozen_string_literal: true

require 'spec_helper'
require './lib/world'
require './lib/radio'
require './lib/invader'
require './lib/invader_iterator'
require './lib/invader_spotter'
require './lib/spotter_algorithm'
require './lib/scanner'
require './lib/spotting'
require './lib/spottings'
require './lib/printer'
require './lib/readers/radio'
require './lib/readers/invaders'

RSpec.describe World do
  subject(:world) { described_class.new(options) }

  let(:options) do
    {
      input: File.join(File.expand_path(File.dirname(File.dirname(__FILE__))), '/spec/fixtures/radio_input')
    }
  end

  describe '#draw' do
    let(:result) { <<~RESULT }
      [34m-[0m[34m-[0m[34m-[0m[34mo[0m[34mo[0m[34m-[0m[34m-[0m[34m-[0m-----------------
      [34m-[0m[34m-[0m[34mo[0m[34mo[0m[34mo[0m[34mo[0m[34m-[0m[34m-[0m-----------------
      [34m-[0m[34mo[0m[34mo[0m[34mo[0m[34mo[0m[34mo[0m[34mo[0m[34m-[0m-----------------
      [34mo[0m[34mo[0m[34m-[0m[34mo[0m[34mo[0m[34m-[0m[34mo[0m[34mo[0m-----------------
      [34mo[0m[34mo[0m[34mo[0m[34mo[0m[34mo[0m[34mo[0m[34mo[0m[34mo[0m-----------------
      [34m-[0m[34m-[0m[34mo[0m[34m-[0m[34m-[0m[34mo[0m[34m-[0m[34m-[0m-----------------
      [34m-[0m[34mo[0m[34m-[0m[34mo[0m[34mo[0m[34m-[0m[34mo[0m[34m-[0m-----------------
      [34mo[0m[34m-[0m[34mo[0m[34m-[0m[34m-[0m[34mo[0m[34m-[0m[34mo[0m-----[34m-[0m[34m-[0m[34mo[0m[34m-[0m[34m-[0m[34m-[0m[34m-[0m[34m-[0m[34mo[0m[34m-[0m[34m-[0m-
      -------------[34m-[0m[34m-[0m[34m-[0m[34mo[0m[34m-[0m[34m-[0m[34m-[0m[34mo[0m[34m-[0m[34m-[0m[34m-[0m-
      -------------[34m-[0m[34m-[0m[34mo[0m[34mo[0m[34mo[0m[34mo[0m[34mo[0m[34mo[0m[34mo[0m[34m-[0m[34m-[0m-
      -------------[34m-[0m[34mo[0m[34mo[0m[34m-[0m[34mo[0m[34mo[0m[34mo[0m[34m-[0m[34mo[0m[34mo[0m[34m-[0m-
      -------------[34mo[0m[34mo[0m[34mo[0m[34mo[0m[34mo[0m[34mo[0m[34mo[0m[34mo[0m[34mo[0m[34mo[0m[34mo[0m-
      -------------[34mo[0m[34m-[0m[34mo[0m[34mo[0m[34mo[0m[34mo[0m[34mo[0m[34mo[0m[34mo[0m[34m-[0m[34mo[0m-
      -------------[34mo[0m[34m-[0m[34mo[0m[34m-[0m[34m-[0m[34m-[0m[34m-[0m[34m-[0m[34mo[0m[34m-[0m[34mo[0m-
      -------------[34m-[0m[34m-[0m[34m-[0m[34mo[0m[34mo[0m[34m-[0m[34mo[0m[34mo[0m[34m-[0m[34m-[0m[34m-[0m-
    RESULT

    it 'writes matches to the output' do
      expect { world.draw }.to output(result).to_stdout
    end
  end
end
