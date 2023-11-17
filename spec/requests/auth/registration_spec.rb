# spec/requests/registration_spec.rb

require 'rails_helper'

RSpec.describe 'User registration', type: :request do
  it 'registers a new user with valid attributes' do
    valid_attributes = {
      name: 'John Doe',
      email: 'john@example.com',
      password: 'password',
      password_confirmation: 'password'
    }

    post '/users', params: { user: valid_attributes }

    expect(response).to have_http_status(:created)
    expect(response.body).to include('Registration successful')
  end

  it 'does not register a user with invalid attributes' do
    invalid_attributes = {
      name: 'John Doe',
      email: 'john@example.com',
      password: 'password',
      password_confirmation: 'different_password'
    }

    post '/users', params: { user: invalid_attributes }

    expect(response).to have_http_status(:unprocessable_entity)
    expect(response.body).to include('Password confirmation doesn\'t match Password')
  end
end
