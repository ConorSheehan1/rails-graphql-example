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
```


Based on the howtographql rails tutorial 

https://www.howtographql.com/graphql-ruby/1-getting-started/
