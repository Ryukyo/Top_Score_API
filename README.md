# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- API
  ** Score \*** Create

```
id: 123456,
player: "player_name",
score: integer > 0,
time: "01.01.21.07.30"
```

\*\*\* Get
Returns the score of the given id
`api/v1/scores/{id}`

Returns a filtered list of scores
`api/v1/scores/{id}?before=01.01.21.07.30&after=01.01.21.07.30&player=abc1,abc2`

Returns a players score history
`api/v1/scores?history=abc1`

\*\*\* Delete
`api/v1/scores/{id}`

Deletes the score of the given id
