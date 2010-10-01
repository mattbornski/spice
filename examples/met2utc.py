#!/usr/bin/env python

import datetime
import glob
import os.path
import spice

isoformat = spice.tpictr(datetime.datetime.utcnow().isoformat(), 64)

def met2utc(spacecraft_clock_string):
    dir = os.path.dirname(__file__)
    kernels = glob.glob(os.path.join(dir, '*.tsc')) \
      + glob.glob(os.path.join(dir, '*.tls'))
    for kernel in kernels:
        spice.furnsh(kernel)
    epehmeris_time_double = spice.scs2e(-362, spacecraft_clock_string)
    utc_time_string = spice.timout(epehmeris_time_double, isoformat, 32)
    return utc_time_string

if __name__ == '__main__':
    demo = ['1/0', '1/108151', '1/98136552']
    for timestamp in demo:
        print 'MET: ' + timestamp
        print 'UTC: ' + met2utc(timestamp)
