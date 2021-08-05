# A Ruby on Rails API

rails db:drop db:create db:migrate rails db:seed
rails c
rails s

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Deployment instructions

- API
** Score
  
*** Create

```
id: 123456,
player: "player_name",
score: integer > 0,
time: "2021-08-05 07:33:41"
```

*** Get
Returns the score of the given id
`api/v1/scores/{id}`

Returns a filtered list of scores
`api/v1/scores/{id}?before=01.01.21.07.30&after=01.01.21.07.30&players[abc1]=1&players[abc2]=2&players[abc3]=3`

Returns a players score history
`api/v1/scores?history=abc1`

*** Delete
`api/v1/scores/{id}`

Deletes the score of the given id
