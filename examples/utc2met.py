#!/usr/bin/env python

import datetime
import glob
import os.path
import spice

def utc2met(utc):
    t = spice.timestamp().from_utc(scid = -362, utc = utc)
    return t.to_met()

if __name__ == '__main__':
    dir = os.path.dirname(__file__)
    kernels = glob.glob(os.path.join(dir, '*.tsc')) \
      + glob.glob(os.path.join(dir, '*.tls'))
    for kernel in kernels:
        spice.api.furnsh(kernel)

    timestamps = [
      datetime.datetime.utcnow().isoformat(),
      '2013-02-17T12:10:37',
    ]
    for timestamp in timestamps:
        print 'UTC: ' + str(timestamp)
        print 'MET: ' + str(utc2met(timestamp))
