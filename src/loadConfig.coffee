{ cosmiconfig } = require 'cosmiconfig'

explorer =
  true: cosmiconfig 'pug', cache: true
  false: cosmiconfig 'pug', cache: false

module.exports = (configPath, method, cache = true) ->
  return null unless configPath
  result = await explorer[cache][method](configPath)
  result?.config
