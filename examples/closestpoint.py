#!/usr/bin/env python

import datetime
import glob
import os.path
import spice

def closestpoint(utc):
    rbsp_a = spice.body('RBSP_A')
    earth = spice.body('IAU_EARTH')
    # From rbsp_a to earth
    return (rbsp_a - earth)(rbsp_a.timestamp(utc = utc))

if __name__ == '__main__':
    dir = os.path.dirname(__file__)
    kernels = glob.glob(os.path.join(dir, '*.tsc')) \
      + glob.glob(os.path.join(dir, '*.tls')) \
      + glob.glob(os.path.join(dir, '*.bsp')) \
      + glob.glob(os.path.join(dir, '*.bc')) \
      + glob.glob(os.path.join(dir, '*.tf')) \
      + glob.glob(os.path.join(dir, '*.tpc'))
    for kernel in kernels:
        spice.api.furnsh(kernel)

    timestamps = [
      # N.B. Throwing an error in the lower-level C interface can cause
      # the loss of all loaded kernels.
#      datetime.datetime.utcnow().isoformat(),
      '2013-02-17T12:10:37',
    ]
    for timestamp in timestamps:
        print 'UTC:                    ' + str(timestamp)
        print 'Nearest point on Earth: ' + str(closestpoint(timestamp))

