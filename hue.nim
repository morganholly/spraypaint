import std/math

type
    Hue* = object
        hue*: range[0'f64 .. 360'f64]
