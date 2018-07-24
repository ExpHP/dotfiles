from __future__ import print_function

# To be run from PYTHONSTARTUP

from sys import stdout as ___stdout
def history(pattern=None, n=15, file=___stdout):
    import readline
    if pattern is None:
        match = lambda s: True
    elif isinstance(pattern, str):
        match = lambda s: pattern in s
    else: raise TypeError

    out = []
    for i in reversed(range(readline.get_current_history_length())):
        line = str(readline.get_history_item(i))
        if not match(line):
            continue

        out.append(line)
        if n is not None and len(out) >= n:
            break
    out = out[::-1]

    if file is None:
        return out
    else:
        for line in out:
            print(line, file=file)

def mpl():
    global plt
    global mpl
    import matplotlib.pyplot as plt
    import matplotlib as mpl

# Jesus H. Christ why haven't I done this sooner
#   - Me, November 2017
#
# (even if these aren't all that useful to use on the command line,
#  I might still want them around just to check docstrings)
import os
import sys
import json
import time
import shutil
import subprocess
import math

try: import argparse
except: pass
try: import numpy; np = numpy
except: pass
try:
    from ruamel.yaml import YAML as yaml
    yaml = yaml()
except:
    try: import yaml
    except: pass

def pmg():
    global Poscar
    global Structure
    global Lattice
    global pymatgen
    global SpacegroupAnalyzer
    import pymatgen
    from pymatgen import Structure, Lattice
    from pymatgen.io.vasp import Poscar
    from pymatgen.symmetry.analyzer import SpacegroupAnalyzer
