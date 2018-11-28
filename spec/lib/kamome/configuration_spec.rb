# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kamome::Configuration do
  describe '#working_directory' do
    subject(:working_directory) { config.working_directory }

    context 'when specified tmp_path' do
      let(:config) do
        described_class.new.tap do |o|
          o.tmp_path = tmp_path.to_s
        end
      end

      it { is_expected.to eq ::Pathname.new(tmp_path.to_s) }
    end

    context 'when not specified tmp_path' do
      let(:config) { described_class.new }

      it { expect(working_directory.to_s).to be_start_with Dir.tmpdir }
      it { is_expected.to be_is_a ::Pathname }
    end
  end
end
