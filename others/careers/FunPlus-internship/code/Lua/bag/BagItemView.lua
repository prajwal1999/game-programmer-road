---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by YCIrving.
--- DateTime: 2019-07-13 17:23
---
require "common/define"

---@class BagItemView
local BagItemView = XT.class()

--start
---@type UnityEngine.UI.Image
BagItemView._objectIcon = nil
---@type UnityEngine.UI.Image
BagItemView._bgIcon = nil
---@type UnityEngine.UI.Image
BagItemView._cvSelected = nil
---@type UnityEngine.UI.Image
BagItemView._tipSpot = nil
---@type UnityEngine.UI.Button
BagItemView._btnSelect = nil
---@type TMPro.TMP_Text
BagItemView._lbNum = nil
--end

--------------------- base function begin ------------------------------------------------------------------------------
function BagItemView:Awake()

end

function BagItemView:Start()
    self:Init()
    self:AddListener()
end

function BagItemView:Init()

end

function BagItemView:Update()

end

function BagItemView:OnDestroy()
    self:OnClose()
end

function BagItemView:AddListener()
    self._btnSelect.onClick:AddListener(function () CT.BagItemCtrl.OnSelect(self.CellIndex, self.CellModel) end)
end

function BagItemView:RemoveListener()
    self._btnSelect.onClick:RemoveListener(function () CT.BagItemCtrl.OnSelect(self.CellIndex, self.CellModel) end )
end

function BagItemView:OnClose()
    self:OnClean()
    self:RemoveListener()
    self:UnBind()
end

function BagItemView:OnClean()

end

function BagItemView.Bind(model, view)

    XT.bind(view, model, function (m)
        ---@type BagItemView
        local v = view
        ---@type BagItemModel
        local m = model


        -- 修改图标和背景
        UGUIUtil.SetImage(v._objectIcon, m.ObjectConfItem.Atlas, m.ObjectConfItem.Icon)
        -- UGUIUtil.SetImage(v._bgIcon, "icon", m.ObjectConfItem.Icon)

--[[        v._objectIcon:SetSprite("icon", m.ObjectConfItem.Icon)
        v._bgIcon:SetSprite("Bag","bg_itemback_blue")]]

        -- 显示选中边框
        v._cvSelected.gameObject:SetActive(m.Selected)
        -- 显示右下数量
        if(m.Count > 9999) then
            v._lbNum.text = "9999+"
        else
            v._lbNum.text = m.Count
        end


        -- 显示小红点
        v._tipSpot.gameObject:SetActive(m.TipSpot)

    end)
end

function BagItemView:UnBind()
    Log("BagItemView:UnBind" .. tostring(self))
    XT.unbind(self)
end

--------------------- base function end ------------------------------------------------------------------------------
return BagItemView