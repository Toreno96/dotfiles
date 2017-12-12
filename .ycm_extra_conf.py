def FlagsForFile( filename, **kwargs ):
  return {
    'flags': [
      '-x', 'c++',
      '-std=c++1z',
      '-g', '-O0', '-DDEBUG',
      '-Wall', '-Wextra', '-Wshadow', '-Wconversion', '-Wpedantic',
      '-isystem', '/usr/include/c++/6',
      '-I/usr/local/boost_1_64_0'
    ],
  }

