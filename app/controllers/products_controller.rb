class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
    @reviews = Review.where(product_id: params[:id]).order(created_at: :desc)

    @userinfo = @reviews.map do |review|
      User.find(review.user_id)
    end

    @overall = 0.0
    @reviews.each do |review|
      @overall += review.rating
    end
    @overall /= @reviews.size

    @review = @product.review.new

    render 'show', locals: {
      reviews: @reviews,
      product: @product,
      userinfo: @userinfo,
      overall: @overall
    }
  end

end
