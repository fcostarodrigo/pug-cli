merge = require 'lodash/merge'

module.exports = (args, config) ->
  if config then merge config, args else args
