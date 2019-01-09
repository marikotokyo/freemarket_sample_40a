class CardsController < ApplicationController

  def index
    @card = CreditCard.find_by(user_id: current_user.id)
  end

  def new
    @card = CreditCard.new
  end

  def create
    @card = CreditCard.create(card_params)
    redirect_to user_cards_path(current_user.id)
  end

  def destroy
    current_user.credit_card.destroy
    redirect_to user_cards_path(current_user.id)
  end

  private
  def card_params
    params.require(:credit_card).permit(:number, :expiration_month, :expriration_year, :security_code).merge(user_id: params[:user_id])
  end
end


