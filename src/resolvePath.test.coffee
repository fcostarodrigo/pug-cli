resolvePath = require './resolvePath.coffee'

test 'use the same directory when there is no out folder', ->
  root = '.'
  source = 'downloads/index.pug'
  target = resolvePath root, source
  expect(target).toBe 'downloads/index.html'

test 'replicate the tree in out folder', ->
  root = '.'
  source = 'downloads/index'
  out = 'dist'
  target = resolvePath root, source, out
  expect(target).toBe 'dist/downloads/index.html'
