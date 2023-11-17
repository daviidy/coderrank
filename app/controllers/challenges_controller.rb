class ChallengesController < ApplicationController
    before_action :set_challenge, only: [:show, :update, :destroy]
    before_action :authorize_user, except: [:index, :show]
    before_action :authorize_admin, except: [:index, :show]

    def index
        @challenges = Challenge.all
        render json: @challenges
    end

    def show
        render json: @challenge
    end

    def create
        @challenge = Challenge.new(challenge_params)
        if @challenge.save
            render json: @challenge, status: :created
        else
            render json: @challenge.errors, status: :unprocessable_entity
        end
    end

    def update
        if @challenge.update(challenge_params)
            render json: @challenge
        else
            render json: @challenge.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @challenge.destroy
        head :no_content
    end

    private

    def set_challenge
        @challenge = Challenge.find(params[:id])
    end

    def challenge_params
        params.require(:challenge).permit(:title, :description, category_ids: [])
    end
end
