path = require 'path'

replaceExt = (file, ext) ->
  { dir, name } = path.parse file
  path.format { dir, name, ext }

relativeTo = (root, source, out) ->
  path.join(out, path.relative(root, source))

module.exports = (root, source, out) ->
  file = if out then relativeTo(root, source, out) else source
  replaceExt file, '.html'
