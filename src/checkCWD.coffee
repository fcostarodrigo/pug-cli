{ resolve } = require 'path'

module.exports = (files) ->
  cwd = resolve process.cwd()
  files.some (file) -> resolve(file) is cwd
