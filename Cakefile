{spawn} = require 'child_process'

log = console.log

run = (cmd) ->
    log "#{cmd}"
    [cmd, args...] = cmd.split ' '
    proc = spawn cmd, args
    proc.stdin.end()
    proc.stdout.on 'data', (data) -> log data.toString()
    proc.stderr.on 'data', (data) -> log data.toString()
    
task 'build', ->
    run 'coffee -o lib -c src/node_util.coffee'

task 'test', ->
    run 'npm test'

task 'bt', ->
    run 'coffee -o lib -c src/node_util.coffee'
    run 'npm test'

task 'docs', ->
  run 'docco src/node_util.coffee'