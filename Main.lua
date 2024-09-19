-- Ported

-- Terrain Save And Load: Plugin Master
-- Crazyman32
-- January 17, 2015

-- Edits:
	-- January 27, 2015
		-- Only requires TerrainSaveLoad once it's first needed
		-- Edited TerrainSaveLoad API to standardize some code
	-- March 12, 2015
		-- Updated the TerrainSaveLoad API to use 'pasteEmptyCells' instead of 'terrain:Clear()'
		-- Got rid of pointless metatable stuff for API
	-- December 20, 2016
		-- Placed plugin in the same toolbar as the other terrain plugins
		-- Fixed wording in the Help UI
		-- Updated TerrainSaveLoad API to also save water properties


do
	-- Copied from the standard ROBLOX terrain plugins:
	local Terrain = workspace:WaitForChild('Terrain', 86400) or workspace:WaitForChild('Terrain')
	while not Terrain.IsSmooth do
	  Terrain.Changed:wait()
	end
	wait(0.5)
end

local terrainSaveLoadApi = loadstring(game:HttpGet("https://raw.githubusercontent.com/TheGuyWhoIsIdiot/Terrain-Save-Load-Pocket/refs/heads/main/TerrainSaveLoad.lua"))()
local gui = loadstring(game:HttpGet("https://raw.githubusercontent.com/TheGuyWhoIsIdiot/Terrain-Save-Load-Pocket/refs/heads/main/GUI.lua"))()
	local app = gui.App
		app.Visible = false
	gui.Parent = game:GetService("CoreGui")

local isOn = true
local isBusy = false

local selectRegionWarningTag = -1

local selectionChangedConn


-- Set change waypoint for undo/redo in Studio:
function SetChangeWaypoint(name)
	game:GetService("ChangeHistoryService"):SetWaypoint(name)
end


-- Find first TerrainRegion from current selection in Studio:
function FindFirstRegionFromSelection()
	for _,v in pairs(game.Selection:Get()) do
		if (v:IsA("TerrainRegion")) then
			return v
		end
	end
	return nil
end


function CheckSelection()
	local hasRegion = (FindFirstRegionFromSelection() ~= nil)
	app.Load.TextTransparency = (hasRegion and 0 or 0.7)
	app.Load.Active = hasRegion
	app.Load.AutoButtonColor = hasRegion
end


function SetupButtons()
	
	-- Save terrain:
	app.Save.MouseButton1Click:connect(function()
		if (isBusy) then return end
		isBusy = true
		app.HelpFrame.Visible = false
		app.SelectRegion.Visible = false
		app.SavingTerrain.Visible = true
		wait(0.1)
		if (not terrainSaveLoadApi) then
			terrainSaveLoadApi = require(script.Parent.TerrainSaveLoad)
		end
		SetChangeWaypoint("BeforeTerrainSave")
		terrainSaveLoadApi:Save(true)			-- SAVE
		SetChangeWaypoint("AfterTerrainSave")
		app.SavingTerrain.Visible = false
		isBusy = false
	end)
	
	-- Load terrain:
	app.Load.MouseButton1Click:connect(function()
		if (isBusy) then return end
		local region = FindFirstRegionFromSelection()
		app.HelpFrame.Visible = false
		if (not region or not region:IsA("TerrainRegion")) then
			local tag = tick()
			selectRegionWarningTag = tag
			app.SelectRegion.Visible = true
			delay(2, function()
				if (tag == selectRegionWarningTag) then
					app.SelectRegion.Visible = false
					selectRegionWarningTag = -1
				end
			end)
			return
		end
		isBusy = true
		app.SelectRegion.Visible = false
		app.LoadingTerrain.Visible = true
		wait(0.1)
		if (not terrainSaveLoadApi) then
			terrainSaveLoadApi = require(script.Parent.TerrainSaveLoad)
		end
		SetChangeWaypoint("BeforeTerrainLoad")
		terrainSaveLoadApi:Load(region)		-- LOAD
		SetChangeWaypoint("AfterTerrainLoad")
		app.LoadingTerrain.Visible = false
		isBusy = false
	end)
	--[[
	-- Insert TerrainSaveLoad API:
	app.InsertAPI.MouseButton1Click:connect(function()
		if (isBusy) then return end
		local api = script.Parent.TerrainSaveLoad:Clone()
		api.Parent = game.ServerScriptService
		game.Selection:Set({api})
	end)
	]]
	-- Exit plugin:
	app.Exit.MouseButton1Click:connect(function()
		Click()
	end)
	-- Help is removed, please check the Help.MD for more information how to use it.
	--[[
	-- Display Help frame:
	app.Help.MouseButton1Click:connect(function()
		app.HelpFrame.Visible = (not app.HelpFrame.Visible)
		app.SelectRegion.Visible = false
	end)
	
	-- Exit Help frame:
	app.HelpFrame.Exit.MouseButton1Click:connect(function()
		app.HelpFrame.Visible = false
	end)
	]]
	
end


-- Plugin button clicked:
function Click()
	isOn = (not isOn)
	app.Visible = isOn
	if (isOn) then
		selectionChangedConn = game.Selection.SelectionChanged:connect(CheckSelection)
		CheckSelection()
	else
		app.SelectRegion.Visible = false
		if (selectionChangedConn and selectionChangedConn.connected) then
			selectionChangedConn:disconnect()
			selectionChangedConn = nil
		end
	end
end

app.LoadingTerrain.Visible = false
app.SavingTerrain.Visible = false
app.SelectRegion.Visible = false

SetupButtons()
Click()
