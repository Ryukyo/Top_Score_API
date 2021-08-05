class Api::V1::ScoresController < ApplicationController
        def index
            @scores = Score.all 
            render json: @scores, status: 200
        end 
    
        def show
            @score = Score.find(params[:id])
            if @score
                render json: @score, status: 200
            else
                render json: {error: "Score not found"}, status: 404
            end
        end 
    
        def create
            @score = Score.create(
                player: params[:player],
                score: params[:score],
                time: params[:time]
            )
            render json: @score, status: 201
        end 

    
        def destroy
            @scores = Score.all 
            @score = Score.find(params[:id])
            @score.destroy
            render json: @scores, status: 200
        end 
end
