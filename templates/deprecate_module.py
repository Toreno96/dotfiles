import warnings

# Based on the <https://stackoverflow.com/a/30093619/5875021>
warnings.warn(
    "the `event` module is deprecated; please use `event2`",
    DeprecationWarning,
    stacklevel=2,
)
