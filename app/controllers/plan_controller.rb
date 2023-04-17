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
    plan = params[:id]
    amount = available_plans[plan]
    nonce = params[:nonce]

    # 建立訂單
    order = current_user.orders.create(plan:, amount:)

    result = gateway.transaction.sale(
      amount:,
      payment_method_nonce: nonce
    )

    if result.success?
      # 把訂單設定為 paid
      order.pay!
      redirect_to root_path, notice: 'ok'
    else
      # 把訂單設定為 fail
      order.fail!
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
