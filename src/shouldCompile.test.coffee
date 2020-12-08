ignore = require 'ignore'
shouldCompile = require './shouldCompile'

test 'Compile valid files', ->
  file = 'index.pug'
  ignorer = ignore()
  extensions = ['.pug']

  expect(shouldCompile(file, ignorer, extensions)).toBe true

test 'Skip by extension list', ->
  file = 'index.html'
  ignorer = ignore()
  extensions = ['.pug']

  expect(shouldCompile(file, ignorer, extensions)).toBe false

test 'Skip folders', ->
  file = 'downloads/'
  ignorer = ignore()
  extensions = ['.pug']

  expect(shouldCompile(file, ignorer, extensions)).toBe false

test 'Skip working directory', ->
  file = '.'
  ignorer = ignore()
  extensions = ['.pug']

  expect(shouldCompile(file, ignorer, extensions)).toBe false

test 'Skip by ignore', ->
  file = 'index.pug'
  ignorer = ignore().add('index.pug')
  extensions = ['.pug']

  expect(shouldCompile(file, ignorer, extensions)).toBe false
