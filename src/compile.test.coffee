ignore = require 'ignore'
{ vol } = require 'memfs'
compile = require './compile'

cwd = process.cwd()

afterEach ->
  vol.reset()

test 'compile a file', ->
  vol.fromJSON
    'index.pug': 'div hello'

  ignorer = ignore()
  root = '.'
  source = 'index.pug'
  args = extensions: ['.pug']

  await compile args, ignorer, root, source

  expect(vol.toJSON()).toEqual
    "#{cwd}/index.pug": 'div hello'
    "#{cwd}/index.html": '<div>hello</div>'

test 'compile to target folder', ->
  vol.fromJSON
    'index.pug': 'div hello'

  ignorer = ignore()
  root = '.'
  source = 'index.pug'
  args =
    extensions: ['.pug']
    out: 'dist'

  await compile args, ignorer, root, source

  expect(vol.toJSON()).toEqual
    "#{cwd}/index.pug": 'div hello'
    "#{cwd}/dist/index.html": '<div>hello</div>'

test 'pass parameters to pug compiler', ->
  vol.fromJSON
    'index.pug': 'div= message'

  ignorer = ignore()
  root = '.'
  source = 'index.pug'
  args =
    extensions: ['.pug']
    options:
      message: 'hello'

  await compile args, ignorer, root, source

  expect(vol.toJSON()).toEqual
    "#{cwd}/index.pug": 'div= message'
    "#{cwd}/index.html": '<div>hello</div>'
