{spawn}     = require 'child_process'
fs          = require 'fs'
path        = require 'path'
request     = require 'request'

# Aliases
# -------

log         = console.log

# Child process utilities
# -----------------------

# Runs as a sub-process (important to note that it does not run this in a shell)
run = (cmd) ->
    log "#{cmd}"
    [cmd, args...] = cmd.split ' '
    proc = spawn cmd, args
    proc.stdin.end()
    proc.stdout.on 'data', (data) -> log data.toString()
    proc.stderr.on 'data', (data) -> log data.toString()
    

# HTTP utilities
# --------------

# NOTE: This seems redundant
# The only place where this might be meaningful is when 
# TODO: Import all the other methods from request too
post = request.post
get  = request.get
put  = request.put
 
# File system utilities
# ---------------------
  
# Removes the dir located at `path` and all it's sub-dirs. If the path does not exist, then this does not do anything
# and returns successfully. Based off [[ryanmcgrath/wrench-js]]
rmdirRecursiveSync = (dirPath) ->
    # If the directory doesn't exist, then return success
    if not path.existsSync dirPath
        return true
    
    # Empty this directory    
    for file in fs.readdirSync(dirPath)
        currFilePath = dirPath + "/" + file
        currFile = fs.statSync currFilePath

        if currFile.isDirectory()
            rmdirRecursiveSync currFilePath
        else if currFile.isSymbolicLink()
            fs.unlinkSync currFilePath
        else
            fs.unlinkSync currFilePath
            
    # Remove the directory and return the return value of that system call
    return fs.rmdirSync dirPath
    
# Exports
# -------

###
The way you would use this module is as follows:

In JS,
node_util = require('node_util').sync()
read = node_util.read
mv   = node_util.mv

In Coffee, destructuring makes usage even more pleasant
{mv, read, rm_r}  = require('node_util').sync()

###

exports.sync = () ->
    mv                 : fs.renameSync
    read               : fs.readFileSync
    cat                : fs.readFileSync
    write              : fs.writeFileSync
    mkdir              : fs.mkdirSync
    rm                 : fs.unlinkSync         # Will fail if the directory is not empty
    remove             : fs.unlinkSync
    rm_r               : rmdirRecursiveSync
    rmdirRecursiveSync : rmdirRecursiveSync
    join               : path.join
    exec               : run
    ls                 : fs.readdirSync
    exists             : path.existsSync
    post               : post
    get                : get