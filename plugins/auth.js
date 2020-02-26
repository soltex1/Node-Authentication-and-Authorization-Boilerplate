'use strict'

// Load modules
const Boom = require('@hapi/boom')

// Validates the user
const validate = async function (_, request, h) {
  try {
    const token = request.headers.authorization.split(' ')[1]

    // Fetch the user session from the database
    const UserSession = await new request.server.plugins.database.UserSession()
      .where({
        token,
        revoked: false
      })
      .fetch()

    if (!UserSession) {
      return { isValid: false }
    }

    const userId = UserSession.get('user_id')

    // Fetch the user scopes with related scope details from the database
    const UserScopes = await new request.server.plugins.database.UserScope()
      .where({ user_id: userId })
      .fetchAll({ withRelated: ['scope'] })

    // Get the scope names
    const scopes = await Promise.all(UserScopes.map((UserScope) => {
      return UserScope.relations.scope.get('name')
    }))

    if (UserScopes && scopes.length) {
      return { isValid: true, credentials: { scope: scopes, token } }
    }

    return { isValid: false }
  } catch (e) {
    return Boom.badRequest(e.message)
  }
}

exports.plugin = {
  name: 'auth',
  version: '1.0.0',
  register: async function (server) {
    try {
      server.auth.strategy('jwt', 'jwt', {
        key: process.env.JWT_SECRET,
        validate,
        verifyOptions: { algorithms: ['HS256'] }
      })

      server.auth.default('jwt')
      server.log('auth', 'Authentication Model loaded.')
    } catch (e) {
      server.log('auth', 'Authentication Model failed to load.')
    }
  }
}
