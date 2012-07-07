(function() {
  var fs, get, log, path, post, put, request, rmdirRecursiveSync, run, spawn;
  var __slice = Array.prototype.slice;
  spawn = require('child_process').spawn;
  fs = require('fs');
  path = require('path');
  request = require('request');
  log = console.log;
  run = function(cmd) {
    var args, proc, _ref;
    log("" + cmd);
    _ref = cmd.split(' '), cmd = _ref[0], args = 2 <= _ref.length ? __slice.call(_ref, 1) : [];
    proc = spawn(cmd, args);
    proc.stdin.end();
    proc.stdout.on('data', function(data) {
      return log(data.toString());
    });
    return proc.stderr.on('data', function(data) {
      return log(data.toString());
    });
  };
  post = request.post;
  get = request.get;
  put = request.put;
  rmdirRecursiveSync = function(dirPath) {
    var currFile, currFilePath, file, _i, _len, _ref;
    if (!fs.existsSync(dirPath)) {
      return true;
    }
    _ref = fs.readdirSync(dirPath);
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      file = _ref[_i];
      currFilePath = dirPath + "/" + file;
      currFile = fs.statSync(currFilePath);
      if (currFile.isDirectory()) {
        rmdirRecursiveSync(currFilePath);
      } else if (currFile.isSymbolicLink()) {
        fs.unlinkSync(currFilePath);
      } else {
        fs.unlinkSync(currFilePath);
      }
    }
    return fs.rmdirSync(dirPath);
  };
  /*
  The way you would use this module is as follows:

  In JS,
  node_util = require('node_util').sync()
  read = node_util.read
  mv   = node_util.mv

  In Coffee, destructuring makes usage even more pleasant
  {mv, read, rm_r}  = require('node_util').sync()

  */
  exports.sync = function() {
    return {
      mv: fs.renameSync,
      read: fs.readFileSync,
      cat: fs.readFileSync,
      write: fs.writeFileSync,
      mkdir: fs.mkdirSync,
      rm: fs.unlinkSync,
      remove: fs.unlinkSync,
      rm_r: rmdirRecursiveSync,
      rmdirRecursiveSync: rmdirRecursiveSync,
      join: path.join,
      exec: run,
      ls: fs.readdirSync,
      exists: fs.existsSync,
      post: post,
      get: get
    };
  };
}).call(this);
