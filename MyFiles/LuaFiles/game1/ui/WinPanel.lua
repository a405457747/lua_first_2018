---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by justi.
--- DateTime: 2024/6/20 10:36
---

local WinPanel =class("WinPanel",UIPanel);

function WinPanel:awake()
    WinPanel.super.awake(self);
    print("win awake");
end

return WinPanel;