class ReviewsController < ApplicationController
  before_filter :authorize

  def create
    ref_params = { product_id: params[:product_id], user_id: current_user.id }

    @product = Product.find(params[:product_id])
    @review = @product.review.new(review_params.merge(ref_params))

    if @product.save
      redirect_to "/products/#{params[:product_id]}", notice: 'Product created!'
    else
      redirect_to "/products/#{params[:product_id]}"
    end
  end

  def destroy
    puts "heyheyhey #{params}"
    @review = Review.find params[:id]
    @review.destroy
    redirect_to "/products/#{params[:product_id]}", notice: 'Review deleted!'
  end

  private

  def review_params
    params.require(:review).permit(
      :description,
      :rating
    )
  end
end
