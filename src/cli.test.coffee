{ vol } = require 'memfs'
{ spawnSync } = require 'child_process'
{ join } = require 'path'
cli = require './cli'

argv = null
env = null
cwd = process.cwd()

beforeAll ->
  argv = process.argv 
  env = process.env

afterEach ->
  vol.reset()
  jest.resetModules()
  process.argv = argv
  process.env = env

test 'compile a pug file', ->
  vol.fromJSON
    'index.pug': 'div hello'

  await cli()

  expect(vol.toJSON()).toEqual
    "#{cwd}/index.pug": 'div hello'
    "#{cwd}/index.html": '<div>hello</div>'

test 'compile a specific pug file', ->
  vol.fromJSON
    'index1.pug': 'div hello'
    'index2.pug': 'div hello'

  process.argv = [ 'coffee', 'script', 'index1.pug' ]
  await cli()

  expect(vol.toJSON()).toEqual
    "#{cwd}/index1.pug": 'div hello'
    "#{cwd}/index2.pug": 'div hello'
    "#{cwd}/index1.html": '<div>hello</div>'

test 'compile to a target folder', ->
  vol.fromJSON
    'index.pug': 'div hello'

  process.argv = [ 'coffee', 'script', '--out', 'dist' ]
  await cli()

  expect(vol.toJSON()).toEqual
    "#{cwd}/index.pug": 'div hello'
    "#{cwd}/dist/index.html": '<div>hello</div>'
