# app/controllers/sessions_controller.rb

class Auth::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
        # Set the expiration time (e.g., 1 hour from now)
        expiration_time = Time.now.to_i + (3600 * 3) # 3600 seconds = 1 hour

        # Create the payload
        payload = { 
            user_id: user.id,
            exp: expiration_time # This sets the expiration time
        }
        token = JWT.encode(payload, ENV['APP_SECRET_KEY'], 'HS256')
        render json: { message: 'Logged in successfully', token: token }
    else
        render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def destroy
    # Invalidate the JWT token by marking it as expired or revoking it.
    # You can customize this part based on your JWT library and logic.
    # Here's a simplified example using the 'jwt' gem:

    token = extract_token_from_request
    if token
      # You may need to decode the token and check its validity here.
      # Depending on your use case, you can mark the token as expired or
      # add it to a blacklist.
      # For simplicity, let's assume marking it as expired:
      begin
        # Try to decode the token to check its validity
        payload, _ = JWT.decode(token, ENV['APP_SECRET_KEY'], true, algorithm: 'HS256')

        # At this point, the token is considered valid, but you can implement
        # additional logic here, such as marking it as expired or adding it to a blacklist.

        # Add expiration to the payload to mark the token as invalid (for example)
        payload['exp'] = Time.now.to_i
        new_token = JWT.encode(payload, ENV['APP_SECRET_KEY'], 'HS256')

        render json: { message: 'Logged out successfully' }
      rescue JWT::DecodeError
        # JWT::DecodeError is raised when the token is not valid
        render json: { message: 'You need to sign in or sign up before continuing' }, status: :unauthorized
      end
    else
      render json: { message: 'No token found' }, status: :unprocessable_entity
    end
  end

  private

  def extract_token_from_request
    request.headers['Authorization']&.split&.last
  end
end
