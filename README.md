node_util
======

Utilities that help you write Node programs and in particular, CLI scripts easily.

Goals
=====

Usage
=====

In JS,

```javascript
node_util = require('node_util').sync()
read = node_util.read
mv   = node_util.mv
```

In Coffee, destructuring makes usage even more pleasant
```coffee
{mv, read, rm_r, get}  = require('node_util').sync()
```

See [[examples/example.coffee]] for more.

TODO
====

* Add async() that returns the async version of everything
* Helper for mkdir -p
* Helper for running something in the current TTY
* Interactive examples?
