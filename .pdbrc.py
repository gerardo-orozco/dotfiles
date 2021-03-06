# Enable tab completion
import atexit
import os
import pdb
import readline
import rlcompleter
import termios
import sys

pdb.Pdb.complete = rlcompleter.Completer(locals()).complete

# Sometimes when you do something funky, you may lose your terminal echo. This
# should restore it when spanwning new pdb.
# https://gist.github.com/epeli/1125049
termios_fd = sys.stdin.fileno()
termios_echo = termios.tcgetattr(termios_fd)
termios_echo[3] = termios_echo[3] | termios.ECHO
termios_result = termios.tcsetattr(termios_fd, termios.TCSADRAIN, termios_echo)

# Command line history:
histfile = os.path.expanduser("~/.pdb-pyhist")
try:
    readline.read_history_file(histfile)
except IOError:
    pass
atexit.register(readline.write_history_file, histfile)
del histfile
readline.set_history_length(200)


# return to debugger after fatal exception (Python Cookbook 3rd Edition 14.12):
def info(type, value, tb):
    import traceback
    import pdb
    if hasattr(sys, 'ps1') or not sys.stderr.isatty():
        sys.__excepthook__(type, value, tb)
    traceback.print_exception(type, value, tb)
    print
    pdb.pm()
sys.excepthook = info
