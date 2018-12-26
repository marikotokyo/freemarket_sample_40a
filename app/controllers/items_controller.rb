class ItemsController < ApplicationController

  def index
  end

  def new
    @item = Item.new
    @item.images.build
    render layout: 'layout_content'
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to items_path
  end

  def show
  end

  def new
    render layout: 'layout_content'
  end

end
