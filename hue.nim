import std/math

type
    Hue* = object
        hue*: range[0'f64 .. 360'f64]



proc hueAverage *(a: range[0'f64 .. 360'f64], b: range[0'f64 .. 360'f64]): range[0'f64 .. 360'f64] =
    if a < b:
        if (b - a) <= abs(b - (a + 360)):
            result = ((b + a) / 2) mod 360
        else:
            result = ((b + a + 360) / 2) mod 360
    else:
        if abs(a - b) <= abs(a - (b + 360)):
            result = ((a + b) / 2) mod 360
        else:
            result = ((a + b + 360) / 2) mod 360

proc hueAverage *(a: range[0'f64 .. 360'f64], b: range[0'f64 .. 360'f64], wb: range[0'f64 .. 1'f64]): range[0'f64 .. 360'f64] =
    let invWB = 1 - wb
    if a < b:
        if (b - a) <= abs(b - (a + 360)):
            result = (b * wb + a * invWB) mod 360
        else:
            result = (b * wb + (a + 360) * invWB) mod 360
    else:
        if (a - b) <= abs(a - (b + 360)):
            result = (a * invWB + b * wb) mod 360
        else:
            result = (a * invWB + (b + 360) * wb) mod 360



proc `+` *(this: Hue, other: Hue): Hue =
    Hue(hue: (this.hue + other.hue) mod 360'f64)

proc `-` *(this: Hue, other: Hue): Hue =
    Hue(hue: (this.hue - other.hue) mod 360'f64)

proc `+/` *(this: Hue, other: Hue): Hue =
    Hue(hue: hueAverage(this.hue, other.hue))


proc `+` *(this: Hue, other: float): Hue =
    Hue(hue: (this.hue + other) mod 360'f64)

proc `-` *(this: Hue, other: float): Hue =
    Hue(hue: (this.hue - other) mod 360'f64)

proc `+/` *(this: Hue, other: float): Hue =
    Hue(hue: hueAverage(this.hue, other))


proc `+` *(this: float, other: Hue): Hue =
    Hue(hue: (this + other.hue) mod 360'f64)

proc `-` *(this: float, other: Hue): Hue =
    Hue(hue: (this - other.hue) mod 360'f64)

proc `+/` *(this: float, other: Hue): Hue =
    Hue(hue: hueAverage(this, other.hue))



proc `+=` *(this: var Hue, other: Hue) =
    this.hue = (this.hue + other.hue) mod 360'f64

proc `-=` *(this: var Hue, other: Hue) =
    this.hue = (this.hue - other.hue) mod 360'f64

proc `+/=` *(this: var Hue, other: Hue): Hue =
    this.hue = hueAverage(this.hue, other.hue)


proc `+=` *(this: var Hue, other: float) =
    this.hue = (this.hue + other) mod 360'f64

proc `-=` *(this: var Hue, other: float) =
    this.hue = (this.hue - other) mod 360'f64

proc `+/=` *(this: var Hue, other: float): Hue =
    this.hue = hueAverage(this.hue, other)



proc `>` *(this: Hue, other: Hue): bool =
    this.hue > other.hue

proc `>=` *(this: Hue, other: Hue): bool =
    this.hue >= other.hue

proc `==` *(this: Hue, other: Hue): bool =
    abs(this.hue - other.hue) < 0.0000001

proc `<=` *(this: Hue, other: Hue): bool =
    this.hue <= other.hue

proc `<` *(this: Hue, other: Hue): bool =
    this.hue < other.hue

proc `!=` *(this: Hue, other: Hue): bool =
    abs(this.hue - other.hue) >= 0.0000001


proc `>` *(this: Hue, other: float): bool =
    this.hue > other

proc `>=` *(this: Hue, other: float): bool =
    this.hue >= other

proc `==` *(this: Hue, other: float): bool =
    abs(this.hue - other) < 0.0000001

proc `<=` *(this: Hue, other: float): bool =
    this.hue <= other

proc `<` *(this: Hue, other: float): bool =
    this.hue < other

proc `!=` *(this: Hue, other: float): bool =
    abs(this.hue - other) >= 0.0000001


proc `>` *(this: float, other: Hue): bool =
    this > other.hue

proc `>=` *(this: float, other: Hue): bool =
    this >= other.hue

proc `==` *(this: float, other: Hue): bool =
    abs(this - other.hue) < 0.0000001

proc `<=` *(this: float, other: Hue): bool =
    this <= other.hue

proc `<` *(this: float, other: Hue): bool =
    this < other.hue

proc `!=` *(this: float, other: Hue): bool =
    abs(this - other.hue) >= 0.0000001
