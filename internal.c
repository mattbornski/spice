/**
 * Include requisisite headers for this module.
 **/
/* My own header. */
#include "internal.h"



/**
 * Declare common objects for this module.  Do this before defining the
 * methods, as the methods may want to reference them.
 **/
/* An error. */
static PyObject *SpiceError;



/**
 * Helper functions
 */
/* Helper function to handle logic of throwing exceptions when
 * allocations fail. */
void *alloc(void *region) {
    if (region == NULL) {
        PyErr_NoMemory();
    }
    return region;
}

/**
 * The core Python extension code.
 */
static PyObject *api_x_s_x(
  void (*function)(ConstSpiceChar  *), PyObject *args) {
    if (PySequence_Check(args)) {
        SpiceChar *in_1 = NULL;
        if (PyArg_ParseTuple(args, "s", &in_1)) {
            function(in_1);
            if (PyErr_Occurred()) {
                PyErr_SetNone(SpiceError);
            } else {
                return Py_None;
            }
        }
    }
    return NULL;
}

static PyObject *api_x_s_ib(
  void (*function)(ConstSpiceChar *, SpiceInt *, SpiceBoolean *),
  PyObject *args) {
    if (PySequence_Check(args)) {
        SpiceChar *in_1 = NULL;
        if (PyArg_ParseTuple(args, "s", &in_1)) {
            SpiceInt out_1;
            SpiceBoolean out_2;
            function(in_1, &out_1, &out_2);
            if (PyErr_Occurred()) {
                PyErr_SetNone(SpiceError);
            } else if (out_2 == SPICETRUE) {
                return Py_BuildValue("i", out_1);
            } else {
                return Py_None;
            }
        }
    }
    return NULL;
}

static PyObject *api_x_ssdsss_d3dd3(
  void (*function)(ConstSpiceChar *, ConstSpiceChar *, SpiceDouble, 
    ConstSpiceChar *, ConstSpiceChar *, ConstSpiceChar *, SpiceDouble *,
    SpiceDouble *, SpiceDouble *),
  PyObject *args) {
    if (PySequence_Check(args)) {
        SpiceChar *in_1 = NULL;
        SpiceChar *in_2 = NULL;
        SpiceDouble in_3;
        SpiceChar *in_4 = NULL;
        SpiceChar *in_5 = NULL;
        SpiceChar *in_6 = NULL;
        if (PyArg_ParseTuple(args, "ssdsss",
          &in_1, &in_2, &in_3, &in_4, &in_5, &in_6)) {
            SpiceDouble *out_1 = alloc(calloc(sizeof(SpiceDouble), 3));
            SpiceDouble *out_2 = alloc(calloc(sizeof(SpiceDouble), 1));
            SpiceDouble *out_3 = alloc(calloc(sizeof(SpiceDouble), 3));
            function(
              in_1, in_2, in_3, in_4, in_5, in_6, out_1, out_2, out_3);
            if (PyErr_Occurred()) {
                if (out_1 != NULL) {
                    free(out_1);
                }
                if (out_2 != NULL) {
                    free(out_2);
                }
                if (out_3 != NULL) {
                    free(out_3);
                }
                PyErr_SetNone(SpiceError);
            } else {
                return Py_BuildValue("((ddd)d(ddd))",
                  out_1[0], out_1[1], out_1[2],
                  out_2,
                  out_3[0], out_3[1], out_3[2]);
            }
        }
    }
    return NULL;
}

static PyObject *api_s_s_x(
  ConstSpiceChar *(*function)(ConstSpiceChar  *), PyObject *args) {
    if (PySequence_Check(args)) {
        SpiceChar *in_1 = NULL;
        if (PyArg_ParseTuple(args, "s", &in_1)) {
            ConstSpiceChar *out_1 = function(in_1);
            if (PyErr_Occurred()) {
                PyErr_SetNone(SpiceError);
            } else {
                return PyString_FromString(out_1);
            }
        }
    }
    return NULL;
}

/**
 * General SPICE API
 */
static PyObject *furnsh_py(PyObject *self, PyObject *args) {
    return api_x_s_x(&furnsh_c, args);
}

static PyObject *unload_py(PyObject *self, PyObject *args) {
    return api_x_s_x(&unload_c, args);
}

static PyObject *tkvrsn_py(PyObject *self, PyObject *args) {
    return api_s_s_x(&tkvrsn_c, args);
}

static PyObject *bods2c_py(PyObject *self, PyObject *args) {
    return api_x_s_ib(&bods2c_c, args);
}


/**
 * Time API
 */
static PyObject *str2et_py(PyObject *self, PyObject *args) {
    if (PySequence_Check(args)) {
        char *in_1 = NULL;
        if (PyArg_ParseTuple(args, "s", &in_1)) {
            SpiceDouble out_1;
            str2et_c(in_1, &out_1);
            if (PyErr_Occurred()) {
                PyErr_SetNone(SpiceError);
            } else {
                return PyFloat_FromDouble(out_1);
            }
        }
    }
    return NULL;
}

static PyObject *tpictr_py(PyObject *self, PyObject *args) {
    if (PySequence_Check(args)) {
        ConstSpiceChar *in_1 = NULL;
        SpiceInt in_2;
        if (PyArg_ParseTuple(args, "si", &in_1, &in_2)) {
            SpiceChar *out_1 = alloc(calloc(sizeof(SpiceChar), in_2));
            if (out_1 != NULL) {
                SpiceBoolean out_2;
                SpiceChar *out_3 = alloc(calloc(sizeof(SpiceChar), in_2));
                if (out_3 != NULL) {
//                    function(in_1, in_2, in_3, out_1);
                    tpictr_c(in_1, in_2, in_2, out_1, &out_2, out_3);
                    if (PyErr_Occurred()) {
                        free(out_1);
                        free(out_3);
                        PyErr_SetNone(SpiceError);
                    } else if (out_2 != SPICETRUE) {
                        free(out_1);
                        PyErr_SetString(SpiceError, out_3);
                    } else {
                        free(out_3);
                        return Py_BuildValue("s", out_1);
                    }
                } else {
                    free(out_1);
                    PyErr_SetString(SpiceError, "Failed to allocate space for error message.");
                }
            } else {
                PyErr_SetString(SpiceError, "Failed to allocate space for result.");
            }
        }
    }
    return NULL;
}

static PyObject *timout_py(PyObject *self, PyObject *args) {
    if (PySequence_Check(args)) {
        SpiceDouble in_1;
        ConstSpiceChar *in_2 = NULL;
        SpiceInt in_3;
        if (PyArg_ParseTuple(args, "dsi", &in_1, &in_2, &in_3)) {
            SpiceChar *out_1 = alloc(calloc(sizeof(SpiceChar), in_3));
            timout_c(in_1, in_2, in_3, out_1);
            if (PyErr_Occurred()) {
                PyErr_SetNone(SpiceError);
            } else {
                return Py_BuildValue("s", out_1);
            }
        }
    }
    return NULL;
}

static PyObject *sce2s_py(PyObject *self, PyObject *args) {
    if (PySequence_Check(args)) {
        SpiceInt in_1;
        SpiceDouble in_2;
        SpiceInt in_3;
        if (PyArg_ParseTuple(args, "idi", &in_1, &in_2, &in_3)) {
            SpiceChar *out_1 = alloc(calloc(sizeof(SpiceChar), in_3));
            sce2s_c(in_1, in_2, in_3, out_1);
            if (PyErr_Occurred()) {
                PyErr_SetNone(SpiceError);
            } else {
                return Py_BuildValue("s", out_1);
            }
        }
    }
    return NULL;
}


static PyObject *scs2e_py(PyObject *self, PyObject *args) {
    if (PySequence_Check(args)) {
        SpiceInt in_1;
        SpiceChar *in_2 = NULL;
        if (PyArg_ParseTuple(args, "is", &in_1, &in_2)) {
            SpiceDouble out_1;
//            function(in_1, in_2, &out_1);
            scs2e_c(in_1, in_2, &out_1);
            if (PyErr_Occurred()) {
                PyErr_SetNone(SpiceError);
            } else {
                return PyFloat_FromDouble(out_1);
            }
        }
    }
    return NULL;
}

static PyObject *sct2e_py(PyObject *self, PyObject *args) {
    if (PySequence_Check(args)) {
        SpiceInt in_1;
        SpiceDouble in_2;
        if (PyArg_ParseTuple(args, "id", &in_1, &in_2)) {
            SpiceDouble out_1;
//            function(in_1, in_2, &out_1);
            sct2e_c(in_1, in_2, &out_1);
            if (PyErr_Occurred()) {
                PyErr_SetNone(SpiceError);
            } else {
                return PyFloat_FromDouble(out_1);
            }
        }
    }
    return NULL;
}

static PyObject *sce2c_py(PyObject *self, PyObject *args) {
    if (PySequence_Check(args)) {
        SpiceInt in_1;
        SpiceDouble in_2;
        if (PyArg_ParseTuple(args, "id", &in_1, &in_2)) {
            SpiceDouble out_1;
//            function(in_1, in_2, &out_1);
            sce2c_c(in_1, in_2, &out_1);
            if (PyErr_Occurred()) {
                PyErr_SetNone(SpiceError);
            } else {
                return PyFloat_FromDouble(out_1);
            }
        }
    }
    return NULL;
}

static PyObject *scencd_py(PyObject *self, PyObject *args) {
    if (PySequence_Check(args)) {
        SpiceInt in_1;
        SpiceChar *in_2 = NULL;
        if (PyArg_ParseTuple(args, "is", &in_1, &in_2)) {
            SpiceDouble out_1;
//            function(in_1, in_2, &out_1);
            scencd_c(in_1, in_2, &out_1);
            if (PyErr_Occurred()) {
                PyErr_SetNone(SpiceError);
            } else {
                return PyFloat_FromDouble(out_1);
            }
        }
    }
    return NULL;
}

static PyObject *scdecd_py(PyObject *self, PyObject *args) {
    if (PySequence_Check(args)) {
        SpiceInt in_1;
        SpiceDouble in_2;
        SpiceInt in_3;
        if (PyArg_ParseTuple(args, "idi", &in_1, &in_2, &in_3)) {
            SpiceChar *out_1 = alloc(calloc(sizeof(SpiceChar), in_3));
//            function(in_1, in_2, in_3, out_1);
            scdecd_c(in_1, in_2, in_3, out_1);
            if (PyErr_Occurred()) {
                PyErr_SetNone(SpiceError);
            } else {
                return Py_BuildValue("s", out_1);
            }
        }
    }
    return NULL;
}

/**
 * Position API
 */
static PyObject *spkezr_py(PyObject *self, PyObject *args) {
    if (PySequence_Check(args)) {
        SpiceChar *in_1 = NULL;
        SpiceDouble in_2;
        SpiceChar *in_3 = NULL;
        SpiceChar *in_4 = NULL;
        SpiceChar *in_5 = NULL;
        if (PyArg_ParseTuple(args, "sdsss",
          &in_1, &in_2, &in_3, &in_4, &in_5)) {
            SpiceDouble *out_1 = alloc(calloc(sizeof(SpiceDouble), 6));
            SpiceDouble *out_2 = alloc(calloc(sizeof(SpiceDouble), 1));
            spkezr_c(in_1, in_2, in_3, in_4, in_5, out_1, out_2);
            if (PyErr_Occurred()) {
                if (out_1 != NULL) {
                    free(out_1);
                }
                if (out_2 != NULL) {
                    free(out_2);
                }
                PyErr_SetNone(SpiceError);
            } else {
                return Py_BuildValue("((dddddd)d)",
                  out_1[0], out_1[1], out_1[2], out_1[3], out_1[4], out_1[5],
                  out_2);
            }
        }
    }
    return NULL;
}

static PyObject *spkpos_py(PyObject *self, PyObject *args) {
    if (PySequence_Check(args)) {
        SpiceChar *in_1 = NULL;
        SpiceDouble in_2;
        SpiceChar *in_3 = NULL;
        SpiceChar *in_4 = NULL;
        SpiceChar *in_5 = NULL;
        if (PyArg_ParseTuple(args, "sdsss",
          &in_1, &in_2, &in_3, &in_4, &in_5)) {
            SpiceDouble *out_1 = alloc(calloc(sizeof(SpiceDouble), 3));
            SpiceDouble *out_2 = alloc(calloc(sizeof(SpiceDouble), 1));
            spkpos_c(in_1, in_2, in_3, in_4, in_5, out_1, out_2);
            if (PyErr_Occurred()) {
                if (out_1 != NULL) {
                    free(out_1);
                }
                if (out_2 != NULL) {
                    free(out_2);
                }
                PyErr_SetNone(SpiceError);
            } else {
                return Py_BuildValue("((ddd)d)",
                  out_1[0], out_1[1], out_1[2],
                  out_2);
            }
        }
    }
    return NULL;
}

static PyObject *subpnt_py(PyObject *self, PyObject *args) {
    return api_x_ssdsss_d3dd3(&subpnt_c, args);
}



/**
 * Define method table for this module.  Do this after declaring
 * or defining methods but before defining initialization, as
 * the initialization must register this table.
 **/
static PyMethodDef InternalMethods[] = {
    /* */
    {"furnsh", furnsh_py, METH_VARARGS,
      "Load one or more SPICE kernels into a program."},
    {"unload", unload_py, METH_VARARGS,
      "Unload a SPICE kernel."},
    {"tkvrsn", tkvrsn_py, METH_VARARGS,
      "Given an item such as the Toolkit or an entry point name, return"
      " the latest version string."},
    {"bods2c", bods2c_py, METH_VARARGS,
      "Translate a string containing a body name or ID code to an integer"
      " code."},
    /* Time API */
    {"str2et", str2et_py, METH_VARARGS,
      "Convert a string representing an epoch to a double precision"
      " value representing the number of TDB seconds past the J2000"
      " epoch corresponding to the input epoch."},
    {"tpictr", tpictr_py, METH_VARARGS,
      "Given a sample time string, create a time format picture"
      " suitable for use by the routine timout_c."},
    {"timout", timout_py, METH_VARARGS,
      "This routine converts an input epoch represented in TDB seconds"
      " past the TDB epoch of J2000 to a character string formatted to"
      " the specifications of a user's format picture."},
    {"sce2s", sce2s_py, METH_VARARGS,
      "Convert an epoch specified as ephemeris seconds past J2000 (ET) to a"
      " character string representation of a spacecraft clock value (SCLK)."},
    {"scs2e", scs2e_py, METH_VARARGS,
      "Convert a spacecraft clock string to ephemeris seconds past"
      " J2000 (ET)."},
    {"sct2e", sct2e_py, METH_VARARGS,
      "Convert encoded spacecraft clock (`ticks') to ephemeris"
      " seconds past J2000 (ET)."},
    {"sce2c", sce2c_py, METH_VARARGS,
      "Convert ephemeris seconds past J2000 (ET) to continuous encoded"
      " spacecraft clock (`ticks').  Non-integral tick values may be"
      " returned."},
    {"scencd", scencd_py, METH_VARARGS,
      "Encode character representation of spacecraft clock time into a"
      " double precision number."},
    {"scdecd", scdecd_py, METH_VARARGS,
      "Convert double precision encoding of spacecraft clock time into"
      " a character representation."},
    /* Position API */
    {"spkezr", spkezr_py, METH_VARARGS,
      ""},
    {"spkpos", spkpos_py, METH_VARARGS,
      ""},
    {"subpnt", subpnt_py, METH_VARARGS,
      "Compute the rectangular coordinates of the sub-observer point on"
      " a target body at a specified epoch, optionally corrected for"
      " light time and stellar aberration."},
    {NULL, NULL, 0, NULL}
};

/* Define initialization for this module. */
PyMODINIT_FUNC
initinternal(void)
{
    PyObject *module;

    module = Py_InitModule("spice.internal", InternalMethods);
    if (module == NULL) {
        return;
    }

    /* Define common objects which were previously declared. */
    /* An error. */
    SpiceError = PyErr_NewException("spice.internal.error", NULL, NULL);
    Py_INCREF(SpiceError);
    PyModule_AddObject(module, "error", SpiceError);

    /* Set the toolkit to report errors but not abort. */
    erract_c("SET", 0, "REPORT");
}
