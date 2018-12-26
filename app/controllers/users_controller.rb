class UsersController < ApplicationController

  before_action :redirect_to_choice, :except => [:choice]

  def choice
    render layout: 'layout_content'
  end

  def logout
  end

  def show
    user = User.find(show_params[:id])
    @nickname = user.nickname
  end

  def edit
    user = User.find(show_params[:id])
  end

  def identification
    @user = User.find(params[:id])
    @address = Address.find_or_initialize_by(id: params[:id])
  end

  def update
    user = User.find(params[:id])
    address = Address.find_or_initialize_by(id: params[:id])
    User.transaction do
      user.update!(user_params)
      address.update_attributes!( address_params )
    end
    render :show
    rescue => e
    render :show
  end

  private
  def redirect_to_choice
    user = User.find(show_params[:id])
    redirect_to :action => "choice" unless user.id == current_user.id
  end

  def show_params
    params.permit(:id)
  end

  def user_params
    params.require(:user).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :birth_year, :birth_month, :birth_day)
  end

  def address_params
    params.require(:user).require(:address).permit(:postal_code, :prefecture, :city, :street_number, :building_name).merge(user_id: current_user.id)
  end


end
