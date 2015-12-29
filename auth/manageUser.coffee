
module.exports = (server, db) ->

#Create Uniqueness for User which will be the id
  db.constraints.uniqueness.create 'User', 'id', (err, constraint) ->
    console.log constraint
    # -> { type: 'UNIQUENESS', label: 'Person', { property_keys: ['name'] }
    return

  #User Register route =============================================
  server.post('/api/v1/diaspora/auth/register', (req, res, next) ->
    user = req.user
    db.save user, ['User','Person'], (err, node) ->
        if err
          throw err
        console.log node
      return


  )
