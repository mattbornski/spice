import setuptools
import glob
import os.path
import platform

if __name__ == '__main__':
    # Files which are unchanged between the 32bit and 64bit distros.
    common = 'src'
    # Files which are specific to either the 32bit or 64bit distros.
    arch = \
      'src32' if platform.architecture()[0].startswith('32') else 'src64'

    # The core code for the Python extension
    sources = ['internal.c']
    for folder in [common, arch]:
        sources += glob.glob(os.path.join(folder, '*.c'))

    # Define a C extension.
    internal = setuptools.Extension(
      'spice.internal',
      sources = sources,
      include_dirs = [common, arch],
    )

    # Define a Python extension.
    pythonic = [
        'spice.interface'
    ]

#    data_dir = os.path.expanduser('~/spice/')
#    data_files = [
#      # Documentation
#      (os.path.join(data_dir, 'docs'), glob.glob('docs/*')),
#      # Examples
#      (os.path.join(data_dir, 'examples'), glob.glob('examples/*')),
#    ]

    # Invoke the setup code, which will (depending on the command line
    # arguments) build, install, or otherwise tinker with this package
    # on this system.
    setuptools.setup(
      name = 'spice',
      version = '0.12',
      description = 'This package provides a limited interface ' \
        + 'to the NASA NAIF SPICE library.',
      author = 'Matt Born',
      author_email = 'mtborn@gmail.com',
      url = 'https://github.com/mattborn/spice',
      classifiers = [
        'Development Status :: 2 - Pre-Alpha',
        'Intended Audience :: Science/Research',
        'License :: OSI Approved :: Apache Software License',
        'Topic :: Scientific/Engineering :: Astronomy',
      ],
      ext_modules = [internal],
      py_modules = pythonic,
      # Include some non-source files.  These files are for reference,
      # and will not be compiled.
#      data_files = data_files,
    )

#    stat = os.stat(os.path.expanduser('~'))
#    uid = stat.st_uid
#    gid = stat.st_gid
#    for (dir, files) in [(data_dir, [])] + data_files:
#        os.chown(dir, uid, gid)
#        for file in files:
#            path = os.path.join(dir, os.path.basename(file))
#            os.chown(path, uid, gid)
