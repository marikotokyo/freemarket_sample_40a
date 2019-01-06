require 'rails_helper'

describe ItemsController, type: :controller do
  describe 'GET #index' do
    it "populates an array of items ordered by created_at DESC" do
      items = create_list(:item, 3)
      users = create_list(:user, 3)
      sizes = create_list(:size, 3)
      get :index
      expect(assigns(:items)).to match(items.sort{ |a, b| b.created_at <=> a.created_at })
    end
  end
end
