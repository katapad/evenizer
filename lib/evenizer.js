
/*
  set even pixel

  @use
  https://github.com/rsms/node-imagemagick

  @see
  画像処理についてあれこれ: ImageMagickで、画像の上下左右に余白を追加する
  http://goo.gl/kVfP9Q
 */
var argv, doEvenize, evenize, exports, fileList, im;

process.bin = process.title = 'evenizer';

argv = require('optimist').boolean('resize').argv;

if (!argv.i) {
  console.log('file not found');
  return;
}

if (argv.i) {
  fileList = [argv.i];
}

if (argv._) {
  fileList = fileList.concat(argv._);
}

if ((fileList != null ? fileList.length : void 0) === 0) {
  console.log('file not found');
  return;
}

im = require('imagemagick');

evenize = (function(_this) {
  return function(fileName) {
    return im.identify(fileName, function(err, features) {
      var direction, direction1, direction2, east, south;
      if (err) {
        throw err;
      }
      direction1 = '';
      direction2 = '';
      south = 0;
      east = 0;
      if (features.height % 2 === 1) {
        direction1 = 'south';
        south = 1;
      }
      if (features.width % 2 === 1) {
        direction2 = 'east';
        east = 1;
      }
      direction = "" + direction1 + direction2;
      if (south || east) {
        if (argv.resize) {
          return im.convert([fileName, '-resize', "" + (features.width + east) + "x" + (features.height + south) + "\!", fileName], function(err, stdout) {
            if (err) {
              throw err;
            }
            return console.log("complete:", fileName);
          });
        } else {
          return im.convert([fileName, '-background', 'rgba(0, 0, 0, 0)', '-gravity', direction, '-splice', "" + east + "x" + south, fileName], function(err, stdout) {
            if (err) {
              throw err;
            }
            return console.log("complete:", fileName);
          });
        }
      }
    });
  };
})(this);

doEvenize = (function(_this) {
  return function() {
    var fileName, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = fileList.length; _i < _len; _i++) {
      fileName = fileList[_i];
      _results.push(evenize(fileName));
    }
    return _results;
  };
})(this);

module.exports = exports = {
  evenize: evenize,
  doEvenize: doEvenize
};
