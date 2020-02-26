'use strict'

// Load child controllers
const User = require('./User')

exports.plugin = {
  name: 'controllers',
  version: '1.0.0',
  register:
    async function (server, options) {
      try {
        await server.register([
          User
        ])

        server.log('controllers', 'Controllers loaded.')
      } catch (e) {
        server.log(['error'], e)
      }
    }
}


