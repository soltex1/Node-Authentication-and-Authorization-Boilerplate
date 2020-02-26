'use strict'

const User = (bookshelf) => {
  return bookshelf.model('User', {
    hasTimestamps: true,
    requireFetch: false,
    tableName: 'user'
  })
}

module.exports = User
