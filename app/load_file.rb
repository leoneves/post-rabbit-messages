# frozen_string_literal: true

class LoadFile
  def initialize
    @csv = CSV.table("#{ROOT_DIR}/#{CONFIG[:file_path]}/#{CONFIG[:file_name]}.csv", headers: true, encoding: 'bom|utf-8')
  end

  def process
    messages = []
    @csv.each do |row|
      chargeback_message = ChargebackMessage.new(
        payload: PayloadMessage.new(load_customer(row)),
        header: load_header(row)
      )
      messages.push(chargeback_message)
    end
    messages
  end

  def load_header(row)
    {
      'Sync-Mode': 'sync',
      'Application-Id': row[:application],
      'Client-Realm-Id': row[:client_realm],
      'Service-Provider-Id': row[:service_provider],
      content_type: 'application/octet-stream'
    }
  end

  def load_customer(row)
    {
      uuid: row[:uuid],
      msisdn: row[:msisdn]
    }
  end
end
