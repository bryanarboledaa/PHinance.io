class AbcProductsController < ApplicationController
  def index
    @abc_products = AbcProduct.all
  end

  def show
    @abc_product = AbcProduct.find(params[:id])
  end
end
