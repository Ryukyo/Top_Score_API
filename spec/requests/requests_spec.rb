require 'rails_helper'

RSpec.describe 'Scores API', type: :request do
  # initialize test data
  let!(:scores) { create_list(:score, 10) }
  let (:player) {scores.first.player}
  let(:id) {scores.first.id}
  
  # Test suite for GET /api/v1/scores
  describe 'GET /api/v1/scores' do
    # make HTTP get request before each example
    before { get '/api/v1/scores' }

    it 'returns scores' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/scores/:id
  describe 'GET /api/v1/scores/:id' do
    before { get "/api/v1/scores/#{id}" }

    context 'when the score exists' do
      it 'returns the score' do
        expect(json).not_to be_empty
        expect(json['player']).to eq(player)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to include("Score not found")
      end
    end
  end

  # Test suite for POST /api/v1/scores
  describe 'POST /api/v1/scores' do
    # valid payload
    let(:valid_attributes) { { player: 'Elm', score: 7, time: '2021-03-27 11:23:18' } }

    context 'when the request is valid' do
      before { post '/api/v1/scores', params: valid_attributes }

      it 'creates a score' do
        expect(json['player']).to eq('Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/scores', params: { player: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to include("can't be blank")
      end
    end
  end

  # Test suite for DELETE /api/v1/scores/:id
  describe 'DELETE /api/v1/scores/:id' do
    before { delete "/api/v1/scores/#{id}" }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    context 'when the record does not exist' do
        let(:id) { 100 }
  
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
  
        it 'returns a not found message' do
          expect(response.body).to include("Score not found")
        end
      end
  end
end