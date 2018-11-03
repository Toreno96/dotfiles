def FlagsForFile( filename, **kwargs ):
  return {
    'flags': [
      '-x', 'c++',
      '-std=c++17',
      '-g', '-O0', '-DDEBUG',
      '-Wall', '-Wextra', '-Wshadow', '-Wconversion', '-Wpedantic',
      '-isystem', '/usr/include/c++/8.2.1',
      '-I/usr/include',
    ],
  }

