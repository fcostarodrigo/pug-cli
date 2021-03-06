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
  argConfig = await loadConfig args.config, 'load'
  args = mergeConfig args, argConfig
  ignore = await loadIgnore args.ignore
  cwd = checkCWD args.files
  files = await resolveGlob filterPaths(args.files), ignore
  files.push '.' if cwd

  await walk files, ignore, (root, file) ->
    await compile args, ignore, root, file

  if args.watch
    await Promise.all (watch args, ignore, file for file in files)
