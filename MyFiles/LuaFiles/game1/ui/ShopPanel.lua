---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by justi.
--- DateTime: 2024/6/20 10:36
---

local ShopPanel =class("ShopPanel",UIPanel);

function ShopPanel:awake()
    ShopPanel.super.awake(self);
    print("ShopPanel awake");
end

return ShopPanel;