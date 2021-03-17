TypeScriptLoader = require '@endemolshinegroup/cosmiconfig-typescript-loader'
{ cosmiconfig, defaultLoaders } = require 'cosmiconfig'
require 'coffeescript/register'
toml = require '@iarna/toml'

moduleName = 'pug'

searchPlaces = [
  'package.json'
  ".#{moduleName}rc",
  ".#{moduleName}rc.json"
  ".#{moduleName}rc.yaml"
  ".#{moduleName}rc.yml"
  ".#{moduleName}rc.js"
  ".#{moduleName}rc.cjs"
  ".#{moduleName}rc.coffee"
  ".#{moduleName}rc.toml"
  ".#{moduleName}rc.ts"
  "#{moduleName}.config.js"
  "#{moduleName}.config.cjs"
  "#{moduleName}.config.coffee"
  "#{moduleName}.config.ts"
]

loaders =
  '.coffee': (file) -> require file 
  '.toml': (file, source) -> toml.parse source
  '.ts': TypeScriptLoader.default

explorer =
  true: cosmiconfig moduleName, { cache: true, loaders, searchPlaces }
  false: cosmiconfig moduleName, { cache: false, loaders, searchPlaces }

module.exports = (configPath, method, cache = true) ->
  return null unless configPath
  result = await explorer[cache][method](configPath)
  result?.config
