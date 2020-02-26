'use strict'

const UserScope = (bookshelf) => {
  return bookshelf.model('UserScope', {
    hasTimestamps: true,
    requireFetch: false,
    tableName: 'user_scope',
    scope () {

      return this.hasOne('Scope', 'id', 'scope_id')
    }
  })
}

module.exports = UserScope
