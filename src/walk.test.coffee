{ promises: { writeFile, mkdir, rmdir } } = require 'fs'
{ join } = require 'path'
ignore = require 'ignore'
walk = require './walk'

testFolder = 'walkTest'

beforeEach ->
  await mkdir testFolder
  process.chdir testFolder

afterEach ->
  process.chdir '..'
  await rmdir testFolder, { recursive: true }

test 'transverse a single file', ->
  await writeFile 'index.pug', 'div hello'

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
  await mkdir 'fruits'
  await writeFile join('fruits', 'banana.pug'), 'div hello'
  await writeFile join('fruits', 'apple.pug'), 'div hello'

  files = ['fruits']
  cwd = false
  extensions = ['.pug']
  ignoreInstance = ignore()
  callback = jest.fn()

  await walk files, cwd, ignoreInstance, extensions, callback

  expect(callback.mock.calls.sort()).toEqual [
    ['fruits', join('fruits', 'banana.pug')]
    ['fruits', join('fruits', 'apple.pug')]
  ].sort()

test 'transverse the working directory', ->
  await writeFile 'banana.pug', 'div hello'
  await writeFile 'apple.pug', 'div hello'

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
  await mkdir 'fruits'
  await writeFile join('fruits', 'banana.pug'), 'div hello'
  await writeFile join('fruits', 'apple.pug'), 'div hello'

  files = ['fruits']
  cwd = false
  extensions = ['.pug']
  ignoreInstance = ignore().add('banana.pug')
  callback = jest.fn()

  await walk files, cwd, ignoreInstance, extensions, callback

  expect(callback.mock.calls).toEqual [
    ['fruits', join('fruits', 'apple.pug')]
  ]

test 'ignore a folder', ->
  await mkdir 'fruits'
  await writeFile join('fruits', 'banana.pug'), 'div hello'
  await writeFile join('fruits', 'apple.pug'), 'div hello'

  await mkdir 'vegetables'
  await writeFile join('vegetables', 'onion.pug'), 'div hello'
  await writeFile join('vegetables', 'lettuce.pug'), 'div hello'

  files = ['fruits']
  cwd = false
  extensions = ['.pug']
  ignoreInstance = ignore().add('vegetables/')
  callback = jest.fn()

  await walk files, cwd, ignoreInstance, extensions, callback

  expect(callback.mock.calls.sort()).toEqual [
    ['fruits', join('fruits', 'banana.pug')]
    ['fruits', join('fruits', 'apple.pug')]
  ].sort()

test 'ignore extensions', ->
  await mkdir 'fruits'
  await writeFile join('fruits', 'banana.pug'), 'div hello'
  await writeFile join('fruits', 'apple.html'), 'div hello'

  files = ['fruits']
  cwd = false
  extensions = ['.pug']
  ignoreInstance = ignore().add('vegetables/')
  callback = jest.fn()

  await walk files, cwd, ignoreInstance, extensions, callback

  expect(callback.mock.calls).toEqual [
    ['fruits', join('fruits', 'banana.pug')]
  ]
