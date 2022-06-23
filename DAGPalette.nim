import oklabColor

type
    DDAGLinkKind* = enum
        dlkNoLink,
        dlkOneLink,
        dlkListLink
        # dlkBidirectional,
        # dlkUniUp,
        # dlkUniDown,
        # dlkNone

    DDAGLinkVariant* = object
        case kind: DDAGLinkKind:
            of dlkNoLink:
                discard
            of dlkOneLink:
                node: DDAGNode
            of dlkListLink:
                list: seq[DDAGNode]

    DDAGNode* = ref object  # doubly directed acyclic graph node
        up: DDAGLinkVariant
        down: DDAGLinkVariant
        color: LCHFloat
        index_fromUp: int
        index_fromDown: int

proc insert_up(node: DDAGNode, add: DDAGNode): bool =
    var up: DDAGNode
    case node.up.kind:
        of dlkNoLink:
            node.up = DDAGLinkVariant(kind: dlkOneLink, node: add)
            add.down = DDAGLinkVariant(kind: dlkOneLink, node: node)
            return true
        of dlkOneLink:
            up = node.up.node
            node.up.node = add
            add.down = DDAGLinkVariant(kind: dlkOneLink, node: node)
        of dlkListLink:
            return false
    case up.down.kind:
        of dlkNoLink:
            return false
        of dlkOneLink:
            up.down.node = add
            add.up = DDAGLinkVariant(kind: dlkOneLink, node: up)
            return true
        of dlkListLink:
            return false

proc insert_down(node: DDAGNode, add: DDAGNode): bool =
    var down: DDAGNode
    case node.down.kind:
        of dlkNoLink:
            node.down = DDAGLinkVariant(kind: dlkOneLink, node: add)
            add.up = DDAGLinkVariant(kind: dlkOneLink, node: node)
            return true
        of dlkOneLink:
            down = node.down.node
            node.down.node = add
            add.up = DDAGLinkVariant(kind: dlkOneLink, node: node)
        of dlkListLink:
            return false
    case down.up.kind:
        of dlkNoLink:
            return false
        of dlkOneLink:
            down.up.node = add
            add.down = DDAGLinkVariant(kind: dlkOneLink, node: down)
            return true
        of dlkListLink:
            return false

proc insert_up(node: DDAGNode, index: int, add: DDAGNode): bool =
    var up: DDAGNode
    case node.up.kind:
        of dlkNoLink:
            node.up = DDAGLinkVariant(kind: dlkOneLink, node: add)
            add.down = DDAGLinkVariant(kind: dlkOneLink, node: node)
            return true
        of dlkOneLink:
            up = node.up.node
            node.up.node = add
        of dlkListLink:
            up = node.up.list[index]
            node.up.list[index] = add
            add.index_fromDown = index
    add.down = DDAGLinkVariant(kind: dlkOneLink, node: node)
    case up.down.kind:
        of dlkNoLink:
            return false
        of dlkOneLink:
            up.down.node = add
            add.up = DDAGLinkVariant(kind: dlkOneLink, node: up)
            return true
        of dlkListLink:
            up.down.list[index] = add
            add.index_fromUp = index
            add.up = DDAGLinkVariant(kind: dlkOneLink, node: up)
            return true

proc insert_down(node: DDAGNode, index: int, add: DDAGNode): bool =
    var down: DDAGNode
    case node.down.kind:
        of dlkNoLink:
            node.down = DDAGLinkVariant(kind: dlkOneLink, node: add)
            add.up = DDAGLinkVariant(kind: dlkOneLink, node: node)
            return true
        of dlkOneLink:
            down = node.down.node
            node.down.node = add
        of dlkListLink:
            down = node.down.list[index]
            node.down.list[index] = add
            add.index_fromDown = index
    add.up = DDAGLinkVariant(kind: dlkOneLink, node: node)
    case down.up.kind:
        of dlkNoLink:
            return false
        of dlkOneLink:
            down.up.node = add
            add.down = DDAGLinkVariant(kind: dlkOneLink, node: down)
            return true
        of dlkListLink:
            down.up.list[index] = add
            add.index_fromUp = index
            add.down = DDAGLinkVariant(kind: dlkOneLink, node: down)
            return true