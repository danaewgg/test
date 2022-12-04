local Workspace = game:GetService("Workspace")
local Stats = game:GetService("Stats")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService('TeleportService')

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Ping = Stats.PerformanceStats.Ping

local Character = LocalPlayer.Character -- Defined later

local remotePath = ReplicatedStorage.GameEvents
local Args = { ... }
local Method = getnamecallmethod()

local tblResources = {
	tblMeter = {
		settingShotMeter = LocalPlayer.PlayerGui.SocialUI.Settings.Frame.List.ShotMeters.Button.Label,
		Size = Character.ShotMeterUI.Meter.Bar.Size.Y.Scale
	},
	tblReleases = {
		["Too-Late Release"] = 1.3,
		["Slightly-Late Release"] = 1.15,
		["Perfect Release"] = 1,
		["Good Release"] = 1.05,
		["Slightly-Early Release"] = 0.95,
		["Too-Early Release"] = 0.5
	}
}
    
local tblSettings = {
    Signature = "[danhub]",
    autoRelease = false,
    tblTimings = {
		["Standing Shot"] = 0.875,
		["Off Dribble Shot"] = 0.865,
		["Drift Shot"] = 0.85,
		["Far Shot"] = 0.835,
		["Freethrow"] = 0.8,
		["Hopstep Off Dribble Shot"] = 0.88,
		["Hopstep Drift Shot"] = 0.81,
		["Layup"] = 0.845,
		["Reverse Layup"] = 0.835,
		["Hopstep Layup"] = 0.845,
		["Eurostep Layup"] = 0.84,
		["Dropstep Layup"] = 0.845,
		["Post Layup"] = 0.79,
		["Floater"] = 0.835,
		["Hopstep Floater"] = 0.8,
		["Eurostep Floater"] = 0.8,
		["Close Shot"] = 0.8,
		["Hopstep Close Shot"] = 0.8,
		["Dropstep Close Shot"] = 0.79,
		["Post Close Shot"] = 0.8,
		["AlleyOop Close Shot"] = 0.79,
		["Standing Dunk"] = 0.8,
		["Hopstep Standing Dunk"] = 0.8,
		["Post Standing Dunk"] = 0.8,
		["Driving Dunk"] = 0.82,
		["AlleyOop Standing Dunk"] = 0.77,
		["AlleyOop Driving Dunk"] = 0.77,
		["Post Fade"] = 0.85,
		["Drift Post Fade"] = 0.85,
		["Hopstep Post Fade"] = 0.85,
		["Dropstep Post Fade"] = 0.85,
		["Post Hook"] = 0.865,
		["Hopstep Post Hook"] = 0.8,
		["Dropstep Post Hook"] = 0.8
    }
}

local function getMeterSetting()
    if tblResources.tblMeter["settingShotMeter"].ContentText then
        return tblResources.tblMeter["settingShotMeter"].ContentText
    else
        print(tblSettings.Signature, "Something went wrong with getMeterSetting()")
        return
    end
end

local function getShotType()
    if Character:GetAttribute("ShotType") then
        return Character:GetAttribute("ShotType")
    elseif not Character:GetAttribute("ShotType") then
        repeat 
            task.wait()
        until Character:GetAttribute("ShotType")

        return Character:GetAttribute("ShotType")
    else
        print(tblSettings.Signature, "Something went wrong with getShotType()")
        return
    end
end

local function getShotMeter()
    if Character:GetAttribute("ShotMeter") then
        return Character:GetAttribute("ShotMeter")
    elseif not Character:GetAttribute("ShotMeter") then
        repeat
            task.wait()
        until Character:GetAttribute("ShotMeter")
        return Character:GetAttribute("ShotMeter")
    else
        warn(tblSettings.Signature, "Something went wrong with getShotMeter()")
        return
    end
end

local function getLandedShotMeter()
    if Character:GetAttribute("LandedShotMeter") then
        return Character:GetAttribute("LandedShotMeter")
    elseif not Character:GetAttribute("LandedShotMeter") then
        repeat 
            task.wait()
        until Character:GetAttribute("LandedShotMeter")

        return Character:GetAttribute("LandedShotMeter")
    else
        print(tblSettings.Signature, "Something went wrong with getLandedShotMeter()")
        return
    end
end

local function noMeterPerfect()
    --if table.find(tblSettings.tblTimings, getShotType()) then
	    print(tblSettings.Signature, "Shot Type:", getShotType())
	    repeat 
	        task.wait()
	    until getShotMeter() >= tblSettings.tblTimings[getShotType()]
	    print(tblSettings.Signature, "Shot Meter:", getShotMeter())
	    remotePath.ClientAction:FireServer("Shoot", false)
	    print(tblSettings.Signature, "Landed:", getLandedShotMeter())
    --else
        --warn(tblSettings.Signature, "Something went wrong with noMeterPerfect()")
	--end
end

local function meterPerfect()
	if Character.ShotMeterUI.Enabled then -- Shot Meter is visible
		print(tblSettings.Signature, "Shot Type:", getShotType())
		repeat
			task.wait()
		until Character.ShotMeterUI.Meter.Bar.Size.Y.Scale >= (tblSettings.tblTimings[getShotType()] - 0.18)
		print(tblSettings.Signature, "Shot Meter:", getShotMeter())
		print(tblSettings.Signature, "Size:", Character.ShotMeterUI.Meter.Bar.Size.Y.Scale)
		remotePath.ClientAction:FireServer("Shoot", false)
		print(tblSettings.Signature, "Landed:", getLandedShotMeter())
	elseif not Character.ShotMeterUI.Enabled then -- Shot Meter is not visible
        print(tblSettings.Signature, "Shot Type:", getShotType())
        repeat
            task.wait()
        until Character["ShotMeterTiming"].Value >= tblSettings.tblTimings[getShotType()]
        print(tblSettings.Signature, "Shot Meter:", getShotMeter())
        remotePath.ClientAction:FireServer("Shoot", false)
        print(tblSettings.Signature, "Landed:", getLandedShotMeter())
    else
        warn(tblSettings.Signature, "Issue with meterPerfect, alternating to noMeterPerfect")
		pcall(noMeterPerfect())
	end
end


local function aimbotPrep()
	if (Character:GetAttribute("ShootingAnim") or Character:GetAttribute("AlleyOop") == true) and tblSettings.autoRelease then
	    print("hi")
		if getMeterSetting() ~= "Off" then -- Not off
			print(tblSettings.Signature, "Calling meterPerfect")
			pcall(meterPerfect())
		elseif getMeterSetting() == "Off" then -- Off
			print(tblSettings.Signature, "Calling noMeterPerfect")
			pcall(noMeterPerfect())
		else
			warn(tblSettings.Signature, "Something went wrong with the ShootingAnim function")
		end
	end
end

local function defineVariables()
    Character = LocalPlayer.Character
    tblResources.tblMeter["Size"] = Character("ShotMeterUI.Meter.Bar.Size.Y.Scale")
end

local function connectMain()
	pcall(defineVariables())
	pcall(aimbotPrep())
end

Character = LocalPlayer.Character
Character:GetAttributeChangedSignal("ShootingAnim"):Connect(aimbotPrep)
Character:GetAttributeChangedSignal("AlleyOop"):Connect(aimbotPrep)

LocalPlayer.CharacterAdded:Connect(connectMain)

local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

local GUI = Mercury:Create{
	Name = "Dan's Hub",
	Size = UDim2.fromOffset(600, 400),
	Theme = Mercury.Themes.Dark,
	Link = "danshub.gg"
}

GUI:Credit{
	Name = "Xeziru",
	Description = "Helped with the script",
	V3rm = "KingKeero",
	Discord = "Xeziru#3383"
}

local tabMain = GUI:Tab{
	Name = "Core",
	Icon = "rbxassetid://8569322835"
}   

local tabTimings = GUI:Tab{
	Name = "Timings",
	Icon = "rbxassetid://8569322835"
}   

tabMain:Toggle{
	Name = "Perfect Release",
	StartingState = false,
	Description = "Good release every shot",
	Callback = function(state)
		tblSettings.autoRelease = state
		print(tblSettings.Signature, "Perfect Release:", state)
	end
}

tabMain:Button{
	Name = "Rejoin",
	Description = nil,
	Callback = function()
		if # Players:GetPlayers() <= 1 then
			LocalPlayer:Kick("\nRejoining, one second...")
			task.wait()
			TeleportService:Teleport(game.PlaceId, LocalPlayer)
		else
			TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
		end
	end
}

tabTimings:Textbox{
	Name = "Standing Shot",
	Description = "Default: 0.875 \nDoesn't work for timings above 1",
	Callback = function(timing1) tblSettings.tblTimings["Standing Shot"] = timing1 end
}

tabTimings:Textbox{
	Name = "Off Dribble Shot",
	Description = "Default: 0.865 \nDoesn't work for timings above 1",
	Callback = function(timing2) tblSettings.tblTimings["Off Dribble Shot"] = timing2 end
}

print(tblSettings.Signature, "Loaded") -- Confirmation
