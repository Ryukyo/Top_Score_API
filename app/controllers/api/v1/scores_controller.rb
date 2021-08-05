class ScoresController < ApplicationController
        def index
            @scores = Score.all 
            render json: @scores
        end 
    
        def show
            @score = Score.find(params[:id])
            render json: @score
        end 
    
        def create
            @score = Score.create(
                player: params[:player],
                score: params[:score],
                time: params[:time]
            )
            render json: @score
        end 

    
        def destroy
            @scores = Score.all 
            @score = Score.find(params[:id])
            @score.destroy
            render json: @scores
        end 
end
