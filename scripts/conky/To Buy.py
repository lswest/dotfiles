#!/usr/bin/env python
## A script to print out my "to buy" list
import os

home=os.path.expanduser("~")

for root, dirs, files in os.walk(os.path.join(home,"To Buy")):
    for infile in [f for f in files]:
        if(infile.endswith("~")!=True):
            fh=open(os.path.abspath(os.path.join(root,infile)))
            for line in fh:
                print "- "+line,
            fh.close()

