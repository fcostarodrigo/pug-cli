{ join, relative, parse, format, basename }  = require 'path'

replaceExt = (file, ext) ->
  { dir, name } = parse file
  format { dir, name, ext }

relativeTo = (root, source, out) ->
  join(out, relative(root, source) or basename(source))

module.exports = (root, source, out) ->
  file = if out then relativeTo(root, source, out) else source
  replaceExt file, '.html'
