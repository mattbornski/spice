# Stock python modules.
import datetime
import glob

# spice extension modules.
from . import internal

#class _relation:
#    def __init__(self, 

class _ephem:
    def __init__(self, observer, target):
        self._observer = observer
        self._target = target
    def __call__(self, timestamp):
        target = str(self._target._scid)
        observer = str(self._observer._scid)
        (state, ltime) = internal.spkezr(
          target,
          timestamp.to_et(),
          'ECLIPJ2000',
          'NONE',
          observer)
        return state[:3]

class body:
    # Bodies have positional relationships to each other.
    # The positional relationships can be reduced to position vectors and
    # velocity vectors at a given timestamp.
    def __init__(self, scid):
        # The SCID is how we identify the body.  It is used to look up
        # information about the body stored in the SPICE kernels.
        # TODO Kernels are actually pretty important and should be loaded
        # with more care.
        kernels = glob.glob('*.bsp *.tpc *.tf *.bc *.tsc *.tls')
        for kernel in kernels:
            internal.furnsh(kernel)
        self._scid = scid
    # Constructors
    def timestamp(self, *args, **kwargs):
        kwargs['scid'] = self._scid
        return timestamp(*args, **kwargs)
    # Math
    # Okay, here's the trick.  Bodies have relationships to each other.
    # SPICE knows about how they are related thanks to the relevant
    # kernels we've loaded.  Relationships can only be reduced to numeric
    # form at a given timestamp.
    def __sub__(self, other):
        return _ephem(self, other)

class timestamp:
    _isoformat = internal.tpictr(datetime.datetime.utcnow().isoformat(), 64)
    def __init__(self, *args, **kwargs):
        self._et = None
        self._scid = None
        if 'scid' in kwargs:
            self._scid = kwargs['scid']
        systems = {
          'et':self.from_et,
          'sclk':self.from_sclk,
          'met':self.from_met,
          'iso':self.from_iso,
          'utc':self.from_utc,
        }
        for timesystem in kwargs.keys():
            if timesystem in systems.keys():
                systems[timesystem](*args, **kwargs)
    # Constructors
    def from_et(self, *args, **kwargs):
        if 'scid' in kwargs:
            self._scid = kwargs['scid']
        if 'et' in kwargs:
            self._et = kwargs['et']
        else:
            self._et = args[0]
        return self
    def from_sclk(self, scid, sclk):
        self._scid = scid
        self._et = internal.scs2e(self._scid, sclk)
        return self
    def from_met(self, scid, met):
        # MET is synonymous with SCLK
        return self.from_sclk(scid, met)
    def from_iso(self, scid, iso):
        self._scid = scid
        self._et = internal.str2et(iso)
        return self
    def from_utc(self, scid, utc):
        return self.from_iso(scid, utc)
    # Reformatters
    def to_et(self):
        return self._et
    def to_sclk(self):
        return internal.sce2s(self._scid, self._et, 32)
    def to_met(self):
        # MET is synonymous with SCLK
        return self.to_sclk()
    def to_iso(self):
        return internal.timout(self._et, timestamp._isoformat, 32)
    def to_utc(self):
        return self.to_iso()
