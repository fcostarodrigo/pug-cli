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
  cwd = false
  extensions = ['.pug']
  ignoreInstance = ignore()
  callback = jest.fn()

  await walk files, cwd, ignoreInstance, extensions, callback

  expect(callback.mock.calls).toEqual [
    ['index.pug', 'index.pug']
  ]

test 'transverse a folder', ->
  vol.fromJSON
    'fruits/banana.pug': ''
    'fruits/apple.pug': ''

  files = ['fruits']
  cwd = false
  extensions = ['.pug']
  ignoreInstance = ignore()
  callback = jest.fn()

  await walk files, cwd, ignoreInstance, extensions, callback

  expect(callback.mock.calls.sort()).toEqual [
    ['fruits', 'fruits/banana.pug']
    ['fruits', 'fruits/apple.pug']
  ].sort()

test 'transverse the working directory', ->
  vol.fromJSON
    'banana.pug': ''
    'apple.pug': ''

  files = []
  cwd = true
  extensions = ['.pug']
  ignoreInstance = ignore()
  callback = jest.fn()

  await walk files, cwd, ignoreInstance, extensions, callback

  expect(callback.mock.calls.sort()).toEqual [
    ['.', 'banana.pug']
    ['.', 'apple.pug']
  ].sort()

test 'ignore a file', ->
  vol.fromJSON
    'fruits/banana.pug': ''
    'fruits/apple.pug': ''

  files = ['fruits']
  cwd = false
  extensions = ['.pug']
  ignoreInstance = ignore().add('banana.pug')
  callback = jest.fn()

  await walk files, cwd, ignoreInstance, extensions, callback

  expect(callback.mock.calls).toEqual [
    ['fruits', 'fruits/apple.pug']
  ]

test 'ignore a folder', ->
  vol.fromJSON
    'fruits/banana.pug': ''
    'fruits/apple.pug': ''
    'vegetables/onion.pug': ''
    'vegetables/lettuce.pug': ''

  files = ['fruits']
  cwd = false
  extensions = ['.pug']
  ignoreInstance = ignore().add('vegetables/')
  callback = jest.fn()

  await walk files, cwd, ignoreInstance, extensions, callback

  expect(callback.mock.calls.sort()).toEqual [
    ['fruits', 'fruits/banana.pug']
    ['fruits', 'fruits/apple.pug']
  ].sort()

test 'ignore extensions', ->
  vol.fromJSON
    'fruits/banana.pug': ''
    'fruits/apple.html': ''

  files = ['fruits']
  cwd = false
  extensions = ['.pug']
  ignoreInstance = ignore()
  callback = jest.fn()

  await walk files, cwd, ignoreInstance, extensions, callback

  expect(callback.mock.calls).toEqual [
    ['fruits', 'fruits/banana.pug']
  ]
