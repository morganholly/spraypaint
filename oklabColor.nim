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


proc nonlin(val: float): float {.inline.} =
    if val < 0.0031308:
        result = 12.92 * val
    else:
        result = 1.055 * pow(val, 1.0 / 2.4) - 0.055

proc nonlin(val: RGBLinearFloat): RGBNonLinearFloat {.inline.} =
    RGBNonLinearFloat(r: nonlin(val.r), g: nonlin(val.g), b: nonlin(val.b))

proc nonlin(val: ORGBLinearFloat): ORGBNonLinearFloat {.inline.} =
    ORGBNonLinearFloat(r: nonlin(val.r), g: nonlin(val.g), b: nonlin(val.b), o: val.o)

proc nonlin(r: float, g: float, b: float): RGBNonLinearFloat {.inline.} =
    RGBNonLinearFloat(r: nonlin(r), g: nonlin(g), b: nonlin(b))

proc nonlin(r: float, g: float, b: float, o: float): ORGBNonLinearFloat {.inline.} =
    ORGBNonLinearFloat(r: nonlin(r), g: nonlin(g), b: nonlin(b), o: o)


proc lin(val: float): float {.inline.} =
    if val < 0.04045:
        result = val / 12.92
    else:
        result = pow((val + 0.055) / (1.055), 2.4)

proc lin(val: RGBNonLinearFloat): RGBLinearFloat {.inline.} =
    RGBLinearFloat(r: lin(val.r), g: lin(val.g), b: lin(val.b))

proc lin(val: ORGBNonLinearFloat): ORGBLinearFloat {.inline.} =
    ORGBLinearFloat(r: lin(val.r), g: lin(val.g), b: lin(val.b), o: val.o)

proc lin(r: float, g: float, b: float): RGBLinearFloat {.inline.} =
    RGBLinearFloat(r: lin(r), g: lin(g), b: lin(b))

proc lin(r: float, g: float, b: float, o: float): ORGBLinearFloat {.inline.} =
    ORGBLinearFloat(r: lin(r), g: lin(g), b: lin(b), o: o)
