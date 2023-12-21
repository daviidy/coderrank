class ChallengesController < ApplicationController
    before_action :set_challenge, only: [:show, :update, :destroy]
    before_action :authorize_user, except: [:index]
    before_action :authorize_admin, except: [:index, :show]

    def index
        @challenges = Challenge.all
        render json: @challenges
    end

    # return a challenge and eager load the comments
    # this will return the challenge and all of its comments
    def show
        render json: @challenge, include: :comments
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
        # delete challenge and comments in cascade
        @challenge.destroy
        #render json with success message that challenge was deleted
        render json: { message: 'Challenge was successfully deleted' }
        # head :no_content
    end

    private

    def set_challenge
        @challenge = Challenge.find(params[:id])
    end

    def challenge_params
        params.require(:challenge).permit(:title, :description, category_ids: [])
    end
end
