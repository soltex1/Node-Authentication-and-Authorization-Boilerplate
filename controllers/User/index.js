'use strict'

// Load modules
const Bcrypt = require('bcryptjs')
const Boom = require('@hapi/boom')
const JWT = require('jsonwebtoken')

const handlers = {}

// User login
handlers.login = async (request, h) => {
  try {
    // Knex plugin
    const knex = request.server.plugins.database.knex

    return await knex.transaction(async function (trx) {

      const { username, password } = request.payload

      // Fetch the user from the database
      const user = await new request.server.plugins.database.User()
        .where({ username })
        .fetch({ transacting: trx })

      if (!user) {
        throw new Error('USER_NOT_FOUND')
      }

      // Validate the password
      const validPassword = await Bcrypt.compare(password, user.attributes.password)

      if (!validPassword) {
        throw new Error('INVALID_PASSWORD')
      }

      // Generate a jwt token
      // Use this token to build your request with the 'Authorization' header.
      // Authorization: Bearer <token>
      const token = JWT.sign({ userId: user.id }, process.env.JWT_SECRET)

      // Revoke any other token for this user
      await new request.server.plugins.database.UserSession()
        .where({
          user_id: user.get('id')
        })
        .save({
          revoked: true
        }, {
          transacting: trx,
          method: 'update'
        })

      // Register a new user session
      await new request.server.plugins.database.UserSession()
        .save({
          user_id: user.id,
          token
        }, {
          transacting: trx
        })

      // Return the user details
      return { user, token, scope: 'user' }
    })
  } catch (e) {
    request.server.log(['error'], e)
    return Boom.badRequest(e.message)
  }
}

handlers.logout = async (request, h) => {
  try {
    // Revoke any token for this user
    await new request.server.plugins.database.UserSession()
      .where({
        token: request.auth.credentials.token
      })
      .save({
        revoked: true
      }, {
        method: 'update'
      })

    return h.response()
  } catch (e) {
    return Boom.badRequest(e.message)
  }
}

// Register a new user
handlers.register = async (request, h) => {
  try {
    // Knex plugin
    const knex = request.server.plugins.database.knex

    const [token, username] = await knex.transaction(async function (trx) {

      const { username, password } = request.payload

      // Encrypt the password
      const encryptedPassword = await Bcrypt.hash(password, 10)

      // Fetch the user from the database
      let user = await new request.server.plugins.database.User()
        .where({ username })
        .fetch()

      if (user) {
        throw new Error('INVALID_USERNAME')
      }

      // Register a new user in the database
      user = await await new request.server.plugins.database.User()
        .save({
          username,
          password: encryptedPassword
        }, {
          transacting: trx
        })

      // Generate a jwt token
      // Use this token to build your request with the 'Authorization' header.
      // Authorization: Bearer <token>
      const token = JWT.sign({ userId: user.id }, process.env.JWT_SECRET)

      // Save the user session
      await new request.server.plugins.database.UserSession()
        .save({
          user_id: user.id,
          token
        }, {
          transacting: trx
        })

      return [token, username]
    })

    // Return the user details
    return h.response({ token, username })
  } catch (e) {
    return Boom.badRequest(e.message)
  }
}

handlers.sectionA = async (request, h) => {
  try {
    return h.response({ text: 'SECTION_A' })
  } catch (e) {
    return Boom.badRequest(e.message)
  }
}

handlers.sectionB = async (request, h) => {
  try {
    return h.response({ text: 'SECTION_B' })
  } catch (e) {
    return Boom.badRequest(e.message)
  }
}

handlers.sectionC = async (request, h) => {
  try {
    return h.response({ text: 'SECTION_C' })
  } catch (e) {
    return Boom.badRequest(e.message)
  }
}

const routes = [
  {
    method: 'POST',
    path: '/users/login',
    handler: handlers.login,
    config: {
      auth: false
    }
  },
  {
    method: 'POST',
    path: '/users/logout',
    handler: handlers.logout,
    config: {
      auth: {
        strategy: 'jwt'
      }
    }
  },
  {
    method: 'POST',
    path: '/users/register',
    handler: handlers.register,
    config: {
      auth: false
    }
  },
  {
    method: 'GET',
    path: '/users/sectionA',
    handler: handlers.sectionA,
    config: {
      auth: {
        strategy: 'jwt',
        scope: ['admin', 'A']
      }
    }
  },
  {
    method: 'GET',
    path: '/users/sectionB',
    handler: handlers.sectionB,
    config: {
      auth: {
        strategy: 'jwt',
        scope: ['admin', 'B']
      }
    }
  },
  {
    method: 'GET',
    path: '/users/sectionC',
    handler: handlers.sectionC,
    config: {
      auth: {
        strategy: 'jwt',
        scope: ['admin', 'C']
      }
    }
  }
]

exports.plugin = {
  name: 'user',
  version: '1.0.0',
  register:
    async function (server, options) {
      try {
        await server.route(routes)
      } catch (e) {
        server.log(['error'], e)
      }
    }
}
