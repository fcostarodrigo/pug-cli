{ cosmiconfig } = require 'cosmiconfig'

explorer = cosmiconfig 'pug'

module.exports = (configPath, method) ->
  return null unless configPath
  result = await explorer[method](configPath)
  result?.config
