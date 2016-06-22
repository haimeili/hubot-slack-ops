# hubot greeting.
#
# (hi|hello) - say hi to your butler

# hubot + slack to service better ops
# (special token only for hubot)
# 1. server status: htop info
# 2. database increasing usage info
# 3. redeployment to trigger script(this is special, others can all web app's api directly)
# 4. check one user's status
# 5. show logs info

child_process = require('child_process')
domain_name = 'https://haimei.pagekite.me/'
token = "123"

module.exports = (robot) ->
  robot.respond /db$/i, (msg) ->
    msg.send "`db info`"
    msg.send "`db <table_name> <command> <optional_info>`"
    msg.send ">`<table_name>`:users, cards, logs"
    msg.send ">`<command>`:info, describe or desc, list, delete"
    msg.send ">`<optional_info>`:id, email"

  # db info
  robot.respond /db info$/i, (msg) ->
    msg.send "checking :airplane_departure:"
    data = JSON.stringify({
      "token": token
    })
    dbPost(robot, data, msg)

  # db <table_name> <command>
  robot.respond /db (.*) (.*)/i, (msg) ->
    msg.send "checking :airplane_departure:"
    tableName = msg.match[1]
    command = msg.match[2]
    data = JSON.stringify({
      "token": token,
      "table_name": tableName,
      "command": command
    })
    dbPost(robot, data, msg)

  # db <table_name> <command> <optional_info>
  robot.respond /db (.*) (.*) (.*)/i, (msg) ->
    msg.send "checking :airplane_departure:"
    tableName = msg.match[1]
    command = msg.match[2]
    optionalInfo = msg.match[3]
    data = JSON.stringify({
      "token": token,
      "table_name": tableName,
      "command": command,
      "optional_info": optionalInfo
    })
    dbPost(robot, data, msg)

dbPost = (robot, data, msg) ->
  robot.http(domain_name + "api/hubot/dbInfo/")
    .header('Content-Type', 'application/json')
    .post(data) (err, res, body) ->
      msg.send "done :bulb:"
      msg.send "#{body}"
