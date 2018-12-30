class OrdersController < ApplicationController

  def index
  end

  def new
    @item = Item.find(params[:item_id])
    render layout: 'layout_content'
  end

  def create
    @order = Order.create(item_id: params[:item_id], user_id: current_user.id, status: 0)
  end

  def show
    @order = Order.find_by(item_id: params[:item_id])
  end

  # def edit
  # end

  # def update
  # end

  # def destroy
  # end

end
