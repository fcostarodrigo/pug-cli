{ vol } = require 'memfs'
{ join } = require 'path'
filterPaths = require './filterPaths'

test 'filter out invalid paths', ->
  vol.fromJSON
    '/folder': {}

  process.chdir '/etc'

  paths = [
    ''
    false
    '../foo'
    '.'
    'foo'
  ]

  expect(filterPaths(paths)).toEqual [ 'foo' ]

test 'make paths relative to the cwd', ->
  paths = [ join(process.cwd(), 'banana') ]
  expect(filterPaths(paths)).toEqual [ 'banana' ]
