from __future__ import print_function

# To be run from PYTHONSTARTUP
from sys import stdout as ___stdout
def history(file=___stdout):
    import readline
    for i in range(readline.get_current_history_length()):
        print(str(readline.get_history_item(i)), file=file)

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
import argparse
import math
import numpy
np = numpy
try: import yaml
except: pass

def pmg():
    global Poscar
    global Structure
    global Lattice
    global pymatgen
    import pymatgen
    from pymatgen import Structure, Lattice
    from pymatgen.io.vasp import Poscar
