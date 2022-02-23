import std/math

type
    Hue* = object
        hue*: range[0'f64 .. 360'f64]



proc hueAverage *(a: float, b: float): float =
    if a < b:
        if abs(b - a) <= abs(b - (a + 360)):
            return ((b + a) / 2) mod 360
        else:
            return ((b + (a + 360)) / 2) mod 360
    else:
        if abs(a - b) <= abs(a - (b + 360)):
            return ((a + b) / 2) mod 360
        else:
            return ((a + (b + 360)) / 2) mod 360

proc hueAverage *(a: float, b: float, wb: float): float =
    if a < b:
        if abs(b - a) <= abs(b - (a + 360)):
            return ((b * 2 * wb + a * 2 * (1 - wb)) / 2) mod 360;
        else:
            return ((b * 2 * wb + (a + 360) * 2 * (1 - wb)) / 2) mod 360;
    else:
        if abs(a - b) <= abs(a - (b + 360)):
            return ((a * 2 * (1 - wb) + b * 2 * wb) / 2) mod 360;
        else:
            return ((a * 2 * (1 - wb) + (b + 360) * 2 * wb) / 2) mod 360;



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
