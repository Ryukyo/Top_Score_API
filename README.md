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
id will be assigned automatically
score must be an integer > 0
```
"player": "Brandon",
"score": 2,
"time": "2020-08-06 17:03:18"
```

*** Get
Returns the score of the given id
`api/v1/scores/{id}`

Returns a filtered list of scores, or unfiltered if no parameters given; maximum limit of 100 to reduce stress on DB
`api/v1/scores?after=2020-08-07&player[]=Hiromi&player[]=braNdon&before=2021-08-05&offset=1&limit=5`

Returns a players score history
`api/v1/scores?history=abc1`

*** Delete
`api/v1/scores/{id}`

Deletes the score of the given id
