{ vol } = require 'memfs'
{ join } = require 'path'
ignore = require 'ignore'
walk = require './walk'

beforeEach ->
  vol.reset()

test 'transverse a single file', ->
  vol.fromJSON
    'index.pug': ''

  files = ['index.pug']
  ignoreInstance = ignore()
  callback = jest.fn()

  await walk files, ignoreInstance, callback

  expect(callback.mock.calls).toEqual [
    ['index.pug', 'index.pug']
  ]

test 'transverse a folder', ->
  vol.fromJSON
    'fruits/banana.pug': ''
    'fruits/apple.pug': ''

  files = ['fruits']
  ignoreInstance = ignore()
  callback = jest.fn()

  await walk files, ignoreInstance, callback

  expect(callback.mock.calls.sort()).toEqual [
    ['fruits', 'fruits/banana.pug']
    ['fruits', 'fruits/apple.pug']
  ].sort()

test 'transverse the working directory', ->
  vol.fromJSON
    'banana.pug': ''
    'apple.pug': ''

  files = ['.']
  ignoreInstance = ignore()
  callback = jest.fn()

  await walk files, ignoreInstance, callback

  expect(callback.mock.calls.sort()).toEqual [
    ['.', 'banana.pug']
    ['.', 'apple.pug']
  ].sort()

test 'ignore a folder', ->
  vol.fromJSON
    'fruits/banana.pug': ''
    'fruits/apple.pug': ''
    'vegetables/onion.pug': ''
    'vegetables/lettuce.pug': ''

  files = ['fruits']
  ignoreInstance = ignore().add('vegetables/')
  callback = jest.fn()

  await walk files, ignoreInstance, callback

  expect(callback.mock.calls.sort()).toEqual [
    ['fruits', 'fruits/banana.pug']
    ['fruits', 'fruits/apple.pug']
  ].sort()
