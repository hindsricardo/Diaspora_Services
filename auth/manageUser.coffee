
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
        res.writeHead 403, 'Content-Type':'application/json; charset=utf-8'
        res.end JSON.stringify {
          message: '"This user - person already exists"'
        }
      else
        db.save user, ['User','Person'], (err, node) ->
            if err
              res.writeHead 403, 'Content-Type':'application/json; charset=utf-8'
              res.end JSON.stringify {
                error: err,
                message: "something went wrong with adding a new person"
              }
            else
              res.writeHead 200, 'Content-Type':'application/json; charset=utf-8'
              res.end JSON.stringify node
    next()

  #User Register Company Route =========================================
  server.post '/api/v1/diaspora/business/auth/register', (req, res, next) ->
    user = req.body.user
    db.find {username: user.username}, (err, obj) ->
      if obj.length > 0
        console.log "This user - business already exists", obj, obj.length
        res.writeHead 403, 'Content-Type':'application/json; charset=utf-8'
        res.end JSON.stringify {
          message: "This user - business already exists"
        }
      else
        db.save user, ['User','Business'], (err, node) ->
          if err
            res.writeHead 403, 'Content-Type':'application/json; charset=utf-8'
            res.end JSON.stringify {
              error: err,
              message: "something went wrong with adding a new business"
            }
          else
            res.writeHead 200, 'Content-Type':'application/json; charset=utf-8'
            res.end JSON.stringify node
    next()

    #User Find Person Route ==============================================
    server.get '/api/v1/diaspora/person/find/:token', (req, res, next) ->
      console.log req.params.token, typeof req.params.token, typeof parseInt req.params.token
      token = req.params.token # The token as a string
      numToken = parseInt(req.params.token) #The token as a number
      if typeof numToken = 'number'
        db.find {userID: numToken}, (err, node) ->
          if err
            res.writeHead 403, 'Content-Type':'application/json; charset=utf-8'
            res.end JSON.stringify {
              error: err,
              message: "something went wrong finding a person"
            }
          res.writeHead 200, 'Content-Type':'application/json; charset=utf-8'
          res.end JSON.stringify node
      if typeof req.params.token = 'string'
        db.find {username: token}, (err, node) ->
          if err
            res.writeHead 403, 'Content-Type':'application/json; charset=utf-8'
            res.end JSON.stringify {
              error: err,
              message: "something went wrong with finding a new person"
            }
          res.writeHead 200, 'Content-Type':'application/json; charset=utf-8'
          res.end JSON.stringify node
    next()
