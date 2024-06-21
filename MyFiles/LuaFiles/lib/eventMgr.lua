local eventMgr={}

local container = {};

local function addEvent(event_type, callback)
    if container[event_type] == nil then
        local callbacks = {};
        callbacks[#callbacks+1]=callback;
        container[event_type] = callbacks;
    else
        local callbacks = container[event_type];
        callbacks[#callbacks+1]=callback;
    end
end;

local function delEvent(event_type, callback)
    if container[event_type] == nil then
        print("Waring The event type is nil");
    else
        local callbacks = container[event_type];

        for i, v in ipairs(callbacks) do
            if(callback==v)then
                table.remove(callbacks,i);
                break;
            end
        end

    end
end

local function sendEvent(event_type, ...)
    local callbacks = container[event_type];

    for i, v in ipairs(callbacks) do
        v(...);
    end
end

eventMgr.addEvent=addEvent;
eventMgr.delEvent=delEvent;
eventMgr.sendEvent=sendEvent;

return eventMgr;