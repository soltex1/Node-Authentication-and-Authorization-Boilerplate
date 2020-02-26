'use strict'

const UserSession = (bookshelf) => {
  return bookshelf.model('UserSession', {
    hasTimestamps: true,
    requireFetch: false,
    tableName: 'user_session'
  })
}

module.exports = UserSession
