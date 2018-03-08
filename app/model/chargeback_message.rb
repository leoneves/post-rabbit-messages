# frozen_string_literal: true

class ChargebackMessage
  attr_accessor :payload, :header

  def initialize(params)
    @payload = params[:payload]
    @header = params[:header]
  end

  def inspect
    " payload: { #{@payload.inspect} }, header: { #{@header.inspect} }"
  end
end
