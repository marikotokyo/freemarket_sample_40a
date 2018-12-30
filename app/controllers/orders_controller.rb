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
    case @order.status
      when "stage0"
        @btn = "入金した"
      when "stage1"
        @btn = "発送する"
      when "stage2"
        @btn = "受け取る"
      when "stage3"
        @btn = "買い手として評価する"
      when "stage4"
        @btn = "売り手として評価して全てを終わらせる"
    end
  end

  def update
    @order = Order.find_by(item_id: params[:item_id])
    order = Order.find(params[:id])
    case order.status
      when "stage0"
        order.update(status: 1)
      when "stage1"
        order.update(status: 2)
      when "stage2"
        order.update(status: 3)
      when "stage3"
        order.update(status: 4)
    end
    redirect_to action: :show
  end

  def destroy
    order = Order.find(params[:id])
    order.destroy
  end

end
