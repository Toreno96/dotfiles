#!/usr/bin/env python3
"""Template for the simple Python script."""
import logging


logging.basicConfig(
    format='%(levelname)s: %(message)s',
    # filename='log_file',
    # filename=os.path.basename(__file__) + os.path.extsep + 'log',
    # datefmt='%F %T',
    # format='[%(asctime)s] %(levelname)s:%(module)s:%(lineno)d: %(message)s',
    level=logging.DEBUG,
)


def main():
    pass


if __name__ == '__main__':
    main()
