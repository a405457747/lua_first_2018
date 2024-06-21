local qa={}

function qa.num(val);
    assert(type(val)=="number",tostring(val)..":is not number");
end
function qa.str(val);
    assert(type(val)=="string",tostring(val)..":is not string");
end
function qa.bool(val);
    assert(type(val)=="boolean",tostring(val)..":is not boolean");
end
function qa.tab(val);
    assert(type(val)=="table",tostring(val)..":is not table");
end
function qa.arg(arr,typeStrArr)
    --bp_debug();
    for i = 1, #arr do
        local val =arr[i];
        local tVal =typeStrArr[i];
        qa[tVal](val);
    end
end

function qa.all(arr,typeStr)
    for i = 1, #arr do
        local val =arr[i];
        qa[typeStr](val);
    end
end

function qa.assertAll(...)
    local arg ={...};
    for i, v in ipairs(arg) do
        assert(v);
    end
end

local function test()
    qa.num(3);
    qa.bool(true,"bool");
    qa.arg({3,"3",true,{}},{"num","str","bool","tab"});
    qa.all({3,2,1,5},"num");
end
test();
return qa;