from __future__ import print_function

# To be run from PYTHONSTARTUP
from sys import stdout as ___stdout
def history(file=___stdout):
    import readline
    for i in range(readline.get_current_history_length()):
        print(str(readline.get_history_item(i)), file=file)
