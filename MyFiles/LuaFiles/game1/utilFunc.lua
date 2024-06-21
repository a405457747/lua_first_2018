local utilFunc={}

utilFunc.numFormat=string.formatnumberthousands;

function utilFunc.clearArr(array)
    while (#array >0) do
        table.remove(array);
    end
end

function utilFunc.removeItem(arr,item)
    for i, v in ipairs(arr) do
        if(item==v)then
            table.remove(arr,i);
            break;
        end
    end
end

function utilFunc.shuffle(array)
    local length = #array
    for i = length, 2, -1 do
        local j = math.random(i)
        array[i], array[j] = array[j], array[i]
    end
end

function utilFunc.arrToHash(cards)

    local count = {}
    for _, card in ipairs(cards) do
        if count[card] then
            count[card] = count[card] + 1
        else
            count[card] = 1
        end
    end
    return count;
end

function utilFunc.print_arr(arr, other)
    local str = "";

    for i = 1, #arr do
        local interval = (i == #arr) and "" or ",";
        str = str .. tostring(arr[i]) .. interval;
    end
    if other then
        print(string.format("[%s]%s",str,other))
    else
        print(string.format("[%s]",str))
    end
end

function utilFunc.readOnlyTable(t)
    local res = {}
    setmetatable(res, {
        __index = t,
        __newindex = function(t, _)
            error("Readonly " .. _, 2);
        end
    })
    return res;
end

function utilFunc.global(key, val)
    rawset(_G, key, val or false);
end

function utilFunc.randomSeed()
    math.randomseed(tostring(os.time()):reverse():sub(1, 7));
end

function utilFunc.print_hash(hash,other)

    if hash[1] then
        error("Don't support key is number 1.")
    end
    print(js.stringify(hash),other);
end

local function test()
    local d={3,2,1};
    local d2={a=3,b=4}
    --utilFunc.print_arr(d,"dddd");
    --utilFunc.print_hash(d2,"dddd2");
end
test();
return utilFunc;