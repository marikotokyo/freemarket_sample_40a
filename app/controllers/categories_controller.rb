class CategoriesController < ApplicationController
  def index
    @categories = Category.all

    @large_categories = Category.find_by_sql(['select * from categories where depth is NULL'])
    @medium_categories = Category.find_by_sql(['select * from categories where depth regexp "^[0-9]+$" '])
    @small_categories = Category.find_by_sql(['select * from categories where depth regexp ".+/.+" '])

    # @grouped_m = @medium_categories.group_by{|s| s[:depth]}.values
    # @grouped_s = @small_categories.group_by{|s| s[:depth]}.values
    # render 'index', formats: 'json' デバック用

    respond_to do |format|
      format.html
      format.json { render json: @categories }
    end
  end

  def select_top
    respond_to do |format|
      format.json{ @m_cate = Category.where('depth = ?', "#{params[:id]}")} if params[:id].present?
    end
  end

  def select_mid
    respond_to do |format|
      format.json{ @s_cate = Category.where('depth LIKE(?)', "%/#{params[:id]}")} if params[:id].present?
    end
  end

end
