class Receipt < ApplicationMailer
  default from: "no-reply@jungle.com"

  def order_email(order)
    @order = order
    puts "heyheyhey #{@order.email}"
    @url = "http://localhost:3000/orders/#{@order.id}"
    mail(to: @order.email, subject: 'Thank you for your purchase at Jungle.com!')
  end
end
