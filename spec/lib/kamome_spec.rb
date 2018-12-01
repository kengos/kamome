# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kamome do
  describe '.import_general_all' do
    subject(:import_general_all) do
      ::Kamome.import_general_all
    end

    let(:operation) { ::Kamome::Operation.general_all }
    let(:mock_loader) { instance_double(::Kamome::Loader) }

    it 'Kamome::Loader to receive :call' do
      allow(::Kamome::Loader).to receive(:new).and_return(mock_loader)
      expect(mock_loader).to receive(:call).with(operation: operation)
      import_general_all
    end
  end

  describe '.import_general_diff' do
    subject(:import_general_diff) do
      ::Kamome.import_general_diff(date: date)
    end

    let(:operation) { ::Kamome::Operation.general_diff(date: date) }
    let(:mock_loader) { instance_double(::Kamome::Loader) }
    let(:date) { Time.local(2018, 11) }

    it 'Kamome::Loader to receive :call' do
      allow(::Kamome::Loader).to receive(:new).and_return(mock_loader)
      expect(mock_loader).to receive(:call).with(operation: operation)
      import_general_diff
    end
  end

  describe '.import_jigyosho_all' do
    subject(:import_jigyosho_all) do
      ::Kamome.import_jigyosho_all
    end

    let(:operation) { ::Kamome::Operation.jigyosho_all }
    let(:mock_loader) { instance_double(::Kamome::Loader) }

    it 'Kamome::Loader to receive :call' do
      allow(::Kamome::Loader).to receive(:new).and_return(mock_loader)
      expect(mock_loader).to receive(:call).with(operation: operation)
      import_jigyosho_all
    end
  end

  describe '.import_jigyosho_diff' do
    subject(:import_jigyosho_diff) do
      ::Kamome.import_jigyosho_diff(date: date)
    end

    let(:operation) { ::Kamome::Operation.jigyosho_diff(date: date) }
    let(:mock_loader) { instance_double(::Kamome::Loader) }
    let(:date) { Time.local(2018, 11) }

    it 'Kamome::Loader to receive :call' do
      allow(::Kamome::Loader).to receive(:new).and_return(mock_loader)
      expect(mock_loader).to receive(:call).with(operation: operation)
      import_jigyosho_diff
    end
  end
end
