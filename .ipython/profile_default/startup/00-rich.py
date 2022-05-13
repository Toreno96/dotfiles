import logging

try:
    import rich.pretty

    rich.pretty.install()
except ImportError:
    logging.warning("`rich` not installed")
