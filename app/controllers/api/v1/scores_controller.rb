class Api::V1::ScoresController < ApplicationController
    before_action :set_score, only: [:show, :destroy]
    
        def index
            if params[:player] || params[:before] || params[:after]
                p(params[:player])
                @players = Score.where(player: params[:player])
                render json: @players, only: [:id, :player, :score, :time], status: 200
            else 
                @scores = Score.all 
                render json: @scores, only: [:id, :player, :score, :time], status: 200
            end
        end 
    
        def show
            if @score
                render json: @score, only: [:player, :score, :time], status: 200
            else
                render json: {error: "Score not found"}, status: 404
            end
        end 
    
        def create
            @score = Score.new(
                player: score_params[:player],
                score: score_params[:score],
                time: score_params[:time]
            )
            if @score.save
                render json: @score, only: [:player, :score, :time], status: 201
            else
                render json: {error: @score.errors}, status: 400
            end
        end 

        def destroy
            @scores = Score.all 
            @score.destroy
            render json: @scores, only: [:player, :score, :time], status: 200
        end
        
        private
            def score_params
                params.permit([:player,:score,:time])
            end

            def set_score
                @score = Score.find(params[:id])
            end
        
end
