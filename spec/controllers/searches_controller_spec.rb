require 'rails_helper'

describe SearchesController do
  let(:user) { create(:user) }

  describe '#create' do
    before do
      sign_in user
      post :create, { id: user.id, user: { location_id: 4 } }
    end

    it 'stores the user\'s location id' do
      session[:location_id] = controller.params[:user][:location_id]
      expect(session[:location_id].to_i).to eq(user.location_id)
    end

    it 'redirects to the index action' do
      expect(response).to redirect_to(searches_path)
    end
  end

end
