# frozen_string_literal: true

class PayloadMessage
  attr_accessor :occurred_at, :origin, :customer

  def initialize(customer)
    @occurred_at = Time.now
    @origin = 'thundercats'
    @customer = customer
  end

  def as_json(_options = {})
    {
      occurred_at: @occurred_at,
      origin: @origin,
      customer: @customer
    }
  end

  def to_json(*options)
    as_json(*options).to_json(*options)
  end

  def inspect
    "occurred_at: #{@occurred_at}, origin: #{@origin}, customer: #{customer}"
  end
end
