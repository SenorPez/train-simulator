------------------------------------------------
-- Scenario Script -- 
------------------------------------------------

-- true/false defn
FALSE = 0
TRUE = 1

-- condition return values
CONDITION_NOT_YET_MET = 0
CONDITION_SUCCEEDED = 1
CONDITION_FAILED = 2

-- Message types
MT_INFO = 0     	-- large centre screen pop up
MT_ALERT = 1    	-- top right alert message

MSG_TOP = 1
MSG_LEFT = 8
MSG_RIGHT = 32

MSG_SMALL = 0
MSG_REG = 1
MSG_LRG = 2

MPH = 2.23693629
KMH = 3.6

FULLSCREEN = 0
FRONT_AND_CENTERED = 1
VIDEO_CALL = 2

PLAY = 1
PAUSE = 2
STOP = 4
SEEK = 8

PAUSE_GAME = 1
DONT_PAUSE_GAME = 0

gSpeedUnits = MPH

gStopLocation = ""
gStopEvent = ""
gStopPlayerServiceName = "Driver Training"

gVideoPlaying = FALSE
gEventOnVideoStop = ""
gVideoName = ""

gSpeedEvents = {}
gControllerTriggers = {}
gControllerEvents = {}

function WatchForStopAt( location, event, tooFarEvent )
	gStopLocation = location
	gStopEvent = event
	gTooFarEvent = tooFarEvent
end

function ClearStopAt()
	gStopLocation = ""
	gStopEvent = ""
end

function FireEvent( event )
	if (string.sub(event, 1, 7) == "Message") then
		DisplayRecordedMessage(string.sub(event, 8))
	else
		_G["OnEvent" .. event]()
	end
end

function InfoMessage(msg)
	SysCall ( "ScenarioManager:ShowMessage", msg );
end

function OnEvent( event )
	-- SysCall ("ScenarioManager:ShowInfoMessageExt", "4e082f8e-538d-4b5a-a970-180f9af07d27", "OnEvent... [" .. event .. "]", 15, MSG_LEFT + MSG_TOP, MSG_SMALL, TRUE );
	if (gVideoPlaying == TRUE) then
		gEventOnVideoStop = event
	else
		FireEvent(event);
	end
end

function PlayCamera(camera)
	SysCall ( "CameraManager:ActivateCamera", camera, 0 );
end

function LockControls()
	SysCall ( "ScenarioManager:LockControls");
end

function UnlockControls()
	SysCall ( "ScenarioManager:UnlockControls");
end

function TestConditionWaitForVideoToStop()
	local result = SysCall("ScenarioManager:IsVideoMessagePlaying", gVideoName);
	if ((result == "1") or (result == 1)) then
		gVideoPlaying = TRUE
		return FALSE;
	else
		gVideoPlaying = FALSE
		gVideoName = ""
		if (gEventOnVideoStop ~= "") then
			FireEvent(gEventOnVideoStop);
		end
		return TRUE;
	end
end

function TestConditionStopAtLocation()
	if (gStopLocation ~= "Setup Zone") then
		Speed = math.abs(SysCall("PlayerEngine:GetSpeed"))
		local serviceAtDestination = SysCall("ScenarioManager:IsAtDestination", gStopPlayerServiceName, gStopLocation);
		--Print("Player not in set up zone")
		if (Speed <= 0.01) and (serviceAtDestination == 1) then
			--Print("Player not moving")
		--	Info("Stopped - testing")
			--Print("Destination stuff")
			--Info("Stopped - at destination")
			local stopEvent = gStopEvent
			ClearStopAt()
			OnEvent(stopEvent);
		elseif (Speed > 0.01 and (serviceAtDestination == 1) and StopFlag == 0) then
			StopFlag = 1
		elseif (Speed > 0.01 and (serviceAtDestination ~= 1) and StopFlag == 1) then
			OnEvent(gTooFarEvent);
			StopFlag = 2
		end
	end
	return FALSE;
end

function AddControllerEvent(name, trigger, event)
	gControllerTriggers[name] = trigger
	gControllerEvents[name] = event;
end

function RemoveControllerEvent(name)
	gControllerTriggers[name] = nil;
	gControllerEvents[name] = nil;
end

function TestConditionController()
	for controllerName, trigger in pairs(gControllerTriggers) do
		local value = SysCall("PlayerEngine:GetControlValue", controllerName, 0)
		
		local triggerOperator = string.sub(trigger, 1, 1)
		local triggerData = tonumber(string.sub(trigger, 2))
		
		if (triggerOperator == ">") then
			if (value >= triggerData) then
				local event = gControllerEvents[controllerName];
				RemoveControllerEvent(controllerName);
				FireEvent(event);
			end
		elseif (triggerOperator == "<") then
			if (value <= triggerData) then
				local event = gControllerEvents[controllerName];
				RemoveControllerEvent(controllerName);
				FireEvent(event);
			end
		elseif (triggerOperator == "=") then
			if (value == triggerData) then
				local event = gControllerEvents[controllerName];
				RemoveControllerEvent(controllerName);
				FireEvent(event);
			end
		end
	end
	
	return FALSE;
end

function AddSpeedEvent(speed, event)
	gSpeedEvents[speed] = event
end

function RemoveSpeedEvent(speed)
	gSpeedEvents[speed] = nil;
end

function TestConditionSpeed()
	CurrentSpeed = SysCall("PlayerEngine:GetSpeed") * gSpeedUnits
	
	for speedTrigger, event in pairs(gSpeedEvents) do
		speed = tonumber(string.sub(speedTrigger, 2))
		trigger = string.sub(speedTrigger, 1, 1)
		
		if (trigger == ">") then
			if (CurrentSpeed >= speed) then
				gSpeedEvents[speedTrigger] = nil;
				FireEvent(event);
			end
		elseif (trigger == "<") then
			if (CurrentSpeed <= speed) then
				gSpeedEvents[speedTrigger] = nil;
				FireEvent(event);
			end
		elseif (trigger == "=") then
			if (CurrentSpeed == speed) then
				gSpeedEvents[speedTrigger] = nil;
				FireEvent(event);
			end
		end
	end
	
	return FALSE;
end

function TestConditionOverspeed()
	CurrentSpeed = SysCall("PlayerEngine:GetSpeed") * gSpeedUnits
	SpeedLimit = SysCall( "PlayerEngine:GetCurrentSpeedLimit" ) * gSpeedUnits
	ScenarioTime = SysCall("ScenarioManager:GetScenarioTime")

	if (SpeedLimit == nil) then
		SpeedLimit = 300
	end
	
	if (SpeedLimit ~= LastSpeedLimit) then
		ScenarioTimeInterval = ScenarioTime + 10
		LastSpeedLimit = SpeedLimit
	end
		
	if ScenarioTime >= ScenarioTimeInterval then
		if (Speed > SpeedLimit) then 
			InfoMessage("SpeedLimit:" .. SpeedLimit)
			SysCall( "ScenarioManager:ShowInfoMessageExt", "4e082f8e-538d-4b5a-a970-180f9af07d27", "ExceedLimit" .. SpeedLimit .. ".html", 25, MSG_RIGHT + MSG_TOP, MSG_SMALL, TRUE );
			SysCall("WindowsManager:HighlightControl", "Speed", 10.0, 0);
			SysCall("WindowsManager:HighlightControl", "SimpleThrottle", 10.0, 0);
		end
		ScenarioTimeInterval = ScenarioTime + 10
	end			
	return FALSE;
end

function DeferredEvent ( event, time )
	SysCall("ScenarioManager:TriggerDeferredEvent", event, time)
end


function TestCondition( condition )
	return _G["TestCondition" .. condition]()
end

function DisplayRecordedMessage( messageName )
	-- SysCall ("ScenarioManager:ShowInfoMessageExt", "4e082f8e-538d-4b5a-a970-180f9af07d27", "DRM... [" .. messageName .. "]", 15, MSG_LEFT + MSG_TOP, MSG_SMALL, TRUE );
	SysCall("RegisterRecordedMessage", "StartDisplay" .. messageName, "StopDisplay" .. messageName, 1);
end

function PlayCornerVideo( videoFile )
	gVideoName = videoFile
	SysCall("ScenarioManager:PlayVideoMessage", videoFile, VIDEO_CALL, DONT_PAUSE_GAME, 0, 0);
	SysCall ( "ScenarioManager:BeginConditionCheck", "WaitForVideoToStop" );
end

function PlayFullScreenVideo( videoFile )
	gVideoName = videoFile
	SysCall("ScenarioManager:PlayVideoMessage", videoFile, FULLSCREEN, PAUSE_GAME, (PLAY + PAUSE + SEEK), 0);
	SysCall ( "ScenarioManager:BeginConditionCheck", "WaitForVideoToStop" );
end

-- ====================================================================================
-- == EVENT HANDLERS
-- ====================================================================================
function OnEventStart()
	SysCall ("ScenarioManager:BeginConditionCheck", "StopAtLocation" );
	--SysCall ("ScenarioManager:BeginConditionCheck", "Speed" );
	--SysCall ("ScenarioManager:BeginConditionCheck", "Overspeed" );
	SysCall ("ScenarioManager:BeginConditionCheck", "Controller" );
end



-- ====================================================================================
-- ====================================================================================
-- ====================================================================================

function OnEventLockControls()
	LockControls()
end

function OnEventIntro()
	DisplayRecordedMessage("Intro")
end

function OnEventUnlockControls()
	UnlockControls()
end

--[[
function OnEventStartMoving()
	AddSpeedEvent(">1", "Moving")
end

function OnEventMoving()
	DisplayRecordedMessage("MovingCongrats")
	WatchForStopAt("Falmouth Approach 1", "Fred")
end
------------------------

function OnEventFred()
	InfoMessage("FRED!")

end

]]
-- ====================================================================================
-- == MESSAGE HANDLERS
-- ====================================================================================

-- ------------------------------------------------------------------------------------------

-- == Intro Message
function StartDisplayIntro()
	--SysCall ("ScenarioManager:ShowInfoMessageExt", "4e082f8e-538d-4b5a-a970-180f9af07d27", "you can get started", 15, MSG_LEFT + MSG_TOP, MSG_SMALL, TRUE );
	SysCall ( "ScenarioManager:ShowInfoMessageExt", "", "intro.html", 15, MSG_TOP + MSG_TOP, MSG_SMALL, TRUE );
end

function StopDisplayIntro()
end

--[[

-- == GetStarted
function StartDisplayGetStarted()
	SysCall ("ScenarioManager:ShowInfoMessageExt", "4e082f8e-538d-4b5a-a970-180f9af07d27", "you can get started", 15, MSG_LEFT + MSG_TOP, MSG_SMALL, TRUE );
end

function StopDisplayGetStarted()
end
-- ------------------------------------------------------------------------------------------


-- ------------------------------------------------------------------------------------------
-- == MovingCongrats
function StartDisplayMovingCongrats()
	SysCall ("ScenarioManager:ShowInfoMessageExt", "4e082f8e-538d-4b5a-a970-180f9af07d27", "you got moving", 15, MSG_LEFT + MSG_TOP, MSG_SMALL, TRUE );
end

function StopDisplayMovingCongrats()
end
-- ------------------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------
-- == MovingCongrats
function StartDisplayCutOffForwards()
	SysCall ("ScenarioManager:ShowInfoMessageExt", "4e082f8e-538d-4b5a-a970-180f9af07d27", "move your cut off full forwards", 15, MSG_LEFT + MSG_TOP, MSG_SMALL, TRUE );
end

function StopDisplayCutOffForwards()
end
-- ------------------------------------------------------------------------------------------


-- ------------------------------------------------------------------------------------------
-- == MovingCongrats
function StartDisplayTimeToGo()
	SysCall ("ScenarioManager:ShowInfoMessageExt", "4e082f8e-538d-4b5a-a970-180f9af07d27", "move your regulator up a bit", 15, MSG_LEFT + MSG_TOP, MSG_SMALL, TRUE );
end

function StopDisplayTimeToGo()
end
-- ------------------------------------------------------------------------------------------


-- ------------------------------------------------------------------------------------------
-- == MovingCongrats
function StartDisplayFinished()
	SysCall ("ScenarioManager:ShowInfoMessageExt", "4e082f8e-538d-4b5a-a970-180f9af07d27", "you're done, now go back having changed the point.", 15, MSG_LEFT + MSG_TOP, MSG_SMALL, TRUE );
end

function StopDisplayFinished()
end
]]
-- ------------------------------------------------------------------------------------------


-- ====================================================================================
-- ====================================================================================
-- ====================================================================================
