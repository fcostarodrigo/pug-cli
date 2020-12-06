{ join } = require 'path'
resolvePath = require './resolvePath.coffee'

test 'use the same directory when there is no out folder', ->
  root = '.'
  source = join 'downloads', 'index.pug'
  target = resolvePath root, source
  expect(target).toBe(join('downloads', 'index.html'))

test 'replicate the tree in out folder', ->
  root = '.'
  source = join 'downloads', 'index'
  out = 'dist'
  target = resolvePath root, source, out
  expect(target).toBe(join('dist', 'downloads', 'index.html'))
