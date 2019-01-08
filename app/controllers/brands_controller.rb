class BrandsController < ApplicationController
  def index
    @brands = Brand.all

    respond_to do |format|
      format.html
      format.json { render json: @brands }
    end
  end

  def search
    @brands = Brand.where('name LIKE(?)', "%#{params[:keyword]}%")
    render json: @brands
  end

  def submit
    @brand = Brand.where('name LIKE(?)', "%#{params[:keyword]}%")
    render json: @brand
  end

end
