class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @products = @category.products.order(created_at: :desc)
  end

  # def show
  #   @category = Category.find(params[:id])
  #   @products = @category.products.order(created_at: :desc)

  #   if req["format"] == "json"
  #         render json: @product, status: :ok
  #   else
  #     render :show
  #   end
  # end


  # def more_detail
  #   # Go to DB and fetch more data
  #   render :json,  {hello: "world"}, status: :ok
  # end

end
