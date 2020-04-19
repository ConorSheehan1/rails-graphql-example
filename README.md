[![Build Status](https://travis-ci.org/ConorSheehan1/rails-graphql-example.svg?branch=master)](https://travis-ci.org/ConorSheehan1/rails-graphql-example)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# Rails Graphql Example
This is a small graphql example built on rails.
Go to http://localhost:3000/graphiql and play around with the queries.

### Install
```bash
# optionally set specific ruby version
rbenv local 2.5.3 

gem install bundler
bundle install
```

### Start
```bash
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails server
```

### Credit
Based on the [howtographql](https://www.howtographql.com/graphql-ruby/1-getting-started/) rails tutorial.  
[howtographql source](https://github.com/howtographql/howtographql).  
[graphql-ruby source](https://github.com/howtographql/graphql-ruby).  


### Queries
http://localhost:3000/graphiql

```graphql

mutation CreateUser1{
  createUser(
    name: "me",
    authProvider: {
      email: {
        email: "me@example.com",
        password: "123"
      }
    }
  ) {
    id
    email
    name
  }
}


mutation SignInUser1{
  signinUser(
    email: {
      email: "me@example.com",
      password: "123"
    }
  ) {
    token
    user {
      id
    }
  }
}

mutation CreateLink1 {
  createLink(
    url: "http://wow.com",
    description: "wow great link"
  ) {
    id
    description
  }
}

mutation CreateUserVote {
  createVote(linkId:"9") {
    link {
      description
    }
    user {
      name
    }
  }
}


query getLinkVotes {
  allLinks {
    votes {
      id
    }
  }
}

query getAllUserVotes {
  allLinks {
    id
    postedBy {
      name
      votes {
        link {
          description
        }  
      }
    }
  }
}

mutation badLink {
  createLink(url: "", description: "") {
    id
  }
}

query getLinkExamples {
  allLinks(filter:{ descriptionContains:"example"}) {
    description
  }
}

query getSecondAndThirdLink {
  allLinks(first:2, skip: 1) {
    id
  }
}
```
