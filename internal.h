#ifndef SPICEMODULE_H
#define SPICEMODULE_H

/**
 * Include requisisite headers for this module.
 **/
/* The Python module creation header. */
#include "Python.h"
/* Defines macros for the CDF library.  Macros provide what CDF considers
 * to be its "standard interface".  The macros refer to an instance of a
 * CDFlib object, which implements what CDF considers to be its "internal
 * interface".  The internal interface and its dependencies are implemented
 * by a collection of C files in the src/ directory, which the Python
 * extension must be aware of.  These are listed out in setup.py.  At this
 * level, however, we do not need to know about them, as the Python
 * distutils should take care of linking against them when compiling the
 * extension.  Only the interface, as defined in cdf.h, is necessary here. */
#include "SpiceUsr.h"
/* Explicitly include stdlib so that the malloc/calloc declarations are
 * accessible.  Without these, return types are assumed for the memory
 * allocation functions which work on 32bit machines but not on 64bit
 * machines. */
#include "stdlib.h"



/**
 * Constants
 */

/**
 * Declare functions.
 **/

#endif
