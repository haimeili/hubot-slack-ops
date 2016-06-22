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
  # app <param>
  robot.respond /app (.*)/i, (msg) ->
    msg.send "checking :airplane_departure:"
    command = msg.match[1]
    if command is "deploy"
      msg.send "done :bulb:"
      msg.send "todo"
    if command is "version"
      msg.send "todo"
