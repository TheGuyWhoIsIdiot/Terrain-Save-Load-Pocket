-- GUI instructions, it will create a gui ordered, and then return it to the script.
-- made by meditext/TGWII

-- ROOT gui
local GUI = Instance.new("ScreenGui")
GUI.Name = "TerrainSaveLoadGui"
-- APP frame
local App = Instance.new("Frame")
App.Name = "App"
App.Position = UDim2.new(0.5, -100, 0, 10)
App.Size = UDim.new(0, 200,0, 96)
App.Style = Enum.FrameStyle.DropShadow -- set to DropShadow.
App.Parent = GUI
-- Button Core Features
local Save = Instance.new("TextButton")
Save.Name = "Save"
Save.Text = "Save"
Save.Position = UDim2.new(0,0,0,20)
Save.Size = UDim2.new(0.5,0,0,30)
Save.Style = Enum.ButtonStyle.RobloxRoundButton
Save.Parent = App
local Load = Instance.new("TextButton")
Load.Name = "Load"
Load.Text = "Load"
Load.Position = UDim2.new(0,0,0,50)
Load.Size = UDim2.new(0.5,0,0,30)
Load.Style = Enum.ButtonStyle.RobloxRoundButton
Load.Parent = App
local Exit = Instance.new("TextButton")
Exit.Name = "Exit"
Exit.Text = "X"
Exit.Position = UDim2.new(1,10,0,-10)
Exit.Size = UDim2.new(0,-26,0,26)
Load.Style = Enum.ButtonStyle.RobloxRoundButton
Load.Parent = App
-- Optional crap AGHH
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Text = "Save & Load Terrain (Exploiter Edition)"
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1,0,0,20)
Title.TextScaled = true
-- SAVING TIME, i will do something more efficient rather than doing this painful process of adding texts inside of the text label.
local SavingTerrain = Instance.new("TextLabel")
SavingTerrain.Name = "SavingTerrain"
SavingTerrain.Text = "Saving Terrain..."
SavingTerrain.Position = UDim2.new(0,0,1,10)
SavingTerrain.Size = UDim2.new(1,0,0,30)
SavingTerrain.BackgroundColor3 = Color3.new(0,0,0)
SavingTerrain.BackgroundTransparency = 0.5
SavingTerrain.Visible = false
local LoadingTerrain = Instance.new("TextLabel")
LoadingTerrain.Name = "LoadingTerrain"
LoadingTerrain.Text = "Loading Terrain..."
LoadingTerrain.Position = UDim2.new(0,0,1,10)
LoadingTerrain.Size = UDim2.new(1,0,0,30)
LoadingTerrain.BackgroundColor3 = Color3.new(0,0,0)
LoadingTerrain.BackgroundTransparency = 0.5
LoadingTerrain.Visible = false
local SelectRegion = Instance.new("TextLabel")
SelectRegion.Name = "SelectRegion"
SelectRegion.Text = "Please select TerrainRegion first"
SelectRegion.Position = UDim2.new(0,0,1,10)
SelectRegion.Size = UDim2.new(1,0,0,30)
SelectRegion.BackgroundColor3 = Color3.new(0,0,0)
SelectRegion.BackgroundTransparency = 0.5
SelectRegion.Visible = false

-- Returns the GUI
return GUI
