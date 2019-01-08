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
    @item = Item.find(params[:id])
    @images = Image.where(item_id: @item.id)
    @small_category = @item.category

    if @item.category.depth.include?("/")
      @small_category_depth = @item.category.depth.split("/").last.to_i
      @medium_category = Category.find(@small_category_depth)
      @large_category = Category.find(@medium_category.depth)
    else
      @medium_category = Category.find(@item.category_id) #中カテどまりの商品
      @large_category = Category.find(@medium_category.depth)
    end

    @items = Item.where(user_id: @item.user_id).where.not(id: @item.id).limit(6) # 同じ出品者の商品
  end


  private
  def item_params
    params.require(:item).permit(:name, :description, :price, :condition, :category_id, :size_id, :shipping_from, :shipping_date, :shipping_fee, :shipping_way, images_attributes: [:image]).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
