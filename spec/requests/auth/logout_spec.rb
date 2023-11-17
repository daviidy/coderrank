# spec/requests/logout_spec.rb

require 'rails_helper'

RSpec.describe 'User logout', type: :request do
  let!(:user) { FactoryBot.create(:user, email: 'john@example.com', password: 'password') }

  before(:each) do
    login_credentials = {
      email: 'john@example.com',
      password: 'password'
    }

    post '/auth/login', params: login_credentials

    expect(response).to have_http_status(:ok)
    response_data = JSON.parse(response.body)

    # Extract the token and set it to the instance variable
    @auth_token = response_data['token']
  end

  it 'logs out a logged-in user' do
    delete '/auth/logout', headers: { 'Authorization' => @auth_token }

    expect(response).to have_http_status(:ok)
    expect(response.body).to include('Logged out successfully')
  end

  it 'does not log out an unauthenticated user' do
    delete '/auth/logout', headers: { 'Authorization' => @auth_token + 'astring' }
    expect(response).to have_http_status(:unauthorized)
    expect(response.body).to include('You need to sign in or sign up before continuing')
  end
end
