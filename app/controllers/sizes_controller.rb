class SizesController < ApplicationController
  def index
    respond_to do |format|
      format.json{ @size = Size.where('parent = ?', "#{params[:id]}") } if params[:id].present?
    end
  end
end
