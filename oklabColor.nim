import hue
import std/math

const inv2_4 = 1.0 / 2.4
const inv256 = 1.0 / 256.0
const inv1_055 = 1.0 / 1.055
const inv12_92 = 1.0 / 12.92

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


converter addOpacity *(val: LABFloat): OLABFloat {.inline.} =
    OLABFloat(l: val.l, a: val.a, b: val.b, o: 1)

converter addOpacity *(val: LCHFloat): OLCHFloat {.inline.} =
    OLCHFloat(l: val.l, c: val.c, h: val.h, o: 1)

converter addOpacity *(val: RGBLinearFloat): ORGBLinearFloat {.inline.} =
    ORGBLinearFloat(r: val.r, g: val.g, b: val.b, o: 1)

converter addOpacity *(val: RGBLinearInt8): ORGBLinearInt8 {.inline.} =
    ORGBLinearInt8(r: val.r, g: val.g, b: val.b, o: 1)

converter addOpacity *(val: RGBNonLinearFloat): ORGBNonLinearFloat {.inline.} =
    ORGBNonLinearFloat(r: val.r, g: val.g, b: val.b, o: 1)

converter addOpacity *(val: RGBNonLinearInt8): ORGBNonLinearInt8 {.inline.} =
    ORGBNonLinearInt8(r: val.r, g: val.g, b: val.b, o: 1)


proc addOpacity *(val: LABFloat, opacity: float): OLABFloat {.inline.} =
    OLABFloat(l: val.l, a: val.a, b: val.b, o: opacity)

proc addOpacity *(val: LCHFloat, opacity: float): OLCHFloat {.inline.} =
    OLCHFloat(l: val.l, c: val.c, h: val.h, o: opacity)

proc addOpacity *(val: RGBLinearFloat, opacity: float): ORGBLinearFloat {.inline.} =
    ORGBLinearFloat(r: val.r, g: val.g, b: val.b, o: opacity)

proc addOpacity *(val: RGBLinearInt8, opacity: int8): ORGBLinearInt8 {.inline.} =
    ORGBLinearInt8(r: val.r, g: val.g, b: val.b, o: opacity)

proc addOpacity *(val: RGBNonLinearFloat, opacity: float): ORGBNonLinearFloat {.inline.} =
    ORGBNonLinearFloat(r: val.r, g: val.g, b: val.b, o: opacity)

proc addOpacity *(val: RGBNonLinearInt8, opacity: int8): ORGBNonLinearInt8 {.inline.} =
    ORGBNonLinearInt8(r: val.r, g: val.g, b: val.b, o: opacity)


proc delOpacity *(val: OLABFloat): LABFloat {.inline.} =
    LABFloat(l: val.l, a: val.a, b: val.b)

proc delOpacity *(val: OLCHFloat): LCHFloat {.inline.} =
    LCHFloat(l: val.l, c: val.c, h: val.h)

proc delOpacity *(val: ORGBLinearFloat): RGBLinearFloat {.inline.} =
    RGBLinearFloat(r: val.r, g: val.g, b: val.b)

proc delOpacity *(val: ORGBLinearInt8): RGBLinearInt8 {.inline.} =
    RGBLinearInt8(r: val.r, g: val.g, b: val.b)

proc delOpacity *(val: ORGBNonLinearFloat): RGBNonLinearFloat {.inline.} =
    RGBNonLinearFloat(r: val.r, g: val.g, b: val.b)

proc delOpacity *(val: ORGBNonLinearInt8): RGBNonLinearInt8 {.inline.} =
    RGBNonLinearInt8(r: val.r, g: val.g, b: val.b)


proc cyl *(val: LABFloat): LCHFloat {.inline.} =
    LCHFloat(l: val.l, c: sqrt(val.a * val.a + val.b * val.b), h: Hue(hue: arctan2(val.b, val.a)))

proc cyl *(val: OLABFloat): OLCHFloat {.inline.} =
    OLCHFloat(l: val.l, c: sqrt(val.a * val.a + val.b * val.b), h: Hue(hue: arctan2(val.b, val.a)), o: val.o)

proc LABtoLCH *(val: LABFloat): LCHFloat {.inline.} =
    LCHFloat(l: val.l, c: sqrt(val.a * val.a + val.b * val.b), h: Hue(hue: arctan2(val.b, val.a)))

proc LABtoLCH *(val: OLABFloat): OLCHFloat {.inline.} =
    OLCHFloat(l: val.l, c: sqrt(val.a * val.a + val.b * val.b), h: Hue(hue: arctan2(val.b, val.a)), o: val.o)


proc cart *(val: LCHFloat): LABFloat {.inline.} =
    LABFloat(l: val.l, a: val.c * cos(val.h.hue), b: val.c * sin(val.h.hue))

proc cart *(val: OLCHFloat): OLABFloat {.inline.} =
    OLABFloat(l: val.l, a: val.c * cos(val.h.hue), b: val.c * sin(val.h.hue), o: val.o)

proc LCHtoLAB *(val: LCHFloat): LABFloat {.inline.} =
    LABFloat(l: val.l, a: val.c * cos(val.h.hue), b: val.c * sin(val.h.hue))

proc LCHtoLAB *(val: OLCHFloat): OLABFloat {.inline.} =
    OLABFloat(l: val.l, a: val.c * cos(val.h.hue), b: val.c * sin(val.h.hue), o: val.o)


proc nonlin *(val: float): float {.inline.} =
    if val < 0.0031308:
        result = 12.92 * val
    else:
        result = 1.055 * pow(val, inv2_4) - 0.055

proc nonlin *(val: RGBLinearFloat): RGBNonLinearFloat {.inline.} =
    RGBNonLinearFloat(r: nonlin(val.r), g: nonlin(val.g), b: nonlin(val.b))

proc nonlin *(val: ORGBLinearFloat): ORGBNonLinearFloat {.inline.} =
    ORGBNonLinearFloat(r: nonlin(val.r), g: nonlin(val.g), b: nonlin(val.b), o: val.o)

proc nonlin *(r: float, g: float, b: float): RGBNonLinearFloat {.inline.} =
    RGBNonLinearFloat(r: nonlin(r), g: nonlin(g), b: nonlin(b))

proc nonlin *(r: float, g: float, b: float, o: float): ORGBNonLinearFloat {.inline.} =
    ORGBNonLinearFloat(r: nonlin(r), g: nonlin(g), b: nonlin(b), o: o)


proc lin *(val: float): float {.inline.} =
    if val < 0.04045:
        result = val * inv12_92
    else:
        result = pow((val + 0.055) * inv1_055, 2.4)

proc lin *(val: RGBNonLinearFloat): RGBLinearFloat {.inline.} =
    RGBLinearFloat(r: lin(val.r), g: lin(val.g), b: lin(val.b))

proc lin *(val: ORGBNonLinearFloat): ORGBLinearFloat {.inline.} =
    ORGBLinearFloat(r: lin(val.r), g: lin(val.g), b: lin(val.b), o: val.o)

proc lin *(r: float, g: float, b: float): RGBLinearFloat {.inline.} =
    RGBLinearFloat(r: lin(r), g: lin(g), b: lin(b))

proc lin *(r: float, g: float, b: float, o: float): ORGBLinearFloat {.inline.} =
    ORGBLinearFloat(r: lin(r), g: lin(g), b: lin(b), o: o)


proc simpleClipToInt8 *(val: float): int8 =
    int8(max(min(val, 1), 0))

proc floatToIntClipEach *(val: RGBLinearFloat): RGBLinearInt8 {.inline} =
    RGBLinearInt8(r: simpleClipToInt8(val.r), g: simpleClipToInt8(val.g), b: simpleClipToInt8(val.b))

proc floatToIntClipEach *(val: ORGBLinearFloat): ORGBLinearInt8 {.inline} =
    ORGBLinearInt8(r: simpleClipToInt8(val.r), g: simpleClipToInt8(val.g), b: simpleClipToInt8(val.b), o: simpleClipToInt8(val.o))

proc floatToIntClipEach *(val: RGBNonLinearFloat): RGBNonLinearInt8 {.inline} =
    RGBNonLinearInt8(r: simpleClipToInt8(val.r), g: simpleClipToInt8(val.g), b: simpleClipToInt8(val.b))

proc floatToIntClipEach *(val: ORGBNonLinearFloat): ORGBNonLinearInt8 {.inline} =
    ORGBNonLinearInt8(r: simpleClipToInt8(val.r), g: simpleClipToInt8(val.g), b: simpleClipToInt8(val.b), o: simpleClipToInt8(val.o))


proc int8ToFloat *(val: int8): float =
    float(val) * inv256

proc intToFloatClipEach *(val: RGBLinearInt8): RGBLinearFloat {.inline} =
    RGBLinearFloat(r: int8ToFloat(val.r), g: int8ToFloat(val.g), b: int8ToFloat(val.b))

proc intToFloatClipEach *(val: ORGBLinearInt8): ORGBLinearFloat {.inline} =
    ORGBLinearFloat(r: int8ToFloat(val.r), g: int8ToFloat(val.g), b: int8ToFloat(val.b), o: int8ToFloat(val.o))

proc intToFloatClipEach *(val: RGBNonLinearInt8): RGBNonLinearFloat {.inline} =
    RGBNonLinearFloat(r: int8ToFloat(val.r), g: int8ToFloat(val.g), b: int8ToFloat(val.b))

proc intToFloatClipEach *(val: ORGBNonLinearInt8): ORGBNonLinearFloat {.inline} =
    ORGBNonLinearFloat(r: int8ToFloat(val.r), g: int8ToFloat(val.g), b: int8ToFloat(val.b), o: int8ToFloat(val.o))


proc linRGBToOklab_sRGB_ref *(val: RGBLinearFloat): LABFloat {.inline.} =
    let l = cbrt(0.4122214708'f64 * val.r + 0.5363325363'f64 * val.g + 0.0514459929'f64 * val.b)
    let m = cbrt(0.2119034982'f64 * val.r + 0.6806995451'f64 * val.g + 0.1073969566'f64 * val.b)
    let s = cbrt(0.0883024619'f64 * val.r + 0.2817188376'f64 * val.g + 0.6299787005'f64 * val.b)

    result = LABFloat(
        l: 0.2104542553'f64 * l + 0.7936177850'f64 * m - 0.0040720468'f64 * s,
        a: 1.9779984951'f64 * l - 2.4285922050'f64 * m + 0.4505937099'f64 * s,
        b: 0.0259040371'f64 * l + 0.7827717662'f64 * m - 0.8086757660'f64 * s
    )

proc linRGBToOklab_sRGB_ref *(val: ORGBLinearFloat): OLABFloat {.inline.} =
    let l = cbrt(0.4122214708'f64 * val.r + 0.5363325363'f64 * val.g + 0.0514459929'f64 * val.b)
    let m = cbrt(0.2119034982'f64 * val.r + 0.6806995451'f64 * val.g + 0.1073969566'f64 * val.b)
    let s = cbrt(0.0883024619'f64 * val.r + 0.2817188376'f64 * val.g + 0.6299787005'f64 * val.b)

    result = OLABFloat(
        l: 0.2104542553'f64 * l + 0.7936177850'f64 * m - 0.0040720468'f64 * s,
        a: 1.9779984951'f64 * l - 2.4285922050'f64 * m + 0.4505937099'f64 * s,
        b: 0.0259040371'f64 * l + 0.7827717662'f64 * m - 0.8086757660'f64 * s,
        o: val.o
    )


proc oklabToLinRGB_sRGB_ref *(val: LABFloat): RGBLinearFloat =
    let l = val.l + 0.3963377774'f64 * val.a + 0.2158037573'f64 * val.b
    let m = val.l - 0.1055613458'f64 * val.a - 0.0638541728'f64 * val.b
    let s = val.l - 0.0894841775'f64 * val.a - 1.2914855480'f64 * val.b

    let l_cubed = l * l * l
    let m_cubed = m * m * m
    let s_cubed = s * s * s

    result = RGBLinearFloat(
        r: 4.0767416621'f64 * l_cubed - 3.3077115913'f64 * m_cubed + 0.2309699292'f64 * s_cubed,
        g: -1.2684380046'f64 * l_cubed + 2.6097574011'f64 * m_cubed - 0.3413193965'f64 * s_cubed,
        b: -0.0041960863'f64 * l_cubed - 0.7034186147'f64 * m_cubed + 1.7076147010'f64 * s_cubed
    )

proc oklabToLinRGB_sRGB_ref *(val: OLABFloat): ORGBLinearFloat =
    let l = val.l + 0.3963377774'f64 * val.a + 0.2158037573'f64 * val.b
    let m = val.l - 0.1055613458'f64 * val.a - 0.0638541728'f64 * val.b
    let s = val.l - 0.0894841775'f64 * val.a - 1.2914855480'f64 * val.b

    let l_cubed = l * l * l
    let m_cubed = m * m * m
    let s_cubed = s * s * s

    result = ORGBLinearFloat(
        r: 4.0767416621'f64 * l_cubed - 3.3077115913'f64 * m_cubed + 0.2309699292'f64 * s_cubed,
        g: -1.2684380046'f64 * l_cubed + 2.6097574011'f64 * m_cubed - 0.3413193965'f64 * s_cubed,
        b: -0.0041960863'f64 * l_cubed - 0.7034186147'f64 * m_cubed + 1.7076147010'f64 * s_cubed,
        o: val.o
    )


proc linRGBToOklab_sRGB_svgeesus *(val: RGBLinearFloat): LABFloat {.inline.} =
    let l = cbrt(0.4121764591770371'f64 * val.r + 0.5362739742695891'f64 * val.g + 0.05144037229550143'f64 * val.b)
    let m = cbrt(0.21190919958804857'f64 * val.r + 0.6807178709823131'f64 * val.g + 0.10739984387775398'f64 * val.b)
    let s = cbrt(0.08834481407213204'f64 * val.r + 0.28185396309857735'f64 * val.g + 0.6302808688015096'f64 * val.b)

    result = LABFloat(
        l: 0.2104542553'f64 * l + 0.7936177850'f64 * m - 0.0040720468'f64 * s,
        a: 1.9779984951'f64 * l - 2.4285922050'f64 * m + 0.4505937099'f64 * s,
        b: 0.0259040371'f64 * l + 0.7827717662'f64 * m - 0.8086757660'f64 * s
    )

proc linRGBToOklab_sRGB_svgeesus *(val: ORGBLinearFloat): OLABFloat {.inline.} =
    let l = cbrt(0.4121764591770371'f64 * val.r + 0.5362739742695891'f64 * val.g + 0.05144037229550143'f64 * val.b)
    let m = cbrt(0.21190919958804857'f64 * val.r + 0.6807178709823131'f64 * val.g + 0.10739984387775398'f64 * val.b)
    let s = cbrt(0.08834481407213204'f64 * val.r + 0.28185396309857735'f64 * val.g + 0.6302808688015096'f64 * val.b)

    result = OLABFloat(
        l: 0.2104542553'f64 * l + 0.7936177850'f64 * m - 0.0040720468'f64 * s,
        a: 1.9779984951'f64 * l - 2.4285922050'f64 * m + 0.4505937099'f64 * s,
        b: 0.0259040371'f64 * l + 0.7827717662'f64 * m - 0.8086757660'f64 * s,
        o: val.o
    )


proc oklabToLinRGB_sRGB_svgeesus *(val: LABFloat): RGBLinearFloat =
    let l = val.l + 0.3963377774'f64 * val.a + 0.2158037573'f64 * val.b
    let m = val.l - 0.1055613458'f64 * val.a - 0.0638541728'f64 * val.b
    let s = val.l - 0.0894841775'f64 * val.a - 1.2914855480'f64 * val.b

    let l_cubed = l * l * l
    let m_cubed = m * m * m
    let s_cubed = s * s * s

    result = RGBLinearFloat(
        r: 4.0771868237173135444'f64 * l_cubed - 3.3076225216643627309'f64 * m_cubed + 0.23085919548795198229'f64 * s_cubed,
        g: -1.2685764914005098651'f64 * l_cubed + 2.6096871144850084836'f64 * m_cubed - 0.34115574866072784699'f64 * s_cubed,
        b: -0.0041965422316564007124'f64 * l_cubed - 0.70339967610102697313'f64 * m_cubed + 1.706796033865412852'f64 * s_cubed
    )

proc oklabToLinRGB_sRGB_svgeesus *(val: OLABFloat): ORGBLinearFloat =
    let l = val.l + 0.3963377774'f64 * val.a + 0.2158037573'f64 * val.b
    let m = val.l - 0.1055613458'f64 * val.a - 0.0638541728'f64 * val.b
    let s = val.l - 0.0894841775'f64 * val.a - 1.2914855480'f64 * val.b

    let l_cubed = l * l * l
    let m_cubed = m * m * m
    let s_cubed = s * s * s

    result = ORGBLinearFloat(
        r: 4.0771868237173135444'f64 * l_cubed - 3.3076225216643627309'f64 * m_cubed + 0.23085919548795198229'f64 * s_cubed,
        g: -1.2685764914005098651'f64 * l_cubed + 2.6096871144850084836'f64 * m_cubed - 0.34115574866072784699'f64 * s_cubed,
        b: -0.0041965422316564007124'f64 * l_cubed - 0.70339967610102697313'f64 * m_cubed + 1.706796033865412852'f64 * s_cubed,
        o: val.o
    )


type
    IndexRGB* = enum
        red, green, blue

    IndexLMS* = enum
        l, m, s

    OklabConversionMatrix* = object # rgb then xyz
        toLMS*: array[IndexLMS.l .. IndexLMS.s, array[IndexRGB.red .. IndexRGB.blue, float64]]
        fromLMS*: array[IndexRGB.red .. IndexRGB.blue, array[IndexLMS.l .. IndexLMS.s, float64]]


let convMatrix_ref = OklabConversionMatrix(
toLMS: [
    [0.4122214708'f64,               0.5363325363'f64,               0.0514459929'f64],
    [0.2119034982'f64,               0.6806995451'f64,               0.1073969566'f64],
    [0.0883024619'f64,               0.2817188376'f64,               0.6299787005'f64]],
fromLMS: [
    [ 4.0767416621'f64,             -3.3077115913'f64,               0.2309699292'f64],
    [-1.2684380046'f64,              2.6097574011'f64,              -0.3413193965'f64],
    [-0.0041960863'f64,             -0.7034186147'f64,               1.7076147010'f64]]
)

let convMatrix_svgeesus = OklabConversionMatrix(
toLMS: [
    [0.4121764591770371'f64,         0.5362739742695891'f64,         0.05144037229550143'f64],
    [0.21190919958804857'f64,        0.6807178709823131'f64,         0.10739984387775398'f64],
    [0.08834481407213204'f64,        0.28185396309857735'f64,        0.6302808688015096'f64]],
fromLMS: [
    [ 4.0771868237173135444'f64,    -3.3076225216643627309'f64,      0.23085919548795198229'f64],
    [-1.2685764914005098651'f64,     2.6096871144850084836'f64,     -0.34115574866072784699'f64],
    [-0.0041965422316564007124'f64, -0.70339967610102697313'f64,     1.706796033865412852'f64]]
)


proc linRGBToOklab_variable *(val: RGBLinearFloat, matrix: OklabConversionMatrix): LABFloat {.inline.} =
    let l = cbrt(matrix.toLMS[IndexLMS.l][red] * val.r + matrix.toLMS[IndexLMS.l][green] * val.g + matrix.toLMS[IndexLMS.l][blue] * val.b)
    let m = cbrt(matrix.toLMS[IndexLMS.m][red] * val.r + matrix.toLMS[IndexLMS.m][green] * val.g + matrix.toLMS[IndexLMS.m][blue] * val.b)
    let s = cbrt(matrix.toLMS[IndexLMS.s][red] * val.r + matrix.toLMS[IndexLMS.s][green] * val.g + matrix.toLMS[IndexLMS.s][blue] * val.b)

    result = LABFloat(
        l: 0.2104542553'f64 * l + 0.7936177850'f64 * m - 0.0040720468'f64 * s,
        a: 1.9779984951'f64 * l - 2.4285922050'f64 * m + 0.4505937099'f64 * s,
        b: 0.0259040371'f64 * l + 0.7827717662'f64 * m - 0.8086757660'f64 * s
    )

proc linRGBToOklab_variable *(val: ORGBLinearFloat, matrix: OklabConversionMatrix): OLABFloat {.inline.} =
    let l = cbrt(matrix.toLMS[IndexLMS.l][red] * val.r + matrix.toLMS[IndexLMS.l][green] * val.g + matrix.toLMS[IndexLMS.l][blue] * val.b)
    let m = cbrt(matrix.toLMS[IndexLMS.m][red] * val.r + matrix.toLMS[IndexLMS.m][green] * val.g + matrix.toLMS[IndexLMS.m][blue] * val.b)
    let s = cbrt(matrix.toLMS[IndexLMS.s][red] * val.r + matrix.toLMS[IndexLMS.s][green] * val.g + matrix.toLMS[IndexLMS.s][blue] * val.b)

    result = OLABFloat(
        l: 0.2104542553'f64 * l + 0.7936177850'f64 * m - 0.0040720468'f64 * s,
        a: 1.9779984951'f64 * l - 2.4285922050'f64 * m + 0.4505937099'f64 * s,
        b: 0.0259040371'f64 * l + 0.7827717662'f64 * m - 0.8086757660'f64 * s,
        o: val.o
    )


proc oklabToLinRGB_variable *(val: LABFloat, matrix: OklabConversionMatrix): RGBLinearFloat =
    let l = val.l + 0.3963377774'f64 * val.a + 0.2158037573'f64 * val.b
    let m = val.l - 0.1055613458'f64 * val.a - 0.0638541728'f64 * val.b
    let s = val.l - 0.0894841775'f64 * val.a - 1.2914855480'f64 * val.b

    let l_cubed = l * l * l
    let m_cubed = m * m * m
    let s_cubed = s * s * s

    result = RGBLinearFloat(
        r: matrix.fromLMS[red][IndexLMS.l] * l_cubed + matrix.fromLMS[red][IndexLMS.m] * m_cubed + matrix.fromLMS[red][IndexLMS.s] * s_cubed,
        g: matrix.fromLMS[green][IndexLMS.l] * l_cubed + matrix.fromLMS[green][IndexLMS.m] * m_cubed + matrix.fromLMS[green][IndexLMS.s] * s_cubed,
        b: matrix.fromLMS[blue][IndexLMS.l] * l_cubed + matrix.fromLMS[blue][IndexLMS.m] * m_cubed + matrix.fromLMS[blue][IndexLMS.s] * s_cubed
    )

proc oklabToLinRGB_variable *(val: OLABFloat, matrix: OklabConversionMatrix): ORGBLinearFloat =
    let l = val.l + 0.3963377774'f64 * val.a + 0.2158037573'f64 * val.b
    let m = val.l - 0.1055613458'f64 * val.a - 0.0638541728'f64 * val.b
    let s = val.l - 0.0894841775'f64 * val.a - 1.2914855480'f64 * val.b

    let l_cubed = l * l * l
    let m_cubed = m * m * m
    let s_cubed = s * s * s

    result = ORGBLinearFloat(
        r: matrix.fromLMS[red][IndexLMS.l] * l_cubed + matrix.fromLMS[red][IndexLMS.m] * m_cubed + matrix.fromLMS[red][IndexLMS.s] * s_cubed,
        g: matrix.fromLMS[green][IndexLMS.l] * l_cubed + matrix.fromLMS[green][IndexLMS.m] * m_cubed + matrix.fromLMS[green][IndexLMS.s] * s_cubed,
        b: matrix.fromLMS[blue][IndexLMS.l] * l_cubed + matrix.fromLMS[blue][IndexLMS.m] * m_cubed + matrix.fromLMS[blue][IndexLMS.s] * s_cubed,
        o: val.o
    )
