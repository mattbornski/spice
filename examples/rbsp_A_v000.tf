KPL/FK

RBSP_A Spacecraft Frame Definitions Kernel
===========================================================================

   This frame kernel contains the RBSP_A spacecraft, science instrument,
   and communication antennae frame definitions.


Version and Date
---------------------------------------------------------------
   The TEXT_KERNEL_ID stores version information of loaded project text
   kernels.  Each entry associated with the keyword is a string that
   consists of four parts: the kernel name, version, entry date, and type.
   For example, the frame kernel might have an entry as follows:

      TEXT_KERNEL_ID += 'RBSP_A_FRAMES V0.0.0 ??-JUL-2010 FK'

   RBSP Frame Kernel Version:

      \begindata

      TEXT_KERNEL_ID += 'RBSP_A_FRAMES V0.0.0 ??-JUL-2010 FK'

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

      Spacecraft Frames:
      ------------------
      RBSP_A_SPACECRAFT         J2000                     CK       -362000

      Science Frames:
      ---------------
      RBSP_A_SCIENCE            RBSP_A_SPACECRAFT         FIXED    -362100

      Antenna Frames:
      ---------------
      RBSP_A_ANT_POSZ           RBSP_A_SPACECRAFT         FIXED    -362200
      RBSP_A_ANT_NEGZ           RBSP_A_SPACECRAFT         FIXED    -362210

      SSH Frames:
      ---------------
      RBSP_A_SSH_A              RBSP_A_SPACECRAFT         FIXED    -362300
      RBSP_A_SSH_B              RBSP_A_SPACECRAFT         FIXED    -362310

      MAG Frames:
      ---------------
      RBSP_A_MAG_EXT            RBSP_A_SCIENCE            FIXED    -362400
      RBSP_A_MAG_INT            RBSP_A_MAG_EXT            FIXED    -362410



RBSP_A Frames Hierarchy
---------------------------------------------------------------

   This diagram is subject to major revisions as this kernel evolves
   to suit the needs of each instrument.

   The articulating frames referenced in this kernel are not required
   to follow the paths outlined in the hierarchy below, however; the
   presentation indicates the expected, or nominal, production path.

   The diagram below illustrates the MESSENGER frame hierarchy:

       'J2000'
          |
          |<--- ck
          |
         'RBSP_A_SPACECRAFT'
              |
             'RBSP_A_SCIENCE'
              |   |
	      |  'RBSP_A_MAG_EXT'
	      |       |
	      |	     'RBSP_A_MAG_INT'
	      |
             'RBSP_A_ANT_POSZ'
              |
             'RBSP_A_ANT_NEGZ'
              |
             'RBSP_A_SSH_A'
              |
             'RBSP_A_SSH_B'
	    



Spacecraft Frames Definitions
---------------------------------------------------------------

                              +Y 
                               /|\ 
                                |
             +Z                 |EMFISIS boom 1
               _               J
              |\'-.            | 
              | \        |```---...__    
                 \       |     |     |
                  \     J__   J      |
                   \    |  ```|''---J
                    \   |     |     |
                     \  ```---|..__ |
                      /```---J..__
                    /  \     |     \ 
      |'''---...  /     \    |       \
      |    |    ||       .--J-.        \
     J     |    ||      / \ |  \        ||'''---...
     |    J    JJ      |    |__ |       ||    |    |
     |    |    ||       \      /```````JJ''---|.._ |
      ```---...||        `---'`        ||    J    J ```''----->+X
               \\                      ||    |    | 
                 \\                   / \`|`---...|
                   \\               /    \!
                    \ ```---...___/     /
                     |```---...__ \   / 
                     |     |     |_\/
                    J     J      |  
                    |     |     J
                    |     |     |
                    ```--J...___|
                         |
                         |EMFISIS boom 2
			 
           Figure 1 (From 4)


      \begindata

      FRAME_RBSP_A_SPACECRAFT     = -362000
      FRAME_-362000_NAME          = 'RBSP_A_SPACECRAFT'
      FRAME_-362000_CLASS         = 3
      FRAME_-362000_CLASS_ID      = -362000
      FRAME_-362000_CENTER        = -362
      CK_-362000_SCLK             = -362
      CK_-362000_SPK              = -362

      \begintext

Science Frames Definitions
---------------------------------------------------------------


                                        |____          o
                      o           .   ' |\'  .       35            .`
                    55       . '        | \     ' .              .`
                           '            |           '          .`
                        '       ________|_______       '     .`
                      '        |        |       |        ' .`___
   ` .              '          |        |       |        .`\ .
       ` .     |  '            |        |       |      .`   \  '          o
           ` . |.___           |        |       |    .`           '     55 
      o     . '` .             |        |       |  .`               '
    35    .        ` .         |________|_______|.`                   '
         '             ` .       .------|-----..`                      ' 
        '   _______________` .  /       |      \     ______________     '
       '   |               |  /      .-`|-.      \  |              |     '
      \|/  |               | |      / +Z|  \      | |              |     |
  ---------|---------------|-|-----|----O---|-----|-|--------------|--------> +Y
      |    |               | |      \   |  /      | |              |    /|\(Spacecraft)
      '    |               |  \      `-.|-`      /  |              |
      '    '_______________'    \       |      /  ` .______________`     '   o
       '                       .``------|-----`       ` .               .  35
        `          EFW Boom  .` ________|_______          ` .              
      o  `            #1-->.`  |        |       |  EFW Boom-->` .      ' 
    55     '             .`    |        |       |      #3       _`_. /
             '         .`      |        |       |                   /|` .
               '  |  .`        |        |       |                 .  |    ` .|
               ---`.`          |        |       |                          -- 
                 .` '          |________|_______|              '            +Y            
               .`     '                 |                  .             (Science)
            |.`          '              |               .   o
            |--           o ' .         |           . '   55
            +X          35       '  . _\|_ .  -  '
         (Science)                     /|
                                        |
                                       \|/ 
                                       +X
                                   (Spacecraft)

           +Z is out of the page
 

      \begindata

      FRAME_RBSP_A_SCIENCE        = -362100
      FRAME_-362100_NAME          = 'RBSP_A_SCIENCE'
      FRAME_-362100_CLASS         = 4
      FRAME_-362100_CLASS_ID      = -362100
      FRAME_-362100_CENTER        = -362
      TKFRAME_-362100_RELATIVE    = 'RBSP_A_SPACECRAFT'
      TKFRAME_-362100_SPEC        = 'MATRIX'
      TKFRAME_-362100_MATRIX      = ( 0.819152044288991789
      				     -0.573576436351046096
				      0.0
				      0.573576436351046096
				      0.819152044288991789
				      0.0
				      0.0
				      0.0
				      1.0 )
      \begintext


Antenna Frames Definitions
---------------------------------------------------------------
      \begindata

      FRAME_RBSP_A_ANT_POSZ       = -362200
      FRAME_-362200_NAME          = 'RBSP_A_ANT_POSZ'
      FRAME_-362200_CLASS         = 4
      FRAME_-362200_CLASS_ID      = -362200
      FRAME_-362200_CENTER        = -362
      TKFRAME_-362200_RELATIVE    = 'RBSP_A_SPACECRAFT'
      TKFRAME_-362200_SPEC        = 'MATRIX'
      TKFRAME_-362200_MATRIX      = ( 1.0
      				      0.0
				      0.0
				      0.0
				      1.0
				      0.0
				      0.0
				      0.0
				      1.0 )
      \begintext

      \begindata

      FRAME_RBSP_A_ANT_NEGZ           = -362210
      FRAME_-362210_NAME          = 'RBSP_A_ANT_NEGZ'
      FRAME_-362210_CLASS         = 4
      FRAME_-362210_CLASS_ID      = -362210
      FRAME_-362210_CENTER        = -362
      TKFRAME_-362210_RELATIVE    = 'RBSP_A_SPACECRAFT'
      TKFRAME_-362210_SPEC        = 'MATRIX'
      TKFRAME_-362210_MATRIX      = (-1.0
      				      0.0
				      0.0
				      0.0
				      1.0
				      0.0
				      0.0
				      0.0
				     -1.0 )
      \begintext


SSH Frames Frames Definitions
---------------------------------------------------------------
      \begindata

      FRAME_RBSP_A_SSH_A          = -362300
      FRAME_-362300_NAME          = 'RBSP_A_SSH_A'
      FRAME_-362300_CLASS         = 4
      FRAME_-362300_CLASS_ID      = -362300
      FRAME_-362300_CENTER        = -362
      TKFRAME_-362300_RELATIVE    = 'RBSP_A_SPACECRAFT'
      TKFRAME_-362300_SPEC        = 'MATRIX'
      TKFRAME_-362300_MATRIX      = ( 0.707106781186547524
      				     -0.707106781186547524
				      0.0
				      0.707106781186547524
				      0.707106781186547524
				      0.0
				      0.0
				      0.0
				      1.0 )
      \begintext

      \begindata

      FRAME_RBSP_A_SSH_B          = -362310
      FRAME_-362310_NAME          = 'RBSP_A_SSH_B'
      FRAME_-362310_CLASS         = 4
      FRAME_-362310_CLASS_ID      = -362310
      FRAME_-362310_CENTER        = -362
      TKFRAME_-362310_RELATIVE    = 'RBSP_A_SPACECRAFT'
      TKFRAME_-362310_SPEC        = 'MATRIX'
      TKFRAME_-362310_MATRIX      = (-0.707106781186547524
      				      0.707106781186547524
				      0.0
				     -0.707106781186547524
				     -0.707106781186547524
				      0.0
				      0.0
				      0.0
				      1.0 )
      \begintext


MAG Frames Definitions
---------------------------------------------------------------
      \begindata

      FRAME_RBSP_A_MAG_EXT        = -362400
      FRAME_-362400_NAME          = 'RBSP_A_MAG_EXT'
      FRAME_-362400_CLASS         = 4
      FRAME_-362400_CLASS_ID      = -362400
      FRAME_-362400_CENTER        = -362
      TKFRAME_-362400_RELATIVE    = 'RBSP_A_SCIENCE'
      TKFRAME_-362400_SPEC        = 'MATRIX'
      TKFRAME_-362400_MATRIX      = ( 1.0
      				      0.0
				      0.0
				      0.0
				      1.0
				      0.0
				      0.0
				      0.0
				      1.0 )
      \begintext

      \begindata

      FRAME_RBSP_A_MAG_INT        = -362410
      FRAME_-362410_NAME          = 'RBSP_A_MAG_INT'
      FRAME_-362410_CLASS         = 4
      FRAME_-362410_CLASS_ID      = -362410
      FRAME_-362410_CENTER        = -362
      TKFRAME_-362410_RELATIVE    = 'RBSP_A_MAG_EXT'
      TKFRAME_-362410_SPEC        = 'MATRIX'
      TKFRAME_-362410_MATRIX      = ( 1.0
      				      0.0
				      0.0
				      0.0
				      1.0
				      0.0
				      0.0
				      0.0
				      1.0 )

      \begintext
