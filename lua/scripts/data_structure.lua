local DS = {}

local _Stack = {size = 0, data = {}}

function _Stack:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function _Stack:push(...)
    local arg = {...}
    for i, v in ipairs(arg) do
        table.insert(self.data, v)
        self.size = self.size + 1
    end
end

function _Stack:pop()
    if self.size > 0 then
        local res = table.remove(self.data)
        self.size = self.size - 1
        return res
    end
end

function _Stack:clean()
    while self.size > 0 do
        self:pop()
    end
end

function _Stack:print()
    print(self.size)
end

local _TNode = {id = nil, data = nil, child = {}, parent = nil}
function _TNode:new(o, id, data)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.id = id
    self.data = data
    return o
end
local _Tree = {nodes = {}, root = false, rootId = nil, nodesNum = 0}
function _Tree:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
function _Tree:initTree(rootId, data)
    local root = _TNode:new(nil, rootId, data)
    assert(not(self.root), "only one root!")
    self.nodes[rootId] = root
    self.root = true
    self.rootId = rootId
    self.nodesNum = self.nodesNum + 1
end
function _Tree:createNode(id, data)
    local node = _TNode:new(nil, id, data)
    return node
end
function _Tree:insertNode(node, parent)
    assert(self.root, "not init tree!")
    assert(node.id, "not a tree node!")
    assert(self.nodes[parent], "not find parent node!")
    self.nodes[node.id] = node
    self.nodes[node.id].parent = parent
    table.insert(self.nodes[parent].child, node.id)
    self.nodesNum = self.nodesNum + 1
end

function _Tree:deep()
    local deep = 0
    local child = self.nodes[self.rootId].child
    while #child do


    end 
    return deep
end


DS.stack = _Stack
DS.tree = _Tree
return DS
