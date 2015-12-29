
module.exports = (server, db) ->

  db.index.create 'User', 'userID', (err, index) ->
    console.log index

  db.constraints.uniqueness.createIfNone 'User', 'userID', (err, constraint) ->
    console.log constraint
  # -> { type: 'UNIQUENESS', label: 'Person', { property_keys: ['name'] }


  #User Register route =============================================
  server.post '/api/v1/diaspora/auth/register', (req, res, next) ->
    user = req.body.user
    console.log user
    db.find { userID: user.userID }, (err, obj) ->
      if err
        console.log err
      if obj = undefined
        console.log err
        db.save user, ['User','Person'], (err, node) ->
            if err
              throw err
            console.log node
      else
        console.log "This user already exists", obj
    return next
