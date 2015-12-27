
module.exports = (server, db) ->

  #User Register route =============================================
  server.post('/api/v1/diaspora/auth/register', (req, res, next) ->
    user = req.form
    db.save( user, (err, node) ->
      db.label(node, ['Person'], (err) ->
        # 'node' is now labelled with 'Person'
        if err then console.log err
        ))

  )
