class AddressesController < ApplicationController

  def new
    @address = Address.new
    @year = (1900..2018).to_a.freeze
    @month = (1..12).to_a.freeze
    @day = (1..31).to_a.freeze
  end

  def create
    @address = Address.create(address_params)
    redirect_to items_path
  end

  def edit
    @address = Address.find(params[:id])
    @year = (1900..2018).to_a.freeze
    @month = (1..12).to_a.freeze
    @day = (1..31).to_a.freeze
  end

  def update
    address = Address.find(params[:id])
    if address.user.id == current_user.id
      address.update(address_params)
    end
  end

  private
  def address_params
    params.require(:address).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :postal_code, :prefecture, :city, :street_number, :building_name, :birth_year, :birth_month, :birth_day).merge(user_id: current_user.id)
  end
end
