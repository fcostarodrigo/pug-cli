{ vol } = require 'memfs'
compile = require './compile'

afterEach ->
  vol.reset()

test.only 'compile a file', ->
  vol.fromJSON
    '/index.pug': 'div hello'

  await compile '/index.pug', {}, '/index.html'

  expect(vol.toJSON()).toEqual
    "/index.pug": 'div hello'
    "/index.html": '<div>hello</div>'

test 'compile to target folder', ->
  vol.fromJSON
    '/index.pug': 'div hello'

  await compile '/index.pug', {}, '/dist/index.html'

  expect(vol.toJSON()).toEqual
    '/index.pug': 'div hello'
    '/dist/index.html': '<div>hello</div>'

test 'pass parameters to pug compiler', ->
  vol.fromJSON
    '/index.pug': 'div= message'

  await compile '/index.pug', { message: 'hello' }, '/index.html'

  expect(vol.toJSON()).toEqual
    '/index.pug': 'div= message'
    '/index.html': '<div>hello</div>'
