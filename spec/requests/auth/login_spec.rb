# spec/requests/login_spec.rb

require 'rails_helper'

RSpec.describe 'User login', type: :request do
  let!(:user) { FactoryBot.create(:user, email: 'john@example.com', password: 'password') }

  it 'logs in a user with valid credentials' do
    login_credentials = {
      email: 'john@example.com',
      password: 'password'
    }

    post '/auth/login', params: login_credentials

    expect(response).to have_http_status(:ok)
    expect(response.body).to include('Logged in successfully')
  end

  it 'does not log in a user with invalid credentials' do
    login_credentials = {
      email: 'john@example.com',
      password: 'wrong_password'
    }

    post '/auth/login', params: login_credentials

    expect(response).to have_http_status(:unauthorized)
    expect(response.body).to include('Invalid credentials')
  end
end
