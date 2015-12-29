
module.exports = (server, db) ->

#Create Uniqueness for User which will be the id
  db.constraints.uniqueness.drop 'User', 'id', (err) ->
    if err
      console.log err

  db.index.create 'User', 'id', (err, index) ->
    console.log index


  #User Register route =============================================
  server.post('/api/v1/diaspora/auth/register', (req, res, next) ->
    user = req.body.user
    console.log user
    db.save user, ['User','Person'], (err, node) ->
        if err
          throw err
        console.log node
      return


  )
