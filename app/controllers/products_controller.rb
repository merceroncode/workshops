class ProductsController < ApplicationController
  before_filter :redirect_not_logged_in, only: [:create, :update]
  before_filter :set_error_if_cant_edit, only: [:edit, :update]
  expose(:category)
  expose(:products)
  expose(:product)
  expose(:review) { Review.new }
  expose_decorated(:reviews, ancestor: :product)

  def index
  end

  def show
  end

  def new
  end

  def edit
    redirect_to [category, product] unless can_edit?
  end

  def create
    self.product = Product.new(product_params)

    if product.save
      category.products << product
      redirect_to category_product_url(category, product), notice: 'Product was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if can_edit? and self.product.update(product_params)
      redirect_to category_product_url(category, product), notice: 'Product was successfully updated.'
    else
      (render action: 'edit' and return) if can_edit?
      redirect_to [category, product]
    end
  end

  # DELETE /products/1
  def destroy
    product.destroy
    redirect_to category_url(product.category), notice: 'Product was successfully destroyed.'
  end

  private
    def product_params
      params.require(:product).permit(:title, :description, :price, :category_id)
    end

    def set_error_if_cant_edit
      set_error_message unless can_edit?
    end

    def redirect_not_logged_in
      redirect_to new_user_session_path unless user_signed_in?
    end

    def set_error_message
      flash[:error] = "You are not allowed to edit this product."
    end

    def can_edit?
      product.user == current_user
    end
end
