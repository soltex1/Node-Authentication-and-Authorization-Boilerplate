'use strict'

// Load modules
const Path = require('path')
const Fs = require('fs')

exports.plugin = {
  name: 'database',
  version: '1.0.0',
  register: async function (server, options) {

    try {
      // Setting up the database connection
      const knex = require('knex')({
        client: 'pg',
        connection: options.connection
      })

      server.expose('knex', knex)

      const bookshelf = require('bookshelf')(knex)

      Fs.readdir(Path.join(__dirname, '../models'), (err, files) => {
        files.forEach(file => {

          const name = file.split('.js')[0]
          const model = require(Path.join(__dirname, '../models/', name))(bookshelf)

          // Expose the model
          server.expose(name, model)
        })
      })

      server.log('database', 'Database models loaded.')
    } catch (e) {
      server.log('auth', 'Database models failed to load.')
    }
  }
}
