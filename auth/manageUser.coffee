
module.exports = (server, db) ->

  #User Register route =============================================
  server.post('/api/v1/diaspora/auth/register', (req, res, next) ->
    user = req
    db.save {
      name: 'Test-Man'
      age: 40
      }, (err, node) ->
        if err
          throw err
        console.log 'Test-Man inserted.'
      return

    #db.save( user, (err, node) ->
    #  db.label(node, ['Person'], (err) ->
        # 'node' is now labelled with 'Person'
    #    if err then console.log err
    #    ))

  )
