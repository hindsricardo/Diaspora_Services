
module.exports = (server, db) ->

  ###db.index.create 'User', 'userID', (err, index) ->
    console.log index

  db.constraints.uniqueness.createIfNone 'User', 'userID', (err, constraint) ->
    console.log constraint
  # -> { type: 'UNIQUENESS', label: 'Person', { property_keys: ['name'] }###


  #User Register route =============================================
  server.post '/api/v1/diaspora/auth/person/register', (req, res, next) ->
    user = req.body.user
    db.find { userID: user.userID }, (err, obj) ->
      if obj.length > 0
        console.log "This user - person already exists", obj, obj.length
        return
      else
        db.save user, ['User','Person'], (err, node) ->
            if err
              throw err
            console.log node

    next()

  #User Register Company Route =========================================
  server.post '/api/v1/diaspora/business/auth/register', (req, res, next) ->
    user = req.body.user
    db.find {username: user.username}, (err, obj) ->
      if obj.length > 0
        console.log "This user - business already exists", obj, obj.length
        return
      else
        db.save user, ['User','business'], (err, node) ->
          if err
            throw err
          console.log node
    next()
