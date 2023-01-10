#!/usr/bin/env python3
"""Example definition of the Python decorator."""
import functools
from typing import Callable


def decorator(func: Callable):
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        return func(*args, **kwargs)

    return wrapper
