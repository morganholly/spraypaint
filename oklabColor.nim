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



converter addOpacity(val: LABFloat): OLABFloat {.inline.} =
    OLABFloat(l: val.l, a: val.a, b: val.b, o: 1)

converter addOpacity(val: LCHFloat): OLCHFloat {.inline.} =
    OLCHFloat(l: val.l, c: val.c, h: val.h, o: 1)

converter addOpacity(val: RGBLinearFloat): ORGBLinearFloat {.inline.} =
    ORGBLinearFloat(r: val.r, g: val.g, b: val.b, o: 1)

converter addOpacity(val: RGBLinearInt8): ORGBLinearInt8 {.inline.} =
    ORGBLinearInt8(r: val.r, g: val.g, b: val.b, o: 1)

converter addOpacity(val: RGBNonLinearFloat): ORGBNonLinearFloat {.inline.} =
    ORGBNonLinearFloat(r: val.r, g: val.g, b: val.b, o: 1)

converter addOpacity(val: RGBNonLinearInt8): ORGBNonLinearInt8 {.inline.} =
    ORGBNonLinearInt8(r: val.r, g: val.g, b: val.b, o: 1)


proc addOpacity(val: LABFloat, opacity: float): OLABFloat {.inline.} =
    OLABFloat(l: val.l, a: val.a, b: val.b, o: opacity)

proc addOpacity(val: LCHFloat, opacity: float): OLCHFloat {.inline.} =
    OLCHFloat(l: val.l, c: val.c, h: val.h, o: opacity)

proc addOpacity(val: RGBLinearFloat, opacity: float): ORGBLinearFloat {.inline.} =
    ORGBLinearFloat(r: val.r, g: val.g, b: val.b, o: opacity)

proc addOpacity(val: RGBLinearInt8, opacity: int8): ORGBLinearInt8 {.inline.} =
    ORGBLinearInt8(r: val.r, g: val.g, b: val.b, o: opacity)

proc addOpacity(val: RGBNonLinearFloat, opacity: float): ORGBNonLinearFloat {.inline.} =
    ORGBNonLinearFloat(r: val.r, g: val.g, b: val.b, o: opacity)

proc addOpacity(val: RGBNonLinearInt8, opacity: int8): ORGBNonLinearInt8 {.inline.} =
    ORGBNonLinearInt8(r: val.r, g: val.g, b: val.b, o: opacity)


proc delOpacity(val: OLABFloat): LABFloat {.inline.} =
    LABFloat(l: val.l, a: val.a, b: val.b)

proc delOpacity(val: OLCHFloat): LCHFloat {.inline.} =
    LCHFloat(l: val.l, c: val.c, h: val.h)

proc delOpacity(val: ORGBLinearFloat): RGBLinearFloat {.inline.} =
    RGBLinearFloat(r: val.r, g: val.g, b: val.b)

proc delOpacity(val: ORGBLinearInt8): RGBLinearInt8 {.inline.} =
    RGBLinearInt8(r: val.r, g: val.g, b: val.b)

proc delOpacity(val: ORGBNonLinearFloat): RGBNonLinearFloat {.inline.} =
    RGBNonLinearFloat(r: val.r, g: val.g, b: val.b)

proc delOpacity(val: ORGBNonLinearInt8): RGBNonLinearInt8 {.inline.} =
    RGBNonLinearInt8(r: val.r, g: val.g, b: val.b)


proc cyl(val: LABFloat): LCHFloat {.inline.} =
    LCHFloat(l: val.l, c: sqrt(val.a * val.a + val.b * val.b), h: Hue(hue: arctan2(val.b, val.a)))

proc cyl(val: OLABFloat): OLCHFloat {.inline.} =
    OLCHFloat(l: val.l, c: sqrt(val.a * val.a + val.b * val.b), h: Hue(hue: arctan2(val.b, val.a)), o: val.o)

proc LABtoLCH(val: LABFloat): LCHFloat {.inline.} =
    LCHFloat(l: val.l, c: sqrt(val.a * val.a + val.b * val.b), h: Hue(hue: arctan2(val.b, val.a)))

proc LABtoLCH(val: OLABFloat): OLCHFloat {.inline.} =
    OLCHFloat(l: val.l, c: sqrt(val.a * val.a + val.b * val.b), h: Hue(hue: arctan2(val.b, val.a)), o: val.o)


proc cart(val: LCHFloat): LABFloat {.inline.} =
    LABFloat(l: val.l, a: val.c * cos(val.h.hue), b: val.c * sin(val.h.hue))

proc cart(val: OLCHFloat): OLABFloat {.inline.} =
    OLABFloat(l: val.l, a: val.c * cos(val.h.hue), b: val.c * sin(val.h.hue), o: val.o)

proc LCHtoLAB(val: LCHFloat): LABFloat {.inline.} =
    LABFloat(l: val.l, a: val.c * cos(val.h.hue), b: val.c * sin(val.h.hue))

proc LCHtoLAB(val: OLCHFloat): OLABFloat {.inline.} =
    OLABFloat(l: val.l, a: val.c * cos(val.h.hue), b: val.c * sin(val.h.hue), o: val.o)
