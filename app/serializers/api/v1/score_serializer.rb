class Api::V1::ScoreSerializer
    include JSONAPI::Serializer
    
    attributes :score, :time
end