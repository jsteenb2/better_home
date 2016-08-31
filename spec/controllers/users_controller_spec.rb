require 'rails_helper'

describe UsersController do
  let(:user) { create(:user) }

  describe '#survey_results' do
    before do
      sign_in user
      post :survey, { id: user.id, user: { location_id: 4 } }
    end

    it 'stores the user\'s location id' do
      session[:location_id] = controller.params[:user][:location_id]
      expect(session[:location_id].to_i).to eq(user.location_id)
    end

    it 'redirects the user to his profile' do
      expect(response).to redirect_to(user_path(user))
    end

  end

end
