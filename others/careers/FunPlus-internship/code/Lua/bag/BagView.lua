---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by YCIrving.
--- DateTime: 2019-07-11 18:12
---
require("common.define")
local CommonFunUtil = require("util.CommonFunUtil")

---@class BagView
local BagView = XT.class()

--start
---@type UnityEngine.UI.Button
BagView._btnExit = nil -- exit
---@type UnityEngine.UI.Toggle
BagView._btnResourcesToggle = nil -- resources tabs
---@type UnityEngine.UI.Toggle
BagView._btnSpeedupToggle = nil -- speedup tabs
---@type UnityEngine.UI.Toggle
BagView._btnBoostsToggle = nil -- boosts tabs
---@type UnityEngine.UI.Toggle
BagView._btnOthersToggle = nil -- others tabs
---@type Wod.UI.BasicGridAdapter
BagView._resourcesGridView = nil -- resources gridView
---@type Wod.UI.BasicGridAdapter
BagView._speedupGridView = nil -- speedup gridView
---@type Wod.UI.BasicGridAdapter
BagView._boostsGridView = nil -- boosts gridView
---@type Wod.UI.BasicGridAdapter
BagView._othersGridView = nil -- others gridView
---@type UnityEngine.GameObject
BagView._goResourcesGridView = nil -- resources gameobject
---@type UnityEngine.GameObject
BagView._goSpeedupGridView = nil -- speedup gameobject
---@type UnityEngine.GameObject
BagView._goBoostsGridView = nil -- boosts gameobject
---@type UnityEngine.GameObject
BagView._goOthersGridView = nil -- others gameobject
---@type TMPro.TMP_Text
BagView._lbItemListEmptyNotice = nil
---@type UnityEngine.GameObject
BagView._goItemSelectedInfo = nil -- ItemInfo
---@type UnityEngine.UI.Image
BagView._itemIcon = nil
---@type TMPro.TMP_Text
BagView._lbItemName = nil
---@type TMPro.TMP_Text
BagView._lbItemText = nil
---@type TMPro.TMP_Text
BagView._lbItemOwn = nil
---@type UnityEngine.GameObject
BagView._goUseItem = nil
---@type TMPro.TMP_InputField
BagView._lbNum = nil -- ItemUse
---@type Wod.UI.Ext.LongPressButton
BagView._btnMinus = nil
---@type Wod.UI.Ext.LongPressButton
BagView._btnPlus = nil
---@type UnityEngine.UI.Button
BagView._btnMax = nil
---@type UnityEngine.UI.Button
BagView._btnUse = nil
--end

--------------------- base function begin --------------------------------------------------------------------------------
function BagView:Awake()
end

function BagView:Start()
    self:Init()
    self:AddListener()
end

function BagView:Init()

    -- 创建不同的view，防止在给currentSelectedItemList赋值时将名字相同的view删掉
    self._resourcesView = {}
    self._speedupView = {}
    self._boostsView = {}
    self._othersView = {}

    if D.BagModel == nil then
        local model = MT.BagModel()
        self.Model = model
        D.BagModel = model
        self:Bind(self, model)
    else
        self:Bind(self, D.BagModel)
        self.Model = D.BagModel
    end

    CT.BagCtrl.InitData()

    self._resourcesGridView.OnStart = function()
        self:BindResourcesItemList()
    end
    self._speedupGridView.OnStart = function()
        self:BindSpeedupItemList()
    end
    self._boostsGridView.OnStart = function()
        self:BindBoostsItemList()
    end
    self._othersGridView.OnStart = function()
        self:BindOthersItemList()
    end

    --self:BindAllItemLists()

    self._btnResourcesToggle.isOn = true
    CT.BagCtrl.SetCurrentSelection(D.BagModel.ResourcesItemList, D.BagModel.ResourcesSelectedIndex)

    self:ShowCurrentSelectedItemList()
    self:ShowCurrentSelectedItem()


--[[    self._btnResourcesToggle.isOn = (D.BagModel.SelectedItemList.CurrentSelectedItemList == D.BagModel.ResourcesItemList)
    self._btnSpeedupToggle.isOn = (D.BagModel.SelectedItemList.CurrentSelectedItemList == D.BagModel.SpeedupItemList)
    self._btnBoostsToggle.isOn = (D.BagModel.SelectedItemList.CurrentSelectedItemList == D.BagModel.BoostsItemList)
    self._btnOthersToggle.isOn = (D.BagModel.SelectedItemList.CurrentSelectedItemList == D.BagModel.OthersItemList)]]

end

function BagView:Update()

end

function BagView:OnDestroy()
    self:OnClose()
end

function BagView:AddListener()

    self._btnExit.onClick:AddListener( CT.BagCtrl.OnBtnExit)
    self._btnMinus.onClick:AddListener( CT.BagCtrl.OnBtnMinus)
    self._btnMinus.onLongPressed:AddListener(CT.BagCtrl.OnLongPressBtnMinus)
    self._btnPlus.onClick:AddListener( CT.BagCtrl.OnBtnPlus)
    self._btnPlus.onLongPressed:AddListener(CT.BagCtrl.OnLongPressBtnPlus)
    self._btnMax.onClick:AddListener( CT.BagCtrl.OnBtnMax)
    self._btnUse.onClick:AddListener( CT.BagCtrl.OnBtnUse)
    self._lbNum.onValueChanged:AddListener (CT.BagCtrl.OnInputNum)

    self._btnResourcesToggle.onValueChanged:AddListener( CT.BagCtrl.OnBtnResourcesTab)
    self._btnSpeedupToggle.onValueChanged:AddListener( CT.BagCtrl.OnBtnSpeedupTab)
    self._btnBoostsToggle.onValueChanged:AddListener( CT.BagCtrl.OnBtnBoostsTab)
    self._btnOthersToggle.onValueChanged:AddListener( CT.BagCtrl.OnBtnOthersTab)

end

function BagView:RemoveListener()
    self._btnExit.onClick:RemoveListener( CT.BagCtrl.OnBtnExit)
    self._btnMinus.onClick:RemoveListener( CT.BagCtrl.OnBtnMinus)
    self._btnMinus.onLongPressed:RemoveListener(CT.BagCtrl.OnLongPressBtnMinus)
    self._btnPlus.onClick:RemoveListener( CT.BagCtrl.OnBtnPlus)
    self._btnPlus.onLongPressed:RemoveListener(CT.BagCtrl.OnLongPressBtnPlus)
    self._btnMax.onClick:RemoveListener( CT.BagCtrl.OnBtnMax)
    self._btnUse.onClick:RemoveListener( CT.BagCtrl.OnBtnUse)
    self._lbNum.onValueChanged:AddListener (CT.BagCtrl.OnInputNum)

    self._btnResourcesToggle.onValueChanged:RemoveListener( CT.BagCtrl.OnBtnResourcesTab)
    self._btnSpeedupToggle.onValueChanged:RemoveListener( CT.BagCtrl.OnBtnSpeedupTab)
    self._btnBoostsToggle.onValueChanged:RemoveListener( CT.BagCtrl.OnBtnBoostsTab)
    self._btnOthersToggle.onValueChanged:RemoveListener( CT.BagCtrl.OnBtnOthersTab)
end

function BagView:OnClose()
    self:RemoveListener()
    self:UnBind()
    self:OnClean()
end

function BagView:OnClean()
    D.BagModel = nil
end

function BagView:UnBind()
    XT.unbind(self)
    Log("BagView UnBind")
end



--绑定列表
--[[function BagView:BindAllItemLists()
    self._goResourcesGridView:SetActive(true)
    self._goSpeedupGridView:SetActive(true)
    self._goBoostsGridView:SetActive(true)
    self._goOthersGridView:SetActive(true)
end]]

-- 绑定时选择各自的view进行绑定
function BagView:BindResourcesItemList()
    Log("BagView:BindResourcesItemList()")

    XT.bind(self._resourcesView, D.BagModel.ResourcesItemList, function (m, v)
        Log("Bind Resources Item List")
        XT.BindGrid(self, self._resourcesGridView, D.BagModel.ResourcesItemList, VT.BagItemView.Bind)
    end)
end

function BagView:BindSpeedupItemList()
    Log("BagView:BindSpeedupItemList()")

    XT.bind(self._speedupView, D.BagModel.SpeedupItemList, function (m, v)
        XT.BindGrid(self, self._speedupGridView, D.BagModel.SpeedupItemList, VT.BagItemView.Bind)
    end)
end

function BagView:BindBoostsItemList()
    Log("BagView:BindBoostsItemList()")

    XT.bind(self._boostsView, D.BagModel.BoostsItemList, function (m, v)
        XT.BindGrid(self, self._boostsGridView, D.BagModel.BoostsItemList, VT.BagItemView.Bind)
    end)
end

function BagView:BindOthersItemList()
    Log("BagView:BindOthersItemList()")

    XT.bind(self._othersView, D.BagModel.OthersItemList, function (m, v)
        XT.BindGrid(self, self._othersGridView, D.BagModel.OthersItemList, VT.BagItemView.Bind)
    end)
end

function BagView:DeactivateOtherListViews(currentListView)
    if currentListView ~= self._goResourcesGridView and self._goResourcesGridView.activeSelf then
        self._goResourcesGridView:SetActive(false)
    end

    if  currentListView ~= self._goSpeedupGridView and self._goSpeedupGridView.activeSelf then
        self._goSpeedupGridView:SetActive(false)
    end

    if  currentListView ~= self._goBoostsGridView and self._goBoostsGridView.activeSelf then
        self._goBoostsGridView:SetActive(false)
    end

    if  currentListView ~= self._goOthersGridView and self._goOthersGridView.activeSelf then
        self._goOthersGridView:SetActive(false)
    end
end

function BagView:ShowCurrentSelectedItemList()
    -- 监听两层，包括改变选中ItemList和ItemList本身的变化（新增和删除，要考虑使用完物品的情况）
    -- XT.bind(self, D.BagModel.SelectedItemList, D.BagModel.SelectedItemList.CurrentSelectedItemList, function (m, v)
    XT.bind(self, D.BagModel.SelectedItemList, function (m, v)
        Log("BagView:ShowCurrentSelectedItemList()")
        local CurrentSelectedItemListEmpty = D.BagModel.SelectedItemList.CurrentSelectedItemListEmpty

        self._lbItemListEmptyNotice.gameObject:SetActive(CurrentSelectedItemListEmpty)
        self._goItemSelectedInfo:SetActive(not CurrentSelectedItemListEmpty)

        if(D.BagModel.SelectedItemList.CurrentSelectedItemList == D.BagModel.ResourcesItemList) then
            --XT.BindGrid(self, self._resourcesGridView, D.BagModel.ResourcesItemList, VT.BagItemView.Bind)
            self._goResourcesGridView:SetActive(true)
            --local resourcesItemListSize = D.BagModel.ResourcesItemList:Count()

            self:DeactivateOtherListViews(self._goResourcesGridView)
        elseif ((D.BagModel.SelectedItemList.CurrentSelectedItemList == D.BagModel.SpeedupItemList)) then
            --XT.BindGrid(self, self._speedupGridView, D.BagModel.SpeedupItemList, VT.BagItemView.Bind)
            self._goSpeedupGridView:SetActive(true)
            self:DeactivateOtherListViews(self._goSpeedupGridView)
        elseif ((D.BagModel.SelectedItemList.CurrentSelectedItemList == D.BagModel.BoostsItemList)) then
            --XT.BindGrid(self, self._boostsGridView, D.BagModel.BoostsItemList, VT.BagItemView.Bind)
            self._goBoostsGridView:SetActive(true)
            self:DeactivateOtherListViews(self._goBoostsGridView)
        elseif ((D.BagModel.SelectedItemList.CurrentSelectedItemList == D.BagModel.OthersItemList)) then
            --XT.BindGrid(self, self._othersGridView, D.BagModel.OthersItemList, VT.BagItemView.Bind)
            self._goOthersGridView:SetActive(true)
            self:DeactivateOtherListViews(self._goOthersGridView)
        else
            Log("BagView:ShowGridView(): tab chosen error!")
        end
    end)
end

function BagView:ShowCurrentSelectedItem()
    -- 监听两层，包括改变选中Item和选中Item数量的变化
    -- XT.bind(self, D.BagModel.SelectedItem, D.BagModel.SelectedItem.CurrentSelectedItem, function(m,v)
    XT.bind(self, D.BagModel.SelectedItem, function(m,v)
        Log("BagView:ShowCurrentSelectedItem()")

        local index = D.BagModel.SelectedItem.CurrentSelectedIndex
        if(D.BagModel.SelectedItem.CurrentSelectedItem ~= nil) then
            --self._itemIcon:SetSprite("icon", D.BagModel.SelectedItem.CurrentSelectedItem.ObjectConfItem.Icon)
            UGUIUtil.SetImage(self._itemIcon, D.BagModel.SelectedItem.CurrentSelectedItem.ObjectConfItem.Atlas, D.BagModel.SelectedItem.CurrentSelectedItem.ObjectConfItem.Icon)
            self._lbItemName.text = D.BagModel.SelectedItem.CurrentSelectedItem.ObjectConfItem.Name
            self._lbItemText.text = D.BagModel.SelectedItem.CurrentSelectedItem.ObjectConfItem.Dec
            self._lbItemOwn.text = D.BagModel.SelectedItem.CurrentSelectedItem.Count
            --self._lbNum.text = D.BagModel.SelectedItem.NumUse
            --self._btnMinus.interactable = (D.BagModel.SelectedItem.NumUse ~= 1)
            --self._btnPlus.interactable = (D.BagModel.SelectedItem.NumUse ~= D.BagModel.SelectedItem.CurrentSelectedItem.Count)
            local useType = D.BagModel.SelectedItem.CurrentSelectedItem.ObjectConfItem.UseType
             --上线记得删去下面判断nil的代码
            if (useType == 0) then
                self._goUseItem:SetActive(false)
                self._btnUse.gameObject:SetActive(false)
            elseif (useType == 1) then
                self._goUseItem:SetActive(false)
                self._btnUse.gameObject:SetActive(true)
            elseif(useType == 2) then
                self._goUseItem:SetActive(true)
                self._btnUse.gameObject:SetActive(true)
                self._lbNum.text = D.BagModel.SelectedItem.NumUse
                self._btnMinus.interactable = (D.BagModel.SelectedItem.NumUse ~= 1)
                self._btnPlus.interactable = (D.BagModel.SelectedItem.NumUse ~= D.BagModel.SelectedItem.CurrentSelectedItem.Count)
            else
                Log("UseType error!")
            end
        else
            self:ShowCurrentSelectedItemList()
        end
    end)
end

function BagView:Bind(view, model)

    XT.bind(view, model,function (m)
        ---@type BagView
        local v = view
        ---@type BagModel
        local m = model

        Log("BagView bind XT.bind")
    end)
    Log("BagView bind")

end
--------------------- base function end --------------------------------------------------------------------------------


return BagView