walk = require './walk'
watch = require './watch'
compile = require './compile'
loadArgs = require './loadArgs'
checkCWD = require './checkCWD'
loadConfig = require './loadConfig'
loadIgnore = require './loadIgnore'
resolveGlob = require './resolveGlob'
mergeConfig = require './mergeConfig'
filterPaths = require './filterPaths'

module.exports = ->
  args = await loadArgs()
  argConfig = await loadConfig args.configPath, 'load'
  args = mergeConfig args, argConfig
  ignore = await loadIgnore args.ignorePath
  cwd = checkCWD args.files
  files = await resolveGlob filterPaths(args.files), ignore
  files.push '.' if cwd

  await walk files, ignore, (root, file) ->
    await compile args, ignore, root, file

  if args.watch
    for file in files
      watch args, ignore, file
