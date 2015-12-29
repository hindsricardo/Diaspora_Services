
module.exports = (server, db) ->

  ###db.index.create 'User', 'userID', (err, index) ->
    console.log index

  db.constraints.uniqueness.createIfNone 'User', 'userID', (err, constraint) ->
    console.log constraint
  # -> { type: 'UNIQUENESS', label: 'Person', { property_keys: ['name'] }###


  #User Register route =============================================
  server.post '/api/v1/diaspora/auth/register', (req, res, next) ->
    user = req.body.user
    newID = { "userID": user.id }
    newUser = user.splice user.indexOf 'id', 1
    userObj = newUser.push newID
    console.log newID, newUser, userObj
    db.find { id: userObj.userID }, (err, obj) ->
      if obj.length > 0
        console.log "This user already exists", obj, obj.length
        return
      else
        db.save user, ['User','Person'], (err, node) ->
            if err
              throw err
            console.log node

    return next
