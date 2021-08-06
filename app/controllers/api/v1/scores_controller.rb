class Api::V1::ScoresController < ApplicationController
    MAX_PAGINATION_LIMIT = 100
    before_action :set_score, only: [:show, :destroy]
    before_action :set_all_scores, only: [:destroy]
    
        def index
            @scores = Score.limit(limit).offset(params[:offset])

            if  params[:player] 
                players = params[:player].map { |string| string.downcase.titleize }
                @scores = @scores.where(player: players)   
            end   
            if  params[:before]
                before = params[:before]
                @scores = @scores.where("time < ?", before )
            end
            if  params[:after]
                after = params[:after]
                @scores = @scores.where("time > ?", after)
            end
            render json: @scores, only: [:id, :player, :score, :time], status: 200
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
                player: score_params[:player].downcase.titleize,
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
            def limit
                [
                    params.fetch(:limit, MAX_PAGINATION_LIMIT).to_i,
                    MAX_PAGINATION_LIMIT
                ].min
            end

            def score_params
                params.permit([:player,:score,:time])
            end

            def set_score
                @score = Score.find(params[:id])
            end

            def set_all_scores
                @scores = Score.all
            end
end
