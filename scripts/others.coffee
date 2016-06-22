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
  robot.respond /hi|hello|greet/i, (res) ->
    res.send "Hi Boss, My name is `Totoro`.:robot_face:"
    res.send "Welcome to PPIM-OPS WOW!"

  robot.respond /helps/i, (msg) ->
    msg.send "`db info`"
    msg.send "`db <table_name> <command> <optional_info>`"
    msg.send ">`<table_name>`: users, cards, logs"
    msg.send ">`<command>`: info, describe or desc, list, delete"
    msg.send ">`<optional_info>`: id, email"
    msg.send "`server <param>`"
    msg.send ">`<param>`: cpu, memory or mem, info, system or sys, user, proc or process"
    msg.send "`app <param>`"
    msg.send ">`<param>`: version, deploy"

  robot.respond /(cal|calendar)( me)?/i, (res) ->
    child_process.exec 'cal', (err, stdout, stderr) ->
      res.send(stdout)
  robot.respond /date/i, (msg) ->
    child_process.exec 'date', (err, stdout, stderr) ->
      msg.send stdout

  #robot.catchAll (res) ->
  #  res.send "Hello Boss, I :thinking_face: can't recognize your command: `#{res.message.text}`."
  #  res.send "Please use `helps` command to know how to write right command"
  #  res.send "And then I can service you. My name is `Totoro`.:robot_face:"
