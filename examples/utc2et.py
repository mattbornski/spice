#!/usr/bin/env python

import datetime
import glob
import os.path
import spice

def utc2et(utc):
    dir = os.path.dirname(__file__)
    kernels = glob.glob(os.path.join(dir, '*.tsc')) \
      + glob.glob(os.path.join(dir, '*.tls'))
    for kernel in kernels:
        spice.internal.furnsh(kernel)

    t = spice.timestamp().from_utc(scid = -362, utc = utc)
    return t.to_et()

if __name__ == '__main__':
    timestamps = [
      datetime.datetime.utcnow().isoformat(),
      '2013-02-17T12:10:37',
    ]
    for timestamp in timestamps:
        print 'UTC: ' + str(timestamp)
        print 'ET:  ' + str(utc2et(timestamp))
