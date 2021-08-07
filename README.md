# A Ruby on Rails API

A pure API project built with Ruby on Rails
With a running server, the endpoints described below can be accessed, for example, through Postman, Insomnia or cURL

## Getting Started

rails c
rails s
bundle install

- Environment
  Ubuntu 20.04
  Ruby
  Ruby on Rails

- Configuration

- Database setup
  rails db:drop db:create db:migrate db:seed

- How to run the test suite

## Scores

### Create

Id will be assigned automatically
Score must be an integer > 0

Sample body:

```
"player": "Brandon",
"score": 2,
"time": "2020-08-06 17:03:18"
```

### Get

Returns the score of the given id
`api/v1/scores/{id}`

Sample response:

```
{
    "player": "Adrian",
    "score": 5,
    "time": "2021-08-03T07:33:41.456Z"
}
```

Returns a filtered list of scores, or unfiltered if no parameters given; maximum limit of 100 to reduce stress on DB. All parameters are optional, multiple player names can be submitted, which are handled case insensitive.
`api/v1/scores?after=2020-08-07&player[]=Hiromi&player[]=braNdon&before=2021-08-05&offset=1&limit=5`

Sample response:

```
[
    {
        "id": 7,
        "player": "Hiromi",
        "score": 2,
        "time": "2021-03-27T11:23:18.000Z"
    }
]
```

Returns a players score history
`api/v1/scores?history=Hiromi`

This response is more deeply nested, as I used _jsonapi-serializer_, which does not allow to omit values like id or type and attaches the result data to the "attributes" property, but it successfully removed player and other timestamps.

Contrary to the other endpoints, using `only: ["listOfProperties"]` was not a valid option when building custom json

Sample response:

```
{
    "topScore": {
        "data": {
            "id": "7",
            "type": "score",
            "attributes": {
                "score": 2,
                "time": "2021-03-27T11:23:18.000Z"
            }
        }
    },
    "lowScore": {
        "data": {
            "id": "3",
            "type": "score",
            "attributes": {
                "score": 1,
                "time": "2021-08-01T07:33:41.456Z"
            }
        }
    },
    "averageScore": 1.5,
    "allScores": {
        "data": [
            {
                "id": "3",
                "type": "score",
                "attributes": {
                    "score": 1,
                    "time": "2021-08-01T07:33:41.456Z"
                }
            },
            {
                "id": "7",
                "type": "score",
                "attributes": {
                    "score": 2,
                    "time": "2021-03-27T11:23:18.000Z"
                }
            }
        ]
    }
}
```

### Delete

Deletes the score of the given id.
Returns a list of the remaining score entries
`api/v1/scores/{id}`
