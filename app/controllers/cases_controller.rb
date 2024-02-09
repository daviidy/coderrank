class CasesController < ApplicationController
  before_action :set_case, only: [:show, :update, :destroy]
  before_action :authorize_user, except: [:index, :show]
  def index
    @cases = Case.all
    render json: @cases
  end

  def show
    render json: @case
  end

  def create
    @case = Case.new(case_params)
    challenge = Challenge.find(@case.challenge_id)
    if challenge
      if @case.save
        render json: @case, status: :created
      else
        render json: @case.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Challenge not found" }, status: :not_found
    end
  end

  def update
    if @case.update(case_params)
      render json: @case
    else
      render json: @case.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @case.destroy
    head :no_content
  end

  private

  def set_case
    @case = Case.find(params[:id])
  end

  def case_params
    params.require(:case).permit(:input, :output, :challenge_id)
  end
end
