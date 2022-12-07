-- discord.gg/boronide, code generated using luamin.js™

-- Only execute after you've spawned in

local Workspace = game:GetService("Workspace")
local Stats = game:GetService("Stats")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService('TeleportService')

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Ping = Stats.PerformanceStats.Ping

local Character = LocalPlayer.Character

local remotePath = ReplicatedStorage.GameEvents
local Args = {...}
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
	autoRelease = true,
	tblTimings40 = {
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
	},
	    tblTimings100 = {
        ["Standing Shot"] = 0.66,
        ["Off Dribble Shot"] = 0.685,
        ["Drift Shot"] = 0.63,
        ["Far Shot"] = 0.5,
        ["Freethrow"] = 0.7,
        ["Hopstep Off Dribble Shot"] = 0.39,
        ["Hopstep Drift Shot"] = 0.63,
        ["Layup"] = 0.55,
        ["Reverse Layup"] = 0.549,
        ["Hopstep Layup"] = 0.549,
        ["Eurostep Layup"] = 0.525,
        ["Dropstep Layup"] = 0.53,
        ["Post Layup"] = 0.555,
        ["Floater"] = 0.55,
        ["Hopstep Floater"] = 0.57,
        ["Eurostep Floater"] = 0.565,
        ["Close Shot"] = 0.5,
        ["Hopstep Close Shot"] = 0.55,
        ["Dropstep Close Shot"] = 0.55,
        ["Post Close Shot"] = 0.55,
        ["AlleyOop Close Shot"] = 0.5,
        ["Standing Dunk"] = 0.6,
        ["Hopstep Standing Dunk"] = 0.3,
        ["Post Standing Dunk"] = 0.6,
        ["Driving Dunk"] = 0.6,
        ["AlleyOop Standing Dunk"] = 0.449,
        ["AlleyOop Driving Dunk"] = 0.449,
        ["Post Fade"] = 0.635,
        ["Drift Post Fade"] = 0.62,
        ["Hopstep Post Fade"] = 0.61,
        ["Dropstep Post Fade"] = 0.61,
        ["Post Hook"] = 0.59,
        ["Hopstep Post Hook"] = 0.515,
        ["Dropstep Post Hook"] = 0.505
    },
	tblTimings200 = {
		["Standing Shot"] = 0.38,
		["Off Dribble Shot"] = 0.395,
		["Drift Shot"] = 0.37,
		["Far Shot"] = 0.25,
		["Freethrow"] = 0.4,
		["Hopstep Off Dribble Shot"] = 0.39,
		["Hopstep Drift Shot"] = 0.36,
		["Layup"] = 0.32,
		["Reverse Layup"] = 0.31,
		["Hopstep Layup"] = 0.31,
		["Eurostep Layup"] = 0.285,
		["Dropstep Layup"] = 0.29,
		["Post Layup"] = 0.3,
		["Floater"] = 0.305,
		["Hopstep Floater"] = 0.29,
		["Eurostep Floater"] = 0.27,
		["Close Shot"] = 0.28,
		["Hopstep Close Shot"] = 0.26,
		["Dropstep Close Shot"] = 0.259,
		["Post Close Shot"] = 0.26,
		["AlleyOop Close Shot"] = 0.08,
		["Standing Dunk"] = 0.35,
		["Hopstep Standing Dunk"] = 0.3,
		["Post Standing Dunk"] = 0.31,
		["Driving Dunk"] = 0.38,
		["AlleyOop Standing Dunk"] = 0.08,
		["AlleyOop Driving Dunk"] = 0.08,
		["Post Fade"] = 0.36,
		["Drift Post Fade"] = 0.365,
		["Hopstep Post Fade"] = 0.36,
		["Dropstep Post Fade"] = 0.36,
		["Post Hook"] = 0.31,
		["Hopstep Post Hook"] = 0.275,
		["Dropstep Post Hook"] = 0.275
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

local function getRelease()
	local releaseType = "Unknown Release"
	for k, v in pairs(tblResources.tblReleases) do
		if getLandedShotMeter() <= v then
			releaseType = k
			break
		end
	end
	return releaseType
end

function getTimingValue(shotType, ping)
  local lowPing = 40
  local mediumPing = 100
  local highPing = 200
  
  -- Find the timing values for the low, medium, and high ping values
  local lowPingTiming = tblSettings.tblTimings40[shotType] -- tblTimings[lowPing][shotType]
  local mediumPingTiming = tblSettings.tblTimings100[shotType] -- tblTimings[mediumPing][shotType]
  local highPingTiming = tblSettings.tblTimings200[shotType] -- tblTimings[highPing][shotType]
  
  -- Calculate the slope and y-intercept of the line using the low, medium, and high ping values
  local m = (highPingTiming - lowPingTiming) / (highPing - lowPing)
  local b = mediumPingTiming - m * mediumPing
  
  -- Use the calculated line to find the timing value for the given ping value
  return m * ping + b
end


local function noMeterPerfect()
	for k, v in pairs(tblSettings.tblTimings40) do
	    local shotType = getShotType()
		if k == shotType then
			print(tblSettings.Signature, "Shot Type:", getShotType())
			local ping = Ping:GetValue()
			local releaseTiming = getTimingValue(getShotType(), ping)
			repeat
				task.wait()
			until getShotMeter() >= releaseTiming
			print(tblSettings.Signature, "Shot Meter:", getShotMeter())
			remotePath.ClientAction:FireServer("Shoot", false)
			print(tblSettings.Signature, "Landed:", getLandedShotMeter())
			print(tblSettings.Signature, getRelease())
			break
		end
	end  
end

local function meterPerfect()
	for k, v in pairs(tblSettings.tblTimings40) do
		local shotType = getShotType()
		if k == shotType then
			if Character.ShotMeterUI.Enabled then
				print(tblSettings.Signature, "Shot Type:", shotType)
				local ping = Ping:GetValue()
				local releaseTiming = getTimingValue(shotType, ping)
				repeat
					task.wait()
				until Character.ShotMeterUI.Meter.Bar.Size.Y.Scale >= (releaseTiming - 0.18)
				print(tblSettings.Signature, "Shot Meter:", getShotMeter())
				print(tblSettings.Signature, "Size:", Character.ShotMeterUI.Meter.Bar.Size.Y.Scale)
				remotePath.ClientAction:FireServer("Shoot", false)
				print(tblSettings.Signature, "Landed:", getLandedShotMeter())
				print(tblSettings.Signature, getRelease())
				break
			end
			if not Character.ShotMeterUI.Enabled then -- Shot Meter is not visible
				print(tblSettings.Signature, "Shot Type:", shotType)
				repeat
					task.wait()
				until Character["ShotMeterTiming"].Value >= tblSettings.tblTimings[shotType]
				print(tblSettings.Signature, "Shot Meter:", getShotMeter())
				remotePath.ClientAction:FireServer("Shoot", false)
				print(tblSettings.Signature, "Landed:", getLandedShotMeter())
				print(tblSettings.Signature, getRelease())
				break
			else
				warn(tblSettings.Signature, "Issue with meterPerfect, alternating to noMeterPerfect")
				pcall(noMeterPerfect())
				break
			end
		end
	end
end

local function aimbotPrep()
	if (Character:GetAttribute("ShootingAnim") or Character:GetAttribute("AlleyOop") == true) and tblSettings.autoRelease then
		if getMeterSetting() ~= "Off" then -- Not off
			print(tblSettings.Signature, "Calling meterPerfect")
			meterPerfect()
		elseif getMeterSetting() == "Off" then -- Off
			print(tblSettings.Signature, "Calling noMeterPerfect")
			noMeterPerfect()
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
	Character = LocalPlayer.Character
	Character:GetAttributeChangedSignal("ShootingAnim"):Connect(aimbotPrep)
	Character:GetAttributeChangedSignal("AlleyOop"):Connect(aimbotPrep)
	pcall(defineVariables())
	pcall(aimbotPrep())
end

Character = LocalPlayer.Character
Character:GetAttributeChangedSignal("ShootingAnim"):Connect(aimbotPrep)
Character:GetAttributeChangedSignal("AlleyOop"):Connect(aimbotPrep)

LocalPlayer.CharacterAdded:Connect(connectMain)

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/miroeramaa/TurtleLib/main/TurtleUiLib.lua"))()

local window = library:Window("Main")

window:Toggle("Perfect Release", true, function(bool)
	autoRelease = bool 
	print(tblSettings.Signature, "Perfect Release:", bool)
end)

window:Button("Rejoin", function()
	if # Players:GetPlayers() <= 1 then
		LocalPlayer:Kick("\nRejoining, one second...")
		task.wait()
		TeleportService:Teleport(game.PlaceId, LocalPlayer)
	else
		TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
	end
end)

print(tblSettings.Signature, "Loaded")
