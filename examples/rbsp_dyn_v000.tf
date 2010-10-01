KPL/FK

RBSP Dynamic Frame Definitions Kernel
===========================================================================

   This frame kernel contains the dynamic frame definitions accepted by the
   RBSP project for use in SPICE based applications.


Version and Date
---------------------------------------------------------------

   The TEXT_KERNEL_ID stores version information of loaded project text
   kernels.  Each entry associated with the keyword is a string that
   consists of four parts: the kernel name, version, entry date, and type.
   For example, the frame kernel might have an entry as follows:

      TEXT_KERNEL_ID += 'RBSP_DYN_FRAMES V0.0.0 ??-JUL-2010 FK'

   RBSP Frame Kernel Version:

      \begindata

      TEXT_KERNEL_ID += 'RBSP_DYN_FRAMES V0.0.0 ??-JUL-2010 FK'

      \begintext


   Version 0.0 -- July ??, 2010 -- Grant Stephens

      Initial prototype release to support C-kernel creation and
      utilization. Nominal alignments are used.

   
References
---------------------------------------------------------------

      1.   "C-kernel Required Reading"

      2.   "Kernel Pool Required Reading"

      3.   "Frames Required Reading"

      4.   "RBSP G&C Coordinate Systems, Component Alignments
           and Naming Conventions", R. M. Vaughan


Implementation Notes
---------------------------------------------------------------

   This file is used by the SPICE system as follows: programs that make use
   of this frame kernel must "load" the kernel normally during program
   initialization.  Loading the kernel associates the data items with
   their names in a data structure called the "kernel pool".  The SPICELIB
   routine FURNSH loads a kernel into the pool as shown below:

      FORTRAN: (SPICELIB)

         CALL FURNSH ( frame_kernel_name )

      C: (CSPICE)

         furnsh_c ( frame_kernel_name );

      IDL: (ICY)

         cspice_furnsh, frame_kernel_name

   In order for a program or routine to extract data from the pool, the
   SPICELIB routines GDPOOL, GIPOOL, and GCPOOL are used.  See [2] for
   more details.

   This file was created and may be updated with a text editor or word
   processor.


RBSP Frames
---------------------------------------------------------------

   The following RBSP frames are defined in this kernel file:

      Frame Name                Relative To              Type      NAIF ID
      =======================   ===================      =======   =======
      RBSP_IGRF_MAG             J2000                    DYNAMIC   -362900
      RBSP_GSE                  J2000                    DYNAMIC   -362910

RBSP IGRF Time Varying Magnetic Frame
---------------------------------------------------------------

   The following frame definition comes from an Excel spreadsheet put together
   by Paul O'Brien.  It extrapolates off the IGRF 2010 data to produce a time
   varying IGRF through 2020.

   Note: the Euler rotation from cartesian GEO to cartesian MAG is given by a 
   rotation of PHIn degrees about the z axis followed by a rotation of THETAn
   degrees about the y axis. The first rotation moves the x axis onto the 
   magnetic prime meridian. The second rotatio moves the z axis to the magnetic
   pole. Formulae for THETAn and PHIn are from:
  
      http://www.spenvis.oma.be/spenvis/help/background/magfield/cd.html

   \begindata
      FRAME_RBSP_IGRF_MAG          = -362900                 
      FRAME_-362900_NAME           = 'RBSP_IGRF_MAG'
      FRAME_-362900_CLASS          = 5
      FRAME_-362900_CLASS_ID       = -362900
      FRAME_-362900_CENTER         = 399
      FRAME_-362900_RELATIVE       = 'J2000'
      FRAME_-362900_DEF_STYLE      = 'PARAMETERIZED'
      FRAME_-362900_FAMILY         = 'EULER'
      FRAME_-362900_EPOCH          = @2005-JAN-1/12:00:00
      FRAME_-362900_AXES           = ( 3  2  1 )
      FRAME_-362900_UNITS          = 'DEGREES'
      FRAME_-362900_ANGLE_1_COEFFS  = ( 9.98554348126434 -1.83033935781059E-09 )
      FRAME_-362900_ANGLE_2_COEFFS  = ( -72.2109096699851 -2.65163767213509E-09 )
      FRAME_-362900_ANGLE_3_COEFFS  = ( 0 )
   \begintext


RBSP Geocentric Solar Ecliptic Frame
---------------------------------------------------------------

   The definition of the geocentric solar ecliptic system follows.  It assumes that the
   ecliptic plane is frozen at the J2000.0 epoch.

   \begindata
      FRAME_RBSP_GSE                 = -362910
      FRAME_-362910_NAME             = 'RBSP_GSE'
      FRAME_-362910_CLASS            = 5
      FRAME_-362910_CLASS_ID         = -362910
      FRAME_-362910_CENTER           = 399
      FRAME_-362910_RELATIVE         = 'J2000'
      FRAME_-362910_DEF_STYLE        = 'PARAMETERIZED'
      FRAME_-362910_FAMILY           = 'TWO-VECTOR'
      FRAME_-362910_PRI_AXIS         = 'X'
      FRAME_-362910_PRI_VECTOR_DEF   = 'OBSERVER_TARGET_POSITION'
      FRAME_-362910_PRI_OBSERVER     = 'EARTH'
      FRAME_-362910_PRI_TARGET       = 'SUN'
      FRAME_-362910_PRI_ABCORR       = 'NONE'
      FRAME_-362910_SEC_AXIS         = 'Z'
      FRAME_-362910_SEC_VECTOR_DEF   = 'CONSTANT'
      FRAME_-362910_SEC_FRAME        = 'ECLIPJ2000'
      FRAME_-362910_SEC_SPEC         = 'RECTANGULAR'
      FRAME_-362910_SEC_VECTOR       = ( 0.0, 0.0, 1.0 )
   \begintext


