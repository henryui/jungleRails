class OrdersController < ApplicationController
  before_filter :authorize

  def show
    # @order = Order.find(params[:id])
    order_item_list = LineItem.where('order_id = ?', params[:id])
    product_list = []

    (1..order_item_list.size).each do |i|
      product_list << Product.find(order_item_list[i - 1].product_id)
    end

    render 'show', locals: {
      order: Order.find(params[:id]),
      items: order_item_list,
      products: product_list
    }
  end

  def create
    charge = perform_stripe_charge
    order  = create_order(charge)

    if order.valid?
      Receipt.order_email(order).deliver_now
      empty_cart!
      redirect_to order, notice: 'Your Order has been placed.'
    else
      redirect_to cart_path, flash: { error: order.errors.full_messages.first }
    end

  rescue Stripe::CardError => e
    redirect_to cart_path, flash: { error: e.message }
  end

  private

  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end

  def perform_stripe_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      cart_subtotal_cents,
      description: "Yunsung Oh's Jungle Order",
      currency:    'cad'
    )
  end

  def create_order(stripe_charge)
    order = Order.new(
      email: params[:stripeEmail],
      total_cents: cart_subtotal_cents,
      stripe_charge_id: stripe_charge.id # returned by stripe
    )

    enhanced_cart.each do |entry|
      product = entry[:product]
      quantity = entry[:quantity]
      order.line_items.new(
        product: product,
        quantity: quantity,
        item_price: product.price,
        total_price: product.price * quantity
      )
      product.update_column(quantity: product.quantity - quantity)
    end
    order.save!
    order
  end

end
