# python startup loader

import sys, os
PYVER = sys.version_info[0]
curdir = os.path.dirname(__file__)
startup = curdir + '/.pythonstartup-%d.py'%PYVER

if PYVER == 2:
	execfile(startup)
elif PYVER == 3:
	exec(open(startup).read())

