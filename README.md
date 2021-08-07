# A Ruby on Rails API

A pure API project built with Ruby on Rails
With a running server, the endpoints described below can be accessed, for example, through Postman, Insomnia or cURL

## Getting Started

To install required gems:

```
bundle install
```

To interact with your Rails application from the command line

```
bin/rails console
```

To launch a web server named Puma, running on localhost:3000 by default:
`bin/rails server`
For further commands and more detailed up to date documentation, please refer to https://guides.rubyonrails.org/command_line.html

- Environment\
  Ubuntu 20.04\
  Ruby 3.0.0\
  Ruby on Rails 6.1.4

- Database setup\
  The API is running on the default SQLite db

  To get started, run the following command to execute the change method within the most recent migration file in the db/migrate directory:

  ```
  bin/rails db:migrate
  ```

  To seed the db with sample data from db/seeds.rb:

  ```
  bin/rails db:seed
  ```

  To reset your database completely, run the following commands in sequence

  ```
  bin/rails db:drop db:create db:migrate
  ```

- How to run the test suite\
  :warning: Requires running server

  ```
  bundle exec rspec
  ```
  Given the limited time, this is not an exhaustive list of tests, but by verifying the endpoints work as expected, the general functionality is assured.

## Scores

### Create

Id will be assigned automatically\
Score must be an integer > 0

Sample body:

```
"player": "Brandon",
"score": 2,
"time": "2020-08-06 17:03:18"
```

### Get

Returns the score of the given id\
`api/v1/scores/{id}`

Sample response:

```
{
    "player": "Adrian",
    "score": 5,
    "time": "2021-08-03T07:33:41.456Z"
}
```

Returns a filtered list of scores, or unfiltered if no parameters given; maximum limit of 100 to reduce stress on DB. All parameters are optional, multiple player names can be submitted, which are handled case insensitive.\
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

Returns a players score history\
`api/v1/scores?history=Hiromi`

This response is more deeply nested, as I used "jsonapi-serializer", which does not allow to omit values like id or type and attaches the result data to the "attributes" property, but it successfully removed player and other timestamps.

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

Deletes the score of the given id.\
Returns the deleted score for confirmation.\
`api/v1/scores/{id}`
