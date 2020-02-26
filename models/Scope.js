'use strict'

const Scope = (bookshelf) => {
  return bookshelf.model('Scope', {
    hasTimestamps: true,
    requireFetch: false,
    tableName: 'scope'
  })
}

module.exports = Scope
