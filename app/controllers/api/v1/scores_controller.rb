class Api::V1::ScoresController < ApplicationController
        def index
            @scores = Score.all 
            render json: @scores, only: [:id, :player, :score, :time], status: 200
        end 
    
        def show
            @score = Score.find(params[:id])
            if @score
                render json: @score, only: [:id, :player, :score, :time], status: 200
            else
                render json: {error: "Score not found"}, status: 404
            end
        end 
    
        def create
            @score = Score.create!(
                score_params
            )
            render json: @score, only: [:player, :score, :time], status: 201
        end 

        def destroy
            @scores = Score.all 
            @score = Score.find(params[:id])
            @score.destroy
            render json: @scores, only: [:player, :score, :time], status: 200
        end
        
        private
        def score_params
            params.require(:player,:score,:time)
        end
        
end
