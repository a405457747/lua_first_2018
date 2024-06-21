---@class gameMgr
local gameMgr=class("gameMgr");
local ver =require("game1.version");
local GamePanel=require("game1.ui.GamePanel");
local PokerCard=require("game1.common.PokerCard");
local utilFunc =require("game1.utilFunc");
local JudgeSys=require("game1.sys.JudgeSys");
local PlayerSys=require("game1.sys.PlayerSys");
local HandSort =require("game1.sys.HandSort");
local BossMgr =require("game1.sys.BossMgr");
local  JokerSys=require("game1.sys.JokerSys");
local  OtherSys=require("game1.sys.OtherSys");

local LosePanel=require("game1.ui.LosePanel");
local ShopPanel=require("game1.ui.ShopPanel");
local WinPanel=require("game1.ui.WinPanel");

gameMgr.sysList={};
gameMgr.uiList={};
---@type GamePanel
local gamePanel;
local lose_ui=false;
local shop_ui=false;
local win_ui=false;


function gameMgr:ctor(a)
    G1=self;



    self:loadAllPocker();
    --print("3"..2,"3"+2);
end

function gameMgr:awake()
    print("G1",G1,self,"awake",gameMgr,ver.ver);
end

function gameMgr:start()

    gamePanel=GamePanel.inst;
    lose_ui=LosePanel.inst;
    shop_ui=ShopPanel.inst;
    win_ui =WinPanel.inst;

    qa.assertAll(lose_ui,shop_ui,win_ui);


--[[    cs_coroutine.start(function ()
        shop_ui:show();
        coroutine.yield(WaitForSeconds(2));
        shop_ui:hide();
    end)]]


    print("gp inst",gamePanel);

    self.gameState=GAME_State.null;

    self:switchState(GAME_State.game_start_start);

end



function gameMgr:switchState(game_state)
    if(self.gameState~=game_state)then
        self.gameState=game_state;
        print("now gameState is "..enumKit.numberToEnum(GAME_State,self.gameState));
    end

--[[    game_start_start = 2,--游戏初始化
    game_ing_selectBlind = 4,--选择盲注时间
     game_ing_play=7,--玩家操控时间
        game_ing_calculate=8,--出牌后的计算
            game_win_shop = 5, --如果达到目标了，就游戏结算和商店时间和操作空间和选盲注，否则继续的玩不选盲注


    game_over = 3,--当计算后可能游戏大结束，也不能玩了
    game_bigWin = 6, --当计算后可能游戏大胜利，没有商店也没有选择盲注，也不能玩

 ]]

    if(self.gameState==GAME_State.game_start_start) then
        self:init();
    elseif(self.gameState==GAME_State.game_ing_selectBlind)then
        gamePanel:toggleBlindUI(true);
    elseif(self.gameState==GAME_State.game_ing_play)then
        --继续玩
        self:giveSomeToHand();
    elseif(self.gameState==GAME_State.game_ing_calculate)then
        self:enterCalculate();
    elseif(self.gameState==GAME_State.game_win_shop)then
        self:enterShop();
    elseif(self.gameState==GAME_State.game_over)then
        self:enterOver();
    elseif(self.gameState==GAME_State.game_bigWin)then
        self:enterBigWin();
    end
end

function gameMgr:enterShop()
    shop_ui:show();
end

function gameMgr:enterOver()
    print("enterOver");
    lose_ui:show();
end

function gameMgr:enterBigWin()
    win_ui:show();
end

function gameMgr:sortByFlower()
    HandSort.sortByFlower(self.handPokers)

    for i, v in ipairs(self.handPokers) do
        v:setSiblingIdx(i);
    end
end

function gameMgr:sortByPoint()
    local old =self.handPokers;

    HandSort.sortByPoint(self.handPokers);

    local new =self.handPokers;

    assert(old==new);

    for i, v in ipairs(self.handPokers) do
        v:setSiblingIdx(i);
    end
end

function gameMgr:loadAllPocker()
    local sp =ue.loadAll("sprite/pocker",typeof(Sprite));
    local spData ={
        hearts={},
        clubs={},
        diamonds={},
        spades={},
    }

    for i = 1, 13 do
        spData.hearts[#spData.hearts+1]=sp[i];
    end
    for i=1,13 do
        table.remove(sp,1);
    end

    for i = 1, 13 do
        spData.clubs[#spData.clubs+1]=sp[i];
    end
    for i=1,13 do
        table.remove(sp,1);
    end

    for i = 1, 13 do
        spData.diamonds[#spData.diamonds+1]=sp[i];
    end
    for i=1,13 do
        table.remove(sp,1);
    end

    for i = 1, 13 do
        spData.spades[#spData.spades+1]=sp[i];
    end
    for i=1,13 do
        table.remove(sp,1);
    end

    assert(#spData.hearts==13);
    assert(#spData.clubs==13);
    assert(#spData.diamonds==13);
    assert(#spData.spades==13);

    --print("sp len",#sp,#spData.spades);
    self.spData =spData;
end

function gameMgr:getPockerSp(point,flower)
    local arr =self.spData[flower];
    local idx =point-1;
    return arr[idx];
end

function gameMgr:getPockerSpByEnum(cPoint,cFlower)
    local point =cPoint;
    local flower  =enumKit.numberToEnum(CARD_Flower,cFlower);
    return self:getPockerSp(point,flower);
end

function gameMgr:init()

    ---@type JokerSys
    self.joker =JokerSys.new();
    self.joker:init();
    print("joker self",self.joker);

    ---@type OtherSys
    self.other =OtherSys.new();
    self.other:init();
    print("other self",self.other);

    ---@type BossMgr
    self.boss =BossMgr.new();
    self.boss:init();
    print("boss self",self.boss);

    ---@type BossMgr
    self.boss =BossMgr.new();
    self.boss:init();
    print("boss self",self.boss);

    ---@type PlayerSys
    self.player =PlayerSys.new();
    self.player:init();
    print("player self",self.player);

    --手持的卡牌
    self.handPokers={};
    --手持选择的卡牌
    self.selectPokers={};
    --准备结算的卡牌
    self.balancePokers={};
    --弃牌的卡尺
    self.dropPokerPool={};
    --计算得分用的数据
    self.calculateData={};

    self.pokerGroup= self:createPokerGroup();
    --洗牌
    utilFunc.shuffle(self.pokerGroup);

    self:switchState(GAME_State.game_ing_selectBlind);
end

--按钮的相关
--todo 发牌状态的强化。 --todo ui的隐藏  和出牌顺序还有重新排序
--发牌了
function gameMgr:sendPoker()
    if(#self.selectPokers<=0)then
        return;
    end

    local canDraw=self.player:reduceDrawPlayCount();
    if(canDraw)then
        self:switchState(GAME_State.game_ing_calculate)
    else
    end
end

function gameMgr:enterCalculate()
    self:sendAllPokerToCenter();
    print("发牌了");
    self:startCalculate();
end

--丢牌了
function gameMgr:dropPoker()
    if(#self.selectPokers<=0)then
        return;
    end

    if(not self.player:reduceDumpCount())then
        return;
    end

    --丢牌钱排序
    self:sortSelectPokersBySiblingIndex();

    while #self.selectPokers >0 do
        self:sendOnePokerToRight(1);
    end

    --todo   延迟3秒清空弃牌池

    cs_coroutine.start(function ()
        coroutine.yield(WaitForSeconds(3));
        gamePanel:delRightGo();
        utilFunc.clearArr(self.dropPokerPool);

        self:giveSomeToHand();

    end);
end

--丢牌到弃牌池子里
 function gameMgr:sendOnePokerToRight(idx)
    ---@type PokerCard
    local pokerCard=self.selectPokers[idx];
    table.remove(self.selectPokers,idx);
    --这里必须一起移除，select只是临时的
    utilFunc.removeItem(self.handPokers,pokerCard);

    table.insert(self.dropPokerPool,pokerCard);

    local go =pokerCard.go;
    gamePanel:addToRight(go);
end

function gameMgr:sortSelectPokersBySiblingIndex()

    table.sort(self.selectPokers,function (a,b)
        return a:getTransIdx()<b:getTransIdx();
    end)
end

--发牌到结算区，center就算结算区
function gameMgr:sendOnePokerToCenter(idx)
    ---@type PokerCard
    local pokerCard=self.selectPokers[idx];

    table.remove(self.selectPokers,idx);
    --这里必须一起移除，select只是临时的
    utilFunc.removeItem(self.handPokers,pokerCard);

    table.insert(self.balancePokers,pokerCard);



    local go =pokerCard.go;
    gamePanel:addToCenter(go);
end

function gameMgr:init_calculateData()
    self.calculateData.blue =0;
    self.calculateData.red =0;
    self.calculateData.typeMsg="";
    self.calculateData.lv ="";
    self.calculateData.coinPoker={};
    self.calculateData.turnCoinTotal ="";
end

--开始计算
function gameMgr:startCalculate()
    --计算一张牌
    local function caculateOne(pc)
        local point =pc:calculatePoint();
        self.calculateData.blue=self.calculateData.blue+point;
        print("筹码加了"..point);
    end

    --todo warn calPokerArr的重置关系大不大
   local calPokerArr= self.calculateData.coinPoker;

    local calTime =1.5;
    cs_coroutine.start(function()
        for i, v in ipairs(calPokerArr) do
            caculateOne(v)
            self:show_showCenterMsg();
            coroutine.yield(WaitForSeconds(calTime));
        end

        local res =self.calculateData.blue* self.calculateData.red;
        self.calculateData.turnCoinTotal=res;
        self:show_showCenterMsg();

        coroutine.yield(WaitForSeconds(calTime));
        self:init_calculateData();
        self:show_showCenterMsg();

        self:isOver(res);
    end)
end

function gameMgr:pointReachTarget()
    local curPoint =self.player:getCoinCount();
    local targetPoint =self.boss:getCurTargetScore();
     return curPoint>=targetPoint;
end

function gameMgr:isOver(point)

    self.player:addCoint(point);
    self.player:addMoneyCount(self.boss:getCurAwardDollar());
    --print("加了这么多的钱了"..point);
    --big_win默认到达不了

    if(true)then
        gamePanel:delCenterGo();
        --清空
        utilFunc.clearArr(self.balancePokers);

        local  isWin =self:pointReachTarget();

        if(isWin)then
            local isBigWin =false;
            if(not isBigWin)then
                --不做商店目前
                --self:switchState(GAME_State.game_win_shop);
                self:switchState(GAME_State.game_ing_play);
            else
                self:switchState(GAME_State.game_bigWin);
            end
        else
            local curSendCount =self.player:getDrawPlayCount();
            if(curSendCount==0)then
                self:switchState(GAME_State.game_over);
            else
                self:switchState(GAME_State.game_ing_play);
            end
        end;
    end
end


function gameMgr:sendAllPokerToCenter()
    --发送前，把selectPokers排序

    self:sortSelectPokersBySiblingIndex();

    while #self.selectPokers >0 do
          self:sendOnePokerToCenter(1);
    end
end


function gameMgr:canSelect()
    if(#self.selectPokers<=5)then
        return true;
    else
        return false;
    end
end

function gameMgr:canSelect2(pokerIns)
   local idx= js.indexOf(self.selectPokers,pokerIns);
    if((#self.selectPokers==5)and (idx==0)) then
        return false;
    end

   return true;
end

function gameMgr:selectAdd(pcIns)
    table.insert(self.selectPokers,pcIns);
end

function gameMgr:selectRemove(pcIns)
    for i, v in ipairs(self.selectPokers) do
        if(pcIns==v)then
            table.remove(self.selectPokers,i);
            break;
        end
    end
end

function gameMgr:giveSomeToHand()
    local giveCount =self.player:drawPokerCount(#self.handPokers);
    print("giveTohand count"..tostring(giveCount),#self.handPokers);

    for i = 1, giveCount do
        self:giveOneToHand(true);
    end
end


--随机给一张移动到手牌
function gameMgr:giveOneToHand(isShow)
    local randomIdx =math.random(#self.pokerGroup)

    ---@type PokerCard
    local goPoker =self.pokerGroup[randomIdx];
    goPoker:changeBack(isShow);

    table.remove(self.pokerGroup,randomIdx);

    table.insert(self.handPokers,goPoker);
    local go =goPoker.go;
    gamePanel:addToHand(go);


end

--获的奖励判断
function gameMgr:pokerAwardResult()
    --提前初始化一次
    self:init_calculateData();

    local award,coinPoker =JudgeSys.JudgeAward(self.selectPokers);
    print("result",enumKit.numberToEnum(CARD_Award,award));
   local blue,red,typeMsg,lv=  self.player:getAwardPointMessage(award);
    if(typeMsg=="")then
        self:init_calculateData();
    else
        self.calculateData.blue =blue;
        self.calculateData.red =red;
        self.calculateData.typeMsg=typeMsg;
        self.calculateData.lv =lv;
        self.calculateData.coinPoker=coinPoker;
        self.calculateData.turnCoinTotal ="";
    end
    typeMsg= (typeMsg~="") and enumKit.numberToEnum(CARD_Award,typeMsg) or "";
    self:show_showCenterMsg();
end

function gameMgr:show_showCenterMsg()
    gamePanel:showCenterMsg(self.calculateData.blue,self.calculateData.red,self.calculateData.typeMsg,self.calculateData.lv,self.calculateData.turnCoinTotal);
end

--初始化牌组
function gameMgr:createPokerGroup()

    local pokerGroup={};

    local function addOne(flower)
        for i = 2, 14 do
            local go =GameObject.Instantiate(ue.loadGo("Prefab/PockerImage"));
            ---@type PokerCard
            local luaIns =CS.LuaMonoHelper.GetLuaComp(go,PokerCard);
            if(luaIns)then
                luaIns:init(i,flower);
                table.insert(pokerGroup,luaIns);
            else
                --print("luaIns error");
            end
            gamePanel:addToGroup(go);
        end
    end

    addOne(CARD_Flower.diamonds);
    addOne(CARD_Flower.hearts);
    addOne(CARD_Flower.spades);
    addOne(CARD_Flower.clubs);

    assert(PokerCard~=pokerGroup[1]);
    assert(#pokerGroup==52);
    return pokerGroup;
end

function gameMgr:generateGo(loadGo, parentTrans, name)
    local go = GameObject.Instantiate(loadGo);
    local canvasTrans = parentTrans;
    go.transform:SetParent(canvasTrans, false);

    if (name ~= nil) then
        go.name = name;
    end

    return go;
end

function gameMgr:test()
    ---@type UnityEngine.Transform
    local t =self.cube:GetComponent(typeof(UnityEngine.Transform));
    t.localPosition=UnityEngine.Vector3(math.random(1,3),math.random(1,3),0);
end

function gameMgr:update()

--[[    for i, v in ipairs(self.sysList) do
        v.update();
    end

    for i, v in ipairs(self.uiList) do
        v:update();
    end]]
end

return gameMgr;