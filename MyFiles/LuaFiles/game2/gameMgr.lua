---@class gameMgr
local gameMgr=class("gameMgr");

function gameMgr:awake()
    print("g2 awake");
end

function gameMgr:update()
    print("g2 update in unity 2018");
end

return gameMgr;