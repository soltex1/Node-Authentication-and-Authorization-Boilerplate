'use strict'

// Load modules
const Path = require('path')

const manifest = {
  server: {
    host: process.env.HOSTNAME,
    port: process.env.PORT,
    debug: {
      log: '*',
      request: '*'
    }
  },
  register: {
    plugins: [
      {
        plugin: require('hapi-auth-jwt2'),
        options: {}
      },
      {
        plugin: Path.join(__dirname, '../plugins/auth'),
        options: {}
      },
      {
        plugin: Path.join(__dirname, '../controllers'),
        options: {}
      },
      {
        plugin: Path.join(__dirname, '../plugins/database'),
        options: {
          connection: {
            host: process.env.DB_HOST,
            user: process.env.DB_USER,
            password: process.env.DB_PASS,
            database: process.env.DB_NAME
          }
        }
      }
    ],
  }
}

module.exports = manifest
