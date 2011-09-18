{read, rm, write, exists, ls, get} = require('../lib/node_util').sync()
{equal, ok} = require 'assert'

eq = equal

write 'TEST', 'Hola world!'
eq read('TEST'), 'Hola world!'
eq ('TEST' in ls('.')), true
rm 'TEST' 
eq ('TEST' in ls('.')), false
eq exists('TEST'), false

get 'http://google.com', (err, res, body) ->
    ok body.substr('google') isnt -1

# post url, {json : }, 

    