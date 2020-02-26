'use strict'

// Load modules
const Glue = require('@hapi/glue')
const Manifest = require('./manifest');

(async function () {
  try {

    const options = {
      relativeTo: __dirname
    }

    const server = await Glue.compose(Manifest, options)

    await server.start()

    server.log(['server'], `server running at: ${server.info.uri}`)

  } catch (err) {
    // Unhandled rejections
    console.error(err)
    process.exit(1)
  }
})()

