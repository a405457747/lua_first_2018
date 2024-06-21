
-- Author: skyAllen
-- Date: 2023-09-07 15:01:08
-- Email: 894982165@qq.com
-- Copyright: © 2023 skyAllen

---@class UIPanel
UIPanel = class("UIPanel");

function UIPanel:awake()
    local rect =self.go:GetComponent(typeof(RectTransform));
    self.rect =rect;
    self.rectInitY =self.rect.anchoredPosition3D.y;
end


function UIPanel:show()
    --self.go:SetActive(true)
    self.is_show = true;

    local rect =self.rect;
    rect.anchoredPosition3D =Vector3(rect.anchoredPosition3D.x,30,rect.anchoredPosition3D.z);
end

function UIPanel:hide()
    --self.go:SetActive(false)
    self.is_show = false;

    local rect =self.rect;
    rect.anchoredPosition3D =Vector3(rect.anchoredPosition3D.x,self.rectInitY,rect.anchoredPosition3D.z);
end


return UIPanel;