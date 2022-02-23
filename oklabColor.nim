import hue
import std/math

type
    LABFloat* = object
        l*: float
        a*: float
        b*: float

    OLABFloat* = object # LABFloat with opacity
        l*: float
        a*: float
        b*: float
        o*: range[0'f64 .. 1'f64]

    LCHFloat* = object
        l*: float
        c*: float
        h*: Hue

    OLCHFloat* = object # LCHFloat with opacity
        l*: float
        c*: float
        h*: Hue
        o*: range[0'f64 .. 1'f64]

    RGBNonLinearFloat* = object
        r*: float
        g*: float
        b*: float

    ORGBNonLinearFloat* = object # RGB with opacity
        r*: float
        g*: float
        b*: float
        o*: range[0'f64 .. 1'f64]

    RGBNonLinearInt8* = object
        r*: int8
        g*: int8
        b*: int8

    ORGBNonLinearInt8* = object # RGB with opacity
        r*: int8
        g*: int8
        b*: int8
        o*: int8

    RGBLinearFloat* = object
        r*: float
        g*: float
        b*: float

    ORGBLinearFloat* = object # RGB with opacity
        r*: float
        g*: float
        b*: float
        o*: range[0'f64 .. 1'f64]

    RGBLinearInt8* = object
        r*: int8
        g*: int8
        b*: int8

    ORGBLinearInt8* = object # RGB with opacity
        r*: int8
        g*: int8
        b*: int8
        o*: int8
