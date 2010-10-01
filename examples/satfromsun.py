#!/usr/bin/env python

import datetime
import glob
import os.path
import spice

def satfromsun(utc):
    rbsp_a = spice.body('RBSP_A')
    sun = spice.body('SUN')
    # From sun to rbsp_a
    return (sun - rbsp_a)(rbsp_a.timestamp(utc = utc))

if __name__ == '__main__':
    dir = os.path.dirname(__file__)
    kernels = glob.glob(os.path.join(dir, '*.tsc')) \
      + glob.glob(os.path.join(dir, '*.tls')) \
      + glob.glob(os.path.join(dir, '*.bsp'))
    for kernel in kernels:
        spice.api.furnsh(kernel)

    timestamps = [
      # N.B. Throwing an error in the lower-level C interface can cause
      # the loss of all loaded kernels.
#      datetime.datetime.utcnow().isoformat(),
      '2013-02-17T12:10:37',
    ]
    for timestamp in timestamps:
        print 'UTC:                 ' + str(timestamp)
        print 'Vector to satellite: ' + str(satfromsun(timestamp))

