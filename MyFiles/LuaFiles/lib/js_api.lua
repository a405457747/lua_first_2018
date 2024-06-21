local js={}

function js.push(t,...)
    local arg={...};
    for i, v in ipairs(arg) do
        table.insert(t,v);
    end
    return #t;
end

function js.pop(t)
    local res =t[#t];
    table.remove(t);
    return res;
end

function js.at(t,idx)
    local item =t[idx];
    return item;
end

function js.unshift(t,...)
    local arg ={...};

    for i = #arg, 1 do
        table.insert(t,1,arg[i]);
    end

    return #t;
end

function js.reverse(arr)
    local l = 1;
    local r = #arr;

    while l < r do
        arr[l], arr[r] = arr[r], arr[l];
        l = l + 1;
        r = r - 1;
    end
end

function js.shift(t)
    local res = table.remove(t, 1);
    return res;
end

function js.forEach(t, func)
    for i = 1, #t do
        func(t[i], i, t);
    end
end

function js.concat(t,t2)
    local t3={};
    for i, v in ipairs(t) do
        t3[#t3+1]=v;
    end
    for i,v in ipairs(t2) do
        t3[#t3+1]=v;
    end
    return t3;
end

function js.map(t, func)
    local res = {};
    for i = 1, #t do
        res[i] = func(t[i]);
    end
    return res;
end

function js.splice(array, index, count)
    -- 存储被删除的元素
    local removedItems = {}

    -- 从数组中删除元素
    for i = 1, count do
        table.insert(removedItems, array[index]) -- 将被删除的元素添加到 removedItems 数组中
        table.remove(array, index) -- 删除指定位置的
    end

    -- 返回被删除的元素
    return removedItems
end

 function js.slice(array, startIndex, endIndex)
    -- 如果未提供 endIndex，则设置为数组长度
    endIndex = endIndex or (#array);

    -- 存储切片后的元素
    local slicedItems = {}

     for i = startIndex, endIndex do
         slicedItems[#slicedItems+1]=array[i];
     end

    return slicedItems
end

function  js.reduce(array, callback, initialValue)
    local accumulator = initialValue
    local startIndex = 1

    if initialValue == nil then
        accumulator = array[1]
        startIndex = 2
    end

    for i = startIndex, #array do
        accumulator = callback(accumulator, array[i], i, array)
    end

    return accumulator
end

function js.includes(t,val)
    for i, v in ipairs(t) do
        if(v==val)then
            return true;
        end
    end
    return false;
end

function js.filter(t, func)
    local res = {};
    for i = 1, #t do
        local item = t[i];
        if (func(item)) then
            table.insert(res, item);
        end
    end
    return res;
end

function js.find(array, callback)
    for _, value in ipairs(array) do
        if callback(value) then
            return value
        end
    end
    return nil
end

function js.indexOf(t, val)
    for i = 1, #t do
        if (t[i] == val) then
            return i;
        end
    end
    return 0;
end


function js.entries(hash)

    local res = {}
    for i, v in pairs(hash) do
        local temp = {};
        table.insert(temp, i);
        table.insert(temp, v);
        table.insert(res, temp);
    end
    return res;

end

function js.keys(hash)
    local res = {}
    for i, v in pairs(hash) do
        res[#res + 1] = i;
    end
    return res;
end

function js.values(hash)

    local res = {}
    for i, v in pairs(hash) do
        res[#res + 1] = v;
    end
    return res;
end

function js.hasOwnProperty(hash, key)
    for i, v in pairs(hash) do
        if (i == key) then
            return true;
        end
    end
    return false;
end

function js.every(arr, fn)
    local res = {};
    for i, v in ipairs(arr) do
        if fn(v) then
            res[#res + 1] = v;
        end
    end
    return res;
end

function js.some(arr, fn)
    for i, v in ipairs(arr) do
        if fn(v) then
            return true;
        end
    end
    return false;
end

function js.flat(array)
    local flattened = {}

    local function flatten(arr)
        for _, value in ipairs(arr) do
            if type(value) == "table" then
                flatten(value)
            else
                table.insert(flattened, value)
            end
        end
    end

    flatten(array)

    return flattened
end

function js.join(arr,flag)
    flag =flag or"";
    return table.concat(arr,flag);
end

function js.stringify(obj)
    local lua = ""
    local t = type(obj)
    if t == "number" then
        lua = lua .. obj
    elseif t == "boolean" then
        lua = lua .. tostring(obj)
    elseif t == "string" then
        lua = lua .. string.format("%q", obj)
    elseif t == "table" then
        lua = lua .. "{\n"
        for k, v in pairs(obj) do
            lua = lua .. "[" .. js.stringify(k) .. "]=" .. js.stringify(v) .. ",\n"
        end
        local metatable = getmetatable(obj)
        if metatable ~= nil and type(metatable.__index) == "table" then
            for k, v in pairs(metatable.__index) do
                lua = lua .. "[" .. js.stringify(k) .. "]=" .. js.stringify(v) .. ",\n"
            end
        end
        lua = lua .. "}"
    elseif t == "nil" then
        return nil
    else
        error("can not serialize a " .. t .. " type.")
    end
    return lua
end

function js.parse(lua)
    local t = type(lua)
    if t == "nil" or lua == "" then
        return nil
    elseif t == "number" or t == "string" or t == "boolean" then
        lua = tostring(lua)
    else
        error("can not unserialize a " .. t .. " type.")
    end
    lua = "return " .. lua
    local func = loadstring(lua);
    if func == nil then
        return nil
    end
    return func()
end

local function test()
    local a={3,4,5,6};
    --print("sum is",js.reduce(a,function (a,b) return a+b end));
    --local b =js.splice(a,2,2);--3679;
    --print(js.join(a))
    --local a2=js.slice(a,1,1);
    --local a3=js.slice(a,1,2);
    --local a4=js.slice(a,1);
    --print(js.join(a3),js.join(a4));
    --print(js.join(a2).."ss");
end
test();
return js;