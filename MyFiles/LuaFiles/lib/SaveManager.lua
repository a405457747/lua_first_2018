
-- Author: skyAllen
-- Date: 2023-09-07 15:01:08
-- Email: 894982165@qq.com
-- Copyright: © 2023 skyAllen

---@class SaveManager
local SaveManager = class("SaveManager");

function SaveManager.Init()
    SaveManager.Load();
end

function SaveManager.Save()
    local data_str = js.stringify(saveData);
    UnityEngine.PlayerPrefs.SetString("player_data", data_str);
end

function SaveManager._GetString()
    return UnityEngine.PlayerPrefs.GetString("player_data");
end

function SaveManager.Load()
    local data_str = UnityEngine.PlayerPrefs.GetString("player_data", "");
    --print("data_str is", data_str)
    if data_str == "" then
        saveData = {
            userSet = {
                _musicEnable = true,
                _soundEnable = true,
            },
            testObj = 1;
        }
    else
        saveData = js.parse(data_str);
    end
end

function SaveManager.test()
    if UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.S) then
        saveData.testObj = saveData.testObj + 1;
        SaveManager.Save();
        print("save success ", saveData.testObj);
        print(SaveManager._GetString());
    end
end

return SaveManager
