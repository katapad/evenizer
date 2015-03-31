#!/usr/bin/env node

###
  set even pixel

  @use
  https://github.com/rsms/node-imagemagick

  @see
  画像処理についてあれこれ: ImageMagickで、画像の上下左右に余白を追加する
  http://goo.gl/kVfP9Q

###


process.bin = process.title = 'evenizer'

argv = require('optimist').boolean('resize').argv
if not argv.i
  console.log 'file not found'
  return

if argv.i
  fileList = [argv.i]
if argv._
  fileList = fileList.concat(argv._)
if fileList?.length == 0
  console.log 'file not found'
  return

im = require('imagemagick')

evenize = (fileName)=>
  im.identify fileName, (err, features) ->
    throw err  if err

    direction1 = ''
    direction2 = ''
    south = 0
    east = 0

    if features.height % 2 == 1
      direction1 = 'south'
      south = 1

    if features.width % 2 == 1
      direction2 = 'east'
      east = 1

    direction = "#{direction1}#{direction2}"
    #-background #e2ddd4 -gravity southeast -splice 1999x25 sample367e.png

    if south or east
      if argv.resize
        im.convert([fileName, '-resize', "#{features.width + east}x#{features.height + south}\!", fileName], (err, stdout) ->
          throw err  if err
          console.log "complete:", fileName
        )
      else
        im.convert([fileName, '-background', 'rgba(0, 0, 0, 0)','-gravity', direction, '-splice',  "#{east}x#{south}", fileName], (err, stdout) ->
          throw err  if err
          console.log "complete:", fileName
        )


doEvenize = =>
  for fileName in fileList
    evenize(fileName)


module.exports = exports = { evenize, doEvenize }
