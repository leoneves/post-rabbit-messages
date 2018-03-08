# frozen_string_literal: true

require 'spec_helper'
require_relative 'test_worker'

describe '#publish' do
  let(:publisher) { Publisher.new }
  let(:messages) { LoadFile.new.process }
  let(:test_worker) { TestWorker.new }

  before do
    Thread.new do
      test_worker.process_messages
    end
    publisher.setup_connection
    messages.each do |message|
      publisher.publish(message)
    end
    sleep(1)
  end

  subject { publisher }

  context 'with success published messages' do
    it { is_expected.to be_success }
    it { expect(test_worker.count_receive_messages).to eq(4)  }
  end

  after(:each) do
    publisher.close
  end
end
