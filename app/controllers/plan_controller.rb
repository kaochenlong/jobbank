# frozen_string_literal: true

class PlanController < ApplicationController
  before_action :authenticate_user!
  before_action :check_available_plans

  def payment
    id = params[:id]

    @token = gateway.client_token.generate
    @price = available_plans[id]
  end

  def pay
    id = params[:id]
    price = available_plans[id]
    nonce = params[:nonce]

    # 建立訂單

    result = gateway.transaction.sale(
      amount: price,
      payment_method_nonce: nonce
    )

    if result.success?
      # 把訂單設定為已付款
      redirect_to root_path, notice: 'ok'
    else
      redirect_to root_path, alert: 'fail'
    end
  end

  private

  def check_available_plans
    return if available_plans.keys.include?(params[:id])

    record_not_found and return
  end

  def available_plans
    { 'a' => 100, 'b' => 500, 'c' => 1000 }
  end

  def gateway
    Braintree::Gateway.new(
      environment: :sandbox,
      merchant_id: ENV.fetch('BRAINTREE_MERCHANT_ID', nil),
      public_key: ENV.fetch('BRAINTREE_PUBLIC_KEY', nil),
      private_key: ENV.fetch('BRAINTREE_PRIVATE_KEY', nil)
    )
  end
end
