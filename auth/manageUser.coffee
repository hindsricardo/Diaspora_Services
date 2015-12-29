
module.exports = (server, db) ->

  db.index.create 'User', 'userID', (err, index) ->
    console.log index

  db.constraints.uniqueness.createIfNone 'User', 'userID', (err, constraint) ->
    console.log constraint
  # -> { type: 'UNIQUENESS', label: 'Person', { property_keys: ['name'] }


  #User Register route =============================================
  server.post '/api/v1/diaspora/auth/register', (req, res, next) ->
    user = req.body.user
    db.find { userID: user.userID }, (err, obj) ->
      if err
        throw err
      switch obj?
        when obj
          console.log "This user already exists", obj
          return
        when undefined
          db.save user, ['User','Person'], (err, node) ->
              if err
                throw err
              console.log node

    return next
