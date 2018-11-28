# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kamome::Loader do
  let(:loader) { described_class.new(config: config) }
  let(:config) do
    Kamome::Configuration.new.tap do |o|
      o.tmp_path = tmp_path
    end
  end

  describe '#call' do
    subject(:models) do
      models = []
      ::VCR.use_cassette(cassette_name) do
        loader.call(operation: operation) do |model, lineno|
          models << model
          break if lineno >= 10
        end
      end
      models
    end

    context 'when operation type: :default, genre: :general' do
      let(:operation) { Kamome::Operation.general_all(type: :default) }
      let(:cassette_name) { ::File.join('loader', 'ken_all.zip') }

      it { expect(models.size).to eq 10 }
    end

    context 'when operation type: :default, genre: :jigyosho' do
      let(:operation) { Kamome::Operation.jigyosho_all(type: :default) }
      let(:cassette_name) { ::File.join('loader', 'jigyosyo.zip') }

      it { expect(models.size).to eq 10 }
    end

    context 'when operation type: :hash, genre: :general' do
      let(:date) { Time.local(2018, 11) }
      let(:operation) { Kamome::Operation.general_diff(date: date, type: :hash) }
      let(:cassette_name) { ::File.join('loader', 'general_diff.zip') }

      it { expect(models.size).to eq 10 }
    end

    context 'when operation type: :detail, genre: :jigyosho' do
      let(:date) { Time.local(2018, 11) }
      let(:operation) { Kamome::Operation.jigyosho_diff(date: date, type: :detail) }
      let(:cassette_name) { ::File.join('loader', 'jigyosho_diff.zip') }

      it { expect(models.size).to eq 10 }
    end
  end
end
