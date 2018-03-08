# frozen_string_literal: true

class Publisher

  attr_accessor :customers_deleted

  def setup_connection
    @success = false
    @customers_deleted = 0
    @connection = Bunny.new(RABBITMQ_CONFIG)
    @connection.start

    channel = @connection.create_channel
    @exchange = channel.topic(RABBITMQ_CONFIG.dig(:exchange), durable: true)
  end

  def publish(message)
    begin
      @exchange.publish(message.payload.to_json, routing_key: 'events.chargeback.processed', priority: 0, headers: message.header)
      @customers_deleted += 1
      @success = true
    rescue StandardError => e
      LOGGER.error chargeback_message: message, reason: e.message
      File.open('messages_not_sent.txt', 'a') do |f|
        f.puts(message.inspect)
      end
    end
  end

  def close
    @connection.close
  end

  def success?
    @success
  end
end
