local T, C, L = Tukui:unpack()

local DataText = T["DataTexts"]
local select = select
local GetItemInfo = GetItemInfo
local GetInventoryItemID = GetInventoryItemID
local GetInventoryItemLink = GetInventoryItemLink
local GetInventoryItemCount = GetInventoryItemCount
local AMMOSLOT = AMMOSLOT
local ThrownSubType = LE_ITEM_WEAPON_THROWN

local OnEnter = function(self)
	GameTooltip:SetOwner(self:GetTooltipAnchor())

	if GetInventoryItemID("player", 0) then
		GameTooltip:SetInventoryItem("player", 0)
	elseif GetInventoryItemID("player", 18) then
		GameTooltip:SetInventoryItem("player", 18)
	end

	GameTooltip:Show()
end

local OnLeave = function()
	GameTooltip:Hide()
end

local OnMouseUp = function()
	ToggleCharacter("PaperDollFrame")
end

local Update = function(self)
	local Count = 0

	if (GetInventoryItemID("player", 0) > 0) then -- Ammo slot
		Count = GetInventoryItemCount("player", 0)
	elseif (GetInventoryItemCount("player", 18) and GetInventoryItemCount("player", 18) > 1) then -- Ranged slot
		Count = GetInventoryItemCount("player", 18)
	end

	self.Text:SetFormattedText("%s%s:|r %s%s|r", DataText.NameColor, AMMOSLOT, DataText.ValueColor, Count)
end

local Enable = function(self)
	self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
	self:RegisterEvent("UNIT_INVENTORY_CHANGED")
	self:RegisterEvent("UPDATE_INVENTORY_DURABILITY")
	self:SetScript("OnEvent", Update)
	self:SetScript("OnEnter", OnEnter)
	self:SetScript("OnLeave", OnLeave)
	self:SetScript("OnMouseUp", OnMouseUp)

	self:Update()
end

local Disable = function(self)
	self:UnregisterEvent("PLAYER_EQUIPMENT_CHANGED")
	self:UnregisterEvent("UNIT_INVENTORY_CHANGED")
	self:UnregisterEvent("UPDATE_INVENTORY_DURABILITY")
	self:SetScript("OnEvent", nil)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnLeave", nil)
	self:SetScript("OnMouseUp", nil)

	self.Text:SetText("")
end

DataText:Register(AMMOSLOT, Enable, Disable, Update)