loadArgs = require './loadArgs'

argv = null
env = null

beforeEach ->
  jest.resetModules()
  argv = process.argv 
  env = process.env

afterEach ->
  process.argv = argv
  process.env = env

test 'parse command line options', ->
  process.argv = [
    'coffee'
    'script'
    'index.pug'
    '--out'
    'dist'
    '--options.debug'
  ]

  args = await loadArgs()

  expect(args).toEqual expect.objectContaining
    files: ['index.pug']
    out: 'dist'
    options:
      debug: true

test 'parse environment variables', ->
  process.env =
    PUG_OUT: 'dist'
    PUG_OPTIONS__DEBUG: 'true'
  
  args = await loadArgs()

  expect(args).toEqual expect.objectContaining
    out: 'dist'
    options:
      debug: true
