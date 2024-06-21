local randomKit={}

local function randomItem(t)
    local idx =math.random(1,#t);
    return t[idx];
end

randomKit.randomItem=randomItem;
return randomKit;