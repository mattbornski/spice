#!/usr/bin/env python

import datetime
import glob
import os.path
import spice

def et2utc(et):
    t = spice.timestamp().from_et(scid = -362, et = et)
    return t.to_utc()

if __name__ == '__main__':
    dir = os.path.dirname(__file__)
    kernels = glob.glob(os.path.join(dir, '*.tsc')) \
      + glob.glob(os.path.join(dir, '*.tls'))
    for kernel in kernels:
        spice.internal.furnsh(kernel)

    timestamps = [
      340452060.128,
      414375103.185,
    ]
    for timestamp in timestamps:
        print 'ET: ' + str(timestamp)
        print 'UTC: ' + str(et2utc(timestamp))
