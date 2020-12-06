{ vol } = require 'memfs'
{ join } = require 'path'
ignore = require 'ignore'
resolveGlob = require './resolveGlob'

afterEach ->
  vol.reset()

test 'empty array', ->
  files = await resolveGlob [], ignore()
  expect(files).toEqual []

test 'resolve to a file', ->
  vol.fromJSON
    'test.txt': ''

  files = await resolveGlob ['*'], ignore()

  expect(files).toEqual [ 'test.txt' ]

test 'resolve to files', ->
  vol.fromJSON
    'test1.txt': ''
    'test2.txt': ''

  files = await resolveGlob ['*'], ignore()

  expect(files.sort()).toEqual [
    'test1.txt'
    'test2.txt'
  ].sort()

test 'work with the working directory', ->
  vol.fromJSON
    'test.txt': ''

  files = await resolveGlob ['*'], ignore()

  expect(files).toEqual [ 'test.txt' ]

test 'ignore files', ->
  vol.fromJSON
    'test1.txt': ''
    'test2.txt': ''

  files = await resolveGlob ['*'], ignore().add('test2.txt')

  expect(files).toEqual [ 'test1.txt' ]

test 'resolve to folders', ->
  vol.fromJSON
    'fruits/banana.pug': ''
    'fruits/apple.pug': ''

  files = await resolveGlob ['*'], ignore()

  expect(files).toEqual [ 'fruits' ]

test 'resolve to files in folders', ->
  vol.fromJSON
    'fruits/banana.pug': ''
    'fruits/apple.pug': ''

  files = await resolveGlob ['**/*.pug'], ignore()

  expect(files.sort()).toEqual [
    'fruits/banana.pug'
    'fruits/apple.pug'
  ].sort()

test 'skip folders', ->
  vol.fromJSON
    'fruits/banana.pug': ''
    'fruits/apple.pug': ''
    'vegetables/onion.pug': ''
    'vegetables/lettuce.pug': ''

  files = await resolveGlob ['**/*.pug'], ignore().add('fruits')

  expect(files.sort()).toEqual [
    'vegetables/onion.pug'
    'vegetables/lettuce.pug'
  ].sort()
