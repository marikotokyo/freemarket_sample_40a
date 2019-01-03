class OrdersController < ApplicationController
  before_action :move_to_choice

  def index # 買手から見たオーダーリスト
    @orders = current_user.orders.order("created_at DESC")
  end

  def new
    @item = Item.find(params[:item_id])
    if current_user != @item.user
      render layout: 'layout_content'
    else
      redirect_to item_path(params[:item_id])
    end
  end

  def create
    item = Item.find(params[:item_id])
    @order = Order.create(order_params) unless current_user.id == item.user.id
  end

  def show
    @order = Order.find(params[:id])
    # 売り手と買い手の画面分岐
    case current_user.id
    when @order.item.user_id
      seller_todo   # 出品者
    when @order.user_id
      buyer_todo   # 購入者
    else
      redirect_to root_path
    end
  end

  def update
    order = Order.find(params[:id])
    case order.status
    when "stage0"
      order.update(status: 1) if current_user.id == order.user_id
    when "stage1"
      order.update(status: 2) if current_user.id == order.item.user_id
    when "stage2"
      order.update(status: 3) if current_user.id == order.user_id
    when "stage3"
      order.update(status: 4) if current_user.id == order.item.user_id
    end
    redirect_to action: :show
  end

  def destroy
    order = Order.find(params[:id])
    order.destroy if current_user.id == order.user.id
    redirect_to user_path(current_user)
  end

  def sale # 売手から見たオーダーリスト
    items_ids = current_user.items.pluck(:id)
    @orders = Order.where(item_id: items_ids).order("created_at DESC")
  end


  private
  def move_to_choice
    redirect_to choice_users_path unless user_signed_in?
  end

  def order_params
    params.permit(:item_id).merge(user_id: current_user.id, status: 0)
  end

  # 出品者
  def seller_todo
    case @order.status
    when "stage0"
      @message = "入金をお待ちください"
    when "stage1"
      @btn = "発送する"
    when "stage2"
      @message = "購入者の受け取り報告と評価をお待ちください"
    when "stage3"
      @btn = "出品者として評価する"
    end
  end

  # 購入者
  def buyer_todo
    case @order.status
    when "stage0"
      @btn = "入金する"
    when "stage1"
      @message = "商品の発送をお待ちください"
    when "stage2"
      @btn = "受け取ったので評価する"
    when "stage3"
      @message = "出品者からの評価をお待ちください"
    end
  end

end
