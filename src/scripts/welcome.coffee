# Description
#   A Hubot script that say "welcome!" when you enter the room.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#   bouzuya <m@bouzuya.net>
#
module.exports = (robot) ->
  robot.enter (res) ->
    res.reply 'welcome!'
