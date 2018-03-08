# frozen_string_literal: true

class Main
  def process
    LOGGER.info 'Initialize process'
    publisher = Publisher.new
    publisher.setup_connection
    messages = LoadFile.new.process

    messages.each do |message|
      publisher.publish(message)
    end

    publisher.close
    LOGGER.info "#{publisher.customers_deleted} messages sent"
  end
end
