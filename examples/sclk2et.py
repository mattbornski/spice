#!/usr/bin/env python

import glob
import os.path
import spice

def sclk2et(utc):
    t = spice.timestamp().from_sclk(scid = -362, sclk = utc)
    return t.to_et()

if __name__ == '__main__':
    dir = os.path.dirname(__file__)
    kernels = glob.glob(os.path.join(dir, '*.tsc')) \
      + glob.glob(os.path.join(dir, '*.tls'))
    for kernel in kernels:
        spice.api.furnsh(kernel)

    timestamps = [
      '0',
      '98799037',
    ]
    for timestamp in timestamps:
        print 'SCLK: ' + str(timestamp)
        print 'ET:   ' + str(sclk2et(timestamp))
