
<h1 align="center">
  Node-Authentication-and-Authorization-Boilerplate
  <br>
</h1>

<h4 align="center">:closed_lock_with_key: A boilerplate application with JWT Authentication and Authorization strategies backed by Hapi and PostgreSQL.</h4>

<p align="center">
  <a href="#description">Description</a> •
  <a href="#how-to-use">How To Use</a> •
  <a href="#database-models">Database Models</a> •
  <a href="#scopes">Scopes</a> •
  <a href="#users">Users</a> •
  <a href="#endpoints">Endpoints</a> •
  <a href="#plugins">Plugins</a> •
  <a href="#environment-variables">Environment Variables</a>
</p>


## Description

This project shows how to implement a consistent authentication and authorization system. There are a few endopoints, each one with a different authorization.

Use the [Database Dump](./jwt_app.sql) and the environment variable JWT_SECRET=`MLH.gH)V#vj6m'J3` in order to execute the examples described below.

If you want to know more about how JWT works, please check the following links:

https://github.com/dwyl/hapi-auth-jwt2 <br>
https://github.com/dwyl/learn-json-web-tokens <br>
https://jwt.io/introduction/ <br>

### How To Use

`git clone`

`npm install`

`node index.js` to run the server.

## Database Models

#### Table user

| Name  |  Type |
| ------------------- | ------------------- |
|  id |  UUID |
|  username |  VARCHAR |
|  password |  VARCHAR (ENCRYPTED) |
|  created_at |  TIMESTAMP WITH TIME ZONE |
|  updated_at |  TIMESTAMP WITH TIME ZONE |

#### Table user_session

| Name  |  Type |
| ------------------- | ------------------- |
|  id |  UUID |
|  user_id |  UUID |
|  token |  VARCHAR |
|  revoked | BOOLEAN |
|  created_at |  TIMESTAMP WITH TIME ZONE |
|  updated_at |  TIMESTAMP WITH TIME ZONE |

#### Table scope

| Name  |  Type |
| ------------------- | ------------------- |
|  id |  UUID |
|  name |  VARCHAR |
|  created_at |  TIMESTAMP WITH TIME ZONE |
|  updated_at |  TIMESTAMP WITH TIME ZONE |

#### Table user_scope

| Name  |  Type |
| ------------------- | ------------------- |
|  id |  UUID |
|  user_id |  UUID |
|  scope_id |  UUID |
|  created_at |  TIMESTAMP WITH TIME ZONE |
|  updated_at |  TIMESTAMP WITH TIME ZONE |

You can download and use the [Database Dump](./jwt_app.sql) 

## Scopes


* **Admin**: can access every section
* **A**: can only access section A 
* **B**: can only access section B
* **C**: can only access section C

## Users

* **Admin**: can access every section
* **user1**: can only access section A and C
* **user2**: can only access section B
* **user3**: can only access section B

You can add as many scopes as you want and manage the permissions by adding or removing data from the user_scope table.

## Endpoints

```
POST /users/login
POST /users/logout
POST /users/register
GET  /users/sectionA
GET  /users/sectionB
GET  /users/sectionC
```

## Plugins

[*@hapi/boom*](https://www.npmjs.com/package/@hapi/boom) <br>
[*@hapi/glue*](https://www.npmjs.com/package/@hapi/glue) <br>
[*bcryptjs*](https://www.npmjs.com/package/bcryptjs) <br>
[*bookshelf*](https://www.npmjs.com/package/bookshelf) <br>
[*jsonwebtoken*](https://www.npmjs.com/package/jsonwebtoken) <br>
[*knex*](https://www.npmjs.com/package/knex) <br>
[*pg*](https://www.npmjs.com/package/pg)

#### Internal Plugins

[database.js](./plugins/database.js) 

This plugin sets up the knex and bookshelf configurations.

[auth.js](./plugins/auth.js) 

This plugin takes care of the authentication and authorization events.

## Environment Variables

`HOST` <br>
`PORT` <br>
`JWT_SECRET` <br>
`DB_HOST` <br>
`DB_NAME` <br>
`DB_USER` <br>
`DB_PASS` <br>
