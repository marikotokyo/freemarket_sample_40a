class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]

  def index
    @items = Item.includes(:user).order("created_at DESC").limit(8)
  end

  def new
    @large_categories = Category.find_by_sql(['select * from categories where depth is NULL'])
    @item = Item.new
    @item.images.build
    render layout: 'layout_content'
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path
    else
      render :action => "new", :layout => "layout_content"
    end
  end

  def show
    gon.address = current_user.address.present?
    @item = Item.find(params[:id])
    @comments = @item.comments
    @comment = Comment.new
  end

  def option
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @default_category = @item.category
    @default_size = @item.size
    @default_brand = @item.brand
    @depth = @default_category.depth.split("/")
    render layout: 'layout_content'
  end

  def destroy
    item = Item.find(params[:id])
    if item.user_id == current_user.id
      item.destroy
      redirect_to items_path
    end
  end

  def update
    item = Item.find(params[:id])
    if item.user_id == current_user.id
      item.update(item_params)
      redirect_to items_path
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :price, :condition, :category_id, :size_id, :shipping_from, :shipping_date, :shipping_fee, :shipping_way, images_attributes: [:image]).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
