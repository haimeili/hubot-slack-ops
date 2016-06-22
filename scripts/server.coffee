# hubot greeting.

# hubot + slack to service better ops
# (special token only for hubot)
# 1. server status: htop info
# 2. database increasing usage info
# 3. redeployment to trigger script(this is special, others can all web app's api directly)
# 4. check one user's status
# 5. show logs info


domain_name = 'https://haimei.pagekite.me/'
token = "123"

module.exports = (robot) ->
  robot.respond /server$/i, (msg) ->
    msg.send "`server <param>`"
    msg.send ">`<param>`:cpu, memory or mem, info, system or sys, user, proc or process"

  # server <param>
  robot.respond /server (.*)/i, (msg) ->
    command = msg.match[1]
    msg.send "checking :airplane_departure:"
    infoReg = /(.?)*info(.?)*/i
    cpuReg = /(.?)*cpu(.?)*/i
    memReg = /(.?)*mem(.?)*/i
    systemReg = /(.?)*sys(.?)*/i
    userReg = /(.?)*user(.?)*/i
    processReg = /(.?)*proc(.?)*/i
    msg.send "done :bulb:"

    if infoReg.test(command) || cpuReg.test(command)
      commandExec(msg, "ps -e -o %cpu | awk '{s+=$1} END {print s}'", "`cpu current usage(%)` ")
      commandExec(msg, "sysctl -n machdep.cpu.brand_string", "`cpu info` ")

    if infoReg.test(command) || memReg.test(command)
      commandExec(msg, "top -l 1 -s 0 | awk ' /Processes/ || /PhysMem/ || /Load Avg/{print}'", "`physical memory`\n")
      commandExec(msg, "ps -e -o %mem | awk '{s+=$1} END {print s}'", "`memory current usage(%)` ")

    if infoReg.test(command) || systemReg.test(command)
      commandExec(msg, "sw_vers", "`system info`\n")
      commandExec(msg, "uname -v", "`kernel version` ")
      commandExec(msg, "df -h", "`disk space usage`\n")
      commandExec(msg, "uname -m", "`hardware name` ")

    if infoReg.test(command) || processReg.test(command)
      commandExec(msg, "w", "`running process`\n")

    if infoReg.test(command) || userReg.test(command)
      commandExec(msg, "uname", "`kernel name of system` ")
      commandExec(msg, "uname -n", "`network hostname` ")
      commandExec(msg, "ulimit -a", "`user limits`\n")

commandExec = (msg, command, desc) ->
  child_process = require('child_process')
  child_process.exec command, (err, stdout, stderr) ->
    msg.send desc+stdout.toString()
