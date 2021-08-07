class Api::V1::ScoresController < ApplicationController
    MAX_PAGINATION_LIMIT = 100
    before_action :set_score, only: [:show, :destroy]
    before_action :set_all_scores, only: [:destroy]
    
        def index
            @scores = Score.limit(limit).offset(params[:offset])

            if  params[:history] 
                history = params[:history].downcase.titleize
                player_scores = @scores.where(player: history)

                # find the average, max and min score of given player
                average_score = player_scores.average(:score).to_f
                top_score = player_scores.maximum(:score)
                low_score = player_scores.minimum(:score)

                # override the top/low score with the actual item
                # item contains the time values which is required for output
                player_scores.each do |item|
                    if item.score == top_score
                        top_score = item
                    end
                    if item.score == low_score
                        low_score = item
                    end
                end

                output = {
                    topScore: top_score,
                    lowScore: low_score,
                    averageScore: average_score,
                    allScores: player_scores
                }
                # p(average_score, low_score, top_score)
                # no requirement to use history of a player in combination with other params
                # therefore: return and not look at other potentially submitted params
                return render json: output, status: 200   
            end 
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
