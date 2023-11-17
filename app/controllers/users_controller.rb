class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      render json: { message: 'Registration successful. Please log in.' }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def add_admin
    email = params[:email]

    if email.blank?
      render json: { errors: 'Email parameter is required' }, status: :unprocessable_entity
    end
    @user = User.find_by(email: email)
    if @user.nil?
      render json: { errors: 'No user with that Email found' }, status: :not_found
    else
      @user.update_column(:role, 1)
      render json: { message: 'User is now an admin' }, status: :ok
    end
  end

  private

  def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
