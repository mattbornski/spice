#!/usr/bin/env python

import glob
import os.path
import spice

def met2utc(met):
    t = spice.timestamp().from_met(scid = -362, met = met)
    return t.to_utc()

if __name__ == '__main__':
    dir = os.path.dirname(__file__)
    kernels = glob.glob(os.path.join(dir, '*.tsc')) \
      + glob.glob(os.path.join(dir, '*.tls'))
    for kernel in kernels:
        spice.internal.furnsh(kernel)

    timestamps = [
      '1/0',
      '1/108151',
      '1/98136552',
    ]
    for timestamp in timestamps:
        print 'MET: ' + timestamp
        print 'UTC: ' + met2utc(timestamp)
