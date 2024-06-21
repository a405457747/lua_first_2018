local ue ={};

UnityEngine= CS.UnityEngine;
GameObject = CS.UnityEngine.GameObject;
Transform = CS.UnityEngine.Transform;
RectTransform = CS.UnityEngine.RectTransform;
Vector3 = CS.UnityEngine.Vector3;
Vector2 = CS.UnityEngine.Vector2;
UI = CS.UnityEngine.UI;
Canvas = CS.UnityEngine.Canvas
CanvasGroup = CS.UnityEngine.CanvasGroup;
Time = CS.UnityEngine.Time;
Random = CS.UnityEngine.Random;
Quaternion = CS.UnityEngine.Quaternion;
Physics2D = CS.UnityEngine.Physics2D;
Resources = CS.UnityEngine.Resources;
SceneManager = CS.UnityEngine.SceneManagement.SceneManager;
Text = CS.UnityEngine.UI.Text;
Sprite =CS.UnityEngine.Sprite;
Image = CS.UnityEngine.UI.Image;
Color = CS.UnityEngine.Color;
WaitForSeconds = CS.UnityEngine.WaitForSeconds;
--[[


SpriteRenderer = CS.UnityEngine.SpriteRenderer;
Button = CS.UnityEngine.UI.Button;
Text = CS.UnityEngine.UI.Text;
AudioSource = CS.UnityEngine.AudioSource;

InputField = CS.UnityEngine.UI.InputField;
Input = CS.UnityEngine.Input;

Slider = CS.UnityEngine.UI.Slider;

WaitForEndOfFrame = CS.UnityEngine.WaitForEndOfFrame;
WaitUntil = CS.UnityEngine.WaitUntil;
Application = CS.UnityEngine.Application;
--]]


local loadGo = function(path)
    return Resources.Load(path,typeof(GameObject));
end;
ue.loadGo=loadGo;

local loadAll=function(path,loadType)
    loadType =loadType or UnityEngine.GameObject;
    local all=Resources.LoadAll(path,typeof(loadType));

    local t ={};

    for i = 1, all.Length do
        t[#t+1]=all[i-1];
    end

    return t;
end
ue.loadAll=loadAll;

local loadSp=function(path)
    return Resources.Load(path,typeof( UnityEngine.Sprite));
end
ue.loadSp=loadSp;

local loadAudio = function(path)
    error("wait audio");
end
ue.loadAudio=loadAudio;

local loadScene = function(name)
    SceneManager.LoadScene(name);
end
ue.loadScene=loadScene;

local showGo = function(go)
    go:SetActive(true);
end
ue.showGo=showGo;

local hideGo = function(go)
    go:SetActive(false);
end
ue.hideGo=hideGo;

local transChilds = function(transParent)--这个不包括自己的呢，不要多用哦
    local transList = {};

    for i = 1, transParent.childCount do
        transList[#transList+1]=transParent:GetChild(i-1);
    end

    return transList;
end
ue.transChilds=transChilds;

local getComps=function(transParent, compType,containSelf)


    local childs = transChilds(transParent);

    local res ={};
    if(containSelf)then
        res[#res+1]=transParent:GetComponent(typeof(compType));
    end

    for i, v in ipairs(childs) do
        res[#res+1]=v;
    end
    return res;
end
ue.getComps=getComps;

local function findTransRecursion(transParent, targetName)--递归这样定义才对哦
    local transList = transChilds(transParent)

    for i, item in ipairs(transList) do
        if(item.name==targetName)then
            return item;
        else
            local res =findTransRecursion(item,targetName);
            if res ~= nil then
                return res;
            end
        end
    end

    return nil;
end
--ue.findTransRecursion=findTransRecursion;--不要暴露了

local getComp = function(go, comName)--这个go可以是trnasform，因为都有getcomponent方法
    return go:GetComponent(comName);
end
ue.getComp=getComp;

local findCompRecursion = function(transParent, targetName, compoentName)
    --bp_debug();
    --这个方法2D sprite也会用到的
    compoentName = compoentName or "Transform";

    local resTrans = nil
    --transform.name=gameObject.name
    if (transParent.name == targetName) then
        resTrans = transParent;
    else
        resTrans = findTransRecursion(transParent, targetName);
    end

    if(resTrans ==nil)then
        return nil;
    else
        return getComp(resTrans,compoentName);
    end
end
ue.findCompRecursion=findCompRecursion;



return ue;