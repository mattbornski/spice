KPL/FK

RBSP_B Spacecraft Frame Definitions Kernel
===========================================================================

   This frame kernel contains the RBSP_B spacecraft, science instrument,
   and communication antennae frame definitions.


Version and Date
---------------------------------------------------------------
   The TEXT_KERNEL_ID stores version information of loaded project text
   kernels.  Each entry associated with the keyword is a string that
   consists of four parts: the kernel name, version, entry date, and type.
   For example, the frame kernel might have an entry as follows:

      TEXT_KERNEL_ID += 'RBSP_B_FRAMES V0.0.0 ??-JUL-2010 FK'

   RBSP Frame Kernel Version:

      \begindata

      TEXT_KERNEL_ID += 'RBSP_B_FRAMES V0.0.0 ??-JUL-2010 FK'

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
      RBSP_B_SPACECRAFT         J2000                     CK       -363000

      Science Frames:
      ---------------
      RBSP_B_SCIENCE            RBSP_B_SPACECRAFT         FIXED    -363100

      Antenna Frames:
      ---------------
      RBSP_B_ANT_POSZ           RBSP_B_SPACECRAFT         FIXED    -363200
      RBSP_B_ANT_NEGZ           RBSP_B_SPACECRAFT         FIXED    -363210

      SSH Frames:
      ---------------
      RBSP_B_SSH_A              RBSP_B_SPACECRAFT         FIXED    -363300
      RBSP_B_SSH_B              RBSP_B_SPACECRAFT         FIXED    -363310

      MAG Frames:
      ---------------
      RBSP_B_MAG_EXT            RBSP_B_SCIENCE            FIXED    -363400
      RBSP_B_MAG_INT            RBSP_B_MAG_EXT            FIXED    -363410


RBSP_B Frames Hierarchy
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
         'RBSP_B_SPACECRAFT'
              |
             'RBSP_B_SCIENCE'
              |   |
	      |  'RBSP_B_MAG_EXT'
	      |       |
	      |	     'RBSP_B_MAG_INT'
	      |
             'RBSP_B_ANT_POSZ'
              |
             'RBSP_B_ANT_NEGZ'
              |
             'RBSP_B_SSH_A'
              |
             'RBSP_B_SSH_B'
	    



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

      FRAME_RBSP_B_SPACECRAFT     = -363000
      FRAME_-363000_NAME          = 'RBSP_B_SPACECRAFT'
      FRAME_-363000_CLASS         = 3
      FRAME_-363000_CLASS_ID      = -363000
      FRAME_-363000_CENTER        = -363
      CK_-363000_SCLK             = -363
      CK_-363000_SPK              = -363

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

      FRAME_RBSP_B_SCIENCE        = -363100
      FRAME_-363100_NAME          = 'RBSP_B_SCIENCE'
      FRAME_-363100_CLASS         = 4
      FRAME_-363100_CLASS_ID      = -363100
      FRAME_-363100_CENTER        = -363
      TKFRAME_-363100_RELATIVE    = 'RBSP_B_SPACECRAFT'
      TKFRAME_-363100_SPEC        = 'MATRIX'
      TKFRAME_-363100_MATRIX      = ( 0.819152044288991789
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

      FRAME_RBSP_B_ANT_POSZ       = -363200
      FRAME_-363200_NAME          = 'RBSP_B_ANT_POSZ'
      FRAME_-363200_CLASS         = 4
      FRAME_-363200_CLASS_ID      = -363200
      FRAME_-363200_CENTER        = -363
      TKFRAME_-363200_RELATIVE    = 'RBSP_B_SPACECRAFT'
      TKFRAME_-363200_SPEC        = 'MATRIX'
      TKFRAME_-363200_MATRIX      = ( 1.0
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

      FRAME_RBSP_B_ANT_NEGZ           = -363210
      FRAME_-363210_NAME          = 'RBSP_B_ANT_NEGZ'
      FRAME_-363210_CLASS         = 4
      FRAME_-363210_CLASS_ID      = -363210
      FRAME_-363210_CENTER        = -363
      TKFRAME_-363210_RELATIVE    = 'RBSP_B_SPACECRAFT'
      TKFRAME_-363210_SPEC        = 'MATRIX'
      TKFRAME_-363210_MATRIX      = (-1.0
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

      FRAME_RBSP_B_SSH_A          = -363300
      FRAME_-363300_NAME          = 'RBSP_B_SSH_A'
      FRAME_-363300_CLASS         = 4
      FRAME_-363300_CLASS_ID      = -363300
      FRAME_-363300_CENTER        = -363
      TKFRAME_-363300_RELATIVE    = 'RBSP_B_SPACECRAFT'
      TKFRAME_-363300_SPEC        = 'MATRIX'
      TKFRAME_-363300_MATRIX      = ( 0.707106781186547524
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

      FRAME_RBSP_B_SSH_B          = -363310
      FRAME_-363310_NAME          = 'RBSP_B_SSH_B'
      FRAME_-363310_CLASS         = 4
      FRAME_-363310_CLASS_ID      = -363310
      FRAME_-363310_CENTER        = -363
      TKFRAME_-363310_RELATIVE    = 'RBSP_B_SPACECRAFT'
      TKFRAME_-363310_SPEC        = 'MATRIX'
      TKFRAME_-363310_MATRIX      = (-0.707106781186547524
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

      FRAME_RBSP_B_MAG_EXT        = -363400
      FRAME_-363400_NAME          = 'RBSP_B_MAG_EXT'
      FRAME_-363400_CLASS         = 4
      FRAME_-363400_CLASS_ID      = -363400
      FRAME_-363400_CENTER        = -363
      TKFRAME_-363400_RELATIVE    = 'RBSP_B_SCIENCE'
      TKFRAME_-363400_SPEC        = 'MATRIX'
      TKFRAME_-363400_MATRIX      = ( 1.0
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

      FRAME_RBSP_B_MAG_INT        = -363410
      FRAME_-363410_NAME          = 'RBSP_B_MAG_INT'
      FRAME_-363410_CLASS         = 4
      FRAME_-363410_CLASS_ID      = -363410
      FRAME_-363410_CENTER        = -363
      TKFRAME_-363410_RELATIVE    = 'RBSP_B_MAG_EXT'
      TKFRAME_-363410_SPEC        = 'MATRIX'
      TKFRAME_-363410_MATRIX      = ( 1.0
      				      0.0
				      0.0
				      0.0
				      1.0
				      0.0
				      0.0
				      0.0
				      1.0 )

      \begintext
