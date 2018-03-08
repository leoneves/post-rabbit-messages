# frozen_string_literal: true

require 'bunny'

class TestWorker

  attr_accessor :count_receive_messages

  def initialize
    @connection = Bunny.new(hostname: 'localhost', automatically_recover: false)
    @connection.start

    channel = @connection.create_channel
    @queue = channel.queue('snarf.events.chargeback.processed', durable: true)
    @queue.bind('thundercats.messages', routing_key: 'events.chargeback.processed')
  end

  def process_messages
    @count_receive_messages = 0
    begin
      @queue.subscribe(block: true) do |_delivery_info, _properties, body|
        @count_receive_messages += 1
        msisdn = JSON.parse(body).dig('customer').dig('msisdn')
        raise Interrupt if msisdn == 11_964_106_357
      end
    rescue Interrupt => _
      @connection.close
    end
    @count_receive_messages
  end
end
