set history filename ~/.gdb_history
set history save on
set history size 10000000
set history expansion on
show history

# stop prompting on Ctrl-D
define hook-quit
    set confirm off
end
