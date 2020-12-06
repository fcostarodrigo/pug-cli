{ vol } = require 'memfs'
{ join } = require 'path'
loadIgnore = require './loadIgnore'

afterEach ->
  vol.reset()

test 'ignore paths of a file', ->
  vol.fromJSON
    '.pugignore': 'test.pug'

  ignore = await loadIgnore '.pugignore'

  expect(ignore.ignores('test.pug')).toBe(true)
  expect(ignore.ignores('index.pug')).toBe(false)

test 'fallback to .gitignore', ->
  vol.fromJSON
    '.gitignore': 'test.pug'

  ignore = await loadIgnore()

  expect(ignore.ignores('test.pug')).toBe(true)
  expect(ignore.ignores('index.pug')).toBe(false)

test 'fallback to node modules', ->
  ignore = await loadIgnore()

  expect(ignore.ignores('node_modules/index.pug')).toBe(true)
  expect(ignore.ignores('index.pug')).toBe(false)
