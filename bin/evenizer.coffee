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

evenizer = require '../lib/evenizer'

evenizer.doEvenize()