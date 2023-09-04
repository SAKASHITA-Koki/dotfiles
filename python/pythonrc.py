# ------------------------------
# Set PYTHONSTARTUP to this file
# ------------------------------

import atexit
import os
import readline
import time


def write_history(path):
    import os
    import readline
    try:
        os.makedirs(os.path.dirname(path), mode=0o700, exist_ok=True)
        readline.write_history_file(path)
    except OSError:
        pass


history = os.path.join(os.environ.get('XDG_DATA_HOME') or
                       os.path.expanduser('~/.cache'),
                       'python_history')
try:
    readline.read_history_file(history)
except FileNotFoundError:
    pass

# Prevents creation of default history if custom is empty
if readline.get_current_history_length() == 0:
    readline.add_history(f'# History created at {time.asctime()}')

atexit.register(write_history, history)
del (atexit, os, readline, time, history, write_history)

