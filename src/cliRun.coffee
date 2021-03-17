cli = require './cli'

cli().catch (error) ->
  console.error error
  process.exit 1
