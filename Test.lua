repeat task.wait()
    if not game:IsLoaded() then
        task.wait();
    end;
until game:IsLoaded();
local Loadui = true
repeat task.wait() until game:IsLoaded();
repeat task.wait() until game:GetService("Players");
repeat task.wait() until game:GetService("Players").LocalPlayer;
repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui;
repeat task.wait() until game:GetService("ReplicatedStorage").Effect.Container;
local InputService = game:GetService('UserInputService');
local TextService = game:GetService('TextService');
local CoreGui = game:GetService('CoreGui');
local Teams = game:GetService('Teams');
local Players = game:GetService('Players');
local RunService = game:GetService('RunService')
local TweenService = game:GetService('TweenService');
local RenderStepped = RunService.RenderStepped;
local LocalPlayer = Players.LocalPlayer;
local Mouse = LocalPlayer:GetMouse();

getgenv().Config = {
    Tooltip = "",
    FastAttack = false,
    AutoFarmBone = false,
    AutoFarm = false,
    Color = Color3.fromRGB(0,0,0),
    SelectLegendarySwords = {""},
    SelectHakiColors = {""},
    FastAttackDelay = 0,
    FastAttackIncrement = 1,
    Points = 1,
    SelectToolFarmMas = "",
    MobHealth = 30,
    SelectChip = "",
    SelectLocation = ""
};

if game.Players.LocalPlayer.Character:FindFirstChild("Root") then
    game.Players.LocalPlayer.Character:FindFirstChild("Root"):Destroy();
end;

local function SendKey(Key,time)
    game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode[Key],false,game);
    task.wait(time);
    game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode[Key],false,game);
end;

local FirstSea,SecondSea,ThirdSea;

if game.PlaceId == 2753915549 then
    FirstSea = true;
elseif game.PlaceId == 4442272183 then
    SecondSea = true;
elseif game.PlaceId == 7449423635 then
    ThirdSea = true;
end;

task.spawn(function()
    while task.wait() do
        for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.ToolTip == "Gun" then
                if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                    Gun = v.Name;
                end;
            end;
        end;
        for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.ToolTip == "Sword" then
                if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                    Sword = v.Name;
                end;
            end;
        end;
        for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.ToolTip == "Blox Fruit" then
                if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                    DevilFruit = v.Name;
                end;
            end;
        end;
    end;
end);

local function fireproximityprompt(Obj, Distance, Amount, Skip)
    if Obj.ClassName == "ProximityPrompt" then 
        if Obj.MaxActivationDistance ~= Distance then
            Obj.MaxActivationDistance = Distance
        end
        task.wait()
        Amount = Amount or 1
        local PromptTime = Obj.HoldDuration
        if Skip then 
            Obj.HoldDuration = 0
        end
        for i = 1, Amount do 
            Obj:InputHoldBegin()
            if not Skip then 
                task.wait(Obj.HoldDuration)
            end
            Obj:InputHoldEnd()
        end
        Obj.HoldDuration = PromptTime
    else 
        error("userdata<ProximityPrompt> expected")
    end
end

task.spawn(function()
    while true do task.wait()
        getgenv().rejoin = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(Kick)
            if Kick.Name == 'ErrorPrompt' and Kick:FindFirstChild('MessageArea') and Kick.MessageArea:FindFirstChild("ErrorFrame") then
                game:GetService("TeleportService"):Teleport(game.PlaceId);
            end;
        end);
    end;
end);

if game.Players.LocalPlayer.Team == nil then
    if game:GetService("Players").LocalPlayer.PlayerGui.Main:FindFirstChild("ChooseTeam") then
    	repeat task.wait()
    		if game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Main").ChooseTeam.Visible == true then
    			if Teams == 'Pirates' then
                    for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.Activated)) do                                                                                                
                        v.Function();
                    end;
                elseif Teams == 'Marines' then
                    for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton.Activated)) do                                                                                                
                        v.Function();
                    end;
                else
                    for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.Activated)) do                                                                                                
                        v.Function();
                    end;
                end;
            end;
    	until game.Players.LocalPlayer.Team ~= nil;
    end;
end;


print("[ Loading Functions ]")

local function QuestCheck()
    local Lvl = game:GetService("Players").LocalPlayer.Data.Level.Value
    if Lvl >= 1 and Lvl <= 9 then
        if tostring(game.Players.LocalPlayer.Team) == "Marines" then
            MobName = "Trainee [Lv. 5]";
            QuestName = "MarineQuest";
            QuestLevel = 1;
            Mon = "Trainee";
            NPCPosition = CFrame.new(-2709.67944, 24.5206585, 2104.24585, -0.744724929, -3.97967455e-08, -0.667371571, 4.32403588e-08, 1, -1.07884304e-07, 0.667371571, -1.09201515e-07, -0.744724929);
        elseif tostring(game.Players.LocalPlayer.Team) == "Pirates" then
            MobName = "Bandit [Lv. 5]";
            Mon = "Bandit";
            QuestName = "BanditQuest1";
            QuestLevel = 1;
            NPCPosition = CFrame.new(1059.99731, 16.9222069, 1549.28162, -0.95466274, 7.29721794e-09, 0.297689587, 1.05190106e-08, 1, 9.22064114e-09, -0.297689587, 1.19340022e-08, -0.95466274);
        end;
        return {
            [1] = QuestLevel,
            [2] = NPCPosition,
            [3] = MobName,
            [4] = QuestName,
            [5] = LevelRequire,
            [6] = Mon,
            [7] = MobCFrame
        };
    end;
    if FirstSea and Lvl >= 700 then
        return {
            [1] = 2,
            [2] = CFrame.new(5256, 39, 4050),
            [3] = "Galley Captain [Lv. 650]",
            [4] = "FountainQuest",
            [5] = 650,
            [6] = "Galley Captain",
            [7] = CFrame.new(5649, 39, 4936)
        };
    elseif SecondSea and Lvl >= 1500 then
        return {
            [1] = 2,
            [2] = CFrame.new(-3054, 237, -10148),
            [3] = "Water Fighter [Lv. 1450]",
            [4] = "ForgottenQuest",
            [5] = 1450,
            [6] = "Water Fighter",
            [7] = CFrame.new(-3385, 239, -10542)
        };
    end
    local GuideModule = require(game:GetService("ReplicatedStorage").GuideModule)
    local Quests = require(game:GetService("ReplicatedStorage").Quests)
    for i,v in pairs(GuideModule["Data"]["NPCList"]) do
        for i1,v1 in pairs(v["Levels"]) do
            if Lvl >= v1 then
                if not LevelRequire then
                    LevelRequire = 0;
                end;
                if v1 > LevelRequire then
                    NPCPosition = i["CFrame"];
                    QuestLevel = i1;
                    LevelRequire = v1;
                end;
                if #v["Levels"] == 3 and QuestLevel == 3 then
                    NPCPosition = i["CFrame"];
                    QuestLevel = 2;
                    LevelRequire = v["Levels"][2];
                end;
            end;
        end;
    end;
    for i,v in pairs(Quests) do
        for i1,v1 in pairs(v) do
            if v1["LevelReq"] == LevelRequire and i ~= "CitizenQuest" then
                QuestName = i;
                for i2,v2 in pairs(v1["Task"]) do
                    MobName = i2;
                    Enemy = string.split(i2," [Lv. ".. v1["LevelReq"] .. "]")[1];
                end;
            end;
        end;
    end;
    if QuestName == "MarineQuest2" then
        QuestName = "MarineQuest2";
        QuestLevel = 1;
        MobName = "Chief Petty Officer [Lv. 120]";
        Mon = "Chief Petty Officer";
        LevelRequire = 120;
        return {
            [1] = QuestLevel,
            [2] = NPCPosition,
            [3] = MobName,
            [4] = QuestName,
            [5] = LevelRequire,
            [6] = Mon,
            [7] = MobCFrame
        };
    elseif QuestName == "ImpelQuest" then
        QuestName = "PrisonerQuest";
        QuestLevel = 2;
        MobName = "Dangerous Prisoner [Lv. 190]";
        Mon = "Dangerous Prisoner";
        LevelRequire = 210;
        NPCPosition = CFrame.new(5310.60547, 0.350014925, 474.946594, 0.0175017118, 0, 0.999846935, 0, 1, 0, -0.999846935, 0, 0.0175017118);
        return {
            [1] = QuestLevel,
            [2] = NPCPosition,
            [3] = MobName,
            [4] = QuestName,
            [5] = LevelRequire,
            [6] = Mon,
            [7] = MobCFrame
        };
    elseif QuestName == "SkyExp1Quest" then
        if QuestLevel == 1 then
            NPCPosition = CFrame.new(-4721.88867, 843.874695, -1949.96643, 0.996191859, -0, -0.0871884301, 0, 1, -0, 0.0871884301, 0, 0.996191859);
        elseif QuestLevel == 2 then
            NPCPosition = CFrame.new(-7859.09814, 5544.19043, -381.476196, -0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, -0.422592998);
        end;
        return {
            [1] = QuestLevel,
            [2] = NPCPosition,
            [3] = MobName,
            [4] = QuestName,
            [5] = LevelRequire,
            [6] = Mon,
            [7] = MobCFrame
        };
    elseif QuestName == "Area2Quest" and QuestLevel == 2 then
        QuestName = "Area2Quest";
        QuestLevel = 1;
        MobName = "Swan Pirate [Lv. 775]";
        Mon = "Swan Pirate";
        LevelRequire = 775;
        return {
            [1] = QuestLevel,
            [2] = NPCPosition,
            [3] = MobName,
            [4] = QuestName,
            [5] = LevelRequire,
            [6] = Mon,
            [7] = MobCFrame
        };
    end;
    MobName = MobName:sub(1,#MobName);
    if not MobName:find("Lv") then
        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
            MonLV = string.match(v.Name, "%d+")
            if v.Name:find(MobName) and #v.Name > #MobName and tonumber(MonLV) <= Lvl + 50 then
                MobName = v.Name;
            end;
        end;
    end;
    if not MobName:find("Lv") then
        for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
            MonLV = string.match(v.Name, "%d+")
            if v.Name:find(MobName) and #v.Name > #MobName and tonumber(MonLV) <= Lvl + 50 then
                MobName = v.Name;
            end;
        end;
    end;
    local MobCFrames = {}
    for i,v in pairs(game:GetService('Workspace')["_WorldOrigin"].EnemySpawns:GetChildren()) do
        if v.Name == Enemy then
            MobCFrame = v.CFrame * CFrame.new(0,30,0);
            table.insert(MobCFrames, v.CFrame);
        end;
    end;
    
    return {
        [1] = QuestLevel,
        [2] = NPCPosition,
        [3] = MobName,
        [4] = QuestName,
        [5] = LevelRequire,
        [6] = Enemy,
        [7] = MobCFrame,
        [8] = MobCFrames
    };
end;

local Increment = 1;
local plr = game.Players.LocalPlayer;
local CbFw = debug.getupvalues(require(plr.PlayerScripts.CombatFramework));
local CbFw2 = CbFw[2];

function GetCurrentBlade() 
    local p13 = CbFw2.activeController
    local ret = p13.blades[1]
    if not ret then return end
    while ret.Parent~=game.Players.LocalPlayer.Character do ret=ret.Parent end
    return ret
end

local function aos8dqttack() 
    local AC = CbFw2.activeController
    if AC and AC.equipped then
        local bladehit = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
            plr.Character,
            {plr.Character.HumanoidRootPart},
            40--Blade Size
        )
        local cac = {}
        local hash = {}
        local Ql=false
        for k, v in pairs(bladehit) do
            if v.Parent:FindFirstChild("HumanoidRootPart") and not hash[v.Parent] then
                if (v.Parent.HumanoidRootPart.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 35 then
                    Ql=true
                    table.insert(cac, v.Parent.HumanoidRootPart)
                    hash[v.Parent] = true
                else
                    table.clear(cac)
                end
            end
        end
        bladehit = cac
        if #bladehit > 0 then 
            pcall(function()
                for k, v in pairs(AC.animator.anims.basic) do
                    v:Play()
                end                  
            end)
            if plr.Character:FindFirstChildOfClass("Tool") and AC.blades and AC.blades[1] and Ql and game.Players.LocalPlayer.Character.Stun.Value == 0 then 
                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(GetCurrentBlade()))
                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, Increment, "")
                Increment=Increment+1
                if Increment >= 4 then
                    Increment = 1
                end
            end
        end
    end
end


local function Material(name)
    for _,_Material in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")) do
        if type(_Material) == "table" then
            if _Material.Type == "Material" then
                if _Material.Name == name then
                    return _Material.Count
                end
            end
        end
    end
    return 0
end

local function Tick(t)
	t = t or 0
	local start = tick()
	repeat
		RunService.Stepped:Wait()
	until (tick() - start) >= t
end

local function GetSwords(Weaponname)
    for i,v in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")) do
        if type(v) == "table" then
            if v.Type == "Sword" then
                if v.Name == Weaponname then
                    return true
                end
            end
        end
    end
    return false
end

function ServerHop()
    local PlaceID = game.PlaceId
    local AllIDs = {}
    local foundAnything = ""
    local actualHour = os.date("!*t").hour
    local Deleted = false
    function TPReturner()
        local Site;
        if foundAnything == "" then
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
        else
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
        end
        local ID = ""
        if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
            foundAnything = Site.nextPageCursor
        end
        local num = 0;
        for i,v in pairs(Site.data) do
            local Possible = true
            ID = tostring(v.id)
            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                for _,Existing in pairs(AllIDs) do
                    if num ~= 0 then
                        if ID == tostring(Existing) then
                            Possible = false
                        end
                    else
                        if tonumber(actualHour) ~= tonumber(Existing) then
                            local delFile = pcall(function()
                                AllIDs = {}
                                table.insert(AllIDs, actualHour)
                            end)
                        end
                    end
                    num = num + 1
                end
                if Possible == true then
                    table.insert(AllIDs, ID)
                    wait()
                    pcall(function()
                        wait()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                    end)
                    wait(4)
                end
            end
        end
    end
    function Teleport() 
        while wait() do
            pcall(function()
                TPReturner()
                if foundAnything ~= "" then
                    TPReturner()
                end
            end)
        end
    end
    Teleport()
end                   


local function Teleport1(...)
    local Pos = ...;
    local targetCFrame;
    if type(Pos) == "vector" then
        targetCFrame = CFrame.new(Pos);
    elseif type(Pos) == "userdata" then
        targetCFrame = Pos;
    elseif type(Pos) == "number" then
        targetCFrame = CFrame.new(unpack(Pos));
    end
    local r = game:GetService("Players").LocalPlayer
    local xTweenPosition = {}
    if not game.Players.LocalPlayer.Character:FindFirstChild("Root")then
    local K = Instance.new("Part",game.Players.LocalPlayer.Character) -- Create part
    K.Size = Vector3.new(20,0.5,20)
    K.Name = "Root"
    K.Anchored = true
    K.Transparency = 1
    K.CanCollide = false
    K.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame*CFrame.new(0,0.6,0) --spawn at player
    end
    local Tween_Service = game:service"TweenService"
    local TweenPosition = (targetCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude -- diatance
    local Magnitude=TweenInfo.new((game:GetService("Players")["LocalPlayer"].Character.Root.Position-Pos.Position).Magnitude/250,Enum.EasingStyle.Linear) -- Create Tween
    
    function xTweenPosition:Stop() --stop tween
    tween:Cancel()
    return tween
    end
    if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
    game.Players.LocalPlayer.Character.Humanoid.Sit = false
    end
    if TweenPosition <= 10 then
    pcall(function()
    tween:Cancel()
    game.Players.LocalPlayer.Character.Root.CFrame = Pos
    end)
    end

    local tween,error = pcall(function()
    tween=Tween_Service:Create(
    game.Players.LocalPlayer.Character["Root"],Magnitude,{CFrame=Pos})
    tween:Play();
    end);
    tween=Tween_Service:Create(
    game.Players.LocalPlayer.Character["Root"],Magnitude,{CFrame=Pos})
    tween:Play();
    if not tween then return error end;
    return xTweenPosition;
end;

local function Teleport(...)
    repeat task.wait() 
        if game:GetService('Players').LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
            local RealtargetPos = {...}
            local targetPos = RealtargetPos[1]
            local targetCFrame
            if type(targetPos) == "vector" then
                targetCFrame = CFrame.new(targetPos)
            elseif type(targetPos) == "userdata" then
                targetCFrame = targetPos
            elseif type(targetPos) == "number" then
                targetCFrame = CFrame.new(unpack(RealtargetPos))
            end
            local tweenfunc = {}
            local Dis = (targetCFrame.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude
            local tween_s = game:service"TweenService"
            local info = TweenInfo.new((targetCFrame.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude/295, Enum.EasingStyle.Linear)
            local tween = tween_s:Create(game:GetService("Players").LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = targetCFrame * CFrame.fromAxisAngle(Vector3.new(1,0,0), math.rad(0))})
            
            if Dis <= 1 then
                tween:Cancel()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetCFrame
            else
                tween:Play()
            end
            if getgenv().Config.Clip then
                tween:Play()
            else
                if tween then
                tween:Stop()end
            end
            if InstantTeleport then
                if Dis >= 3600 then
                    if game:GetService("Players").LocalPlayer.PlayerGui.Main:FindFirstChild("InCombat").Visible == false then
                        if tween then tween:Cancel() end
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetCFrame
                        game:GetService("ReplicatedStorage").Remotes.Location:FireServer()
                        game.Players.LocalPlayer.Character.Humanoid.Health =-math.huge
                    end
                else
                    tween:Play()
                end
            end

            function tweenfunc:Stop()
                tween:Cancel()
                return tween
            end

            if not tween then return tween end
            return tweenfunc
        else
            
        end
    until game.Players.LocalPlayer.Character.Humanoid.Health <= 0
end

local Player = game.Players.LocalPlayer
local function InstantTo(Pos)
    Player.Character.HumanoidRootPart.CFrame = Pos
    game:GetService("ReplicatedStorage").Remotes.Location:FireServer()
    Player.Character.Humanoid.Health =- math.huge
end

local function Tehwiqaleport(...)
	local RealtargetPos = {...}
	local targetPos = RealtargetPos[1]
	local RealTarget
	if type(targetPos) == "vector" then
		RealTarget = CFrame.new(math.floor(targetPos))
	elseif type(targetPos) == "userdata" then
		RealTarget = (targetPos)
	elseif type(targetPos) == "number" then
		RealTarget = math.floor(CFrame.new(unpack(RealtargetPos)))
	end
	if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health == 0 then if tween then tween:Cancel() end repeat wait() until game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health > 0; wait(0.2) end
	local tweenfunc = {}
	local Distance = (RealTarget.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude

    if Distance < 300 then
		Speed = 575
        Speed1 = 999
	else 
	    Speed = 350
        Speed1 = 310
    end
	local r = game:GetService("Players").LocalPlayer

	local Rot=game.Players.LocalPlayer.Character:FindFirstChild("Root")
    local sq = TweenInfo.new((RealTarget.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude/Speed1, Enum.EasingStyle.Linear)
	local tween_s = game:service"TweenService"
	local info = TweenInfo.new((RealTarget.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude/Speed, Enum.EasingStyle.Linear)
	local tweenw, err = pcall(function()
		--tween = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = RealTarget})
	end)
	local Hum = game.Players.LocalPlayer.Character.Root
	local X = math.floor(Hum.Position.x)
	local Y = math.floor(Hum.Position.y)
	local Z = math.floor(Hum.Position.z)
	local GetX=math.floor(RealTarget.x)
	local GetY=math.floor(RealTarget.y)
	local GetZ=math.floor(RealTarget.z)
    if Distance <= 4000 then
        if not game.Players.LocalPlayer.Character:FindFirstChild("Root")then 
            local K = Instance.new("Part",game.Players.LocalPlayer.Character) -- Create part
            K.Size = Vector3.new(0.1,0.1,0.1)
            K.Name = "Root"
            K.Anchored = true
            K.Transparency = 0.5
            K.CanCollide = false
            K.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame*CFrame.new(0,0.6,0) --spawn at player
        end
        if r:DistanceFromCharacter(Vector3.new(X,GetY,Z)) <= 10 then
            if r:DistanceFromCharacter(Vector3.new(GetX,Y,Z)) <= 10 then
                if r:DistanceFromCharacter(Vector3.new(X,Y,GetZ)) <= 10 then
                    tween = tween_s:Create(game.Players.LocalPlayer.Character["Root"], info, {CFrame = RealTarget})
                    tween:Play()
                else
                    tween = tween_s:Create(game.Players.LocalPlayer.Character["Root"], sq, {CFrame = CFrame.new(X,Y,GetZ)})
                    if (r.Character.Root.Position-CFrame.new(X,Y,GetZ).Position).Magnitude < 51 then
                        tween:Cancel()
                        r.Character.Root.CFrame=CFrame.new(X,Y,GetZ)
                    else
                        tween:Play()
                    end
                end
            else
                tween = tween_s:Create(game.Players.LocalPlayer.Character["Root"], sq, {CFrame = CFrame.new(GetX,Y,Z)})
                if (r.Character.Root.Position-CFrame.new(GetX,Y,Z).Position).Magnitude < 100 then
                    tween:Cancel()
                    r.Character.Root.CFrame=CFrame.new(GetX,Y,Z)
                else
                    tween:Play()
                end
            end
        else
            tween = tween_s:Create(game.Players.LocalPlayer.Character["Root"], sq, {CFrame = CFrame.new(X,GetY,Z)})
            if (r.Character.Root.Position-CFrame.new(X,GetY,Z).Position).Magnitude < 300 then
                tween:Cancel()
                r.Character.Root.CFrame=CFrame.new(X,GetY,Z)
            else
                tween:Play()
            end
        end
    else
        tween = tween_s:Create(game.Players.LocalPlayer.Character["Root"], info, {CFrame = RealTarget})
        tween:Play()
        --[[if not game.Players.LocalPlayer.Character:FindFirstChild("Root") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = RealTarget
            game:GetService("ReplicatedStorage").Remotes.Location:FireServer()
            game.Players.LocalPlayer.Character.Humanoid.Health =- math.huge
        else
            if game.Players.LocalPlayer.Character:FindFirstChild("Root") then
                game.Players.LocalPlayer.Character:FindFirstChild("Root"):Destroy()
            end
        end]]
    end
    
	function tweenfunc:Stop()
		tween:Cancel()
	end 

	function tweenfunc:Wait()
		tween.Completed:Wait()
	end 

	return tweenfunc
end

local function  pwowjwj(...)
    local TarGetPositions = {...}
	local Args_Positions = TarGetPositions[1]
	local PositionToTarget;
	if type(Args_Positions) == "vector" then
		PositionToTarget = CFrame.new(Args_Positions)
	elseif type(Args_Positions) == "userdata" then
		PositionToTarget = Args_Positions
	elseif type(Args_Positions) == "number" then
		PositionToTarget = CFrame.new(unpack(TarGetPositions))
	end;
    if not game.Players.LocalPlayer.Character:FindFirstChild("PartToTarGet") then
        local BodyPartToTarGet = Instance.new("Part",game.Players.LocalPlayer.Character);
        BodyPartToTarGet.Name = "PartToTarGet"
        BodyPartToTarGet.Anchored = true
        BodyPartToTarGet.CanCollide = false
        BodyPartToTarGet.Transparency = 1
        BodyPartToTarGet.Size = Vector3.new(5,5,5)
        BodyPartToTarGet:PivotTo(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-3.9,0))
    end;
    task.wait()
    if not game.Players.LocalPlayer.Character:FindFirstChild("BodyPartCharacter") then
        local BodyPartTweens = Instance.new("Part",game.Players.LocalPlayer.Character);
        BodyPartTweens.Name = "BodyPartCharacter"
        BodyPartTweens.Anchored = true
        BodyPartTweens.CanCollide = false
        BodyPartTweens.Transparency = 1
        BodyPartTweens.Size = Vector3.new(20,0.5,20)
        BodyPartTweens:PivotTo(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-3.9,0))
    end;
	local Distance = game.Players.LocalPlayer:DistanceFromCharacter(PositionToTarget.Position);
    local X = math.floor(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.x);
    local Y = math.floor(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.y);
    local Z = math.floor(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.z);
    local BodyPartCharacterToTarGets = game.Players.LocalPlayer.Character.PartToTarGet;
    local BodyPartCharacter = game.Players.LocalPlayer.Character.BodyPartCharacter;
    local FuncTweens = game:GetService("TweenService")
    if Distance <= 250 then 
        game.Players.LocalPlayer.Character:PivotTo(PositionToTarget)
    elseif Distance <= 500 then
        Speed = 330
    elseif Distance >= 500 then
        Speed = 330
    elseif Distance <= 1000 then
        Speed = 325
    elseif Distance >= 1000 then
        Speed = 320
    end
    spawn(function() 
        pcall(function() 
            if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health == 0 then if ready then ready:Pause() end repeat wait() until game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health > 0; wait(0.2) end
            if game.Players.LocalPlayer.Character:FindFirstChild("PartToTarGet") then
                BodyPartCharacter.CanCollide = true
                BodyPartCharacter:PivotTo(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-3.8,0))
                game.Players.LocalPlayer.Character.PartToTarGet:PivotTo(PositionToTarget*CFrame.new(0,60,0))
                task.wait(.1)
                if (PositionToTarget.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 250 then
                    BodyPartCharacter.CanCollide = false
                    BodyPartCharacter:PivotTo(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-3.8,0))
                    ready:Pause()
                    game.Players.LocalPlayer.Character:PivotTo(PositionToTarget)
                else
                    BodyPartCharacter.CanCollide = true
                    BodyPartCharacter:PivotTo(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-3.8,0))
                    ready = FuncTweens:Create(
                    game.Players.LocalPlayer.Character.HumanoidRootPart,
                    TweenInfo.new((PositionToTarget.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude/Speed,Enum.EasingStyle.Linear),
                    {CFrame = game.Players.LocalPlayer.Character.PartToTarGet.CFrame});
                    ready:Play()
                end
            end;
        end);
    end);
end;

task.spawn(function()
    while task.wait() do
        if game.Players.LocalPlayer.Character:FindFirstChild("Root") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.Root.CFrame
        else

        end
    end
end) 

local function PartToPlayers() --teleport part to player
    game.Players.LocalPlayer.Character.Root.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
end
    
local function PlayersToPart() -- teleport player to part
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.Root.CFrame
end

task.spawn(function()
    while task.wait() do
        pcall(function ()
            if plr.Character.Humanoid.Health <= 0 then
                if game.Players.LocalPlayer.Character:FindFirstChild("Root") then
                    game.Players.LocalPlayer.Character:FindFirstChild("Root"):Destroy();
                end;
            end;
        end);
    end;
end);

local function BusoAndKen()
    if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso");
    end;
    if game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('Ken',false) then
        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('Ken',true);
    end;
end;

if game:GetService("ReplicatedStorage").Effect.Container:FindFirstChild("Death") then
    game:GetService("ReplicatedStorage").Effect.Container.Death:Destroy();
end;
if game:GetService("ReplicatedStorage").Effect.Container:FindFirstChild("Respawn") then
    game:GetService("ReplicatedStorage").Effect.Container.Respawn:Destroy();
end;



task.spawn(function()
	while true do task.wait()
		if setscriptable then
			setscriptable(game.Players.LocalPlayer, "SimulationRadius", true);
		end;
		if sethiddenproperty then
			sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge);
		end;
	end;
end);

local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
local CombatFrameworkR = getupvalues(CombatFramework)[2]
local RigController = require(game:GetService("Players")["LocalPlayer"].PlayerScripts.CombatFramework.RigController)
local RigControllerR = getupvalues(RigController)[2]
local CbFwGetupvalue = getupvalues(CombatFramework)[2];


function GetWeapon()
    local Ac = p20.CbFwGetupvalue.activeController
    local blades1 = Ac.blades[1]
    if not blades1 then
        return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name
    end
    pcall(function()
        while blades1.Parent~=game.Players.LocalPlayer.Character do
            blades1=blades1.Parent
        end
    end)
    return blades1
end

function GetEnemiesPart()
    local Parts = {}
    local Client = game.Players.LocalPlayer
    local Enemies = game:GetService("Workspace").Enemies:GetChildren()
    for i=1,#Enemies do local v = Enemies[i]
        local Human = v:FindFirstChildOfClass("Humanoid")
        if Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < 51 then
            table.insert(Parts,Human.RootPart)
        end
    end
    return Parts
end

function attack()
    local Ac = CbFwGetupvalue.activeController
    if Ac and Ac.equipped then
        if game.Players.LocalPlayer.Character.Stun.Value == 0 then
            local EnemiesPart = GetEnemiesPart()
            if #EnemiesPart > 0 then
                if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and Ac.blades and Ac.blades[1] then 
                    Ac.animator.anims.basic[2]:Play(0.01,0.01,0.01)
                    game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(GetCurrentBlade()))
                    game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", EnemiesPart, 2, "")
                end
            end
        end
    end
end

function Click()
	game:GetService("VirtualUser"):CaptureController()
	game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
end

local function Sea1()
    if SecondSea or ThirdSea then
	    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain");
    end;
end;

local WeaponName

local function Sea2()
    if FirstSea or ThirdSea then
	    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa");
    end;
end;

local function Sea3()
    if FirstSea or SecondSea then
	    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou");
    end;
end;

local function EquipTool(Tool)
	pcall(function()
		if game.Players.LocalPlayer.Backpack:FindFirstChild(Tool) then 
			local ToolHumanoid = game.Players.LocalPlayer.Backpack:FindFirstChild(Tool);
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(ToolHumanoid);
		end;
	end);
end;

local function CheckMastery(name)
    if game.Players.LocalPlayer.Backpack:FindFirstChild(name) or game.Players.LocalPlayer.Character:FindFirstChild(name) then
        return tonumber(game.Players.LocalPlayer.Backpack:FindFirstChild(name).Level.Value);
    end;
    return nil;
end;

local function FruitMasCheck()
    if game:GetService("Players").LocalPlayer.Character:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value) then
        return game:GetService("Players").LocalPlayer.Character[game.Players.LocalPlayer.Data.DevilFruit.Value].Level.Value;
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value) then
        return game:GetService("Players").LocalPlayer.Backpack[game.Players.LocalPlayer.Data.DevilFruit.Value].Level.Value;
    end;
end;

local function FindBackPack(Item)
    if game.Players.LocalPlayer.Character:FindFirstChild(Item) or game.Players.LocalPlayer.Backpack:FindFirstChild(Item) then
        return true;
    end;
    return false;
end;

local function MaxMasFruit(arg)
    for i,v in pairs(require(game:GetService("Players").LocalPlayer.Backpack[game.Players.LocalPlayer.Data.DevilFruit.Value].Data)) do
        if i == 'Lvl' then          
            for a,b in pairs(v) do
                if a == tostring(arg) then
                    return b;
                end;
            end;
        end;
    end;
end;

local function FruitName()
    if game:GetService("Players").LocalPlayer.Character:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value) then
        return game:GetService("Players").LocalPlayer.Character[game.Players.LocalPlayer.Data.DevilFruit.Value];
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value) then
        return game:GetService("Players").LocalPlayer.Backpack[game.Players.LocalPlayer.Data.DevilFruit.Value];
    end;
end;

spawn(function()
	game:GetService("RunService").RenderStepped:Connect(function()
		pcall(function()
			if getgenv().Config.Clip or getgenv().Config.AutoFarm then
				if syn or (identifyexecutor() == 'Krnl') then
					setfflag("HumanoidParallelRemoveNoPhysics", "False");
					setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False");
					game.Players.LocalPlayer.Character.Humanoid:ChangeState(11);
				else
					if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
						if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1") then
							if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == true then
								game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false;
							end;
							local BodyVelocity = Instance.new("BodyVelocity");
							BodyVelocity.Name = "BodyVelocity1";
							BodyVelocity.Parent =  game:GetService("Players").LocalPlayer.Character.HumanoidRootPart;
							BodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000);
							BodyVelocity.Velocity = Vector3.new(0, 0, 0);
						end;
					end;
					for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
						if v:IsA("BasePart") then
							v.CanCollide = false;
						end;
					end;
				end;
			else
                if game.Players.LocalPlayer.Character:FindFirstChild("Root") then
                    game.Players.LocalPlayer.Character:FindFirstChild("Root"):Destroy();
                end;
				if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1") then
					game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1"):Destroy();
                end;
			end;
		end);
	end);
end);

function LoadSettings()
    if readfile and writefile and isfile and isfolder then
        if not isfolder("ZPU Hub") then
            makefolder("ZPU Hub")
        end
        if not isfolder("ZPU Hub/Blox Fruits/") then
            makefolder("ZPU Hub/Blox Fruits/")
        end
        if not isfile("ZPU Hub/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json") then
            writefile("ZPU Hub/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json", game:GetService("HttpService"):JSONEncode(getgenv().Config))
        else
            local Decode = game:GetService("HttpService"):JSONDecode(readfile("ZPU Hub/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json"))
            for i,v in pairs(Decode) do
                getgenv().Config[i] = v
            end
        end
    else
        return warn("Status : Undetected Executor");
    end;
end;

function save()
    if readfile and writefile and isfile and isfolder then
        if not isfile("ZPU Hub/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json") then
            LoadSettings()
        else
            local Decode = game:GetService("HttpService"):JSONDecode(readfile("ZPU Hub/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json"))
            local Array = {}
            for i,v in pairs(getgenv().Config) do
                Array[i] = v
            end
            writefile("ZPU Hub/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json", game:GetService("HttpService"):JSONEncode(Array))
        end
    else
        return warn("Status : Undetected Executor")
    end
end;

print("[ All Functions Loadded ]");

local function LoadUI(Hub)
    local Cam = game.Workspace.CurrentCamera;
    local Info = TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0);
    local Start = {FieldOfView = 35};
    local End = {FieldOfView = 70};
    local TweenService = game:GetService("TweenService");

    if game.CoreGui:FindFirstChild("Loader") then
        game.CoreGui:FindFirstChild("Loader"):Destroy();
    end;

    local Loader = Instance.new("ScreenGui");
    local Main = Instance.new("Frame");
    local Main2 = Instance.new("Frame");
    local Loading = Instance.new("TextLabel");
    local LoadBar = Instance.new("Frame");
    local Frame = Instance.new("Frame");
    local HubName = Instance.new("TextLabel");
    local Bar = Instance.new("Frame");

    Loader.Name = "Loader";
    Loader.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui");
    Loader.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;

    Main.Name = "Main";
    Main.Parent = Loader;
    Main.AnchorPoint = Vector2.new(0.5, 0.5);
    Main.Position = UDim2.fromScale(0.5, 0.5);
    Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    Main.BorderColor3 = Color3.fromRGB(255, 255, 255);
    Main.Size = UDim2.new(0, 255, 0, 100);

    Main2.Name = "Main2";
    Main2.Parent = Main;
    Main2.BackgroundColor3 = Color3.fromRGB(24, 24, 24);
    Main2.BorderColor3 = Color3.fromRGB(255, 255, 255);
    Main2.Position = UDim2.new(0, 8, 0, 12);
    Main2.Size = UDim2.new(0.941176474, -1, 0.819999993, -2);

    Loading.Name = "Loading";
    Loading.Parent = Main2;
    Loading.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    Loading.BackgroundTransparency = 1.000;
    Loading.Position = UDim2.new(0.075313814, 0, -0.099999994, 0);
    Loading.Size = UDim2.new(0, 200, 0, 50);
    Loading.Font = Enum.Font.Code;
    Loading.Text = "Loading UI";
    Loading.TextColor3 = Color3.fromRGB(255, 255, 255);
    Loading.TextSize = 14.000;

    spawn(function()
        for i = 1, 2 do 
            wait(.3);
            Loading.Text = "Loading UI.";
            wait(.3);
            Loading.Text = "Loading UI..";
            wait(.3);
            Loading.Text = "Loading UI...";
            wait(.3);
            Loading.Text = "Loading UI....";
            wait(.3);
            Loading.Text = "Loading UI.....";
        end;
    end);

    LoadBar.Name = "LoadBar";
    LoadBar.Parent = Main2;
    LoadBar.BackgroundColor3 = Color3.fromRGB(24, 24, 24);
    LoadBar.Position = UDim2.new(0.0292887036, 0, 0.625, 0);
    LoadBar.Size = UDim2.new(0, 224, 0, 15);

    Frame.Name = "LoadingBar";
    Frame.Parent = LoadBar;
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    Frame.BorderSizePixel = 0;
    Frame.Position = UDim2.new(0, 1, 0.067000322, 0);
    Frame.Size = UDim2.new(0, 1, 0, 13);

    spawn(function()
        TweenService:Create(Cam, Info, {FieldOfView = 80}):Play();
        wait(.5);
        TweenService:Create(Cam, Info, {FieldOfView = 50}):Play();
        Frame:TweenSize(UDim2.new(0,222,0,13),"Out","Linear",5,true);
        wait(5);
        Loading.Text = "Loaded";
        wait(.8);
        Loading.Text = "Welcome to ZPU Hub";
        wait(.2);
        --Main:TweenPosition(UDim2.new(0.5,0,0,-1),"Out","Quad",1,true)
        TweenService:Create(Cam, Info, {FieldOfView = 30}):Play();
        wait(.5);
        TweenService:Create(Cam, Info, {FieldOfView = 70}):Play();
        Main:TweenPosition(UDim2.new(0.5,0,2,0),"Out","Quad",3,true);
        if game.CoreGui:FindFirstChild("Loader") then
            game.CoreGui:FindFirstChild("Loader"):Destroy();
        end;
    end);

    HubName.Name = "HubName";
    HubName.Parent = Main;
    HubName.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    HubName.BackgroundTransparency = 1.000;
    HubName.Position = UDim2.new(0.0313725509, 0, 0, 0);
    HubName.Size = UDim2.new(0, 239, 0, 12);
    HubName.Font = Enum.Font.Code;
    HubName.Text = Hub;
    HubName.TextColor3 = Color3.fromRGB(255, 255, 255);
    HubName.TextSize = 14.000;

    Bar.Name = "Bar";
    Bar.Parent = Main;
    Bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    Bar.BorderColor3 = Color3.fromRGB(255, 255, 255);
    Bar.Position = UDim2.new(0.301999986, 0, 0.419999987, 0);
    Bar.Size = UDim2.new(0, 100, 0, 1);

end;

if game:GetService("CoreGui"):FindFirstChild("Kenei") then
    game:GetService("CoreGui"):FindFirstChild("Kenei"):Destroy();
end;

if Loadui == true then
    LoadUI("ZPU Hub");

    task.wait(10);
end;

local ProtectGui = protectgui or (syn and syn.protect_gui) or (function() end);

local ScreenGui = Instance.new('ScreenGui');
ProtectGui(ScreenGui);

ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global;
ScreenGui.Parent = CoreGui;
ScreenGui.Name = "Kenei"

local Toggles = {};
local Options = {};

getgenv().Toggles = Toggles;
getgenv().Options = Options;

local Library = {
    Registry = {};
    RegistryMap = {};

    HudRegistry = {};

    FontColor = Color3.fromRGB(255, 255, 255);
    MainColor = Color3.fromRGB(28, 28, 28);
    BackgroundColor = Color3.fromRGB(20, 20, 20);
    AccentColor = Color3.fromRGB(0, 85, 255);
    OutlineColor = Color3.fromRGB(50, 50, 50);
    RiskColor = Color3.fromRGB(255, 50, 50),

    Black = Color3.new(0, 0, 0);
    Font = Enum.Font.Code,

    OpenedFrames = {};
    DependencyBoxes = {};

    Signals = {};
    ScreenGui = ScreenGui;
};

local RainbowStep = 0
local Hue = 0

table.insert(Library.Signals, RenderStepped:Connect(function(Delta)
    RainbowStep = RainbowStep + Delta

    if RainbowStep >= (1 / 60) then
        RainbowStep = 0

        Hue = Hue + (1 / 400);

        if Hue > 1 then
            Hue = 0;
        end;

        Library.CurrentRainbowHue = Hue;
        Library.CurrentRainbowColor = Color3.fromHSV(Hue, 0.8, 1);
    end
end))

local function GetPlayersString()
    local PlayerList = Players:GetPlayers();

    for i = 1, #PlayerList do
        PlayerList[i] = PlayerList[i].Name;
    end;

    table.sort(PlayerList, function(str1, str2) return str1 < str2 end);

    return PlayerList;
end;

local function GetTeamsString()
    local TeamList = Teams:GetTeams();

    for i = 1, #TeamList do
        TeamList[i] = TeamList[i].Name;
    end;

    table.sort(TeamList, function(str1, str2) return str1 < str2 end);
    
    return TeamList;
end;

function Library:SafeCallback(f, ...)
    if (not f) then
        return;
    end;

    if not Library.NotifyOnError then
        return f(...);
    end;

    local success, event = pcall(f, ...);

    if not success then
        local _, i = event:find(":%d+: ");

        if not i then
            return Library:Notify(event);
        end;

        return Library:Notify(event:sub(i + 1), 3);
    end;
end;

function Library:AttemptSave()
    if Library.SaveManager then
        Library.SaveManager:Save();
    end;
end;

function Library:Create(Class, Properties)
    local _Instance = Class;

    if type(Class) == 'string' then
        _Instance = Instance.new(Class);
    end;

    for Property, Value in next, Properties do
        _Instance[Property] = Value;
    end;

    return _Instance;
end;

function Library:ApplyTextStroke(Inst)
    Inst.TextStrokeTransparency = 1;

    Library:Create('UIStroke', {
        Color = Color3.new(0, 0, 0);
        Thickness = 1;
        LineJoinMode = Enum.LineJoinMode.Miter;
        Parent = Inst;
    });
end;

function Library:CreateLabel(Properties, IsHud)
    local _Instance = Library:Create('TextLabel', {
        BackgroundTransparency = 1;
        Font = Library.Font;
        TextColor3 = Library.FontColor;
        TextSize = 16;
        TextStrokeTransparency = 0;
    });

    Library:ApplyTextStroke(_Instance);

    Library:AddToRegistry(_Instance, {
        TextColor3 = 'FontColor';
    }, IsHud);

    return Library:Create(_Instance, Properties);
end;

function Library:MakeDraggable(Instance, Cutoff)
    Instance.Active = true;

    Instance.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            local ObjPos = Vector2.new(
                Mouse.X - Instance.AbsolutePosition.X,
                Mouse.Y - Instance.AbsolutePosition.Y
            );

            if ObjPos.Y > (Cutoff or 40) then
                return;
            end;

            while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                Instance.Position = UDim2.new(
                    0,
                    Mouse.X - ObjPos.X + (Instance.Size.X.Offset * Instance.AnchorPoint.X),
                    0,
                    Mouse.Y - ObjPos.Y + (Instance.Size.Y.Offset * Instance.AnchorPoint.Y)
                );

                RenderStepped:Wait();
            end;
        end;
    end)
end;

function Library:AddToolTip(InfoStr, HoverInstance)
    local X, Y = Library:GetTextBounds(InfoStr, Library.Font, 14);
    local Tooltip = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor,
        BorderColor3 = Library.OutlineColor,

        Size = UDim2.fromOffset(X + 5, Y + 4),
        ZIndex = 100,
        Parent = Library.ScreenGui,

        Visible = false,
    })

    local Label = Library:CreateLabel({
        Position = UDim2.fromOffset(3, 1),
        Size = UDim2.fromOffset(X, Y);
        TextSize = 14;
        Text = InfoStr,
        TextColor3 = Library.FontColor,
        TextXAlignment = Enum.TextXAlignment.Left;
        ZIndex = Tooltip.ZIndex + 1,

        Parent = Tooltip;
    });

    Library:AddToRegistry(Tooltip, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'OutlineColor';
    });

    Library:AddToRegistry(Label, {
        TextColor3 = 'FontColor',
    });

    local IsHovering = false

    HoverInstance.MouseEnter:Connect(function()
        if Library:MouseIsOverOpenedFrame() then
            return
        end

        IsHovering = true

        Tooltip.Position = UDim2.fromOffset(Mouse.X + 15, Mouse.Y + 12)
        Tooltip.Visible = true

        while IsHovering do
            RunService.Heartbeat:Wait()
            Tooltip.Position = UDim2.fromOffset(Mouse.X + 15, Mouse.Y + 12)
        end
    end)

    HoverInstance.MouseLeave:Connect(function()
        IsHovering = false
        Tooltip.Visible = false
    end)
end

function Library:OnHighlight(HighlightInstance, Instance, Properties, PropertiesDefault)
    HighlightInstance.MouseEnter:Connect(function()
        local Reg = Library.RegistryMap[Instance];

        for Property, ColorIdx in next, Properties do
            Instance[Property] = Library[ColorIdx] or ColorIdx;

            if Reg and Reg.Properties[Property] then
                Reg.Properties[Property] = ColorIdx;
            end;
        end;
    end)

    HighlightInstance.MouseLeave:Connect(function()
        local Reg = Library.RegistryMap[Instance];

        for Property, ColorIdx in next, PropertiesDefault do
            Instance[Property] = Library[ColorIdx] or ColorIdx;

            if Reg and Reg.Properties[Property] then
                Reg.Properties[Property] = ColorIdx;
            end;
        end;
    end)
end;

function Library:MouseIsOverOpenedFrame()
    for Frame, _ in next, Library.OpenedFrames do
        local AbsPos, AbsSize = Frame.AbsolutePosition, Frame.AbsoluteSize;

        if Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X
            and Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y then

            return true;
        end;
    end;
end;

function Library:IsMouseOverFrame(Frame)
    local AbsPos, AbsSize = Frame.AbsolutePosition, Frame.AbsoluteSize;

    if Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X
        and Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y then

        return true;
    end;
end;

function Library:UpdateDependencyBoxes()
    for _, Depbox in next, Library.DependencyBoxes do
        Depbox:Update();
    end;
end;

function Library:MapValue(Value, MinA, MaxA, MinB, MaxB)
    return (1 - ((Value - MinA) / (MaxA - MinA))) * MinB + ((Value - MinA) / (MaxA - MinA)) * MaxB;
end;

function Library:GetTextBounds(Text, Font, Size, Resolution)
    local Bounds = TextService:GetTextSize(Text, Size, Font, Resolution or Vector2.new(1920, 1080))
    return Bounds.X, Bounds.Y
end;

function Library:GetDarkerColor(Color)
    local H, S, V = Color3.toHSV(Color);
    return Color3.fromHSV(H, S, V / 1.5);
end;
Library.AccentColorDark = Library:GetDarkerColor(Library.AccentColor);

function Library:AddToRegistry(Instance, Properties, IsHud)
    local Idx = #Library.Registry + 1;
    local Data = {
        Instance = Instance;
        Properties = Properties;
        Idx = Idx;
    };

    table.insert(Library.Registry, Data);
    Library.RegistryMap[Instance] = Data;

    if IsHud then
        table.insert(Library.HudRegistry, Data);
    end;
end;

function Library:RemoveFromRegistry(Instance)
    local Data = Library.RegistryMap[Instance];

    if Data then
        for Idx = #Library.Registry, 1, -1 do
            if Library.Registry[Idx] == Data then
                table.remove(Library.Registry, Idx);
            end;
        end;

        for Idx = #Library.HudRegistry, 1, -1 do
            if Library.HudRegistry[Idx] == Data then
                table.remove(Library.HudRegistry, Idx);
            end;
        end;

        Library.RegistryMap[Instance] = nil;
    end;
end;

function Library:UpdateColorsUsingRegistry()
    -- TODO: Could have an 'active' list of objects
    -- where the active list only contains Visible objects.

    -- IMPL: Could setup .Changed events on the AddToRegistry function
    -- that listens for the 'Visible' propert being changed.
    -- Visible: true => Add to active list, and call UpdateColors function
    -- Visible: false => Remove from active list.

    -- The above would be especially efficient for a rainbow menu color or live color-changing.

    for Idx, Object in next, Library.Registry do
        for Property, ColorIdx in next, Object.Properties do
            if type(ColorIdx) == 'string' then
                Object.Instance[Property] = Library[ColorIdx];
            elseif type(ColorIdx) == 'function' then
                Object.Instance[Property] = ColorIdx()
            end
        end;
    end;
end;

function Library:GiveSignal(Signal)
    -- Only used for signals not attached to library instances, as those should be cleaned up on object destruction by Roblox
    table.insert(Library.Signals, Signal)
end

function Library:Unload()
    -- Unload all of the signals
    for Idx = #Library.Signals, 1, -1 do
        local Connection = table.remove(Library.Signals, Idx)
        Connection:Disconnect()
    end

     -- Call our unload callback, maybe to undo some hooks etc
    if Library.OnUnload then
        Library.OnUnload()
    end

    ScreenGui:Destroy()
end

function Library:OnUnload(Callback)
    Library.OnUnload = Callback
end

Library:GiveSignal(ScreenGui.DescendantRemoving:Connect(function(Instance)
    if Library.RegistryMap[Instance] then
        Library:RemoveFromRegistry(Instance);
    end;
end))

local BaseAddons = {};

do
    local Funcs = {};

    function Funcs:AddColorPicker(Idx, Info)
        local ToggleLabel = self.TextLabel;
        -- local Container = self.Container;

        assert(Info.Default, 'AddColorPicker: Missing default value.');

        local ColorPicker = {
            Value = Info.Default;
            Transparency = Info.Transparency or 0;
            Type = 'ColorPicker';
            Title = type(Info.Title) == 'string' and Info.Title or 'Color picker',
            Callback = Info.Callback or function(Color) end;
        };

        function ColorPicker:SetHSVFromRGB(Color)
            local H, S, V = Color3.toHSV(Color);

            ColorPicker.Hue = H;
            ColorPicker.Sat = S;
            ColorPicker.Vib = V;
        end;

        ColorPicker:SetHSVFromRGB(ColorPicker.Value);

        local DisplayFrame = Library:Create('Frame', {
            BackgroundColor3 = ColorPicker.Value;
            BorderColor3 = Library:GetDarkerColor(ColorPicker.Value);
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(0, 28, 0, 14);
            ZIndex = 6;
            Parent = ToggleLabel;
        });

        -- Transparency image taken from https://github.com/matas3535/SplixPrivateDrawingLibrary/blob/main/Library.lua cus i'm lazy
        local CheckerFrame = Library:Create('ImageLabel', {
            BorderSizePixel = 0;
            Size = UDim2.new(0, 27, 0, 13);
            ZIndex = 5;
            Image = 'http://www.roblox.com/asset/?id=12977615774';
            Visible = not not Info.Transparency;
            Parent = DisplayFrame;
        });

        -- 1/16/23
        -- Rewrote this to be placed inside the Library ScreenGui
        -- There was some issue which caused RelativeOffset to be way off
        -- Thus the color picker would never show

        local PickerFrameOuter = Library:Create('Frame', {
            Name = 'Color';
            BackgroundColor3 = Color3.new(1, 1, 1);
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.fromOffset(DisplayFrame.AbsolutePosition.X, DisplayFrame.AbsolutePosition.Y + 18),
            Size = UDim2.fromOffset(230, Info.Transparency and 271 or 253);
            Visible = false;
            ZIndex = 15;
            Parent = ScreenGui,
        });

        DisplayFrame:GetPropertyChangedSignal('AbsolutePosition'):Connect(function()
            PickerFrameOuter.Position = UDim2.fromOffset(DisplayFrame.AbsolutePosition.X, DisplayFrame.AbsolutePosition.Y + 18);
        end)

        local PickerFrameInner = Library:Create('Frame', {
            BackgroundColor3 = Library.BackgroundColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 16;
            Parent = PickerFrameOuter;
        });

        local Highlight = Library:Create('Frame', {
            BackgroundColor3 = Library.AccentColor;
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 0, 2);
            ZIndex = 17;
            Parent = PickerFrameInner;
        });

        local SatVibMapOuter = Library:Create('Frame', {
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.new(0, 4, 0, 25);
            Size = UDim2.new(0, 200, 0, 200);
            ZIndex = 17;
            Parent = PickerFrameInner;
        });

        local SatVibMapInner = Library:Create('Frame', {
            BackgroundColor3 = Library.BackgroundColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 18;
            Parent = SatVibMapOuter;
        });

        local SatVibMap = Library:Create('ImageLabel', {
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 18;
            Image = 'rbxassetid://4155801252';
            Parent = SatVibMapInner;
        });

        local CursorOuter = Library:Create('ImageLabel', {
            AnchorPoint = Vector2.new(0.5, 0.5);
            Size = UDim2.new(0, 6, 0, 6);
            BackgroundTransparency = 1;
            Image = 'http://www.roblox.com/asset/?id=9619665977';
            ImageColor3 = Color3.new(0, 0, 0);
            ZIndex = 19;
            Parent = SatVibMap;
        });

        local CursorInner = Library:Create('ImageLabel', {
            Size = UDim2.new(0, CursorOuter.Size.X.Offset - 2, 0, CursorOuter.Size.Y.Offset - 2);
            Position = UDim2.new(0, 1, 0, 1);
            BackgroundTransparency = 1;
            Image = 'http://www.roblox.com/asset/?id=9619665977';
            ZIndex = 20;
            Parent = CursorOuter;
        })

        local HueSelectorOuter = Library:Create('Frame', {
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.new(0, 208, 0, 25);
            Size = UDim2.new(0, 15, 0, 200);
            ZIndex = 17;
            Parent = PickerFrameInner;
        });

        local HueSelectorInner = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(1, 1, 1);
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 18;
            Parent = HueSelectorOuter;
        });

        local HueCursor = Library:Create('Frame', { 
            BackgroundColor3 = Color3.new(1, 1, 1);
            AnchorPoint = Vector2.new(0, 0.5);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, 0, 0, 1);
            ZIndex = 18;
            Parent = HueSelectorInner;
        });

        local HueBoxOuter = Library:Create('Frame', {
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.fromOffset(4, 228),
            Size = UDim2.new(0.5, -6, 0, 20),
            ZIndex = 18,
            Parent = PickerFrameInner;
        });

        local HueBoxInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 18,
            Parent = HueBoxOuter;
        });

        Library:Create('UIGradient', {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 212, 212))
            });
            Rotation = 90;
            Parent = HueBoxInner;
        });

        local HueBox = Library:Create('TextBox', {
            BackgroundTransparency = 1;
            Position = UDim2.new(0, 5, 0, 0);
            Size = UDim2.new(1, -5, 1, 0);
            Font = Library.Font;
            PlaceholderColor3 = Color3.fromRGB(190, 190, 190);
            PlaceholderText = 'Hex color',
            Text = '#FFFFFF',
            TextColor3 = Library.FontColor;
            TextSize = 14;
            TextStrokeTransparency = 0;
            TextXAlignment = Enum.TextXAlignment.Left;
            ZIndex = 20,
            Parent = HueBoxInner;
        });

        Library:ApplyTextStroke(HueBox);

        local RgbBoxBase = Library:Create(HueBoxOuter:Clone(), {
            Position = UDim2.new(0.5, 2, 0, 228),
            Size = UDim2.new(0.5, -6, 0, 20),
            Parent = PickerFrameInner
        });

        local RgbBox = Library:Create(RgbBoxBase.Frame:FindFirstChild('TextBox'), {
            Text = '255, 255, 255',
            PlaceholderText = 'RGB color',
            TextColor3 = Library.FontColor
        });

        local TransparencyBoxOuter, TransparencyBoxInner, TransparencyCursor;
        
        if Info.Transparency then 
            TransparencyBoxOuter = Library:Create('Frame', {
                BorderColor3 = Color3.new(0, 0, 0);
                Position = UDim2.fromOffset(4, 251);
                Size = UDim2.new(1, -8, 0, 15);
                ZIndex = 19;
                Parent = PickerFrameInner;
            });

            TransparencyBoxInner = Library:Create('Frame', {
                BackgroundColor3 = ColorPicker.Value;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.new(1, 0, 1, 0);
                ZIndex = 19;
                Parent = TransparencyBoxOuter;
            });

            Library:AddToRegistry(TransparencyBoxInner, { BorderColor3 = 'OutlineColor' });

            Library:Create('ImageLabel', {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
                Image = 'http://www.roblox.com/asset/?id=12978095818';
                ZIndex = 20;
                Parent = TransparencyBoxInner;
            });

            TransparencyCursor = Library:Create('Frame', { 
                BackgroundColor3 = Color3.new(1, 1, 1);
                AnchorPoint = Vector2.new(0.5, 0);
                BorderColor3 = Color3.new(0, 0, 0);
                Size = UDim2.new(0, 1, 1, 0);
                ZIndex = 21;
                Parent = TransparencyBoxInner;
            });
        end;

        local DisplayLabel = Library:CreateLabel({
            Size = UDim2.new(1, 0, 0, 14);
            Position = UDim2.fromOffset(5, 5);
            TextXAlignment = Enum.TextXAlignment.Left;
            TextSize = 14;
            Text = ColorPicker.Title,--Info.Default;
            TextWrapped = false;
            ZIndex = 16;
            Parent = PickerFrameInner;
        });


        local ContextMenu = {}
        do
            ContextMenu.Options = {}
            ContextMenu.Container = Library:Create('Frame', {
                BorderColor3 = Color3.new(),
                ZIndex = 14,

                Visible = false,
                Parent = ScreenGui
            })

            ContextMenu.Inner = Library:Create('Frame', {
                BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.fromScale(1, 1);
                ZIndex = 15;
                Parent = ContextMenu.Container;
            });

            Library:Create('UIListLayout', {
                Name = 'Layout',
                FillDirection = Enum.FillDirection.Vertical;
                SortOrder = Enum.SortOrder.LayoutOrder;
                Parent = ContextMenu.Inner;
            });

            Library:Create('UIPadding', {
                Name = 'Padding',
                PaddingLeft = UDim.new(0, 4),
                Parent = ContextMenu.Inner,
            });

            local function updateMenuPosition()
                ContextMenu.Container.Position = UDim2.fromOffset(
                    (DisplayFrame.AbsolutePosition.X + DisplayFrame.AbsoluteSize.X) + 4,
                    DisplayFrame.AbsolutePosition.Y + 1
                )
            end

            local function updateMenuSize()
                local menuWidth = 60
                for i, label in next, ContextMenu.Inner:GetChildren() do
                    if label:IsA('TextLabel') then
                        menuWidth = math.max(menuWidth, label.TextBounds.X)
                    end
                end

                ContextMenu.Container.Size = UDim2.fromOffset(
                    menuWidth + 8,
                    ContextMenu.Inner.Layout.AbsoluteContentSize.Y + 4
                )
            end

            DisplayFrame:GetPropertyChangedSignal('AbsolutePosition'):Connect(updateMenuPosition)
            ContextMenu.Inner.Layout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(updateMenuSize)

            task.spawn(updateMenuPosition)
            task.spawn(updateMenuSize)

            Library:AddToRegistry(ContextMenu.Inner, {
                BackgroundColor3 = 'BackgroundColor';
                BorderColor3 = 'OutlineColor';
            });

            function ContextMenu:Show()
                self.Container.Visible = true
            end

            function ContextMenu:Hide()
                self.Container.Visible = false
            end

            function ContextMenu:AddOption(Str, Callback)
                if type(Callback) ~= 'function' then
                    Callback = function() end
                end

                local Button = Library:CreateLabel({
                    Active = false;
                    Size = UDim2.new(1, 0, 0, 15);
                    TextSize = 13;
                    Text = Str;
                    ZIndex = 16;
                    Parent = self.Inner;
                    TextXAlignment = Enum.TextXAlignment.Left,
                });

                Library:OnHighlight(Button, Button, 
                    { TextColor3 = 'AccentColor' },
                    { TextColor3 = 'FontColor' }
                );

                Button.InputBegan:Connect(function(Input)
                    if Input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                        return
                    end

                    Callback()
                end)
            end

            ContextMenu:AddOption('Copy color', function()
                Library.Colorgetgenv().Clipboard = ColorPicker.Value
                Library:Notify('Copied color!', 2)
            end)

            ContextMenu:AddOption('Paste color', function()
                if not Library.Colorgetgenv().Clipboard then
                    return Library:Notify('You have not copied a color!', 2)
                end
                ColorPicker:SetValueRGB(Library.Colorgetgenv().Clipboard)
            end)


            ContextMenu:AddOption('Copy HEX', function()
                pcall(setgetgenv().Clipboard, ColorPicker.Value:ToHex())
                Library:Notify('Copied hex code to getgenv().Clipboard!', 2)
            end)

            ContextMenu:AddOption('Copy RGB', function()
                pcall(setgetgenv().Clipboard, table.concat({ math.floor(ColorPicker.Value.R * 255), math.floor(ColorPicker.Value.G * 255), math.floor(ColorPicker.Value.B * 255) }, ', '))
                Library:Notify('Copied RGB values to getgenv().Clipboard!', 2)
            end)

        end

        Library:AddToRegistry(PickerFrameInner, { BackgroundColor3 = 'BackgroundColor'; BorderColor3 = 'OutlineColor'; });
        Library:AddToRegistry(Highlight, { BackgroundColor3 = 'AccentColor'; });
        Library:AddToRegistry(SatVibMapInner, { BackgroundColor3 = 'BackgroundColor'; BorderColor3 = 'OutlineColor'; });

        Library:AddToRegistry(HueBoxInner, { BackgroundColor3 = 'MainColor'; BorderColor3 = 'OutlineColor'; });
        Library:AddToRegistry(RgbBoxBase.Frame, { BackgroundColor3 = 'MainColor'; BorderColor3 = 'OutlineColor'; });
        Library:AddToRegistry(RgbBox, { TextColor3 = 'FontColor', });
        Library:AddToRegistry(HueBox, { TextColor3 = 'FontColor', });

        local SequenceTable = {};

        for Hue = 0, 1, 0.1 do
            table.insert(SequenceTable, ColorSequenceKeypoint.new(Hue, Color3.fromHSV(Hue, 1, 1)));
        end;

        local HueSelectorGradient = Library:Create('UIGradient', {
            Color = ColorSequence.new(SequenceTable);
            Rotation = 90;
            Parent = HueSelectorInner;
        });

        HueBox.FocusLost:Connect(function(enter)
            if enter then
                local success, result = pcall(Color3.fromHex, HueBox.Text)
                if success and typeof(result) == 'Color3' then
                    ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib = Color3.toHSV(result)
                end
            end

            ColorPicker:Display()
        end)

        RgbBox.FocusLost:Connect(function(enter)
            if enter then
                local r, g, b = RgbBox.Text:match('(%d+),%s*(%d+),%s*(%d+)')
                if r and g and b then
                    ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib = Color3.toHSV(Color3.fromRGB(r, g, b))
                end
            end

            ColorPicker:Display()
        end)

        function ColorPicker:Display()
            ColorPicker.Value = Color3.fromHSV(ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib);
            SatVibMap.BackgroundColor3 = Color3.fromHSV(ColorPicker.Hue, 1, 1);

            Library:Create(DisplayFrame, {
                BackgroundColor3 = ColorPicker.Value;
                BackgroundTransparency = ColorPicker.Transparency;
                BorderColor3 = Library:GetDarkerColor(ColorPicker.Value);
            });

            if TransparencyBoxInner then
                TransparencyBoxInner.BackgroundColor3 = ColorPicker.Value;
                TransparencyCursor.Position = UDim2.new(1 - ColorPicker.Transparency, 0, 0, 0);
            end;

            CursorOuter.Position = UDim2.new(ColorPicker.Sat, 0, 1 - ColorPicker.Vib, 0);
            HueCursor.Position = UDim2.new(0, 0, ColorPicker.Hue, 0);

            HueBox.Text = '#' .. ColorPicker.Value:ToHex()
            RgbBox.Text = table.concat({ math.floor(ColorPicker.Value.R * 255), math.floor(ColorPicker.Value.G * 255), math.floor(ColorPicker.Value.B * 255) }, ', ')

            Library:SafeCallback(ColorPicker.Callback, ColorPicker.Value);
            Library:SafeCallback(ColorPicker.Changed, ColorPicker.Value);
        end;

        function ColorPicker:OnChanged(Func)
            ColorPicker.Changed = Func;
            Func(ColorPicker.Value)
        end;

        function ColorPicker:Show()
            for Frame, Val in next, Library.OpenedFrames do
                if Frame.Name == 'Color' then
                    Frame.Visible = false;
                    Library.OpenedFrames[Frame] = nil;
                end;
            end;

            PickerFrameOuter.Visible = true;
            Library.OpenedFrames[PickerFrameOuter] = true;
        end;

        function ColorPicker:Hide()
            PickerFrameOuter.Visible = false;
            Library.OpenedFrames[PickerFrameOuter] = nil;
        end;

        function ColorPicker:SetValue(HSV, Transparency)
            local Color = Color3.fromHSV(HSV[1], HSV[2], HSV[3]);

            ColorPicker.Transparency = Transparency or 0;
            ColorPicker:SetHSVFromRGB(Color);
            ColorPicker:Display();
        end;

        function ColorPicker:SetValueRGB(Color, Transparency)
            ColorPicker.Transparency = Transparency or 0;
            ColorPicker:SetHSVFromRGB(Color);
            ColorPicker:Display();
        end;

        SatVibMap.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                    local MinX = SatVibMap.AbsolutePosition.X;
                    local MaxX = MinX + SatVibMap.AbsoluteSize.X;
                    local MouseX = math.clamp(Mouse.X, MinX, MaxX);

                    local MinY = SatVibMap.AbsolutePosition.Y;
                    local MaxY = MinY + SatVibMap.AbsoluteSize.Y;
                    local MouseY = math.clamp(Mouse.Y, MinY, MaxY);

                    ColorPicker.Sat = (MouseX - MinX) / (MaxX - MinX);
                    ColorPicker.Vib = 1 - ((MouseY - MinY) / (MaxY - MinY));
                    ColorPicker:Display();

                    RenderStepped:Wait();
                end;

                Library:AttemptSave();
            end;
        end);

        HueSelectorInner.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                    local MinY = HueSelectorInner.AbsolutePosition.Y;
                    local MaxY = MinY + HueSelectorInner.AbsoluteSize.Y;
                    local MouseY = math.clamp(Mouse.Y, MinY, MaxY);

                    ColorPicker.Hue = ((MouseY - MinY) / (MaxY - MinY));
                    ColorPicker:Display();

                    RenderStepped:Wait();
                end;

                Library:AttemptSave();
            end;
        end);

        DisplayFrame.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not Library:MouseIsOverOpenedFrame() then
                if PickerFrameOuter.Visible then
                    ColorPicker:Hide()
                else
                    ContextMenu:Hide()
                    ColorPicker:Show()
                end;
            elseif Input.UserInputType == Enum.UserInputType.MouseButton2 and not Library:MouseIsOverOpenedFrame() then
                ContextMenu:Show()
                ColorPicker:Hide()
            end
        end);

        if TransparencyBoxInner then
            TransparencyBoxInner.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                        local MinX = TransparencyBoxInner.AbsolutePosition.X;
                        local MaxX = MinX + TransparencyBoxInner.AbsoluteSize.X;
                        local MouseX = math.clamp(Mouse.X, MinX, MaxX);

                        ColorPicker.Transparency = 1 - ((MouseX - MinX) / (MaxX - MinX));

                        ColorPicker:Display();

                        RenderStepped:Wait();
                    end;

                    Library:AttemptSave();
                end;
            end);
        end;

        Library:GiveSignal(InputService.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                local AbsPos, AbsSize = PickerFrameOuter.AbsolutePosition, PickerFrameOuter.AbsoluteSize;

                if Mouse.X < AbsPos.X or Mouse.X > AbsPos.X + AbsSize.X
                    or Mouse.Y < (AbsPos.Y - 20 - 1) or Mouse.Y > AbsPos.Y + AbsSize.Y then

                    ColorPicker:Hide();
                end;

                if not Library:IsMouseOverFrame(ContextMenu.Container) then
                    ContextMenu:Hide()
                end
            end;

            if Input.UserInputType == Enum.UserInputType.MouseButton2 and ContextMenu.Container.Visible then
                if not Library:IsMouseOverFrame(ContextMenu.Container) and not Library:IsMouseOverFrame(DisplayFrame) then
                    ContextMenu:Hide()
                end
            end
        end))

        ColorPicker:Display();
        ColorPicker.DisplayFrame = DisplayFrame

        Options[Idx] = ColorPicker;

        return self;
    end;

    function Funcs:AddKeyPicker(Idx, Info)
        local ParentObj = self;
        local ToggleLabel = self.TextLabel;
        local Container = self.Container;

        assert(Info.Default, 'AddKeyPicker: Missing default value.');

        local KeyPicker = {
            Value = Info.Default;
            Toggled = false;
            Mode = Info.Mode or 'Toggle'; -- Always, Toggle, Hold
            Type = 'KeyPicker';
            Callback = Info.Callback or function(Value) end;
            ChangedCallback = Info.ChangedCallback or function(New) end;

            SyncToggleState = Info.SyncToggleState or false;
        };

        if KeyPicker.SyncToggleState then
            Info.Modes = { 'Toggle' }
            Info.Mode = 'Toggle'
        end

        local PickOuter = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(0, 28, 0, 15);
            ZIndex = 6;
            Parent = ToggleLabel;
        });

        local PickInner = Library:Create('Frame', {
            BackgroundColor3 = Library.BackgroundColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 7;
            Parent = PickOuter;
        });

        Library:AddToRegistry(PickInner, {
            BackgroundColor3 = 'BackgroundColor';
            BorderColor3 = 'OutlineColor';
        });

        local DisplayLabel = Library:CreateLabel({
            Size = UDim2.new(1, 0, 1, 0);
            TextSize = 13;
            Text = Info.Default;
            TextWrapped = true;
            ZIndex = 8;
            Parent = PickInner;
        });

        local ModeSelectOuter = Library:Create('Frame', {
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.fromOffset(ToggleLabel.AbsolutePosition.X + ToggleLabel.AbsoluteSize.X + 4, ToggleLabel.AbsolutePosition.Y + 1);
            Size = UDim2.new(0, 60, 0, 45 + 2);
            Visible = false;
            ZIndex = 14;
            Parent = ScreenGui;
        });

        ToggleLabel:GetPropertyChangedSignal('AbsolutePosition'):Connect(function()
            ModeSelectOuter.Position = UDim2.fromOffset(ToggleLabel.AbsolutePosition.X + ToggleLabel.AbsoluteSize.X + 4, ToggleLabel.AbsolutePosition.Y + 1);
        end);

        local ModeSelectInner = Library:Create('Frame', {
            BackgroundColor3 = Library.BackgroundColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 15;
            Parent = ModeSelectOuter;
        });

        Library:AddToRegistry(ModeSelectInner, {
            BackgroundColor3 = 'BackgroundColor';
            BorderColor3 = 'OutlineColor';
        });

        Library:Create('UIListLayout', {
            FillDirection = Enum.FillDirection.Vertical;
            SortOrder = Enum.SortOrder.LayoutOrder;
            Parent = ModeSelectInner;
        });

        local ContainerLabel = Library:CreateLabel({
            TextXAlignment = Enum.TextXAlignment.Left;
            Size = UDim2.new(1, 0, 0, 18);
            TextSize = 13;
            Visible = false;
            ZIndex = 110;
            Parent = Library.KeybindContainer;
        },  true);

        local Modes = Info.Modes or { 'Always', 'Toggle', 'Hold' };
        local ModeButtons = {};

        for Idx, Mode in next, Modes do
            local ModeButton = {};

            local Label = Library:CreateLabel({
                Active = false;
                Size = UDim2.new(1, 0, 0, 15);
                TextSize = 13;
                Text = Mode;
                ZIndex = 16;
                Parent = ModeSelectInner;
            });

            function ModeButton:Select()
                for _, Button in next, ModeButtons do
                    Button:Deselect();
                end;

                KeyPicker.Mode = Mode;

                Label.TextColor3 = Library.AccentColor;
                Library.RegistryMap[Label].Properties.TextColor3 = 'AccentColor';

                ModeSelectOuter.Visible = false;
            end;

            function ModeButton:Deselect()
                KeyPicker.Mode = nil;

                Label.TextColor3 = Library.FontColor;
                Library.RegistryMap[Label].Properties.TextColor3 = 'FontColor';
            end;

            Label.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    ModeButton:Select();
                    Library:AttemptSave();
                end;
            end);

            if Mode == KeyPicker.Mode then
                ModeButton:Select();
            end;

            ModeButtons[Mode] = ModeButton;
        end;

        function KeyPicker:Update()
            if Info.NoUI then
                return;
            end;

            local State = KeyPicker:GetState();

            ContainerLabel.Text = string.format('[%s] %s (%s)', KeyPicker.Value, Info.Text, KeyPicker.Mode);

            ContainerLabel.Visible = true;
            ContainerLabel.TextColor3 = State and Library.AccentColor or Library.FontColor;

            Library.RegistryMap[ContainerLabel].Properties.TextColor3 = State and 'AccentColor' or 'FontColor';

            local YSize = 0
            local XSize = 0

            for _, Label in next, Library.KeybindContainer:GetChildren() do
                if Label:IsA('TextLabel') and Label.Visible then
                    YSize = YSize + 18;
                    if (Label.TextBounds.X > XSize) then
                        XSize = Label.TextBounds.X
                    end
                end;
            end;

            Library.KeybindFrame.Size = UDim2.new(0, math.max(XSize + 10, 210), 0, YSize + 23)
        end;

        function KeyPicker:GetState()
            if KeyPicker.Mode == 'Always' then
                return true;
            elseif KeyPicker.Mode == 'Hold' then
                if KeyPicker.Value == 'None' then
                    return false;
                end

                local Key = KeyPicker.Value;

                if Key == 'MB1' or Key == 'MB2' then
                    return Key == 'MB1' and InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
                        or Key == 'MB2' and InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2);
                else
                    return InputService:IsKeyDown(Enum.KeyCode[KeyPicker.Value]);
                end;
            else
                return KeyPicker.Toggled;
            end;
        end;

        function KeyPicker:SetValue(Data)
            local Key, Mode = Data[1], Data[2];
            DisplayLabel.Text = Key;
            KeyPicker.Value = Key;
            ModeButtons[Mode]:Select();
            KeyPicker:Update();
        end;

        function KeyPicker:OnClick(Callback)
            KeyPicker.Clicked = Callback
        end

        function KeyPicker:OnChanged(Callback)
            KeyPicker.Changed = Callback
            Callback(KeyPicker.Value)
        end

        if ParentObj.Addons then
            table.insert(ParentObj.Addons, KeyPicker)
        end

        function KeyPicker:DoClick()
            if ParentObj.Type == 'Toggle' and KeyPicker.SyncToggleState then
                ParentObj:SetValue(not ParentObj.Value)
            end

            Library:SafeCallback(KeyPicker.Callback, KeyPicker.Toggled)
            Library:SafeCallback(KeyPicker.Clicked, KeyPicker.Toggled)
        end

        local Picking = false;

        PickOuter.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not Library:MouseIsOverOpenedFrame() then
                Picking = true;

                DisplayLabel.Text = '';

                local Break;
                local Text = '';

                task.spawn(function()
                    while (not Break) do
                        if Text == '...' then
                            Text = '';
                        end;

                        Text = Text .. '.';
                        DisplayLabel.Text = Text;

                        wait(0.4);
                    end;
                end);

                wait(0.2);

                local Event;
                Event = InputService.InputBegan:Connect(function(Input)
                    local Key;

                    if Input.UserInputType == Enum.UserInputType.Keyboard then
                        Key = Input.KeyCode.Name;
                    elseif Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                        Key = 'MB1';
                    elseif Input.UserInputType == Enum.UserInputType.MouseButton2 then
                        Key = 'MB2';
                    end;

                    Break = true;
                    Picking = false;

                    DisplayLabel.Text = Key;
                    KeyPicker.Value = Key;

                    Library:SafeCallback(KeyPicker.ChangedCallback, Input.KeyCode or Input.UserInputType)
                    Library:SafeCallback(KeyPicker.Changed, Input.KeyCode or Input.UserInputType)

                    Library:AttemptSave();

                    Event:Disconnect();
                end);
            elseif Input.UserInputType == Enum.UserInputType.MouseButton2 and not Library:MouseIsOverOpenedFrame() then
                ModeSelectOuter.Visible = true;
            end;
        end);

        Library:GiveSignal(InputService.InputBegan:Connect(function(Input)
            if (not Picking) then
                if KeyPicker.Mode == 'Toggle' then
                    local Key = KeyPicker.Value;

                    if Key == 'MB1' or Key == 'MB2' then
                        if Key == 'MB1' and Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch
                        or Key == 'MB2' and Input.UserInputType == Enum.UserInputType.MouseButton2 then
                            KeyPicker.Toggled = not KeyPicker.Toggled
                            KeyPicker:DoClick()
                        end;
                    elseif Input.UserInputType == Enum.UserInputType.Keyboard then
                        if Input.KeyCode.Name == Key then
                            KeyPicker.Toggled = not KeyPicker.Toggled;
                            KeyPicker:DoClick()
                        end;
                    end;
                end;

                KeyPicker:Update();
            end;

            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                local AbsPos, AbsSize = ModeSelectOuter.AbsolutePosition, ModeSelectOuter.AbsoluteSize;

                if Mouse.X < AbsPos.X or Mouse.X > AbsPos.X + AbsSize.X
                    or Mouse.Y < (AbsPos.Y - 20 - 1) or Mouse.Y > AbsPos.Y + AbsSize.Y then

                    ModeSelectOuter.Visible = false;
                end;
            end;
        end))

        Library:GiveSignal(InputService.InputEnded:Connect(function(Input)
            if (not Picking) then
                KeyPicker:Update();
            end;
        end))

        KeyPicker:Update();

        Options[Idx] = KeyPicker;

        return self;
    end;

    BaseAddons.__index = Funcs;
    BaseAddons.__namecall = function(Table, Key, ...)
        return Funcs[Key](...);
    end;
end;

local BaseGroupbox = {};

do
    local Funcs = {};

    function Funcs:AddBlank(Size)
        local Groupbox = self;
        local Container = Groupbox.Container;

        Library:Create('Frame', {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 0, Size);
            ZIndex = 1;
            Parent = Container;
        });
    end;

    function Funcs:AddLabel(Text, DoesWrap)
        local Label = {};

        local Groupbox = self;
        local Container = Groupbox.Container;

        local TextLabel = Library:CreateLabel({
            Size = UDim2.new(1, -4, 0, 15);
            TextSize = 14;
            Text = Text;
            TextWrapped = DoesWrap or false,
            TextXAlignment = Enum.TextXAlignment.Left;
            ZIndex = 5;
            Parent = Container;
        });

        if DoesWrap then
            local Y = select(2, Library:GetTextBounds(Text, Library.Font, 14, Vector2.new(TextLabel.AbsoluteSize.X, math.huge)))
            TextLabel.Size = UDim2.new(1, -4, 0, Y)
        else
            Library:Create('UIListLayout', {
                Padding = UDim.new(0, 4);
                FillDirection = Enum.FillDirection.Horizontal;
                HorizontalAlignment = Enum.HorizontalAlignment.Right;
                SortOrder = Enum.SortOrder.LayoutOrder;
                Parent = TextLabel;
            });
        end

        Label.TextLabel = TextLabel;
        Label.Container = Container;

        function Label:SetText(Text)
            TextLabel.Text = Text

            if DoesWrap then
                local Y = select(2, Library:GetTextBounds(Text, Library.Font, 14, Vector2.new(TextLabel.AbsoluteSize.X, math.huge)))
                TextLabel.Size = UDim2.new(1, -4, 0, Y)
            end

            Groupbox:Resize();
        end

        if (not DoesWrap) then
            setmetatable(Label, BaseAddons);
        end

        Groupbox:AddBlank(5);
        Groupbox:Resize();

        return Label;
    end;

    function Funcs:AddButton(...)
        -- TODO: Eventually redo this
        local Button = {};
        local function ProcessButtonParams(Class, Obj, ...)
            local Props = select(1, ...)
            if type(Props) == 'table' then
                Obj.Text = Props.Text
                Obj.Func = Props.Func
                Obj.DoubleClick = Props.DoubleClick
                Obj.Tooltip = Props.Tooltip
            else
                Obj.Text = select(1, ...)
                Obj.Func = select(2, ...)
            end

            assert(type(Obj.Func) == 'function', 'AddButton: `Func` callback is missing.');
        end

        ProcessButtonParams('Button', Button, ...)

        local Groupbox = self;
        local Container = Groupbox.Container;

        local function CreateBaseButton(Button)
            local Outer = Library:Create('Frame', {
                BackgroundColor3 = Color3.new(0, 0, 0);
                BorderColor3 = Color3.new(0, 0, 0);
                Size = UDim2.new(1, -4, 0, 20);
                ZIndex = 5;
            });

            local Inner = Library:Create('Frame', {
                BackgroundColor3 = Library.MainColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.new(1, 0, 1, 0);
                ZIndex = 6;
                Parent = Outer;
            });

            local Label = Library:CreateLabel({
                Size = UDim2.new(1, 0, 1, 0);
                TextSize = 14;
                Text = Button.Text;
                ZIndex = 6;
                Parent = Inner;
            });

            Library:Create('UIGradient', {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 212, 212))
                });
                Rotation = 90;
                Parent = Inner;
            });

            Library:AddToRegistry(Outer, {
                BorderColor3 = 'Black';
            });

            Library:AddToRegistry(Inner, {
                BackgroundColor3 = 'MainColor';
                BorderColor3 = 'OutlineColor';
            });

            Library:OnHighlight(Outer, Outer,
                { BorderColor3 = 'AccentColor' },
                { BorderColor3 = 'Black' }
            );

            return Outer, Inner, Label
        end

        local function InitEvents(Button)
            local function WaitForEvent(event, timeout, validator)
                local bindable = Instance.new('BindableEvent')
                local connection = event:Once(function(...)

                    if type(validator) == 'function' and validator(...) then
                        bindable:Fire(true)
                    else
                        bindable:Fire(false)
                    end
                end)
                task.delay(timeout, function()
                    connection:disconnect()
                    bindable:Fire(false)
                end)
                return bindable.Event:Wait()
            end

            local function ValidateClick(Input)
                if Library:MouseIsOverOpenedFrame() then
                    return false
                end

                if Input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                    return false
                end

                return true
            end

            Button.Outer.InputBegan:Connect(function(Input)
                if not ValidateClick(Input) then return end
                if Button.Locked then return end

                if Button.DoubleClick then
                    Library:RemoveFromRegistry(Button.Label)
                    Library:AddToRegistry(Button.Label, { TextColor3 = 'AccentColor' })

                    Button.Label.TextColor3 = Library.AccentColor
                    Button.Label.Text = 'Are you sure?'
                    Button.Locked = true

                    local clicked = WaitForEvent(Button.Outer.InputBegan, 0.5, ValidateClick)

                    Library:RemoveFromRegistry(Button.Label)
                    Library:AddToRegistry(Button.Label, { TextColor3 = 'FontColor' })

                    Button.Label.TextColor3 = Library.FontColor
                    Button.Label.Text = Button.Text
                    task.defer(rawset, Button, 'Locked', false)

                    if clicked then
                        Library:SafeCallback(Button.Func)
                    end

                    return
                end

                Library:SafeCallback(Button.Func);
            end)
        end

        Button.Outer, Button.Inner, Button.Label = CreateBaseButton(Button)
        Button.Outer.Parent = Container

        InitEvents(Button)

        function Button:AddTooltip(tooltip)
            if type(tooltip) == 'string' then
                Library:AddToolTip(tooltip, self.Outer)
            end
            return self
        end


        function Button:AddButton(...)
            local SubButton = {}

            ProcessButtonParams('SubButton', SubButton, ...)

            self.Outer.Size = UDim2.new(0.5, -2, 0, 20)

            SubButton.Outer, SubButton.Inner, SubButton.Label = CreateBaseButton(SubButton)

            SubButton.Outer.Position = UDim2.new(1, 3, 0, 0)
            SubButton.Outer.Size = UDim2.fromOffset(self.Outer.AbsoluteSize.X - 2, self.Outer.AbsoluteSize.Y)
            SubButton.Outer.Parent = self.Outer

            function SubButton:AddTooltip(tooltip)
                if type(tooltip) == 'string' then
                    Library:AddToolTip(tooltip, self.Outer)
                end
                return SubButton
            end

            if type(SubButton.Tooltip) == 'string' then
                SubButton:AddTooltip(SubButton.Tooltip)
            end

            InitEvents(SubButton)
            return SubButton
        end

        if type(Button.Tooltip) == 'string' then
            Button:AddTooltip(Button.Tooltip)
        end

        Groupbox:AddBlank(5);
        Groupbox:Resize();

        return Button;
    end;

    function Funcs:AddDivider()
        local Groupbox = self;
        local Container = self.Container

        local Divider = {
            Type = 'Divider',
        }

        Groupbox:AddBlank(2);
        local DividerOuter = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, -4, 0, 5);
            ZIndex = 5;
            Parent = Container;
        });

        local DividerInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 6;
            Parent = DividerOuter;
        });

        Library:AddToRegistry(DividerOuter, {
            BorderColor3 = 'Black';
        });

        Library:AddToRegistry(DividerInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        Groupbox:AddBlank(9);
        Groupbox:Resize();
    end

    function Funcs:AddInput(Idx, Info)
        assert(Info.Text, 'AddInput: Missing `Text` string.')

        local Textbox = {
            Value = Info.Default or '';
            Numeric = Info.Numeric or false;
            Finished = Info.Finished or false;
            Type = 'Input';
            Callback = Info.Callback or function(Value) end;
        };

        local Groupbox = self;
        local Container = Groupbox.Container;

        local InputLabel = Library:CreateLabel({
            Size = UDim2.new(1, 0, 0, 15);
            TextSize = 14;
            Text = Info.Text;
            TextXAlignment = Enum.TextXAlignment.Left;
            ZIndex = 5;
            Parent = Container;
        });

        Groupbox:AddBlank(1);

        local TextBoxOuter = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, -4, 0, 20);
            ZIndex = 5;
            Parent = Container;
        });

        local TextBoxInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 6;
            Parent = TextBoxOuter;
        });

        Library:AddToRegistry(TextBoxInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        Library:OnHighlight(TextBoxOuter, TextBoxOuter,
            { BorderColor3 = 'AccentColor' },
            { BorderColor3 = 'Black' }
        );

        if type(Info.Tooltip) == 'string' then
            Library:AddToolTip(Info.Tooltip, TextBoxOuter)
        end

        Library:Create('UIGradient', {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 212, 212))
            });
            Rotation = 90;
            Parent = TextBoxInner;
        });

        local Container = Library:Create('Frame', {
            BackgroundTransparency = 1;
            ClipsDescendants = true;

            Position = UDim2.new(0, 5, 0, 0);
            Size = UDim2.new(1, -5, 1, 0);

            ZIndex = 7;
            Parent = TextBoxInner;
        })

        local Box = Library:Create('TextBox', {
            BackgroundTransparency = 1;

            Position = UDim2.fromOffset(0, 0),
            Size = UDim2.fromScale(5, 1),

            Font = Library.Font;
            PlaceholderColor3 = Color3.fromRGB(190, 190, 190);
            PlaceholderText = Info.Placeholder or '';

            Text = Info.Default or '';
            TextColor3 = Library.FontColor;
            TextSize = 14;
            TextStrokeTransparency = 0;
            TextXAlignment = Enum.TextXAlignment.Left;

            ZIndex = 7;
            Parent = Container;
        });

        Library:ApplyTextStroke(Box);

        function Textbox:SetValue(Text)
            if Info.MaxLength and #Text > Info.MaxLength then
                Text = Text:sub(1, Info.MaxLength);
            end;

            if Textbox.Numeric then
                if (not tonumber(Text)) and Text:len() > 0 then
                    Text = Textbox.Value
                end
            end

            Textbox.Value = Text;
            Box.Text = Text;

            Library:SafeCallback(Textbox.Callback, Textbox.Value);
            Library:SafeCallback(Textbox.Changed, Textbox.Value);
        end;

        if Textbox.Finished then
            Box.FocusLost:Connect(function(enter)
                if not enter then return end

                Textbox:SetValue(Box.Text);
                Library:AttemptSave();
            end)
        else
            Box:GetPropertyChangedSignal('Text'):Connect(function()
                Textbox:SetValue(Box.Text);
                Library:AttemptSave();
            end);
        end

        -- https://devforum.roblox.com/t/how-to-make-textboxes-follow-current-cursor-position/1368429/6
        -- thank you nicemike40 :)

        local function Update()
            local PADDING = 2
            local reveal = Container.AbsoluteSize.X

            if not Box:IsFocused() or Box.TextBounds.X <= reveal - 2 * PADDING then
                -- we aren't focused, or we fit so be normal
                Box.Position = UDim2.new(0, PADDING, 0, 0)
            else
                -- we are focused and don't fit, so adjust position
                local cursor = Box.CursorPosition
                if cursor ~= -1 then
                    -- calculate pixel width of text from start to cursor
                    local subtext = string.sub(Box.Text, 1, cursor-1)
                    local width = TextService:GetTextSize(subtext, Box.TextSize, Box.Font, Vector2.new(math.huge, math.huge)).X

                    -- check if we're inside the box with the cursor
                    local currentCursorPos = Box.Position.X.Offset + width

                    -- adjust if necessary
                    if currentCursorPos < PADDING then
                        Box.Position = UDim2.fromOffset(PADDING-width, 0)
                    elseif currentCursorPos > reveal - PADDING - 1 then
                        Box.Position = UDim2.fromOffset(reveal-width-PADDING-1, 0)
                    end
                end
            end
        end

        task.spawn(Update)

        Box:GetPropertyChangedSignal('Text'):Connect(Update)
        Box:GetPropertyChangedSignal('CursorPosition'):Connect(Update)
        Box.FocusLost:Connect(Update)
        Box.Focused:Connect(Update)

        Library:AddToRegistry(Box, {
            TextColor3 = 'FontColor';
        });

        function Textbox:OnChanged(Func)
            Textbox.Changed = Func;
            Func(Textbox.Value);
        end;

        Groupbox:AddBlank(5);
        Groupbox:Resize();

        Options[Idx] = Textbox;

        return Textbox;
    end;

    function Funcs:AddToggle(Idx, Info)
        assert(Info.Text, 'AddInput: Missing `Text` string.')

        local Toggle = {
            Value = Info.Default or false;
            Type = 'Toggle';

            Callback = Info.Callback or function(Value) end;
            Addons = {},
            Risky = Info.Risky,
        };

        local Groupbox = self;
        local Container = Groupbox.Container;

        local ToggleOuter = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(0, 13, 0, 13);
            ZIndex = 5;
            Parent = Container;
        });

        Library:AddToRegistry(ToggleOuter, {
            BorderColor3 = 'Black';
        });

        local ToggleInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 6;
            Parent = ToggleOuter;
        });

        Library:AddToRegistry(ToggleInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        local ToggleLabel = Library:CreateLabel({
            Size = UDim2.new(0, 216, 1, 0);
            Position = UDim2.new(1, 6, 0, 0);
            TextSize = 14;
            Text = Info.Text;
            TextXAlignment = Enum.TextXAlignment.Left;
            ZIndex = 6;
            Parent = ToggleInner;
        });

        Library:Create('UIListLayout', {
            Padding = UDim.new(0, 4);
            FillDirection = Enum.FillDirection.Horizontal;
            HorizontalAlignment = Enum.HorizontalAlignment.Right;
            SortOrder = Enum.SortOrder.LayoutOrder;
            Parent = ToggleLabel;
        });

        local ToggleRegion = Library:Create('Frame', {
            BackgroundTransparency = 1;
            Size = UDim2.new(0, 170, 1, 0);
            ZIndex = 8;
            Parent = ToggleOuter;
        });

        Library:OnHighlight(ToggleRegion, ToggleOuter,
            { BorderColor3 = 'AccentColor' },
            { BorderColor3 = 'Black' }
        );

        function Toggle:UpdateColors()
            Toggle:Display();
        end;

        if type(Info.Tooltip) == 'string' then
            Library:AddToolTip(Info.Tooltip, ToggleRegion)
        end

        function Toggle:Display()
            ToggleInner.BackgroundColor3 = Toggle.Value and Library.AccentColor or Library.MainColor;
            ToggleInner.BorderColor3 = Toggle.Value and Library.AccentColorDark or Library.OutlineColor;

            Library.RegistryMap[ToggleInner].Properties.BackgroundColor3 = Toggle.Value and 'AccentColor' or 'MainColor';
            Library.RegistryMap[ToggleInner].Properties.BorderColor3 = Toggle.Value and 'AccentColorDark' or 'OutlineColor';
        end;

        function Toggle:OnChanged(Func)
            Toggle.Changed = Func;
            Func(Toggle.Value);
        end;

        function Toggle:SetValue(Bool)
            Bool = (not not Bool);

            Toggle.Value = Bool;
            Toggle:Display();

            for _, Addon in next, Toggle.Addons do
                if Addon.Type == 'KeyPicker' and Addon.SyncToggleState then
                    Addon.Toggled = Bool
                    Addon:Update()
                end
            end

            Library:SafeCallback(Toggle.Callback, Toggle.Value);
            Library:SafeCallback(Toggle.Changed, Toggle.Value);
            Library:UpdateDependencyBoxes();
        end;

        ToggleRegion.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not Library:MouseIsOverOpenedFrame() then
                Toggle:SetValue(not Toggle.Value) -- Why was it not like this from the start?
                Library:AttemptSave();
            end;
        end);

        if Toggle.Risky then
            Library:RemoveFromRegistry(ToggleLabel)
            ToggleLabel.TextColor3 = Library.RiskColor
            Library:AddToRegistry(ToggleLabel, { TextColor3 = 'RiskColor' })
        end

        Toggle:Display();
        Groupbox:AddBlank(Info.BlankSize or 5 + 2);
        Groupbox:Resize();

        Toggle.TextLabel = ToggleLabel;
        Toggle.Container = Container;
        setmetatable(Toggle, BaseAddons);

        Toggles[Idx] = Toggle;

        Library:UpdateDependencyBoxes();

        return Toggle;
    end;

    function Funcs:AddSlider(Idx, Info)
        assert(Info.Default, 'AddSlider: Missing default value.');
        assert(Info.Text, 'AddSlider: Missing slider text.');
        assert(Info.Min, 'AddSlider: Missing minimum value.');
        assert(Info.Max, 'AddSlider: Missing maximum value.');
        assert(Info.Rounding, 'AddSlider: Missing rounding value.');

        local Slider = {
            Value = Info.Default;
            Min = Info.Min;
            Max = Info.Max;
            Rounding = Info.Rounding;
            MaxSize = 232;
            Type = 'Slider';
            Callback = Info.Callback or function(Value) end;
        };

        local Groupbox = self;
        local Container = Groupbox.Container;

        if not Info.Compact then
            Library:CreateLabel({
                Size = UDim2.new(1, 0, 0, 10);
                TextSize = 14;
                Text = Info.Text;
                TextXAlignment = Enum.TextXAlignment.Left;
                TextYAlignment = Enum.TextYAlignment.Bottom;
                ZIndex = 5;
                Parent = Container;
            });

            Groupbox:AddBlank(3);
        end

        local SliderOuter = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, -4, 0, 13);
            ZIndex = 5;
            Parent = Container;
        });

        Library:AddToRegistry(SliderOuter, {
            BorderColor3 = 'Black';
        });

        local SliderInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 6;
            Parent = SliderOuter;
        });

        Library:AddToRegistry(SliderInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        local Fill = Library:Create('Frame', {
            BackgroundColor3 = Library.AccentColor;
            BorderColor3 = Library.AccentColorDark;
            Size = UDim2.new(0, 0, 1, 0);
            ZIndex = 7;
            Parent = SliderInner;
        });

        Library:AddToRegistry(Fill, {
            BackgroundColor3 = 'AccentColor';
            BorderColor3 = 'AccentColorDark';
        });

        local HideBorderRight = Library:Create('Frame', {
            BackgroundColor3 = Library.AccentColor;
            BorderSizePixel = 0;
            Position = UDim2.new(1, 0, 0, 0);
            Size = UDim2.new(0, 1, 1, 0);
            ZIndex = 8;
            Parent = Fill;
        });

        Library:AddToRegistry(HideBorderRight, {
            BackgroundColor3 = 'AccentColor';
        });

        local DisplayLabel = Library:CreateLabel({
            Size = UDim2.new(1, 0, 1, 0);
            TextSize = 14;
            Text = 'Infinite';
            ZIndex = 9;
            Parent = SliderInner;
        });

        Library:OnHighlight(SliderOuter, SliderOuter,
            { BorderColor3 = 'AccentColor' },
            { BorderColor3 = 'Black' }
        );

        if type(Info.Tooltip) == 'string' then
            Library:AddToolTip(Info.Tooltip, SliderOuter)
        end

        function Slider:UpdateColors()
            Fill.BackgroundColor3 = Library.AccentColor;
            Fill.BorderColor3 = Library.AccentColorDark;
        end;

        function Slider:Display()
            local Suffix = Info.Suffix or '';

            if Info.Compact then
                DisplayLabel.Text = Info.Text .. ': ' .. Slider.Value .. Suffix
            elseif Info.HideMax then
                DisplayLabel.Text = string.format('%s', Slider.Value .. Suffix)
            else
                DisplayLabel.Text = string.format('%s/%s', Slider.Value .. Suffix, Slider.Max .. Suffix);
            end

            local X = math.ceil(Library:MapValue(Slider.Value, Slider.Min, Slider.Max, 0, Slider.MaxSize));
            Fill.Size = UDim2.new(0, X, 1, 0);

            HideBorderRight.Visible = not (X == Slider.MaxSize or X == 0);
        end;

        function Slider:OnChanged(Func)
            Slider.Changed = Func;
            Func(Slider.Value);
        end;

        local function Round(Value)
            if Slider.Rounding == 0 then
                return math.floor(Value);
            end;


            return tonumber(string.format('%.' .. Slider.Rounding .. 'f', Value))
        end;

        function Slider:GetValueFromXOffset(X)
            return Round(Library:MapValue(X, 0, Slider.MaxSize, Slider.Min, Slider.Max));
        end;

        function Slider:SetValue(Str)
            local Num = tonumber(Str);

            if (not Num) then
                return;
            end;

            Num = math.clamp(Num, Slider.Min, Slider.Max);

            Slider.Value = Num;
            Slider:Display();

            Library:SafeCallback(Slider.Callback, Slider.Value);
            Library:SafeCallback(Slider.Changed, Slider.Value);
        end;

        SliderInner.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not Library:MouseIsOverOpenedFrame() then
                local mPos = Mouse.X;
                local gPos = Fill.Size.X.Offset;
                local Diff = mPos - (Fill.AbsolutePosition.X + gPos);

                while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                    local nMPos = Mouse.X;
                    local nX = math.clamp(gPos + (nMPos - mPos) + Diff, 0, Slider.MaxSize);

                    local nValue = Slider:GetValueFromXOffset(nX);
                    local OldValue = Slider.Value;
                    Slider.Value = nValue;

                    Slider:Display();

                    if nValue ~= OldValue then
                        Library:SafeCallback(Slider.Callback, Slider.Value);
                        Library:SafeCallback(Slider.Changed, Slider.Value);
                    end;

                    RenderStepped:Wait();
                end;

                Library:Attemptsave();
            end;
        end);

        Slider:Display();
        Groupbox:AddBlank(Info.BlankSize or 6);
        Groupbox:Resize();

        Options[Idx] = Slider;

        return Slider;
    end;

    function Funcs:AddDropdown(Idx, Info)
        if Info.SpecialType == 'Player' then
            Info.Values = GetPlayersString();
            Info.AllowNull = true;
        elseif Info.SpecialType == 'Team' then
            Info.Values = GetTeamsString();
            Info.AllowNull = true;
        end;

        assert(Info.Values, 'AddDropdown: Missing dropdown value list.');
        assert(Info.AllowNull or Info.Default, 'AddDropdown: Missing default value. Pass `AllowNull` as true if this was intentional.')

        if (not Info.Text) then
            Info.Compact = true;
        end;

        local Dropdown = {
            Values = Info.Values;
            Value = Info.Multi and {};
            Multi = Info.Multi;
            Type = 'Dropdown';
            SpecialType = Info.SpecialType; -- can be either 'Player' or 'Team'
            Callback = Info.Callback or function(Value) end;
        };

        local Groupbox = self;
        local Container = Groupbox.Container;

        local RelativeOffset = 0;

        if not Info.Compact then
            local DropdownLabel = Library:CreateLabel({
                Size = UDim2.new(1, 0, 0, 10);
                TextSize = 14;
                Text = Info.Text;
                TextXAlignment = Enum.TextXAlignment.Left;
                TextYAlignment = Enum.TextYAlignment.Bottom;
                ZIndex = 5;
                Parent = Container;
            });

            Groupbox:AddBlank(3);
        end

        for _, Element in next, Container:GetChildren() do
            if not Element:IsA('UIListLayout') then
                RelativeOffset = RelativeOffset + Element.Size.Y.Offset;
            end;
        end;

        local DropdownOuter = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, -4, 0, 20);
            ZIndex = 5;
            Parent = Container;
        });

        Library:AddToRegistry(DropdownOuter, {
            BorderColor3 = 'Black';
        });

        local DropdownInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 6;
            Parent = DropdownOuter;
        });

        Library:AddToRegistry(DropdownInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        Library:Create('UIGradient', {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 212, 212))
            });
            Rotation = 90;
            Parent = DropdownInner;
        });

        local DropdownArrow = Library:Create('ImageLabel', {
            AnchorPoint = Vector2.new(0, 0.5);
            BackgroundTransparency = 1;
            Position = UDim2.new(1, -16, 0.5, 0);
            Size = UDim2.new(0, 12, 0, 12);
            Image = 'http://www.roblox.com/asset/?id=6282522798';
            ZIndex = 8;
            Parent = DropdownInner;
        });

        local ItemList = Library:CreateLabel({
            Position = UDim2.new(0, 5, 0, 0);
            Size = UDim2.new(1, -5, 1, 0);
            TextSize = 14;
            Text = '--';
            TextXAlignment = Enum.TextXAlignment.Left;
            TextWrapped = true;
            ZIndex = 7;
            Parent = DropdownInner;
        });

        Library:OnHighlight(DropdownOuter, DropdownOuter,
            { BorderColor3 = 'AccentColor' },
            { BorderColor3 = 'Black' }
        );

        if type(Info.Tooltip) == 'string' then
            Library:AddToolTip(Info.Tooltip, DropdownOuter)
        end

        local MAX_DROPDOWN_ITEMS = 8;

        local ListOuter = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            ZIndex = 20;
            Visible = false;
            Parent = ScreenGui;
        });

        local function RecalculateListPosition()
            ListOuter.Position = UDim2.fromOffset(DropdownOuter.AbsolutePosition.X, DropdownOuter.AbsolutePosition.Y + DropdownOuter.Size.Y.Offset + 1);
        end;

        local function RecalculateListSize(YSize)
            ListOuter.Size = UDim2.fromOffset(DropdownOuter.AbsoluteSize.X, YSize or (MAX_DROPDOWN_ITEMS * 20 + 2))
        end;

        RecalculateListPosition();
        RecalculateListSize();

        DropdownOuter:GetPropertyChangedSignal('AbsolutePosition'):Connect(RecalculateListPosition);

        local ListInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 21;
            Parent = ListOuter;
        });

        Library:AddToRegistry(ListInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        local Scrolling = Library:Create('ScrollingFrame', {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            CanvasSize = UDim2.new(0, 0, 0, 0);
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 21;
            Parent = ListInner;

            TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png',
            BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png',

            ScrollBarThickness = 3,
            ScrollBarImageColor3 = Library.AccentColor,
        });

        Library:AddToRegistry(Scrolling, {
            ScrollBarImageColor3 = 'AccentColor'
        })

        Library:Create('UIListLayout', {
            Padding = UDim.new(0, 0);
            FillDirection = Enum.FillDirection.Vertical;
            SortOrder = Enum.SortOrder.LayoutOrder;
            Parent = Scrolling;
        });

        function Dropdown:Display()
            local Values = Dropdown.Values;
            local Str = '';

            if Info.Multi then
                for Idx, Value in next, Values do
                    if Dropdown.Value[Value] then
                        Str = Str .. Value .. ', ';
                    end;
                end;

                Str = Str:sub(1, #Str - 2);
            else
                Str = Dropdown.Value or '';
            end;

            ItemList.Text = (Str == '' and '--' or Str);
        end;

        function Dropdown:GetActiveValues()
            if Info.Multi then
                local T = {};

                for Value, Bool in next, Dropdown.Value do
                    table.insert(T, Value);
                end;

                return T;
            else
                return Dropdown.Value and 1 or 0;
            end;
        end;

        function Dropdown:BuildDropdownList()
            local Values = Dropdown.Values;
            local Buttons = {};

            for _, Element in next, Scrolling:GetChildren() do
                if not Element:IsA('UIListLayout') then
                    Element:Destroy();
                end;
            end;

            local Count = 0;

            for Idx, Value in next, Values do
                local Table = {};

                Count = Count + 1;

                local Button = Library:Create('Frame', {
                    BackgroundColor3 = Library.MainColor;
                    BorderColor3 = Library.OutlineColor;
                    BorderMode = Enum.BorderMode.Middle;
                    Size = UDim2.new(1, -1, 0, 20);
                    ZIndex = 23;
                    Active = true,
                    Parent = Scrolling;
                });

                Library:AddToRegistry(Button, {
                    BackgroundColor3 = 'MainColor';
                    BorderColor3 = 'OutlineColor';
                });

                local ButtonLabel = Library:CreateLabel({
                    Active = false;
                    Size = UDim2.new(1, -6, 1, 0);
                    Position = UDim2.new(0, 6, 0, 0);
                    TextSize = 14;
                    Text = Value;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    ZIndex = 25;
                    Parent = Button;
                });

                Library:OnHighlight(Button, Button,
                    { BorderColor3 = 'AccentColor', ZIndex = 24 },
                    { BorderColor3 = 'OutlineColor', ZIndex = 23 }
                );

                local Selected;

                if Info.Multi then
                    Selected = Dropdown.Value[Value];
                else
                    Selected = Dropdown.Value == Value;
                end;

                function Table:UpdateButton()
                    if Info.Multi then
                        Selected = Dropdown.Value[Value];
                    else
                        Selected = Dropdown.Value == Value;
                    end;

                    ButtonLabel.TextColor3 = Selected and Library.AccentColor or Library.FontColor;
                    Library.RegistryMap[ButtonLabel].Properties.TextColor3 = Selected and 'AccentColor' or 'FontColor';
                end;

                ButtonLabel.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                        local Try = not Selected;

                        if Dropdown:GetActiveValues() == 1 and (not Try) and (not Info.AllowNull) then
                        else
                            if Info.Multi then
                                Selected = Try;

                                if Selected then
                                    Dropdown.Value[Value] = true;
                                else
                                    Dropdown.Value[Value] = nil;
                                end;
                            else
                                Selected = Try;

                                if Selected then
                                    Dropdown.Value = Value;
                                else
                                    Dropdown.Value = nil;
                                end;

                                for _, OtherButton in next, Buttons do
                                    OtherButton:UpdateButton();
                                end;
                            end;

                            Table:UpdateButton();
                            Dropdown:Display();

                            Library:SafeCallback(Dropdown.Callback, Dropdown.Value);
                            Library:SafeCallback(Dropdown.Changed, Dropdown.Value);

                            Library:Attemptsave();
                        end;
                    end;
                end);

                Table:UpdateButton();
                Dropdown:Display();

                Buttons[Button] = Table;
            end;

            Scrolling.CanvasSize = UDim2.fromOffset(0, (Count * 20) + 1);

            local Y = math.clamp(Count * 20, 0, MAX_DROPDOWN_ITEMS * 20) + 1;
            RecalculateListSize(Y);
        end;

        function Dropdown:SetValues(NewValues)
            if NewValues then
                Dropdown.Values = NewValues;
            end;

            Dropdown:BuildDropdownList();
        end;

        function Dropdown:OpenDropdown()
            ListOuter.Visible = true;
            Library.OpenedFrames[ListOuter] = true;
            DropdownArrow.Rotation = 180;
        end;

        function Dropdown:CloseDropdown()
            ListOuter.Visible = false;
            Library.OpenedFrames[ListOuter] = nil;
            DropdownArrow.Rotation = 0;
        end;

        function Dropdown:OnChanged(Func)
            Dropdown.Changed = Func;
            Func(Dropdown.Value);
        end;

        function Dropdown:SetValue(Val)
            if Dropdown.Multi then
                local nTable = {};

                for Value, Bool in next, Val do
                    if table.find(Dropdown.Values, Value) then
                        nTable[Value] = true
                    end;
                end;

                Dropdown.Value = nTable;
            else
                if (not Val) then
                    Dropdown.Value = nil;
                elseif table.find(Dropdown.Values, Val) then
                    Dropdown.Value = Val;
                end;
            end;

            Dropdown:BuildDropdownList();

            Library:SafeCallback(Dropdown.Callback, Dropdown.Value);
            Library:SafeCallback(Dropdown.Changed, Dropdown.Value);
        end;

        DropdownOuter.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not Library:MouseIsOverOpenedFrame() then
                if ListOuter.Visible then
                    Dropdown:CloseDropdown();
                else
                    Dropdown:OpenDropdown();
                end;
            end;
        end);

        InputService.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                local AbsPos, AbsSize = ListOuter.AbsolutePosition, ListOuter.AbsoluteSize;

                if Mouse.X < AbsPos.X or Mouse.X > AbsPos.X + AbsSize.X
                    or Mouse.Y < (AbsPos.Y - 20 - 1) or Mouse.Y > AbsPos.Y + AbsSize.Y then

                    Dropdown:CloseDropdown();
                end;
            end;
        end);

        Dropdown:BuildDropdownList();
        Dropdown:Display();

        local Defaults = {}

        if type(Info.Default) == 'string' then
            local Idx = table.find(Dropdown.Values, Info.Default)
            if Idx then
                table.insert(Defaults, Idx)
            end
        elseif type(Info.Default) == 'table' then
            for _, Value in next, Info.Default do
                local Idx = table.find(Dropdown.Values, Value)
                if Idx then
                    table.insert(Defaults, Idx)
                end
            end
        elseif type(Info.Default) == 'number' and Dropdown.Values[Info.Default] ~= nil then
            table.insert(Defaults, Info.Default)
        end

        if next(Defaults) then
            for i = 1, #Defaults do
                local Index = Defaults[i]
                if Info.Multi then
                    Dropdown.Value[Dropdown.Values[Index]] = true
                else
                    Dropdown.Value = Dropdown.Values[Index];
                end

                if (not Info.Multi) then break end
            end

            Dropdown:BuildDropdownList();
            Dropdown:Display();
        end

        Groupbox:AddBlank(Info.BlankSize or 5);
        Groupbox:Resize();

        Options[Idx] = Dropdown;

        return Dropdown;
    end;

    function Funcs:AddDependencyBox()
        local Depbox = {
            Dependencies = {};
        };
        
        local Groupbox = self;
        local Container = Groupbox.Container;

        local Holder = Library:Create('Frame', {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 0, 0);
            Visible = false;
            Parent = Container;
        });

        local Frame = Library:Create('Frame', {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 1, 0);
            Visible = true;
            Parent = Holder;
        });

        local Layout = Library:Create('UIListLayout', {
            FillDirection = Enum.FillDirection.Vertical;
            SortOrder = Enum.SortOrder.LayoutOrder;
            Parent = Frame;
        });

        function Depbox:Resize()
            Holder.Size = UDim2.new(1, 0, 0, Layout.AbsoluteContentSize.Y);
            Groupbox:Resize();
        end;

        Layout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
            Depbox:Resize();
        end);

        Holder:GetPropertyChangedSignal('Visible'):Connect(function()
            Depbox:Resize();
        end);

        function Depbox:Update()
            for _, Dependency in next, Depbox.Dependencies do
                local Elem = Dependency[1];
                local Value = Dependency[2];

                if Elem.Type == 'Toggle' and Elem.Value ~= Value then
                    Holder.Visible = false;
                    Depbox:Resize();
                    return;
                end;
            end;

            Holder.Visible = true;
            Depbox:Resize();
        end;

        function Depbox:SetupDependencies(Dependencies)
            for _, Dependency in next, Dependencies do
                assert(type(Dependency) == 'table', 'SetupDependencies: Dependency is not of type `table`.');
                assert(Dependency[1], 'SetupDependencies: Dependency is missing element argument.');
                assert(Dependency[2] ~= nil, 'SetupDependencies: Dependency is missing value argument.');
            end;

            Depbox.Dependencies = Dependencies;
            Depbox:Update();
        end;

        Depbox.Container = Frame;

        setmetatable(Depbox, BaseGroupbox);

        table.insert(Library.DependencyBoxes, Depbox);

        return Depbox;
    end;

    BaseGroupbox.__index = Funcs;
    BaseGroupbox.__namecall = function(Table, Key, ...)
        return Funcs[Key](...);
    end;
end;

-- < Create other UI elements >

do
    Library.NotificationArea = Library:Create('Frame', {
        BackgroundTransparency = 1;
        Position = UDim2.new(0, 0, 0, 40);
        Size = UDim2.new(0, 300, 0, 200);
        ZIndex = 100;
        Parent = ScreenGui;
    });

    Library:Create('UIListLayout', {
        Padding = UDim.new(0, 4);
        FillDirection = Enum.FillDirection.Vertical;
        SortOrder = Enum.SortOrder.LayoutOrder;
        Parent = Library.NotificationArea;
    });

    local WatermarkOuter = Library:Create('Frame', {
        BorderColor3 = Color3.new(0, 0, 0);
        Position = UDim2.new(0, 100, 0, -25);
        Size = UDim2.new(0, 213, 0, 20);
        ZIndex = 200;
        Visible = false;
        Parent = ScreenGui;
    });

    local WatermarkInner = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.AccentColor;
        BorderMode = Enum.BorderMode.Inset;
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 201;
        Parent = WatermarkOuter;
    });

    Library:AddToRegistry(WatermarkInner, {
        BorderColor3 = 'AccentColor';
    });

    local InnerFrame = Library:Create('Frame', {
        BackgroundColor3 = Color3.new(1, 1, 1);
        BorderSizePixel = 0;
        Position = UDim2.new(0, 1, 0, 1);
        Size = UDim2.new(1, -2, 1, -2);
        ZIndex = 202;
        Parent = WatermarkInner;
    });

    local Gradient = Library:Create('UIGradient', {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Library:GetDarkerColor(Library.MainColor)),
            ColorSequenceKeypoint.new(1, Library.MainColor),
        });
        Rotation = -90;
        Parent = InnerFrame;
    });

    Library:AddToRegistry(Gradient, {
        Color = function()
            return ColorSequence.new({
                ColorSequenceKeypoint.new(0, Library:GetDarkerColor(Library.MainColor)),
                ColorSequenceKeypoint.new(1, Library.MainColor),
            });
        end
    });

    local WatermarkLabel = Library:CreateLabel({
        Position = UDim2.new(0, 5, 0, 0);
        Size = UDim2.new(1, -4, 1, 0);
        TextSize = 14;
        TextXAlignment = Enum.TextXAlignment.Left;
        ZIndex = 203;
        Parent = InnerFrame;
    });

    Library.Watermark = WatermarkOuter;
    Library.WatermarkText = WatermarkLabel;
    Library:MakeDraggable(Library.Watermark);



    local KeybindOuter = Library:Create('Frame', {
        AnchorPoint = Vector2.new(0, 0.5);
        BorderColor3 = Color3.new(0, 0, 0);
        Position = UDim2.new(0, 10, 0.5, 0);
        Size = UDim2.new(0, 210, 0, 20);
        Visible = false;
        ZIndex = 100;
        Parent = ScreenGui;
    });

    local KeybindInner = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.OutlineColor;
        BorderMode = Enum.BorderMode.Inset;
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 101;
        Parent = KeybindOuter;
    });

    Library:AddToRegistry(KeybindInner, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'OutlineColor';
    }, true);

    local ColorFrame = Library:Create('Frame', {
        BackgroundColor3 = Library.AccentColor;
        BorderSizePixel = 0;
        Size = UDim2.new(1, 0, 0, 2);
        ZIndex = 102;
        Parent = KeybindInner;
    });

    Library:AddToRegistry(ColorFrame, {
        BackgroundColor3 = 'AccentColor';
    }, true);

    local KeybindLabel = Library:CreateLabel({
        Size = UDim2.new(1, 0, 0, 20);
        Position = UDim2.fromOffset(5, 2),
        TextXAlignment = Enum.TextXAlignment.Left,

        Text = 'Keybinds';
        ZIndex = 104;
        Parent = KeybindInner;
    });

    local KeybindContainer = Library:Create('Frame', {
        BackgroundTransparency = 1;
        Size = UDim2.new(1, 0, 1, -20);
        Position = UDim2.new(0, 0, 0, 20);
        ZIndex = 1;
        Parent = KeybindInner;
    });

    Library:Create('UIListLayout', {
        FillDirection = Enum.FillDirection.Vertical;
        SortOrder = Enum.SortOrder.LayoutOrder;
        Parent = KeybindContainer;
    });

    Library:Create('UIPadding', {
        PaddingLeft = UDim.new(0, 5),
        Parent = KeybindContainer,
    })

    Library.KeybindFrame = KeybindOuter;
    Library.KeybindContainer = KeybindContainer;
    Library:MakeDraggable(KeybindOuter);
end;

function Library:SetWatermarkVisibility(Bool)
    Library.Watermark.Visible = Bool;
end;

function Library:SetWatermark(Text)
    local X, Y = Library:GetTextBounds(Text, Library.Font, 14);
    Library.Watermark.Size = UDim2.new(0, X + 15, 0, (Y * 1.5) + 3);
    Library:SetWatermarkVisibility(true)

    Library.WatermarkText.Text = Text;
end;

function Library:Notify(Text, Time)
    local XSize, YSize = Library:GetTextBounds(Text, Library.Font, 14);

    YSize = YSize + 7

    local NotifyOuter = Library:Create('Frame', {
        BorderColor3 = Color3.new(0, 0, 0);
        Position = UDim2.new(0, 100, 0, 10);
        Size = UDim2.new(0, 0, 0, YSize);
        ClipsDescendants = true;
        ZIndex = 100;
        Parent = Library.NotificationArea;
    });

    local NotifyInner = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.OutlineColor;
        BorderMode = Enum.BorderMode.Inset;
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 101;
        Parent = NotifyOuter;
    });

    Library:AddToRegistry(NotifyInner, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'OutlineColor';
    }, true);

    local InnerFrame = Library:Create('Frame', {
        BackgroundColor3 = Color3.new(1, 1, 1);
        BorderSizePixel = 0;
        Position = UDim2.new(0, 1, 0, 1);
        Size = UDim2.new(1, -2, 1, -2);
        ZIndex = 102;
        Parent = NotifyInner;
    });

    local Gradient = Library:Create('UIGradient', {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Library:GetDarkerColor(Library.MainColor)),
            ColorSequenceKeypoint.new(1, Library.MainColor),
        });
        Rotation = -90;
        Parent = InnerFrame;
    });

    Library:AddToRegistry(Gradient, {
        Color = function()
            return ColorSequence.new({
                ColorSequenceKeypoint.new(0, Library:GetDarkerColor(Library.MainColor)),
                ColorSequenceKeypoint.new(1, Library.MainColor),
            });
        end
    });

    local NotifyLabel = Library:CreateLabel({
        Position = UDim2.new(0, 4, 0, 0);
        Size = UDim2.new(1, -4, 1, 0);
        Text = Text;
        TextXAlignment = Enum.TextXAlignment.Left;
        TextSize = 14;
        ZIndex = 103;
        Parent = InnerFrame;
    });

    local LeftColor = Library:Create('Frame', {
        BackgroundColor3 = Library.AccentColor;
        BorderSizePixel = 0;
        Position = UDim2.new(0, -1, 0, -1);
        Size = UDim2.new(0, 3, 1, 2);
        ZIndex = 104;
        Parent = NotifyOuter;
    });

    Library:AddToRegistry(LeftColor, {
        BackgroundColor3 = 'AccentColor';
    }, true);

    pcall(NotifyOuter.TweenSize, NotifyOuter, UDim2.new(0, XSize + 8 + 4, 0, YSize), 'Out', 'Quad', 0.4, true);

    task.spawn(function()
        wait(Time or 5);

        pcall(NotifyOuter.TweenSize, NotifyOuter, UDim2.new(0, 0, 0, YSize), 'Out', 'Quad', 0.4, true);

        wait(0.4);

        NotifyOuter:Destroy();
    end);
end;

function Library:CreateWindow(...)
    local Arguments = { ... }
    local Config = { AnchorPoint = Vector2.zero }

    if type(...) == 'table' then
        Config = ...;
    else
        Config.Title = Arguments[1]
        Config.AutoShow = Arguments[2] or false;
    end

    if type(Config.Title) ~= 'string' then Config.Title = 'No title' end
    if type(Config.TabPadding) ~= 'number' then Config.TabPadding = 0 end
    if type(Config.MenuFadeTime) ~= 'number' then Config.MenuFadeTime = 0.2 end

    if typeof(Config.Position) ~= 'UDim2' then Config.Position = UDim2.fromOffset(175, 50) end
    if typeof(Config.Size) ~= 'UDim2' then Config.Size = UDim2.fromOffset(550, 600) end

    if Config.Center then
        Config.AnchorPoint = Vector2.new(0.5, 0.5)
        Config.Position = UDim2.fromScale(0.5, 0.5)
    end

    local Window = {
        Tabs = {};
    };

    local Outer = Library:Create('Frame', {
        AnchorPoint = Config.AnchorPoint,
        BackgroundColor3 = Color3.new(0, 0, 0);
        BorderSizePixel = 0;
        Position = Config.Position,
        Size = Config.Size,
        Visible = false;
        ZIndex = 1;
        Parent = ScreenGui;
    });

    Library:MakeDraggable(Outer, 25);

    local Inner = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.AccentColor;
        BorderMode = Enum.BorderMode.Inset;
        Position = UDim2.new(0, 1, 0, 1);
        Size = UDim2.new(1, -2, 1, -2);
        ZIndex = 1;
        Parent = Outer;
    });

    Library:AddToRegistry(Inner, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'AccentColor';
    });

    local WindowLabel = Library:CreateLabel({
        Position = UDim2.new(0, 7, 0, 0);
        Size = UDim2.new(0, 0, 0, 25);
        Text = Config.Title or '';
        TextXAlignment = Enum.TextXAlignment.Left;
        ZIndex = 1;
        Parent = Inner;
    });

    local MainSectionOuter = Library:Create('Frame', {
        BackgroundColor3 = Library.BackgroundColor;
        BorderColor3 = Library.OutlineColor;
        Position = UDim2.new(0, 8, 0, 25);
        Size = UDim2.new(1, -16, 1, -33);
        ZIndex = 1;
        Parent = Inner;
    });

    Library:AddToRegistry(MainSectionOuter, {
        BackgroundColor3 = 'BackgroundColor';
        BorderColor3 = 'OutlineColor';
    });

    local MainSectionInner = Library:Create('Frame', {
        BackgroundColor3 = Library.BackgroundColor;
        BorderColor3 = Color3.new(0, 0, 0);
        BorderMode = Enum.BorderMode.Inset;
        Position = UDim2.new(0, 0, 0, 0);
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 1;
        Parent = MainSectionOuter;
    });

    Library:AddToRegistry(MainSectionInner, {
        BackgroundColor3 = 'BackgroundColor';
    });

    local TabArea = Library:Create('Frame', {
        BackgroundTransparency = 1;
        Position = UDim2.new(0, 8, 0, 8);
        Size = UDim2.new(1, -16, 0, 21);
        ZIndex = 1;
        Parent = MainSectionInner;
    });

    local TabListLayout = Library:Create('UIListLayout', {
        Padding = UDim.new(0, Config.TabPadding);
        FillDirection = Enum.FillDirection.Horizontal;
        SortOrder = Enum.SortOrder.LayoutOrder;
        Parent = TabArea;
    });

    local TabContainer = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.OutlineColor;
        Position = UDim2.new(0, 8, 0, 30);
        Size = UDim2.new(1, -16, 1, -38);
        ZIndex = 2;
        Parent = MainSectionInner;
    });
    

    Library:AddToRegistry(TabContainer, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'OutlineColor';
    });

    function Window:SetWindowTitle(Title)
        WindowLabel.Text = Title;
    end;

    function Window:AddTab(Name)
        local Tab = {
            Groupboxes = {};
            Tabboxes = {};
        };

        local TabButtonWidth = Library:GetTextBounds(Name, Library.Font, 16);

        local TabButton = Library:Create('Frame', {
            BackgroundColor3 = Library.BackgroundColor;
            BorderColor3 = Library.OutlineColor;
            Size = UDim2.new(0, TabButtonWidth + 8 + 4, 1, 0);
            ZIndex = 1;
            Parent = TabArea;
        });

        Library:AddToRegistry(TabButton, {
            BackgroundColor3 = 'BackgroundColor';
            BorderColor3 = 'OutlineColor';
        });

        local TabButtonLabel = Library:CreateLabel({
            Position = UDim2.new(0, 0, 0, 0);
            Size = UDim2.new(1, 0, 1, -1);
            Text = Name;
            ZIndex = 1;
            Parent = TabButton;
        });

        local Blocker = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderSizePixel = 0;
            Position = UDim2.new(0, 0, 1, 0);
            Size = UDim2.new(1, 0, 0, 1);
            BackgroundTransparency = 1;
            ZIndex = 3;
            Parent = TabButton;
        });

        Library:AddToRegistry(Blocker, {
            BackgroundColor3 = 'MainColor';
        });

        local TabFrame = Library:Create('Frame', {
            Name = 'TabFrame',
            BackgroundTransparency = 1;
            Position = UDim2.new(0, 0, 0, 0);
            Size = UDim2.new(1, 0, 1, 0);
            Visible = false;
            ZIndex = 2;
            Parent = TabContainer;
        });

        local LeftSide = Library:Create('ScrollingFrame', {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Position = UDim2.new(0, 8 - 1, 0, 8 - 1);
            Size = UDim2.new(0.5, -12 + 2, 0, 507 + 2);
            CanvasSize = UDim2.new(0, 0, 0, 0);
            BottomImage = '';
            TopImage = '';
            ScrollBarThickness = 0;
            ZIndex = 2;
            Parent = TabFrame;
        });

        local RightSide = Library:Create('ScrollingFrame', {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Position = UDim2.new(0.5, 4 + 1, 0, 8 - 1);
            Size = UDim2.new(0.5, -12 + 2, 0, 507 + 2);
            CanvasSize = UDim2.new(0, 0, 0, 0);
            BottomImage = '';
            TopImage = '';
            ScrollBarThickness = 0;
            ZIndex = 2;
            Parent = TabFrame;
        });

        Library:Create('UIListLayout', {
            Padding = UDim.new(0, 8);
            FillDirection = Enum.FillDirection.Vertical;
            SortOrder = Enum.SortOrder.LayoutOrder;
            HorizontalAlignment = Enum.HorizontalAlignment.Center;
            Parent = LeftSide;
        });

        Library:Create('UIListLayout', {
            Padding = UDim.new(0, 8);
            FillDirection = Enum.FillDirection.Vertical;
            SortOrder = Enum.SortOrder.LayoutOrder;
            HorizontalAlignment = Enum.HorizontalAlignment.Center;
            Parent = RightSide;
        });

        for _, Side in next, { LeftSide, RightSide } do
            Side:WaitForChild('UIListLayout'):GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
                Side.CanvasSize = UDim2.fromOffset(0, Side.UIListLayout.AbsoluteContentSize.Y);
            end);
        end;

        function Tab:ShowTab()
            for _, Tab in next, Window.Tabs do
                Tab:HideTab();
            end;

            Blocker.BackgroundTransparency = 0;
            TabButton.BackgroundColor3 = Library.MainColor;
            Library.RegistryMap[TabButton].Properties.BackgroundColor3 = 'MainColor';
            TabFrame.Visible = true;
        end;

        function Tab:HideTab()
            Blocker.BackgroundTransparency = 1;
            TabButton.BackgroundColor3 = Library.BackgroundColor;
            Library.RegistryMap[TabButton].Properties.BackgroundColor3 = 'BackgroundColor';
            TabFrame.Visible = false;
        end;

        function Tab:SetLayoutOrder(Position)
            TabButton.LayoutOrder = Position;
            TabListLayout:ApplyLayout();
        end;

        function Tab:AddGroupbox(Info)
            local Groupbox = {};

            local BoxOuter = Library:Create('Frame', {
                BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.new(1, 0, 0, 507 + 2);
                ZIndex = 2;
                Parent = Info.Side == 1 and LeftSide or RightSide;
            });

            Library:AddToRegistry(BoxOuter, {
                BackgroundColor3 = 'BackgroundColor';
                BorderColor3 = 'OutlineColor';
            });

            local BoxInner = Library:Create('Frame', {
                BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Color3.new(0, 0, 0);
                -- BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.new(1, -2, 1, -2);
                Position = UDim2.new(0, 1, 0, 1);
                ZIndex = 4;
                Parent = BoxOuter;
            });

            Library:AddToRegistry(BoxInner, {
                BackgroundColor3 = 'BackgroundColor';
            });

            local Highlight = Library:Create('Frame', {
                BackgroundColor3 = Library.AccentColor;
                BorderSizePixel = 0;
                Size = UDim2.new(1, 0, 0, 2);
                ZIndex = 5;
                Parent = BoxInner;
            });

            Library:AddToRegistry(Highlight, {
                BackgroundColor3 = 'AccentColor';
            });

            local GroupboxLabel = Library:CreateLabel({
                Size = UDim2.new(1, 0, 0, 18);
                Position = UDim2.new(0, 4, 0, 2);
                TextSize = 14;
                Text = Info.Name;
                TextXAlignment = Enum.TextXAlignment.Left;
                ZIndex = 5;
                Parent = BoxInner;
            });

            local Container = Library:Create('Frame', {
                BackgroundTransparency = 1;
                Position = UDim2.new(0, 4, 0, 20);
                Size = UDim2.new(1, -4, 1, -20);
                ZIndex = 1;
                Parent = BoxInner;
            });

            Library:Create('UIListLayout', {
                FillDirection = Enum.FillDirection.Vertical;
                SortOrder = Enum.SortOrder.LayoutOrder;
                Parent = Container;
            });

            function Groupbox:Resize()
                local Size = 0;

                for _, Element in next, Groupbox.Container:GetChildren() do
                    if (not Element:IsA('UIListLayout')) and Element.Visible then
                        Size = Size + Element.Size.Y.Offset;
                    end;
                end;

                BoxOuter.Size = UDim2.new(1, 0, 0, 20 + Size + 2 + 2);
            end;

            Groupbox.Container = Container;
            setmetatable(Groupbox, BaseGroupbox);

            Groupbox:AddBlank(3);
            Groupbox:Resize();

            Tab.Groupboxes[Info.Name] = Groupbox;

            return Groupbox;
        end;

        function Tab:AddLeftGroupbox(Name)
            return Tab:AddGroupbox({ Side = 1; Name = Name; });
        end;

        function Tab:AddRightGroupbox(Name)
            return Tab:AddGroupbox({ Side = 2; Name = Name; });
        end;

        function Tab:AddTabbox(Info)
            local Tabbox = {
                Tabs = {};
            };

            local BoxOuter = Library:Create('Frame', {
                BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.new(1, 0, 0, 0);
                ZIndex = 2;
                Parent = Info.Side == 1 and LeftSide or RightSide;
            });

            Library:AddToRegistry(BoxOuter, {
                BackgroundColor3 = 'BackgroundColor';
                BorderColor3 = 'OutlineColor';
            });

            local BoxInner = Library:Create('Frame', {
                BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Color3.new(0, 0, 0);
                -- BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.new(1, -2, 1, -2);
                Position = UDim2.new(0, 1, 0, 1);
                ZIndex = 4;
                Parent = BoxOuter;
            });

            Library:AddToRegistry(BoxInner, {
                BackgroundColor3 = 'BackgroundColor';
            });

            local Highlight = Library:Create('Frame', {
                BackgroundColor3 = Library.AccentColor;
                BorderSizePixel = 0;
                Size = UDim2.new(1, 0, 0, 2);
                ZIndex = 10;
                Parent = BoxInner;
            });

            Library:AddToRegistry(Highlight, {
                BackgroundColor3 = 'AccentColor';
            });

            local TabboxButtons = Library:Create('Frame', {
                BackgroundTransparency = 1;
                Position = UDim2.new(0, 0, 0, 1);
                Size = UDim2.new(1, 0, 0, 18);
                ZIndex = 5;
                Parent = BoxInner;
            });

            Library:Create('UIListLayout', {
                FillDirection = Enum.FillDirection.Horizontal;
                HorizontalAlignment = Enum.HorizontalAlignment.Left;
                SortOrder = Enum.SortOrder.LayoutOrder;
                Parent = TabboxButtons;
            });

            function Tabbox:AddTab(Name)
                local Tab = {};

                local Button = Library:Create('Frame', {
                    BackgroundColor3 = Library.MainColor;
                    BorderColor3 = Color3.new(0, 0, 0);
                    Size = UDim2.new(0.5, 0, 1, 0);
                    ZIndex = 6;
                    Parent = TabboxButtons;
                });

                Library:AddToRegistry(Button, {
                    BackgroundColor3 = 'MainColor';
                });

                local ButtonLabel = Library:CreateLabel({
                    Size = UDim2.new(1, 0, 1, 0);
                    TextSize = 14;
                    Text = Name;
                    TextXAlignment = Enum.TextXAlignment.Center;
                    ZIndex = 7;
                    Parent = Button;
                });

                local Block = Library:Create('Frame', {
                    BackgroundColor3 = Library.BackgroundColor;
                    BorderSizePixel = 0;
                    Position = UDim2.new(0, 0, 1, 0);
                    Size = UDim2.new(1, 0, 0, 1);
                    Visible = false;
                    ZIndex = 9;
                    Parent = Button;
                });

                Library:AddToRegistry(Block, {
                    BackgroundColor3 = 'BackgroundColor';
                });

                local Container = Library:Create('Frame', {
                    BackgroundTransparency = 1;
                    Position = UDim2.new(0, 4, 0, 20);
                    Size = UDim2.new(1, -4, 1, -20);
                    ZIndex = 1;
                    Visible = false;
                    Parent = BoxInner;
                });

                Library:Create('UIListLayout', {
                    FillDirection = Enum.FillDirection.Vertical;
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    Parent = Container;
                });

                function Tab:Show()
                    for _, Tab in next, Tabbox.Tabs do
                        Tab:Hide();
                    end;

                    Container.Visible = true;
                    Block.Visible = true;

                    Button.BackgroundColor3 = Library.BackgroundColor;
                    Library.RegistryMap[Button].Properties.BackgroundColor3 = 'BackgroundColor';

                    Tab:Resize();
                end;

                function Tab:Hide()
                    Container.Visible = false;
                    Block.Visible = false;

                    Button.BackgroundColor3 = Library.MainColor;
                    Library.RegistryMap[Button].Properties.BackgroundColor3 = 'MainColor';
                end;

                function Tab:Resize()
                    local TabCount = 0;

                    for _, Tab in next, Tabbox.Tabs do
                        TabCount = TabCount + 1;
                    end;

                    for _, Button in next, TabboxButtons:GetChildren() do
                        if not Button:IsA('UIListLayout') then
                            Button.Size = UDim2.new(1 / TabCount, 0, 1, 0);
                        end;
                    end;

                    if (not Container.Visible) then
                        return;
                    end;

                    local Size = 0;

                    for _, Element in next, Tab.Container:GetChildren() do
                        if (not Element:IsA('UIListLayout')) and Element.Visible then
                            Size = Size + Element.Size.Y.Offset;
                        end;
                    end;

                    BoxOuter.Size = UDim2.new(1, 0, 0, 20 + Size + 2 + 2);
                end;

                Button.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch and not Library:MouseIsOverOpenedFrame() then
                        Tab:Show();
                        Tab:Resize();
                    end;
                end);

                Tab.Container = Container;
                Tabbox.Tabs[Name] = Tab;

                setmetatable(Tab, BaseGroupbox);

                Tab:AddBlank(3);
                Tab:Resize();

                -- Show first tab (number is 2 cus of the UIListLayout that also sits in that instance)
                if #TabboxButtons:GetChildren() == 2 then
                    Tab:Show();
                end;

                return Tab;
            end;

            Tab.Tabboxes[Info.Name or ''] = Tabbox;

            return Tabbox;
        end;

        function Tab:AddLeftTabbox(Name)
            return Tab:AddTabbox({ Name = Name, Side = 1; });
        end;

        function Tab:AddRightTabbox(Name)
            return Tab:AddTabbox({ Name = Name, Side = 2; });
        end;

        TabButton.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                Tab:ShowTab();
            end;
        end);

        -- This was the first tab added, so we show it by default.
        if #TabContainer:GetChildren() == 1 then
            Tab:ShowTab();
        end;

        Window.Tabs[Name] = Tab;
        return Tab;
    end;

    local ModalElement = Library:Create('TextButton', {
        BackgroundTransparency = 1;
        Size = UDim2.new(0, 0, 0, 0);
        Visible = true;
        Text = '';
        Modal = false;
        Parent = ScreenGui;
    });

    local TransparencyCache = {};
    local Toggled = false;
    local Fading = false;

    function Library:Toggle()
        if Fading then
            return;
        end;

        local FadeTime = Config.MenuFadeTime;
        Fading = true;
        Toggled = (not Toggled);
        ModalElement.Modal = Toggled;

        if Toggled then
            -- A bit scuffed, but if we're going from not toggled -> toggled we want to show the frame immediately so that the fade is visible.
            Outer.Visible = true;

            task.spawn(function()
                -- TODO: add cursor fade?
                local State = InputService.MouseIconEnabled;

                local Cursor = Drawing.new('Triangle');
                Cursor.Thickness = 1;
                Cursor.Filled = true;
                Cursor.Visible = true;

                local CursorOutline = Drawing.new('Triangle');
                CursorOutline.Thickness = 1;
                CursorOutline.Filled = false;
                CursorOutline.Color = Color3.new(0, 0, 0);
                CursorOutline.Visible = true;

                while Toggled and ScreenGui.Parent do
                    InputService.MouseIconEnabled = false;

                    local mPos = InputService:GetMouseLocation();

                    Cursor.Color = Library.AccentColor;

                    Cursor.PointA = Vector2.new(mPos.X, mPos.Y);
                    Cursor.PointB = Vector2.new(mPos.X + 16, mPos.Y + 6);
                    Cursor.PointC = Vector2.new(mPos.X + 6, mPos.Y + 16);

                    CursorOutline.PointA = Cursor.PointA;
                    CursorOutline.PointB = Cursor.PointB;
                    CursorOutline.PointC = Cursor.PointC;

                    RenderStepped:Wait();
                end;

                InputService.MouseIconEnabled = State;

                Cursor:Remove();
                CursorOutline:Remove();
            end);
        end;

        for _, Desc in next, Outer:GetDescendants() do
            local Properties = {};

            if Desc:IsA('ImageLabel') then
                table.insert(Properties, 'ImageTransparency');
                table.insert(Properties, 'BackgroundTransparency');
            elseif Desc:IsA('TextLabel') or Desc:IsA('TextBox') then
                table.insert(Properties, 'TextTransparency');
            elseif Desc:IsA('Frame') or Desc:IsA('ScrollingFrame') then
                table.insert(Properties, 'BackgroundTransparency');
            elseif Desc:IsA('UIStroke') then
                table.insert(Properties, 'Transparency');
            end;

            local Cache = TransparencyCache[Desc];

            if (not Cache) then
                Cache = {};
                TransparencyCache[Desc] = Cache;
            end;

            for _, Prop in next, Properties do
                if not Cache[Prop] then
                    Cache[Prop] = Desc[Prop];
                end;

                if Cache[Prop] == 1 then
                    TweenService:Create(Desc, TweenInfo.new(FadeTime, Enum.EasingStyle.Linear), { [Prop] = Toggled and Cache[Prop] or 1 }):Play();
                end;

                TweenService:Create(Desc, TweenInfo.new(FadeTime, Enum.EasingStyle.Linear), { [Prop] = Toggled and Cache[Prop] or 1 }):Play();
            end;
        end;

        task.wait(FadeTime);

        Outer.Visible = Toggled;

        Fading = false;
    end

    Library:GiveSignal(InputService.InputBegan:Connect(function(Input, Processed)
        if type(Library.ToggleKeybind) == 'table' and Library.ToggleKeybind.Type == 'KeyPicker' then
            if Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode.Name == Library.ToggleKeybind.Value then
                task.spawn(Library.Toggle)
            end
        elseif Input.KeyCode == Enum.KeyCode.RightControl or (Input.KeyCode == Enum.KeyCode.RightShift and (not Processed)) then
            task.spawn(Library.Toggle)
        end
    end))

    if Config.AutoShow then task.spawn(Library.Toggle) end

    Window.Holder = Outer;

    return Window;
end;

local function OnPlayerChange()
    local PlayerList = GetPlayersString();

    for _, Value in next, Options do
        if Value.Type == 'Dropdown' and Value.SpecialType == 'Player' then
            Value:SetValues(PlayerList);
        end;
    end;
end;

Players.PlayerAdded:Connect(OnPlayerChange);
Players.PlayerRemoving:Connect(OnPlayerChange);

getgenv().Library = Library;

LoadSettings()

local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/';

local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))();
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))();

local Window = Library:CreateWindow({
    Title = "ZPU Hub | BloxFruits",
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2,
    Size = UDim2.fromOffset(550, 600)
});

task.spawn(function()
	while task.wait() do
		Window:SetWindowTitle("ZPU Hub | Blox Fruits - "..os.date('%A, %B %d %Y at %H:%M:%S'));
	end;
end);

local function setwatermarktime()
    local dgt = math.floor(workspace.DistributedGameTime+0.27322);
    local hr = math.floor(dgt/(60^2))%24;
    local min = math.floor(dgt/(60^1))%6;
    local sec = math.floor(dgt/(60^0))%60;
    Library:SetWatermark("ZPU Hub | BloxFruits - "..hr.." Hour(hr) "..min.." Minute(m) "..sec.." Second(s)");
end;
 
task.spawn(function()
    while task.wait(1) do 
        pcall(function()
            setwatermarktime();
        end);
    end;
end);

pcall(function()
    game.Players.LocalPlayer.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Invisicam
end)

local GeneralTab = Window:AddTab("General");
local AutomaticsTab = Window:AddTab("Automatics");
local Visural = Window:AddTab("Visual");
local Combat = Window:AddTab("Combat");
local Theme = Window:AddTab("Ui Configs")

local Tabbox1 = GeneralTab:AddLeftTabbox();
local AutoFarm = Tabbox1:AddTab([[ AutoFarm ]])
do

    AutoFarm:AddToggle("AutoFarms", {
        Text = "Auto Farm Levels",
        Default = getgenv().Config.AutoFarm,
        Tooltip = 'Auto griding level'
    }):OnChanged(function(a)
        getgenv().Config.AutoFarm = a
        getgenv().Config.Clip = a
        save()
    end)

    if FirstSea then
        local MoreAutoFarm = AutoFarm:AddDependencyBox();
        do
            MoreAutoFarm:AddToggle("FasttFams", {
                Text = "Fast Auto Farm",
                Default = getgenv().Config.FastFarms,
                Tooltip = 'Make u level up faster than normal'
            }):OnChanged(function(a)
                getgenv().Config.FastFarms = a;
                save();
            end);

            MoreAutoFarm:AddToggle("KillPlayer", {
                Text = "Allow Kill Players",
                Default = getgenv().Config.AllowKillPlayer,
                Tooltip = 'Kills players'
            }):OnChanged(function(a)
                getgenv().Config.AllowKillPlayer = a;
                save();
            end);

            MoreAutoFarm:AddToggle("Indx", {
                Text = "Farm Mobs Around",
                Default = getgenv().Config.FarmAround,
                Tooltip = 'Farm around when not have mob'
            }):OnChanged(function(a)
                getgenv().Config.FarmAround = a;
                FarmAround = a;
                save();
            end);
        end;

        MoreAutoFarm:SetupDependencies({
            { Toggles.AutoFarms, true }
        });
    

        AutoFarm:AddToggle("AutoSecondSea", {
            Text = "Auto Sea 2",
            Default = getgenv().Config.AutoSea2,
            Tooltip = 'Auto griding level'
        }):OnChanged(function(a)
            getgenv().Config.AutoSea2 = a
            getgenv().Config.Clip = a
            save()
        end)
    end

    if SecondSea then
        AutoFarm:AddToggle("AutoBartilio", {
            Text = "Auto Bartilio Quests",
            Default = getgenv().Config.AutoBartilio
        }):OnChanged(function(a)
            getgenv().Config.AutoBartilio = a
            getgenv().Config.Clip = a
        end)

        spawn(function()
            while wait() do
                pcall(function()
                    if getgenv().Config.AutoBartilio then
                        if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 3 then
                            return else
                            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 0 then
                                if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirates") and string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                                    if game.Workspace.Enemies:FindFirstChild("Swan Pirate [Lv. 775]") then
                                        for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                            if v.Name == "Swan Pirate [Lv. 775]" then
                                                pcall(function()
                                                    repeat task.wait()
                                                        Attack = true
                                                        BusoAndKen()
                                                        EquipTool(WeaponName)
                                                        getgenv().MobPos = v.HumanoidRootPart.CFrame
                                                        v.Humanoid.JumpPower = 0
                                                        v.Humanoid.WalkSpeed = 0
                                                        v.HumanoidRootPart.CanCollide = false
                                                        v.Humanoid:ChangeState(11)															
                                                        Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                                    until not v.Parent or v.Humanoid.Health <= 0 or getgenv().Config.AutoBartilio == false or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                                    Attack = false
                                                end)
                                            end
                                        end
                                    else
                                        Teleport(CFrame.new(1057.92761, 137.614319, 1242.08069).Position,CFrame.new(1057.92761, 137.614319, 1242.08069))
                                    end
                                else
                                    Teleport(CFrame.new(-456.28952, 73.0200958, 299.895966).Position,CFrame.new(-456.28952, 73.0200958, 299.895966))
                                    if (CFrame.new(-456.28952, 73.0200958, 299.895966).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer("StartQuest","BartiloQuest",1)
                                    end
                                end
                            elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 1 then
                                if game.Workspace.Enemies:FindFirstChild("Jeremy [Lv. 850] [Boss]") then
                                    for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                        if v.Name == "Jeremy [Lv. 850] [Boss]" then
                                            repeat task.wait()
                                                Attack = true
                                                BusoAndKen()
                                                EquipTool(WeaponName)
                                                getgenv().MobPos = v.HumanoidRootPart.CFrame
                                                v.Humanoid.JumpPower = 0
                                                v.Humanoid.WalkSpeed = 0
                                                v.HumanoidRootPart.CanCollide = false
                                                v.Humanoid:ChangeState(11)															
                                                Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                            until not v.Parent or v.Humanoid.Health <= 0 or getgenv().U.Main.AutoSea3 == false
                                            Attack = false
                                        end
                                    end
                                else
                                    Teleport(CFrame.new(2099.88159, 448.931, 648.997375).Position,CFrame.new(2099.88159, 448.931, 648.997375))
                                end
                            elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 2 then
                                if (CFrame.new(-1836, 11, 1714).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
                                    Bartilotween = Teleport(CFrame.new(-1836, 11, 1714).Position,CFrame.new(-1836, 11, 1714))
                                elseif (CFrame.new(-1836, 11, 1714).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                                    if Bartilotween then Bartilotween:Stop() end
                                    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1836, 11, 1714)
                                    wait(.5)
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1850.49329, 13.1789551, 1750.89685)
                                    wait(.1)
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1858.87305, 19.3777466, 1712.01807)
                                    wait(.1)
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1803.94324, 16.5789185, 1750.89685)
                                    wait(.1)
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1858.55835, 16.8604317, 1724.79541)
                                    wait(.1)
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1869.54224, 15.987854, 1681.00659)
                                    wait(.1)
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1800.0979, 16.4978027, 1684.52368)
                                    wait(.1)
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1819.26343, 14.795166, 1717.90625)
                                    wait(.1)
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1813.51843, 14.8604736, 1724.79541)
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end

    local DessrosaQuest = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress")

    spawn(function()
        while wait() do
            pcall(function()
                if getgenv().Config.AutoSea2 then
                    if game:GetService("Players").LocalPlayer.Data.Level.Value >= 700 then
                        if not DessrosaQuest.UsedKey then
                            if DessrosaQuest.UsedKey then
                                return;
                            end;
                            if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Key") or game.Players.LocalPlayer.Character:FindFirstChild("Key") then
                                repeat task.wait()
                                    EquipTool("Key");
                                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,game:GetService("Workspace").Map.Ice.Door,0);
                                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,game:GetService("Workspace").Map.Ice.Door,1);
                                until not getgenv().Config.AutoSea2 or DessrosaQuest.UsedKey;
                            else
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress","Detective");
                            end;
                        elseif DessrosaQuest.UsedKey and not DessrosaQuest.KilledIceBoss then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
                            if game:GetService("ReplicatedStorage"):FindFirstChild("Ice Admiral [Lv. 700] [Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Ice Admiral [Lv. 700] [Boss]") then
                                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do 
                                    if v.Name == "Ice Admiral [Lv. 700] [Boss]" and v:FindFirstChild("Humanoid") then
                                        if v.Humanoid.Health > 0 then
                                            repeat task.wait()
                                                EquipTool(WeaponName)
                                                BusoAndKen()
                                                Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0)) 
                                                v.Humanoid.JumpPower = 0
                                                v.Humanoid.WalkSpeed = 0
                                                v.HumanoidRootPart.CanCollide = false
                                                v.Humanoid:ChangeState(11)
                                                Attack = true
                                            until not v.Parent or v.Humanoid.Health <= 0 or not v:FindFirstChild("Humanoid") or getgenv().Config.AutoSea2 == false or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
                                            Attack = false;
                                        end;
                                    else
                                        Attack = false;
                                        Teleport(CFrame.new(1244.29688, 39.5166664, -1460.42871, -0.722323179, 2.79456125e-09, -0.691555679, -2.25985142e-09, 1, 6.40137054e-09, 0.691555679, 6.18667162e-09, -0.722323179))
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end);
        end;
    end);

    task.spawn(function()
        while task.wait() do
            if getgenv().Config.AutoFarm then
                pcall(function()
                    local QuestTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
                    if not string.find(QuestTitle, QuestCheck()[6]) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                    end
                    if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                        if (QuestCheck()[2].Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5 then
                            wait(1)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest",QuestCheck()[4],QuestCheck()[1])
                        else
                            Teleport(QuestCheck()[2])
                        end
                    elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                        if game:GetService("Workspace").Enemies:FindFirstChild(tostring(QuestCheck()[3])) then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                    if v.Name == QuestCheck()[3] then
                                        if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, QuestCheck()[6]) then
                                            repeat task.wait()
                                                BusoAndKen()
                                                getgenv().AutoFarmMon = v.HumanoidRootPart.CFrame
                                                Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                                                EquipTool(WeaponName)
                                                v.HumanoidRootPart.CanCollide = false
                                                v.Humanoid.WalkSpeed = 20
                                                v.Head.CanCollide = false
                                                Attack = true
                                                v.HumanoidRootPart.Size = Vector3.new(1,1,1)
                                            until not getgenv().Config.AutoFarm or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                            Attack = false
                                        else
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                                        end
                                    end
                                end
                            end
                        else
                            if FarmAround then
                                if not game:GetService("ReplicatedStorage"):FindFirstChild(tostring(QuestCheck()[3])) then
                                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                        if v.Name and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                            if (v.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 750 then
                                                repeat task.wait()
                                                    BusoAndKen()
                                                    getgenv().AutoFarmMon = v.HumanoidRootPart.CFrame
                                                    Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                                                    EquipTool(WeaponName)
                                                    v.HumanoidRootPart.CanCollide = false
                                                    v.Humanoid.WalkSpeed = 20
                                                    v.Head.CanCollide = false
                                                    v.HumanoidRootPart.Size = Vector3.new(1,1,1)
                                                    Attack = true
                                                until not FarmAround or not getgenv().Config.AutoFarm or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Workspace").Enemies:FindFirstChild(tostring(QuestCheck()[3])) or game:GetService("ReplicatedStorage"):FindFirstChild(tostring(QuestCheck()[3]))
                                                Attack = false
                                            end;
                                        end;
                                    end;
                                else
                                    Attack = false
                                    Teleport(QuestCheck()[7]);
                                end;
                            else
                                Teleport(QuestCheck()[7]);
                            end;
                        end;
                    end;
                end);
            end;
        end;
    end);

    task.spawn(function()
        while task.wait(.15) do
            pcall(function()
                if getgenv().Config.AutoFarm then
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if not string.find(v.Name,"Boss") and (v.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 600 then
                            if (v.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 200 then
                                v.HumanoidRootPart.CFrame = getgenv().AutoFarmMon;
                                v.HumanoidRootPart.Size = Vector3.new(1,1,1);
                                v.Humanoid.JumpPower = 0;
                                v.HumanoidRootPart.CanCollide = false;
                                v.Humanoid:ChangeState(11);
                            else
                            end;
                        end;
                    end;
                end;
            end);
        end;
    end);
end;

local Boss = Tabbox1:AddTab([[ Bosses ]]);
do
    local Bosses = {}
    for _,v in pairs(game:GetService('ReplicatedStorage'):GetChildren()) do
        if string.find(v.Name,'Boss') then
            if not table.find(Bosses, v.Name) then
                table.insert(Bosses,v.Name)
            end
        end
    end

    Boss:AddDropdown('BossesSelect',{
        Text = 'Select Bosses',
        Values = Bosses,
        Default = getgenv().Config.SelectBosses or 1,
        Tooltip = "Select Bosses to farm",
        Multi = false
    }):OnChanged(function(a)
        getgenv().Config.SelectBosses = a
        SelectBoss = a;
    end);
    
    Boss:AddToggle("Indx", {
        Text = 'Auto Farm Bosses',
        Default = getgenv().Config.AutoFarmBosses,
    }):OnChanged(function(a)
        getgenv().Config.AutoFarmBosses = a;
        getgenv().Config.Clip = a
        save();
    end);
    
    spawn(function()
        while wait() do
            pcall(function()
                if getgenv().Config.AutoFarmBosses then
                    if game:GetService("Workspace").Enemies:FindFirstChild(getgenv().Config.SelectBosses) then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v.Name == getgenv().Config.SelectBosses and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health >= 1 then
                                repeat wait()
                                    BusoAndKen()
                                    EquipTool(WeaponName)
                                    Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0));
                                    v.HumanoidRootPart.Size = Vector3.new(1,1,1);
                                    v.Humanoid.JumpPower = 0;
                                    v.HumanoidRootPart.CanCollide = false;
                                    v.Humanoid:ChangeState(11);
                                    Attack = true
                                until not getgenv().Config.AutoFarmBosses or v.Humanoid.Health < 0 or not v.Parent or not v:FindFirstChild("HumanoidRootPart")
                                Attack = false
                            end
                        end
                    else
                        Attack = false
                        if game:GetService("ReplicatedStorage"):FindFirstChild(getgenv().Config.SelectBosses) then
                            Teleport(game:GetService("ReplicatedStorage"):FindFirstChild(getgenv().Config.SelectBosses):FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0,30,0))
                        end
                    end
                end
            end)
        end
    end)

    Boss:AddLabel([[\\ Bosses Configs //]]);
    
    Boss:AddToggle("Indx", {
        Text = 'Auto Get Quest',
        Default = getgenv().Config.GetQuestBoss,
    }):OnChanged(function(a)
        getgenv().Config.GetQuestBoss = a;
        save();
    end);
    
    Boss:AddToggle("Indx", {
        Text = 'Auto Hop When Not Found',
        Default = getgenv().Config.BossHop,
    }):OnChanged(function(a)
        getgenv().Config.BossHop = a;
        save();
    end);
end;

local Sea1 = GeneralTab:AddLeftGroupbox("First Sea")
do
    Sea1:AddToggle("Indx", {
        Text = 'Auto Farm Saber',
        Default = getgenv().Config.AutoSaber,
    }):OnChanged(function(a)
        getgenv().Config.AutoSaber = a;
        getgenv().Config.Clip = a
        save();
    end);

    Sea1:AddToggle("Indx", {
        Text = 'Auto Farm Binsento V2',
        Default = getgenv().Config.AutoBisentoV2,
    }):OnChanged(function(a)
        getgenv().Config.AutoBisentoV2 = a;
        getgenv().Config.Clip = a
        save();
    end);

    Sea1:AddToggle("AutoPole", {
        Text = 'Auto Farm Pole',
        Default = getgenv().Config.AutoPole,
    }):OnChanged(function(a)
        getgenv().Config.AutoPole = a;
        getgenv().Config.Clip = a
        save();
    end);

    spawn(function() 
        while task.wait() do 
            pcall(function()
                if getgenv().Config.AutoSaber and not GetSwords("Saber") then
                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress").UsedTorch == false then
                        for i = 0 , 5 do
                            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress").Plates[i] == false then
                                for i,v in pairs(game:GetService("Workspace").Map.Jungle.QuestPlates:GetDescendants()) do 
                                    if v:IsA("TouchTransmitter") then
                                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0)
                                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1)
                                        task.wait(.1);
                                    end;
                                end;
                            elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress").Plates[i] == true then
                                if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Torch") or game.Players.LocalPlayer.Character:FindFirstChild("Torch") then
                                    EquipTool("Torch")
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress")
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","DestroyTorch")
                                else
                                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, game:GetService("Workspace").Map.Jungle.Torch, 0)
                                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, game:GetService("Workspace").Map.Jungle.Torch, 1)
                                end;
                            end;
                        end
                    elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress").UsedTorch == true then
                        if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress").UsedCup == false then
                            if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Cup") or game.Players.LocalPlayer.Character:FindFirstChild("Cup") then
                                EquipTool("Cup")
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","FillCup",game:GetService("Players").LocalPlayer.Character.Cup)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan") 
                            else
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","GetCup")
                            end;
                        elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress").UsedCup == true then
                            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == nil then
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")
                            elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 0 then
                                if game:GetService("ReplicatedStorage"):FindFirstChild("Mob Leader [Lv. 120] [Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Mob Leader [Lv. 120] [Boss]") then
                                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do 
                                        if v.Name == "Mob Leader [Lv. 120] [Boss]" and v:FindFirstChild("Humanoid") then
                                            if v.Humanoid.Health > 0 then
                                                repeat task.wait()
                                                    EquipTool(WeaponName)
                                                    Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                                    BusoAndKen() 
                                                    v.Humanoid.JumpPower = 0
                                                    v.Humanoid.WalkSpeed = 0
                                                    v.HumanoidRootPart.CanCollide = false
                                                    v.Humanoid:ChangeState(11)
                                                    Attack = true
                                                until not v.Parent or v.Humanoid.Health <= 0 or not v:FindFirstChild("Humanoid") or getgenv().Config.AutoSaber == false or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
                                                Attack = true
                                            end;
                                        else
                                            Attack = false
                                            Teleport(CFrame.new(-2877.64429, 6.44372749, 5406.70215, -0.172625661, 0, -0.984987795, 0, 1, 0, 0.984987795, 0, -0.172625661)*CFrame.new(0,60,0))
                                        end;
                                    end;
                                end;
                            elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 1 then
                                if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress").UsedRelic == false then
                                    if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Relic") or game.Players.LocalPlayer.Character:FindFirstChild("Relic") then
                                        EquipTool("Relic")
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","PlaceRelic")
                                        if (CFrame.new(-1402.60242, 29.8519974, 7.68171883, 0.830097198, 3.37981376e-08, 0.557618737, -5.78092596e-08, 1, 2.54460009e-08, -0.557618737, -5.33581819e-08, 0.830097198).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 14 then
                                            Teleport(CFrame.new(-1402.60242, 29.8519974, 7.68171883, 0.830097198, 1.86464213e-08, 0.557618737, -3.18877831e-08, 1, 1.40302667e-08, -0.557618737, -2.94277118e-08, 0.830097198))
                                            task.wait(.1)
                                            Teleport(CFrame.new(-1405.01831, 29.8519974, 3.57124162, 0.894635439, -3.49088847e-09, 0.446796894, 6.12287732e-09, 1, -4.44688508e-09, -0.446796894, 6.71402312e-09, 0.894635439))
                                            task.wait(.1)
                                            Teleport(CFrame.new(-1406.83301, 29.8519974, 4.6349864, 0.901276588, -2.28638033e-08, 0.433244139, 1.86878832e-08, 1, 1.38971341e-08, -0.433244139, -4.42874581e-09, 0.901276588))
                                            task.wait(.1)
                                            Teleport(CFrame.new(-1404.41431, 29.8519993, 3.26321101, 0.901589274, 1.19557049e-08, 0.432593048, -1.59494729e-08, 1, 5.60380675e-09, -0.432593048, -1.1951963e-08, 0.901589274))
                                            task.wait(.1)
                                        else 
                                            Teleport(CFrame.new(-1402.60242, 29.8519974, 7.68171883, 0.830097198, 2.52802757e-08, 0.557618737, -4.32373284e-08, 1, 1.90289704e-08, -0.557618737, -3.99058386e-08, 0.830097198))
                                        end;                           
                                    else
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress")
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")
                                    end;
                                elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress").UsedRelic == true then
                                    task.wait()
                                    if game.Players.LocalPlayer.Data.Level.Value >= 200 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress").KilledShanks == false then
                                        if game:GetService("Workspace").Enemies:FindFirstChild("Saber Expert [Lv. 200] [Boss]") then
                                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do 
                                                if v.Name == "Saber Expert [Lv. 200] [Boss]" and v:FindFirstChild("Humanoid") then
                                                    if v.Humanoid.Health > 0 then
                                                        repeat task.wait()
                                                            Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0)) 
                                                            EquipTool(WeaponName)
                                                            BusoAndKen()
                                                            v.Humanoid.JumpPower = 0
                                                            v.Humanoid.WalkSpeed = 0
                                                            v.HumanoidRootPart.CanCollide = false
                                                            v.Humanoid:ChangeState(11)
                                                            Attack = true
                                                        until not v.Parent or v.Humanoid.Health <= 0 or not v:FindFirstChild("Humanoid") or getgenv().Config.AutoSaber == false or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
                                                        Attack = false
                                                    end
                                                else
                                                    Attack = false
                                                    if game:GetService("ReplicatedStorage"):FindFirstChild("Saber Expert [Lv. 200] [Boss]") then
                                                        Teleport(game:GetService("ReplicatedStorage"):FindFirstChild("Saber Expert [Lv. 200] [Boss]").HumanoidRootPart.CFrame)
                                                    else
                                                        Teleport(CFrame.new(-1518, 39, -54))
                                                    end
                                                end;
                                            end;
                                        end;
                                    elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress").KilledShanks == true and game.Players.LocalPlayer.Data.Level.Value >= 200 then
                                        if game:GetService("ReplicatedStorage"):FindFirstChild("Saber Expert [Lv. 200] [Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Saber Expert [Lv. 200] [Boss]") then
                                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do 
                                                if v.Name == "Saber Expert [Lv. 200] [Boss]" and v:FindFirstChild("Humanoid") then
                                                    if v.Humanoid.Health > 0 then
                                                        repeat task.wait()
                                                            Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0)) 
                                                            EquipTool(WeaponName)
                                                            BusoAndKen()
                                                            v.Humanoid.JumpPower = 0
                                                            v.Humanoid.WalkSpeed = 0
                                                            v.HumanoidRootPart.CanCollide = false
                                                            v.Humanoid:ChangeState(11)
                                                            Attack = true
                                                        until not v.Parent or v.Humanoid.Health <= 0 or not v:FindFirstChild("Humanoid") or getgenv().Config.AutoSaber == false or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
                                                        Attack = false
                                                    end;
                                                else
                                                    Attack = false
                                                    if game:GetService("ReplicatedStorage"):FindFirstChild("Saber Expert [Lv. 200] [Boss]") then
                                                        Teleport(game:GetService("ReplicatedStorage"):FindFirstChild("Saber Expert [Lv. 200] [Boss]").HumanoidRootPart.CFrame)
                                                    else
                                                        Teleport(CFrame.new(-1518, 39, -54))
                                                    end
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end);
        end;
    end);    
end;

local Mastery = GeneralTab:AddLeftGroupbox([[\\ Masteries //]])
do
    Mastery:AddDropdown('MethodMas',{
        Text = 'Select Tool',
        Values = {
            "Swords",
            "Devil Fruits",
            "Guns"
        },
        Default = getgenv().Config.SelectToolFarmMas or 1,
        Tooltip = "Select Colors for snipe this",
        Multi = false
    }):OnChanged(function(a)
        getgenv().Config.SelectToolFarmMas = a;
        save();
        task.spawn(function()
            while task.wait() do
                pcall(function()
                end);
            end;
        end);
    end);
    
    Mastery:AddSlider('MobHealth', {
        Text = 'Use Skill At [%]',
        Default = getgenv().Config.MobHealth,
        Min = 0,
        Max = 100,
        Rounding = 0,
        Compact = false,
    });
    Options.MobHealth:OnChanged(function(a)
        getgenv().Config.MobHealth = a or Options.MobHealth.Value;
        save();
    end);

    Mastery:AddToggle("Indx", {
        Text = 'Auto Farm Select Mastery',
        Default = getgenv().Config.AutoFarmMas,
    }):OnChanged(function(a)
        getgenv().Config.AutoFarmMas = a;
        AutoFarmMas = a;
        save();
    end);
    
    task.spawn(function()
        while task.wait() do
            if AutoFarmMas then
                pcall(function()
                    local QuestTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
                    if not string.find(QuestTitle, QuestCheck()[6]) then
                        Magnet = false
                        UseSkill = false
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                    end
                    if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                        StartMasteryFruitMagnet = false
                        UseSkill = false
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest",QuestCheck()[4],QuestCheck()[1])
                    elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                        if game:GetService("Workspace").Enemies:FindFirstChild(tostring(QuestCheck()[3])) then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                    if v.Name == QuestCheck()[3] then
                                        if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, QuestCheck()[6]) then
                                            local HealthMs = v.Humanoid.MaxHealth * Options.MobHealth.Value/100
                                            repeat task.wait()
                                                if v.Humanoid.Health <= HealthMs then
                                                    BusoAndKen()
                                                    EquipTool(game:GetService("Players").LocalPlayer.Data.DevilFruit.Value)
                                                    Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                                    v.HumanoidRootPart.CanCollide = false
                                                    PosMonMasteryFruit = v.HumanoidRootPart.CFrame
                                                    v.Humanoid.WalkSpeed = 0
                                                    v.Head.CanCollide = false
                                                    UseSkill = true
                                                else           
                                                    UseSkill = false 
                                                    BusoAndKen()
                                                    EquipTool(WeaponName)
                                                    Teleport(v.HumanoidRootPart.CFrame * CFrame.new(5,20,7));
                                                    v.HumanoidRootPart.CanCollide = false;
                                                    v.HumanoidRootPart.Size = Vector3.new(120,120,120);
                                                    PosMonMasteryFruit = v.HumanoidRootPart.CFrame;
                                                    v.Humanoid.WalkSpeed = 0;
                                                    v.Head.CanCollide = false
                                                end;
                                                StartMasteryFruitMagnet = true;
                                            until not AutoFarmMas or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false;
                                        else
                                            UseSkill = false;
                                            StartMasteryFruitMagnet = false;
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest");
                                        end;
                                    end;
                                end;
                            end;
                        else
                            StartMasteryFruitMagnet = false;
                            UseSkill = false ;
                            local Mob = game:GetService("ReplicatedStorage"):FindFirstChild(tostring(QuestCheck()[3]));
                            if Mob then
                                Teleport(Mob.HumanoidRootPart.CFrame * CFrame.new(5,20,7));
                            else
                                if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Y <= 1 then
                                    game:GetService("Players").LocalPlayer.Character.Humanoid.Jump = true;
                                    task.wait();
                                    game:GetService("Players").LocalPlayer.Character.Humanoid.Jump = false;
                                end;
                            end;
                        end;
                    end;
                end);
            end;
        end;
    end);
    
    task.spawn(function()
        while task.wait() do
            if UseSkill then
                pcall(function()
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if game:GetService("Players").LocalPlayer.Character:FindFirstChild(game:GetService("Players").LocalPlayer.Data.DevilFruit.Value) then
                            MasBF = game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Data.DevilFruit.Value].Level.Value;
                        elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(game:GetService("Players").LocalPlayer.Data.DevilFruit.Value) then
                            MasBF = game:GetService("Players").LocalPlayer.Backpack[game:GetService("Players").LocalPlayer.Data.DevilFruit.Value].Level.Value;
                        end;
                        if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon-Dragon") then                      
                            if getgenv().SkillZ then
                                local args = {
                                    [1] = PosMonMasteryFruit.Position;
                                };
                                game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args));
                                game:GetService("VirtualInputManager"):SendKeyEvent(true,"Z",false,game);
                                game:GetService("VirtualInputManager"):SendKeyEvent(false,"Z",false,game);
                            end;
                            if getgenv().SkillX then          
                                local args = {
                                    [1] = PosMonMasteryFruit.Position;
                                };
                                game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args));
                                game:GetService("VirtualInputManager"):SendKeyEvent(true,"X",false,game);
                                game:GetService("VirtualInputManager"):SendKeyEvent(false,"X",false,game);
                            end
                            if getgenv().SkillC then
                                local args = {
                                    [1] = PosMonMasteryFruit.Position;
                                };
                                game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args));
                                game:GetService("VirtualInputManager"):SendKeyEvent(true,"C",false,game);
                                wait(3);
                                game:GetService("VirtualInputManager"):SendKeyEvent(false,"C",false,game);
                            end;
                        elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("Venom-Venom") then
                            if getgenv().SkillZ then
                                local args = {
                                    [1] = PosMonMasteryFruit.Position;
                                };
                                game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args));
                                game:GetService("VirtualInputManager"):SendKeyEvent(true,"Z",false,game);
                                task.wait(3);
                                game:GetService("VirtualInputManager"):SendKeyEvent(false,"Z",false,game);
                            end
                            if getgenv().SkillX then
                                local args = {
                                    [1] = PosMonMasteryFruit.Position;
                                };
                                game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args));
                                game:GetService("VirtualInputManager"):SendKeyEvent(true,"X",false,game);
                                game:GetService("VirtualInputManager"):SendKeyEvent(false,"X",false,game);
                            end;
                            if getgenv().SkillC then 
                                local args = {
                                    [1] = PosMonMasteryFruit.Position;
                                };
                                game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args));
                                game:GetService("VirtualInputManager"):SendKeyEvent(true,"C",false,game);
                                wait(2);
                                game:GetService("VirtualInputManager"):SendKeyEvent(false,"C",false,game);
                            end;
                        elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("Human-Human: Buddha") then
                            if getgenv().SkillZ and game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Size == Vector3.new(2, 2.0199999809265, 1) then
                                local args = {
                                    [1] = PosMonMasteryFruit.Position;
                                };
                                game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args));
                                game:GetService("VirtualInputManager"):SendKeyEvent(true,"Z",false,game);
                                game:GetService("VirtualInputManager"):SendKeyEvent(false,"Z",false,game);
                            end;
                            if getgenv().SkillX then
                                local args = {
                                    [1] = PosMonMasteryFruit.Position;
                                };
                                game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args));
                                game:GetService("VirtualInputManager"):SendKeyEvent(true,"X",false,game);
                                game:GetService("VirtualInputManager"):SendKeyEvent(false,"X",false,game);
                            end;
                            if getgenv().SkillC then
                                local args = {
                                    [1] = PosMonMasteryFruit.Position;
                                };
                                game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args));
                                game:GetService("VirtualInputManager"):SendKeyEvent(true,"C",false,game);
                                game:GetService("VirtualInputManager"):SendKeyEvent(false,"C",false,game);
                            end;
                            if getgenv().SkillV then
                                local args = {
                                    [1] = PosMonMasteryFruit.Position;
                                };
                                game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args));
                                game:GetService("VirtualInputManager"):SendKeyEvent(true,"V",false,game);
                                game:GetService("VirtualInputManager"):SendKeyEvent(false,"V",false,game);
                            end;
                        elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild(game:GetService("Players").LocalPlayer.Data.DevilFruit.Value) then
                            if getgenv().SkillZ then 
                                local args = {
                                    [1] = PosMonMasteryFruit.Position;
                                };
                                game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args));
                                game:GetService("VirtualInputManager"):SendKeyEvent(true,"Z",false,game);
                                game:GetService("VirtualInputManager"):SendKeyEvent(false,"Z",false,game);
                            end;
                            if getgenv().SkillX then
                                local args = {
                                    [1] = PosMonMasteryFruit.Position;
                                };
                                game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args));
                                game:GetService("VirtualInputManager"):SendKeyEvent(true,"X",false,game);
                                game:GetService("VirtualInputManager"):SendKeyEvent(false,"X",false,game);
                            end;
                            if getgenv().SkillC then
                                local args = {
                                    [1] = PosMonMasteryFruit.Position;
                                };
                                game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args));
                                game:GetService("VirtualInputManager"):SendKeyEvent(true,"C",false,game);
                                game:GetService("VirtualInputManager"):SendKeyEvent(false,"C",false,game);
                            end;
                            if getgenv().SkillV then
                                local args = {
                                    [1] = PosMonMasteryFruit.Position;
                                };
                                game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args));
                                game:GetService("VirtualInputManager"):SendKeyEvent(true,"V",false,game);
                                game:GetService("VirtualInputManager"):SendKeyEvent(false,"V",false,game);
                            end;
                        end;
                    end;
                end);
            end;
        end;
    end);
    
    task.spawn(function()
        game:GetService("RunService").RenderStepped:Connect(function()
            pcall(function()
                if UseSkill then
                    for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Notifications:GetChildren()) do
                        if v.Name == "NotificationTemplate" then
                            if string.find(v.Text,"Skill locked!") then
                                v:Destroy();
                            end;
                        end;
                    end;
                end;
            end);
        end);
    end);
    
    task.spawn(function()
        pcall(function()
            game:GetService("RunService").RenderStepped:Connect(function()
                if UseSkill then
                    local args = {
                        [1] = PosMonMasteryFruit.Position;
                    };
                    game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Data.DevilFruit.Value].RemoteEvent:FireServer()
                end;
            end);
        end);
    end);
end;

local ObServation = GeneralTab:AddLeftGroupbox([[\\ Observations //]])
do
    local ObsEXP = ObServation:AddLabel('Observation EXP : [ inf ]');
    local Status = ObServation:AddLabel('Task : 🔴 Disibled');

    task.spawn(function()
        while task.wait() do
            pcall(function()
                ObsEXP:SetText("Observation EXP : [ "..math.floor(game:GetService("Players").LocalPlayer.VisionRadius.Value) .. " ]")
            end);
        end;
    end);

    ObServation:AddToggle("Indx", {
        Text = 'Auto Farm Observation',
        Default = getgenv().Config.AutoFarmObs,
    }):OnChanged(function(a)
        getgenv().Config.AutoFarmObs = a;
        save();
        getgenv().Config.Clip = a
    end)

    ObServation:AddToggle("Indx", {
        Text = 'Auto Observation V2',
        Default = getgenv().Config.AutoFarmObsv2,
    }):OnChanged(function(a)
        getgenv().Config.AutoFarmObsv2 = a;
        save();
        getgenv().Config.Clip = a
    end)

    task.spawn(function()
        pcall(function()
            while task.wait() do
                if getgenv().Config.AutoFarmObs then
                    if game:GetService("Players").LocalPlayer.VisionRadius.Value >= 3000 then
                        Status:SetText('Task : 🔵 You are currently maxed observation level');
                    else
                        if SecondSea then
                            if game:GetService("Workspace").Enemies:FindFirstChild("Lava Pirate [Lv. 1200]") then
                                if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                                    repeat task.wait()
                                        Status:SetText('Task : ⚪ Farming observation exp');
                                        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Lava Pirate [Lv. 1200]").HumanoidRootPart.CFrame * CFrame.new(3,0,0)
                                    until getgenv().Config.AutoFarmObs == false or not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
                                else
                                    repeat task.wait()
                                        Status:SetText('Task : ⏰ wait for observation cooldown');
                                        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Lava Pirate [Lv. 1200]").HumanoidRootPart.CFrame * CFrame.new(0,150,0)
                                        if not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") and getgenv().Config.AllowHop == true then
                                            game:GetService("TeleportService"):Teleport(game.PlaceId,game:GetService("Players").LocalPlayer)
                                        end
                                    until getgenv().Config.AutoFarmObs == false or game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
                                end
                            else
                                Teleport(CFrame.new(-5478.39209, 15.9775667, -5246.9126))
                            end
                        elseif FirstSea then
                            if game:GetService("Workspace").Enemies:FindFirstChild("Galley Captain [Lv. 650]") then
                                if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                                    repeat task.wait()
                                        Status:SetText('Task : ⚪ Farming observation exp');
                                        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Galley Captain [Lv. 650]").HumanoidRootPart.CFrame * CFrame.new(3,0,0)
                                    until getgenv().Config.AutoFarmObs == false or not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
                                else
                                    repeat task.wait()
                                        Status:SetText('Task : ⏰ wait for observation cooldown');
                                        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Galley Captain [Lv. 650]").HumanoidRootPart.CFrame * CFrame.new(0,150,0)
                                        if not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") and getgenv().Config.AllowHop == true then
                                            game:GetService("TeleportService"):Teleport(game.PlaceId,game:GetService("Players").LocalPlayer)
                                        end
                                    until getgenv().Config.AutoFarmObs == false or game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
                                end
                            else
                                Teleport(CFrame.new(5533.29785, 88.1079102, 4852.3916))
                            end
                        elseif ThirdSea then
                            if game:GetService("Workspace").Enemies:FindFirstChild("Giant Islander [Lv. 1650]") then
                                if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                                    repeat task.wait()
                                        Status:SetText('Task : ⚪ Farming observation exp');
                                        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Giant Islander [Lv. 1650]").HumanoidRootPart.CFrame * CFrame.new(3,0,0)
                                    until getgenv().Config.AutoFarmObs == false or not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
                                else
                                    repeat task.wait()
                                        Status:SetText('Task : ⏰ wait for observation cooldown');
                                        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Giant Islander [Lv. 1650]").HumanoidRootPart.CFrame * CFrame.new(0,150,0)
                                        if not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") and getgenv().Config.AllowHop then
                                            game:GetService("TeleportService"):Teleport(game.PlaceId,game:GetService("Players").LocalPlayer)
                                        end
                                    until getgenv().Config.AutoFarmObs == false or game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
                                end
                            else
                                Teleport(CFrame.new(4530.3540039063, 656.75695800781, -131.60952758789))
                            end
                        end
                    end
                else
                    Status:SetText('Task : 🔴 Dissibled');
                end
            end
        end)
    end);

    task.spawn(function()
        while task.wait() do
            pcall(function()
                if getgenv().Configs.AutoFarmObs then
                    repeat task.wait()
                        if not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                            game:GetService('VirtualUser'):CaptureController()
                            game:GetService('VirtualUser'):SetKeyDown('0x65')
                            wait(2)
                            game:GetService('VirtualUser'):SetKeyUp('0x65')
                        end
                    until game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") or not getgenv().Configs.AutoFarmObs
                end
            end)
        end
    end);

    task.spawn(function()
        while task.wait() do
            pcall(function()
                if getgenv().Config.AutoFarmObsv2 then
                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen") == 3 then
                        if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Banana") and  game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Apple") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Pineapple") then
                            repeat 
                                Teleport(CFrame.new(-12444.78515625, 332.40396118164, -7673.1806640625)) 
                                task.wait() 
                            until not getgenv().Config.AutoFarmObsv2 or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-12444.78515625, 332.40396118164, -7673.1806640625)).Magnitude <= 10
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen")
                        elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Fruit Bowl") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Fruit Bowl") then
                            repeat 
                                Teleport(CFrame.new(-10920.125, 624.20275878906, -10266.995117188)) 
                                task.wait() 
                            until not getgenv().Config.AutoFarmObsv2 or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-10920.125, 624.20275878906, -10266.995117188)).Magnitude <= 10
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk2","Start")
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk2","Buy")
                        else
                            for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
                                if v.Name == "Apple" or v.Name == "Banana" or v.Name == "Pineapple" then
                                    v.Handle.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,1,10)
                                    task.wait()
                                    firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,v.Handle,0)
                                    task.wait()
                                end
                            end   
                        end
                    end
                end
            end)
        end
    end);
end;

local Others = GeneralTab:AddLeftGroupbox("Others");
do
    Others:AddToggle("AutoRainbowHaki", {
        Text = "Auto Obtain Rainbow Haki",
        Default = getgenv().Config.AutoRainbowHaki,
        Tooltip = 'Make u body change color like rgb light gaming chair'
    }):OnChanged(function(a)
        getgenv().Config.AutoRainbowHaki = a
        save()
    end);

    Others:AddToggle("AutoMusketeer", {
        Text = "Auto Obtain Musketeer Hat",
        Default = getgenv().Config.AutoMusketeerHat,
        Tooltip = 'for?'
    }):OnChanged(function(a)
        getgenv().Config.AutoMusketeerHat = a
        save()
    end);

    spawn(function()
        pcall(function()
            while wait(.1) do
                if getgenv().Config.AutoMusketeerHat then
                    if game:GetService("Players").LocalPlayer.Data.Level.Value >= 1800 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress").KilledBandits == false then
                        if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Forest Pirate") and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                            if game:GetService("Workspace").Enemies:FindFirstChild("Forest Pirate [Lv. 1825]") then
                                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if v.Name == "Forest Pirate [Lv. 1825]" then
                                        repeat task.wait()
                                            pcall(function()
                                                EquipTool(WeaponName)
                                                BusoAndKen()
                                                Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                                v.HumanoidRootPart.CanCollide = false
                                                getgenv().PosMon = v.HumanoidRootPart.CFrame
                                                Attack = true
                                            end)
                                        until getgenv().Config.AutoMusketeerHat == false or not v.Parent or v.Humanoid.Health <= 0 or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                        Attack = false
                                    end
                                end
                            else
                                Attack = false
                                Teleport(CFrame.new(-13206.452148438, 425.89199829102, -7964.5537109375))
                            end
                        else
                            Teleport(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125))
                            if (Vector3.new(-12443.8671875, 332.40396118164, -7675.4892578125) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                                wait(1.5)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest","CitizenQuest",1)
                            end
                        end
                    elseif game:GetService("Players").LocalPlayer.Data.Level.Value >= 1800 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress").KilledBoss == false then
                        if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") and game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                            if game:GetService("Workspace").Enemies:FindFirstChild("Captain Elephant [Lv. 1875] [Boss]") then
                                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if v.Name == "Captain Elephant [Lv. 1875] [Boss]" then
                                        repeat task.wait()
                                            pcall(function()
                                                EquipTool(WeaponName)
                                                BusoAndKen()
                                                v.HumanoidRootPart.CanCollide = false
                                                Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                                Attack = true
                                                sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                                            end)
                                        until getgenv().Config.AutoMusketeerHat == false or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                        Attack = false
                                    end
                                end
                            else
                                if game:GetService('ReplicatedStorage'):FindFirstChild("Captain Elephant [Lv. 1875] [Boss]") then
                                    Teleport(game:GetService('ReplicatedStorage'):FindFirstChild("Captain Elephant [Lv. 1875] [Boss]").HumanoidRootPart.CFrame)
                                end
                            end
                        else
                            Teleport(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125))
                            if (CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 then
                                wait(1.5)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen")
                            end
                        end
                    elseif game:GetService("Players").LocalPlayer.Data.Level.Value >= 1800 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen") == 2 then
                        Teleport(CFrame.new(-12512.138671875, 340.39279174805, -9872.8203125))
                    end
                end
            end
        end)
    end)

    spawn(function()
        pcall(function()
            while wait(.1) do
                if getgenv().Config.AutoRainbowHaki then
                    if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                        Teleport(CFrame.new(-11892.0703125, 930.57672119141, -8760.1591796875))
                        if (Vector3.new(-11892.0703125, 930.57672119141, -8760.1591796875) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                            wait(1.5)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("HornedMan","Bet")
                        end
                    elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Stone") then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Stone [Lv. 1550] [Boss]") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Stone [Lv. 1550] [Boss]" then
                                    repeat task.wait()
                                        EquipTool(WeaponName)
                                        Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                        v.HumanoidRootPart.CanCollide = false
                                        Attack = true
                                        sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                                    until getgenv().Config.AutoRainbowHaki == false or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                    Attack = false
                                end
                            end
                        else
                            if game:GetService('ReplicatedStorage'):FindFirstChild("Stone [Lv. 1550] [Boss]") then
                                Teleport(game:GetService('ReplicatedStorage'):FindFirstChild("Stone [Lv. 1550] [Boss]").HumanoidRootPart.CFrame)
                            end
                        end
                    elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Island Empress") then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Island Empress [Lv. 1675] [Boss]") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Island Empress [Lv. 1675] [Boss]" then
                                    repeat task.wait()
                                        EquipTool(WeaponName)
                                        Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                        v.HumanoidRootPart.CanCollide = false
                                        Attack = true
                                        sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                                    until getgenv().Config.AutoRainbowHaki == false or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                    Attack = false
                                end
                            end
                        else
                            if game:GetService('ReplicatedStorage'):FindFirstChild("Island Empress [Lv. 1675] [Boss]") then
                                Teleport(game:GetService('ReplicatedStorage'):FindFirstChild("Island Empress [Lv. 1675] [Boss]").HumanoidRootPart.CFrame)
                            end
                        end
                    elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Kilo Admiral") then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Kilo Admiral [Lv. 1750] [Boss]") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Kilo Admiral [Lv. 1750] [Boss]" then
                                    repeat task.wait()
                                        EquipTool(WeaponName)
                                        Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                        v.HumanoidRootPart.CanCollide = false
                                        Attack = true
                                        sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                                    until getgenv().Config.AutoRainbowHaki == false or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                    Attack = false
                                end
                            end
                        else
                            if game:GetService('ReplicatedStorage'):FindFirstChild("Kilo Admiral [Lv. 1750] [Boss]") then
                                Teleport(game:GetService('ReplicatedStorage'):FindFirstChild("Kilo Admiral [Lv. 1750] [Boss]").HumanoidRootPart.CFrame)
                            end
                        end
                    elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Captain Elephant [Lv. 1875] [Boss]") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Captain Elephant [Lv. 1875] [Boss]" then
                                    repeat task.wait()
                                        EquipTool(WeaponName)
                                        Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                        v.HumanoidRootPart.CanCollide = false
                                        sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                                    until getgenv().Config.AutoRainbowHaki == false or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                end
                            end
                        else
                            if game:GetService('ReplicatedStorage'):FindFirstChild("Captain Elephant [Lv. 1875] [Boss]") then
                                Teleport(game:GetService('ReplicatedStorage'):FindFirstChild("Captain Elephant [Lv. 1875] [Boss]").HumanoidRootPart.CFrame)
                            end
                        end
                    elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Beautiful Pirate") then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Beautiful Pirate [Lv. 1950] [Boss]") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Beautiful Pirate [Lv. 1950] [Boss]" then
                                    OldCFrameRainbow = v.HumanoidRootPart.CFrame
                                    repeat task.wait()
                                        EquipTool(WeaponName)
                                        Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                        v.HumanoidRootPart.CanCollide = false
                                        Attack = true
                                        sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                                    until getgenv().Config.AutoRainbowHaki == false or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                    Attack = false
                                end
                            end
                        else
                            if game:GetService('ReplicatedStorage'):FindFirstChild("Beautiful Pirate [Lv. 1950] [Boss]") then
                                Teleport(game:GetService('ReplicatedStorage'):FindFirstChild("Beautiful Pirate [Lv. 1950] [Boss]").HumanoidRootPart.CFrame)
                            end
                        end
                    else
                        Teleport(CFrame.new(-11892.0703125, 930.57672119141, -8760.1591796875))
                        if (Vector3.new(-11892.0703125, 930.57672119141, -8760.1591796875) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                            wait(1.5)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("HornedMan","Bet")
                        end
                    end
                end
            end
        end)
    end)

    spawn(function()
        while task.wait(.15) do
            pcall(function()
                if getgenv().Config.AutoMusketeerHat or getgenv().Config.AutoRainbowHaki then
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if not string.find(v.Name,"Boss") and (v.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 600 then
                            if (v.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 200 then
                                v.HumanoidRootPart.CFrame = getgenv().PosMon;
                                v.HumanoidRootPart.Size = Vector3.new(1,1,1);
                                v.Humanoid.JumpPower = 0;
                                v.HumanoidRootPart.CanCollide = false;
                                v.Humanoid:ChangeState(11);
                            end;
                        end;
                    end;
                end;
            end);
        end;
    end);
end;

-- Settings

local Setting = GeneralTab:AddRightGroupbox("Settings");
do

    Setting:AddDropdown('SelectWeapon',{
        Text = 'Select Tooltip',
        Values = {
            "Melee",
            "Swords",
            "Devil Fruits"
        },
        Default = getgenv().Config.Tooltip or 1,
        Tooltip = "Select tooltip for equip this weapon",
        Multi = false
    }):OnChanged(function(a)
        getgenv().Config.Tooltip = a;
        Tooltip = a;
        save();
        task.spawn(function()
            while task.wait() do
                pcall(function()
                    if getgenv().Config.Tooltip == "Melee" then
                        for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v.ToolTip == "Melee" then
                                if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                                    WeaponName = v.Name;
                                    Melee = v.Name;
                                end;
                            end;
                        end;
                    elseif getgenv().Config.Tooltip == "Sword" then
                        for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v.ToolTip == "Sword" then
                                if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                                    WeaponName = v.Name;
                                    Sword = v.Name;
                                end;
                            end;
                        end;
                    elseif getgenv().Config.Tooltip == "Devil Fruit" then
                        for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v.ToolTip == "Blox Fruit" then
                                if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                                    WeaponName = v.Name;
                                    DevilFruit = v.Name;
                                end;
                            end;
                        end;
                    else
                        for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v.ToolTip == "Melee" then
                                if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                                    WeaponName = v.Name;
                                end;
                            end;
                        end;
                    end;
                end);
            end;
        end);
    end);

    Setting:AddToggle("Indx", {
        Text = "Fast Attack",
        Default = getgenv().Config.FastAttack,
        Tooltip = 'Make your attack speed faster!'
    }):OnChanged(function(a)
        getgenv().Config.FastAttack = a
        save()
    end);
    
    local CameraShaker = require(game.ReplicatedStorage.Util.CameraShaker)
    for l,v in pairs(getreg()) do
        if typeof(v) == "function" and getfenv(v).script == game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework then
            for _,y in pairs(debug.getupvalues(v)) do
                if typeof(y) == "table" then
                    task.spawn(function()
                        while task.wait(getgenv().Config.FastAttackDelay) do
                            if getgenv().Config.FastAttack and Attack then
                                attack()
                                if identifyexecutor() == 'Fluxus' or identifyexecutor() == 'Hydrogen' then
                                    pcall(function()
                                        CameraShaker:Stop()
                                        y.timeToNextAttack = -math.huge
                                        y.activeController.attacking = false
                                        y.activeController.increment = 1
                                        y.activeController.hitboxMagnitude =80
                                        y.activeController.blocking = false
                                        y.activeController:attack()
                                        y.activeController.timeToNextBlock = false
                                    end)
                                else
                                    pcall(function()
                                        CameraShaker:Stop()
                                        y.timeToNextAttack = -math.huge
                                        y.activeController.attacking = false
                                        y.activeController.increment = 1
                                        y.activeController.hitboxMagnitude =80
                                        y.activeController.blocking = false
                                        y.activeController:attack()
                                        y.activeController.timeToNextBlock = false
                                    end)
                                end
                            end
                        end
                    end)
                end
            end
        end
    end

    Setting:AddSlider('Delay', {
        Text = 'Fast Attack Delay',
        Default = getgenv().Config.FastAttackDelay,
        Min = 0,
        Max = 1,
        Rounding = 10,
        Compact = false,
    });

    Options.Delay:OnChanged(function(a)
        getgenv().Config.FastAttackDelay = a or Options.Delay.Value;
        save();
    end);

    Setting:AddSlider('Incre', {
        Text = 'Fast Attack Increments',
        Default = getgenv().Config.FastAttackIncrement,
        Min = 1,
        Max = 10,
        Rounding = 0,
        Compact = false,
    });

    Options.Incre:OnChanged(function(a)
        getgenv().Config.FastAttackIncrement = a or Options.Incre.Value;
        Increments = a or Options.Incre.Value;
        save();
    end);
    
    Setting:AddToggle("Indx", {
        Text = "Instant Teleport",
        Default = getgenv().Config.InstantTeleport,
        Tooltip = 'Make your teleport faster!'
    }):OnChanged(function(a)
        getgenv().Config.InstantTeleport = a
        save()
        InstantTeleport = a
    end);

    Setting:AddLabel('Select Color'):AddColorPicker('ColorPicker', {
        Default = getgenv().Config.Color,
        Title = 'Select Screen Color []', 
    });

    Options.ColorPicker:OnChanged(function()
        getgenv().Config.Color = Options.ColorPicker.Value;
        save();
    end);

    Setting:AddToggle("Indx", {
        Text = 'Screen Rainbow',
        Default = getgenv().Config.Rainbow,
        Tooltip = 'R G B Screen color bruh',
    }):OnChanged(function(a)
        getgenv().Config.Rainbow=a
        if a==false then
            getgenv().Config.Color = Color3.fromRGB(0,0,0);
        end;
    end);

    Setting:AddToggle("Indx", {
        Text = 'Boost Fps Screen',
        Default = getgenv().Config.Screen,
        Tooltip = 'Boost your fps',
    }):OnChanged(function(a)
        getgenv().Config.Screen = a;
        save();
    end);

    Setting:AddToggle("Indx", {
        Text = 'Normal white screen',
        Default = getgenv().Config.WhiteScreen,
        Tooltip = 'Boost your fps',
    }):OnChanged(function(a)
        getgenv().Config.WhiteScreen = a;
        save();
        task.spawn(function()
            while getgenv().Config.WhiteScreen do task.wait()
                if getgenv().Config.WhiteScreen then
                    game:GetService('RunService'):Set3dRenderingEnabled(false);
                    setfpscap(360);
                else
                    game:GetService('RunService'):Set3dRenderingEnabled(true);
                end;
            end;
        end);
    end);

    local g = game;
    local w = g.Workspace;
    local l = g.Lighting;
    local t = w.Terrain;

    Setting:AddButton('Teleport tool',function()
        local plr = game:GetService("Players").LocalPlayer
        local mouse = plr:GetMouse()

        local tool = Instance.new("Tool")
        tool.RequiresHandle = false
        tool.Name = "Teleport Tool"

        tool.Activated:Connect(function()
            local root = plr.Character.HumanoidRootPart
            local pos = mouse.Hit.Position+Vector3.new(0,2.5,0)
            local offset = pos-root.Position
            if (root.Position - pos).Magnitude <= 50 then
                root.CFrame = root.CFrame+offset
            else
                local Target = root.CFrame+offset
                Teleport(CFrame.new(Target))
            end
        end)

        tool.Parent = plr.Backpack
    end);

    Setting:AddButton('Boosts FPS', function()
        do
            game:GetService("ReplicatedStorage").Assets.GUI.DamageCounter.Enabled = false
            task.spawn(function()
                while task.wait() do
                    for i, v in pairs(game.Workspace["_WorldOrigin"]:GetChildren()) do
                        if v.Name == "Dust" or v.Name == "eff" or v.Name == "CurvedRing" or v.Name == "SwordSlash" or v.Name == "Sounds" or v.Name == "SlashHit" then
                            v:Destroy() 
                        end
                    end
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetDescendants()) do
                        if v.ClassName == "MeshPart" then
                            v.Transparency = 0.5
                        end
                    end
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetDescendants()) do
                        if v.Name == "Head" then
                            v.Transparency = 0.5
                        end
                    end
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetDescendants()) do
                        if v.ClassName == "Accessory" then
                            v.Handle.Transparency = 0.5
                        end
                    end
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetDescendants()) do
                        if v.ClassName == "Decal" then
                            v.Transparency = 0.5
                        end
                    end
                end
            end)
            local decalsyeeted = true;
            t.WaterWaveSize = 0;
            t.WaterWaveSpeed = 0;
            t.WaterReflectance = 0;
            t.WaterTransparency = 0;
            l.GlobalShadows = false;
            l.FogEnd = 9e9;
            l.Brightness = 0;
            settings().Rendering.QualityLevel = "Level01";
            for i, v in pairs(g:GetDescendants()) do
                if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then 
                    v.Material = "Plastic";
                    v.Reflectance = 0;
                elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
                    v.Transparency = 1;
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v.Lifetime = NumberRange.new(0);
                elseif v:IsA("Explosion") then
                    v.BlastPressure = 1;
                    v.BlastRadius = 1;
                elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                    v.Enabled = false;
                elseif v:IsA("MeshPart") then
                    v.Material = "Plastic";
                    v.Reflectance = 0;
                    v.TextureID = 10385902758728957;
                end;
            end;
            for i, e in pairs(l:GetChildren()) do
                if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                    e.Enabled = false;
                end;
            end;
        end;
    end);
end;

local Stats = GeneralTab:AddRightGroupbox([[Stats]])
do
    Stats:AddDropdown('Stats',{
        Text = 'Select Stats to upgrade',
        Values = {
            "Melee",
            "Defense",
            "Sword",
            "Devil Fruit",
            "Gun"
        },
        Default = getgenv().Config.SelectUpStats or 1,
        Tooltip = "Select Stats to upgrade",
        Multi = true
    }):OnChanged(function(a)
        save()
        for k,v in next,Options.Stats.Value do
            task.spawn(function()
                while task.wait() do
                    pcall(function()
                        if getgenv().Config.AutoStats then
                            if k == 'Melee' then
                                local args = {
                                    [1] = "AddPoint",
                                    [2] = "Melee",
                                    [3] = getgenv().Config.Points
                                }
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                            end;
                            if k == "Defense" then 
                                local args = {
                                    [1] = "AddPoint",
                                    [2] = "Defense",
                                    [3] = getgenv().Config.Points
                                }
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))				
                            end;
                            if k == 'Sword' then 
                                local args = {
                                    [1] = "AddPoint",
                                    [2] = "Sword",
                                    [3] = getgenv().Config.Points
                                }
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))				
                            end;
                            if k == "Devil Fruit" then 
                                local args = {
                                    [1] = "AddPoint",
                                    [2] = "Demon Fruit",
                                    [3] = getgenv().Config.Points
                                }
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))				
                            end;
                            if k == 'Gun' then
                                local args = {
                                    [1] = "AddPoint",
                                    [2] = "Gun",
                                    [3] = getgenv().Config.Points
                                }
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                            end;
                        end;
                    end);
                end;
            end);
        end;
    end);

    Stats:AddSlider('Points', {
        Text = 'Points',
        Default = getgenv().Config.Points,
        Min = 0,
        Max = 10,
        Rounding = 0,
        Compact = false,
    });
    local Points = Options.Points.Value;
    Options.Points:OnChanged(function(a)
        getgenv().Config.Points = a or Options.Points.Value;
        save();
    end);

    Stats:AddToggle("Indx", {
        Text = 'Auto Upgrade Stats',
        Default = getgenv().Config.AutoStats,
    }):OnChanged(function(a)
        getgenv().Config.AutoStats = a;
        save();
    end);
end;

local Server = GeneralTab:AddRightGroupbox([[Servers]])
do
    Server:AddInput('JobID', {
        Default = 'insert JobID here',
        Numeric = false,
        Finished = true,
        Text = 'JobID Server Joiner',
        Tooltip = 'Join server with jobid',
    
        Placeholder = 'Placeholder text',
    });

    Server:AddButton("Join Server", function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(tostring(game.PlaceId), Options.JobID.Value)
    end);
    
    Server:AddButton("Copy Jobid", function()
        setgetgenv().Clipboard(game.JobId)
    end);
    
    Server:AddButton("Copy Join Server Script", function()
        setgetgenv().Clipboard('game:GetService("TeleportService"):TeleportToPlaceInstance('.. tonumber(game.PlaceId) .. ', "'.. game.JobId .. '")')
    end);
end;

task.spawn(function()
	while task.wait() do
		if ThirdSea then
			if not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild('Frame') then
				local b = Instance.new('Frame',game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui)
			end
		local BlackScreen = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Frame
		elseif FirstSea or SecondSea then
			local BlackScreen = game:GetService("Players").LocalPlayer.PlayerGui.Smokescreen.Frame
		end
		local BlackScreen = game:GetService("Players").LocalPlayer.PlayerGui.Smokescreen.Frame
		--local Frame = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui
		getgenv().DefaultSize = BlackScreen.Size
		getgenv().NewSize = UDim2.new(500, 0, 500, 500)
		if getgenv().Config.Screen == true then
			game:GetService("RunService"):Set3dRenderingEnabled(false)
			setfpscap(360)
			if getgenv().Config.Screen==true then
			BlackScreen.BackgroundColor3 = getgenv().Config.Color or Color3.fromRGB(0,0,0)
			BlackScreen.BackgroundTransparency = 0
			end
			BlackScreen.Size = NewSize
		elseif getgenv().Config.Screen == false then
			BlackScreen.Size = UDim2.new(DefaultSize)
			BlackScreen.BackgroundTransparency = 1
			game:GetService("RunService"):Set3dRenderingEnabled(true)
		end
        local t = 5; --how long does it take to go through the rainbow
		local tick = tick()
		local fromHSV = Color3.fromRGB
		local RunService = game:GetService("RunService")
		if getgenv().Config.Rainbow==true and getgenv().Config.Screen==true then
			local hue = tick() % t / t
			local color = fromHSV(hue, 1, 1)
			getgenv().Config.Color = color
		end
	end
end);

local FightingStyle = AutomaticsTab:AddLeftGroupbox("Fighting Styles");
do
    FightingStyle:AddToggle("Godhuman", {
        Text = "Auto Godhuman",
        Default = getgenv().Config.AutoGodhuman,
        Callback = function(a)
            getgenv().Config.AutoGodhuman = a;
            getgenv().Config.Clip = a;
            save();
        end;
    });

    FightingStyle:AddToggle("DragonTalon", {
        Text = "Auto Dragon Talon",
        Default = getgenv().Config.AutoDragonTalon,
        Callback = function(a)
            getgenv().Config.AutoDragonTalon = a;
            getgenv().Config.Clip = a;
            save();
        end;
    });

    FightingStyle:AddToggle("ElectricClaw", {
        Text = "Auto Godhuman",
        Default = getgenv().Config.AutoElectricClaw,
        Callback = function(a)
            getgenv().Config.AutoElectricClaw = a;
            getgenv().Config.Clip = a;
            save();
        end;
    });

    FightingStyle:AddToggle("SharkmanKarate", {
        Text = "Auto Godhuman",
        Default = getgenv().Config.AutoSharkmanKarate,
        Callback = function(a)
            getgenv().Config.AutoSharkmanKarate = a;
            getgenv().Config.Clip = a;
            save();
        end;
    });
    
    FightingStyle:AddToggle("Death Step", {
        Text = "Auto Death Step",
        Default = getgenv().Config.AutoDeathStep,
        Callback = function(a)
            getgenv().Config.AutoDeathStep = a;
            getgenv().Config.Clip = a;
            save();
        end;
    });
    
    FightingStyle:AddToggle("Superhuman", {
        Text = "Auto Superhuman",
        Default = getgenv().Config.AutoSuperhuman,
        Callback = function(a)
            getgenv().Config.AutoSuperhuman = a;
            getgenv().Config.Clip = a;
            save();
        end;
    });
end;

local Tabbox2 = AutomaticsTab:AddLeftTabbox();
local Bone = Tabbox2:AddTab([[Bones]])
do
    local TotalBone = Bone:AddLabel('Bones : [ inf ]');

    task.spawn(function()
        while task.wait() do
            TotalBone:SetText('Bones : [ '.. Material("Bones") ..' ]');
        end;
    end);

    Bone:AddToggle("Indx", {
        Text = 'Auto Farm Bones',
        Default = getgenv().Config.AutoFarmBone,
    }):OnChanged(function(a)
        getgenv().Config.AutoFarmBone = a;
        save();
        AutoFarmBone = a;
        getgenv().Config.Clip = a
        task.spawn(function()
            while task.wait() do
                pcall(function()
                    if AutoFarmBone then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton [Lv. 1975]") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie [Lv. 2000]") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul [Lv. 2025]") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy [Lv. 2050]") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Reborn Skeleton [Lv. 1975]" or v.Name == "Living Zombie [Lv. 2000]" or v.Name == "Demonic Soul [Lv. 2025]" or v.Name == "Posessed Mummy [Lv. 2050]" then
                                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                        repeat task.wait()
                                            Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                            EquipTool(WeaponName)
                                            BusoAndKen()
                                            getgenv().PosMon = v.HumanoidRootPart.CFrame
                                            v.HumanoidRootPart.Size = Vector3.new(1,1,1)
                                            v.Humanoid.JumpPower = 0
                                            v.HumanoidRootPart.CanCollide = false
                                            v.Humanoid:ChangeState(11)
                                            Attack = true
                                        until not AutoFarmBone or v.Humanoid.Health <= 0 or not v.Parent or v.Humanoid.Health <= 0
                                        Attack = false
                                    end
                                end
                            end
                        else
                            Attack = false
                            Teleport(CFrame.new(-9504.8564453125, 172.14292907714844, 6057.259765625))
                        end
                    end
                end)
            end
        end);
    end);

    Bone:AddToggle("Indx", {
        Text = 'Auto Trade Death King',
        Default = getgenv().Config.AutorandomBone,
    }):OnChanged(function(t)
        AutorandomBone = t
        getgenv().Config.AutorandomBone = t
        save()
        task.spawn(function()
            while task.wait() do
                if AutorandomBone then
                    if plr.Character.Humanoid.Health >= 1 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones","Buy",1,1);
                    end;
                end;
            end;
        end);
    end);
end;

local Tabbox3 = AutomaticsTab:AddRightTabbox();
local Rip = Tabbox3:AddTab([[Rip Indra]])
do
    Rip:AddToggle("Indx", {
        Text = 'Auto Darkdagger',
        Default = getgenv().Config.AutoDarkdagger,
    }):OnChanged(function(a)
        getgenv().Config.AutoDarkdagger = a;
        save();
        darkdagger = a;
        getgenv().Config.Clip = a
        task.spawn(function()
            while task.wait() do
                pcall(function()
                    if darkdagger then
                        if game:GetService('ReplicatedStorage'):FindFirstChild('rip_indra True Form [Lv. 5000] [Raid Boss]') or game:GetService('Workspace').Enemies:FindFirstChild('rip_indra True Form [Lv. 5000] [Raid Boss]') then
                            for i,v in pairs(game:GetService('Workspace').Enemies:GetChilren()) do
                                if v.Name == 'rip_indra True Form [Lv. 5000] [Raid Boss]' and v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') or v.Humanoid.Heath >= 1 then
                                    repeat task.wait()
                                        EquipTool(WeaponName)
                                        Teleport(v.HumanoidRootPart.CFrame*CFrame.new(0,30,0))
                                        v.HumanoidRootPart.Size = Vector3.new(1,1,1)
                                    until not darkdagger or not v.Parent or not v:FindForstChild('HumanoidRootPart') or not v:FindFirstChild('Humanoid') or v.Humanoid.Healt <= 0
                                end
                            end
                        else
                            Teleport(game:GetService('ReplicatedStorage'):FindFirstChild('rip_indra True Form [Lv. 5000] [Raid Boss]').HumanoidRootPart.CFrame*CFrame.new(0,30,0))
                        end
                    end
                end)
            end
        end)
    end);

    Rip:AddToggle("Indx", {
        Text = 'Auto Activate Haki Pad',
        Default = false,
    }):OnChanged(function(a)
        ActivateHaki = a;
        save();
        pad = a;
        getgenv().Config.Clip = a
        task.spawn(function()
            while task.wait() do
                pcall(function()
                    if ActivateHaki then
                        if not Pink and not White and not Red then
                            local plr = game.Players.LocalPlayer.Character.HumanoidRootPart
                            for i,v in pairs(game:GetService("Workspace").Map["Boat Castle"].Summoner.Circle:GetChildren()) do
                                if v.Name == 'Part' then
                                    if tostring(v.BrickColor) == ('Really red') then
                                        if v.Part.ClassName == "Part" then
                                            if tostring(v.Part.BrickColor) == 'Dark stone grey' then
                                                if not au then
                                                    local args = {
                                                        [1] = "activateColor",
                                                        [2] = "Pure Red"
                                                    }
                                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                                    au = true
                                                end
                                                task.wait()
                                                plr.CFrame = v.CFrame*CFrame.new(0,3,0)
                                                firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,v.CFrame,0)
                                                Red = true
                                            else
                                                Red = true
                                            end
                                        end
                                    end
                                    task.wait(3)
                                    if tostring(v.BrickColor) == ('Oyster') then
                                        if v.Part.ClassName == "Part" then
                                            if tostring(v.Part.BrickColor) == 'Dark stone grey' then
                                                if not df then
                                                    local args = {
                                                        [1] = "activateColor",
                                                        [2] = "Snow White"
                                                    }
                                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                                    df = true
                                                end
                                                plr.CFrame = v.CFrame*CFrame.new(0,3,0)
                                                firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,v.CFrame,0)
                                                White = true
                                            else
                                                White = true
                                            end
                                        end
                                    end
                                    task.wait(3)
                                    if tostring(v.BrickColor) == ('Hot pink') then
                                        if v.Part.ClassName == "Part" then
                                            if tostring(v.Part.BrickColor) == 'Dark stone grey' then
                                                if not nk then
                                                    local args = {
                                                        [1] = "activateColor",
                                                        [2] = "Winter Sky"
                                                    }
                                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                                    nk = true
                                                end
                                                task.wait()
                                                plr.CFrame = v.CFrame*CFrame.new(0,3,0)
                                                firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,v.CFrame,0)
                                                Pink = true
                                            else
                                                Pink=true
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            print("Workkkkk")
                            plr.CFrame = game:GetService("Workspace").Map["Boat Castle"].Summoner.Circle.Detection.CFrame
                        end
                    end
                end)
            end
        end)
    end);
end;

local Group1 = AutomaticsTab:AddRightGroupbox([[Cake Prince]]);
do
    local MobKilled = Group1:AddLabel('[ N/A ]');

    Group1:AddToggle("Indx", {
        Text = 'Auto Cake Prince',
        Default = getgenv().Config.AutoCakePrince,
    }):OnChanged(function(t)
        CakePrince = t;
        getgenv().Config.AutoCakePrince = t;
        getgenv().Config.Clip = t;
        save();
    end);

    Group1:AddToggle("DoughtKingZ", {
        Text = 'Auto Dought King',
        Default = getgenv().Config.AutoDoughtKing,
    }):OnChanged(function(t)
        getgenv().Config.Clip = t;
        DoughtKing = t;
        getgenv().Config.AutoDoughtKing = t;
        save();
    end);

    local DoughtFunc = Group1:AddDependencyBox()
    do
        DoughtFunc:AddToggle("UnlockDought", {
            Text = 'Unlock Dought Raid',
            Default = getgenv().Config.UnlockDought,
        }):OnChanged(function(t)
            getgenv().Config.UnlockDough = t;
            save();
        end);
    end;

    DoughtFunc:SetupDependencies({
        {Toggles.DoughtKingZ, true}
    });

    spawn(function()
        while task.wait() do
            if getgenv().Config.AutoDoughtKing then
                if getgenv().Config.UnlockDought then
                    if not game:GetService("Workspace").Map.CakeLoaf:FindFirstChild("RedDoor") then
                        if game.Players.LocalPlayer.Character:FindFirstChild("Red Key") or game.Players.LocalPlayer.Backpack:FindFirstChild("Red Key") then
                            local args = {
                                [1] = "CakeScientist",
                                [2] = "Check"
                            }

                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))    
                            local args = {
                                [1] = "RaidsNpc",
                                [2] = "Check"
                            }

                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))                        
                        end
                    elseif game:GetService("Workspace").Map.CakeLoaf:FindFirstChild("RedDoor") then
                        if game.Players.LocalPlayer.Character:FindFirstChild("Red Key") or game.Players.LocalPlayer.Backpack:FindFirstChild("Red Key") then
                            RedDorTween = Teleport(CFrame.new(-2681.97998, 64.3921585, -12853.7363, 0.149007782, -1.87902192e-08, 0.98883605, 3.60619588e-08, 1, 1.35681812e-08, -0.98883605, 3.36376011e-08, 0.149007782))
                            if (CFrame.new(-2681.97998, 64.3921585, -12853.7363, 0.149007782, -1.87902192e-08, 0.98883605, 3.60619588e-08, 1, 1.35681812e-08, -0.98883605, 3.36376011e-08, 0.149007782).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 5 then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2681.97998, 64.3921585, -12853.7363, 0.149007782, -1.87902192e-08, 0.98883605, 3.60619588e-08, 1, 1.35681812e-08, -0.98883605, 3.36376011e-08, 0.149007782)
                                wait(0.5)
                                EquipTool("Red Key")
                                wait(0.5)
                            end
                        elseif game.Workspace:FindFirstChild("Enemies"):FindFirstChild("Dough King [Lv. 2300] [Raid Boss]") then
                            if game:GetService("Workspace").Enemies:FindFirstChild("Dough King [Lv. 2300] [Raid Boss]") then
                                for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                    if getgenv().Config.AutoDoughtKing and v.Name == "Dough King [Lv. 2300] [Raid Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                        repeat task.wait()
                                            BusoAndKen()
                                            EquipTool(WeaponName)
                                            Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                            Attack = true
                                        until not getgenv().Config.AutoDoughtKing or not v.Parent or v.Humanoid.Health <= 0 or game:GetService("ReplicatedStorage"):FindFirstChild("Dough King [Lv. 2300] [Raid Boss]")
                                        Attack = true
                                    end
                                end
                            else
                                if game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == 0 then
                                    if game:GetService("ReplicatedStorage"):FindFirstChild("Dough King [Lv. 2300] [Raid Boss]") then
                                        Teleport(game:GetService("ReplicatedStorage"):FindFirstChild("Dough King [Lv. 2300] [Raid Boss]").HumanoidRootPart.CFrame)
                                    end
                                end 
                            end
                        elseif game.Players.LocalPlayer.Character:FindFirstChild("Sweet Chalice") or game.Players.LocalPlayer.Backpack:FindFirstChild("Sweet Chalice") then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
                            if game:GetService("Workspace").Enemies:FindFirstChild("Cookie Crafter [Lv. 2200]") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Guard [Lv. 2225]") or game:GetService("Workspace").Enemies:FindFirstChild("Baking Staff [Lv. 2250]") or game:GetService("Workspace").Enemies:FindFirstChild("Head Baker [Lv. 2275]") then
                                for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                    if (v.Name == "Cookie Crafter [Lv. 2200]" or v.Name == "Cake Guard [Lv. 2225]" or v.Name == "Baking Staff [Lv. 2250]" or v.Name == "Head Baker [Lv. 2275]") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                        repeat task.wait()
                                            getgenv().MobPos = v.HumanoidRootPart.CFrame
                                            Magnet = true
                                            BusoAndKen()
                                            EquipTool(WeaponName)
                                            Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,30,30))
                                            Attack = true
                                        until not getgenv().Config.AutoDoughtKing or not v.Parent or v.Humanoid.Health <= 0
                                        Attack = false
                                    end
                                end
                            else
                                Attack = false
                                Magnet = false
                                Teleport(CFrame.new(-2077, 252, -12373))
                            end
                        elseif FindBackPack("God's Chalice") then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SweetChaliceNpc")
                            wait(0.2)
                        elseif not FindBackPack("God's Chalice") and (game.Workspace.Enemies:FindFirstChild("Deandre [Lv. 1750]") or game.Workspace.Enemies:FindFirstChild("Urban [Lv. 1750]") or game.Workspace.Enemies:FindFirstChild("Diablo [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Deandre [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Urban [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Diablo [Lv. 1750]")) then
                            if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                                if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") then
                                    for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
                                        if string.find(v.Name,"Diablo") then
                                            Teleport(v.HumanoidRootPart.CFrame)
                                        end	
                                        if string.find(v.Name,"Urban") then
                                            Teleport(v.HumanoidRootPart.CFrame)
                                        end
                                        if string.find(v.Name,"Deandre") then
                                            Teleport(v.HumanoidRootPart.CFrame)
                                        end
                                    end
                                    for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                        if string.find(v.Name,"Diablo") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                            repeat task.wait()
                                                BusoAndKen()
                                                Attack = true
                                                EquipTool(WeaponName)
                                                Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                                            until not getgenv().Config.AutoDoughtKing or not v.Parent or v.Humanoid.Health <= 0
                                            Attack = false
                                        end
                                        if string.find(v.Name,"Urban") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                            repeat task.wait()
                                                BusoAndKen()
                                                EquipTool(WeaponName)
                                                Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                                                Attack = true
                                            until not getgenv().Config.AutoDoughtKing or not v.Parent or v.Humanoid.Health <= 0
                                            Attack = false
                                        end
                                        if string.find(v.Name,"Deandre") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                            repeat task.wait()
                                                EquipTool(WeaponName)
                                                BusoAndKen()
                                                Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
                                                Attack = true
                                            until not getgenv().Config.AutoDoughtKing or not v.Parent or v.Humanoid.Health <= 0
                                            Attack = false
                                        end
                                    end
                                else
                                    local string_1 = "EliteHunter";
                                    local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
                                    Target:InvokeServer(string_1);
                                end
                            else
                                local string_1 = "EliteHunter";
                                local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
                                Target:InvokeServer(string_1);
                            end
                        else
                            if game:GetService("Workspace").Enemies:FindFirstChild("Candy Rebel [Lv. 2375]") or game:GetService("Workspace").Enemies:FindFirstChild("Sweet Thief [Lv. 2350]") or game:GetService("Workspace").Enemies:FindFirstChild("Chocolate Bar Battler [Lv. 2325]") or game:GetService("Workspace").Enemies:FindFirstChild("Cocoa Warrior [Lv. 2300]") then
                                for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                    if (v.Name == "Candy Rebel [Lv. 2375]" or v.Name == "Sweet Thief [Lv. 2350]" or v.Name == "Chocolate Bar Battler [Lv. 2325]" or v.Name == "Cocoa Warrior [Lv. 2300]") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                        repeat task.wait()
                                            getgenv().PosMon = v.HumanoidRootPart.CFrame
                                            Magnet = true
                                            Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                            Attack = true
                                            BusoAndKen()
                                            EquipTool(WeaponName)
                                        until not getgenv().Config.AutoDoughtKing or not v.Parent or v.Humanoid.Health <= 0
                                    end
                                end
                            else
                                Attack = false
                                Magnet = false
                                Teleport(CFrame.new(620.6344604492188, 200.93644714355469, -12581.369140625))
                            end
                        end
                    end
                else
                    if game.Workspace:FindFirstChild("Enemies"):FindFirstChild("Dough King [Lv. 2300] [Raid Boss]") or game:GetService("ReplicatedStorage"):FindFirstChild("Dough King [Lv. 2300] [Raid Boss]") then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Dough King [Lv. 2300] [Raid Boss]") then
                            for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                if getgenv().Config.AutoDoughtKing and v.Name == "Dough King [Lv. 2300] [Raid Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        BusoAndKen()
                                        EquipTool(WeaponName)
                                        Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,30,30))
                                        Attack = true
                                    until not getgenv().Config.AutoDoughtKing or not v.Parent or v.Humanoid.Health <= 0 or game:GetService("ReplicatedStorage"):FindFirstChild("Dough King [Lv. 2300] [Raid Boss]")
                                    Attack = false
                                end
                            end
                        else
                            if game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == 0 then
                                if (game:GetService("Workspace").Enemies:FindFirstChild("Dough King [Lv. 2300] [Raid Boss]").HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude > 2500 then
                                    Teleport(CFrame.new(-2151.82153, 149.315704, -12404.9053))
                                end
                            end 
                        end
                    elseif game.Players.LocalPlayer.Character:FindFirstChild("Sweet Chalice") or game.Players.LocalPlayer.Backpack:FindFirstChild("Sweet Chalice") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
                        if game:GetService("Workspace").Enemies:FindFirstChild("Cookie Crafter [Lv. 2200]") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Guard [Lv. 2225]") or game:GetService("Workspace").Enemies:FindFirstChild("Baking Staff [Lv. 2250]") or game:GetService("Workspace").Enemies:FindFirstChild("Head Baker [Lv. 2275]") then
                            for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                if (v.Name == "Cookie Crafter [Lv. 2200]" or v.Name == "Cake Guard [Lv. 2225]" or v.Name == "Baking Staff [Lv. 2250]" or v.Name == "Head Baker [Lv. 2275]") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        MobCFrame = v.HumanoidRootPart.CFrame
                                        Attack = true
                                        BusoAndKen()
                                        EquipTool(WeaponName)
                                        Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,30,30))
                                    until not getgenv().Config.AutoDoughtKing or not v.Parent or v.Humanoid.Health <= 0
                                end
                            end
                        else
                            Attack = false
                            Teleport(CFrame.new(-2077, 252, -12373))
                        end
                    elseif FindBackPack("God's Chalice") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SweetChaliceNpc")
                        wait(0.2)
                    elseif not FindBackPack("God's Chalice") and (game.Workspace.Enemies:FindFirstChild("Deandre [Lv. 1750]") or game.Workspace.Enemies:FindFirstChild("Urban [Lv. 1750]") or game.Workspace.Enemies:FindFirstChild("Diablo [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Deandre [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Urban [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Diablo [Lv. 1750]")) then
                        if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                            if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") then
                                for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
                                    if string.find(v.Name,"Diablo") then
                                        Teleport(v.HumanoidRootPart.CFrame)
                                    end	
                                    if string.find(v.Name,"Urban") then
                                        Teleport(v.HumanoidRootPart.CFrame)
                                    end
                                    if string.find(v.Name,"Deandre") then
                                        Teleport(v.HumanoidRootPart.CFrame)
                                    end
                                end
                                for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                    if string.find(v.Name,"Diablo") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                        repeat task.wait()
                                            BusoAndKen()
                                            EquipTool(WeaponName)
                                            Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                                            Attack = true
                                        until not getgenv().Config.AutoDoughtKing or not v.Parent or v.Humanoid.Health <= 0
                                        Attack = false
                                    end
                                    if string.find(v.Name,"Urban") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                        repeat task.wait()
                                            BusoAndKen()
                                            EquipTool(WeaponName)
                                            Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                                            Attack = true
                                        until not getgenv().Config.AutoDoughtKing or not v.Parent or v.Humanoid.Health <= 0
                                        Attack = false
                                    end
                                    if string.find(v.Name,"Deandre") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                        repeat task.wait()
                                            EquipTool(WeaponName)
                                            BusoAndKen()
                                            Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
                                            Attack = true
                                        until not getgenv().Config.AutoDoughtKing or not v.Parent or v.Humanoid.Health <= 0
                                        Attack = false
                                    end
                                end
                            else
                                local string_1 = "EliteHunter";
                                local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
                                Target:InvokeServer(string_1);
                            end
                        else
                            local string_1 = "EliteHunter";
                        end
                    else
                        if game:GetService("Workspace").Enemies:FindFirstChild("Candy Rebel [Lv. 2375]") or game:GetService("Workspace").Enemies:FindFirstChild("Sweet Thief [Lv. 2350]") or game:GetService("Workspace").Enemies:FindFirstChild("Chocolate Bar Battler [Lv. 2325]") or game:GetService("Workspace").Enemies:FindFirstChild("Cocoa Warrior [Lv. 2300]") then
                            for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                if (v.Name == "Candy Rebel [Lv. 2375]" or v.Name == "Sweet Thief [Lv. 2350]" or v.Name == "Chocolate Bar Battler [Lv. 2325]" or v.Name == "Cocoa Warrior [Lv. 2300]") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        getgenv().PosMon = v.HumanoidRootPart.CFrame
                                        Magnet = true
                                        Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                        Attack = true
                                        BusoAndKen()
                                        EquipTool(WeaponName)
                                    until not getgenv().Config.AutoDoughtKing or not v.Parent or v.Humanoid.Health <= 0
                                end
                            end
                        else
                            Attack = false
                            Magnet = false
                            Teleport(CFrame.new(620.6344604492188, 200.93644714355469, -12581.369140625))
                        end
                    end
                end
            end
        end
    end)

    spawn(function()
        while task.wait() do
            pcall(function()
                if getgenv().Config.AutoCakePrince == true then
                    if string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 88 then
                        MobKilled:SetText("[ ".. game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner",true):split(">")[2]:split("<")[1] .. " ] Kills Remains");
                    elseif string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 87 then
                        MobKilled:SetText("[ ".. game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner",true):split(">")[2]:split("<")[1] .. " ] Kills Remains");
                    elseif string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 86 then
                        MobKilled:SetText("[ ".. game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner",true):split(">")[2]:split("<")[1] .. " ] Kills Remains");
                    else
                        MobKilled:SetText("[ Portal Is Opened! ]");
                    end;
                end;
            end);
        end;
    end);

    spawn(function()
        while task.wait() do
            if (getgenv().Config.AutoCakePrince or getgenv().Config.AutoDoughtKing) == true and tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner",true):split(">")[2]:split("<")[1])<2 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner",true)
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
            end
        end
    end)

    spawn(function()
        while task.wait() do
            if getgenv().Config.AutoCakePrince then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Dought King [Lv. 2300] [Raid Boss]") then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v.Name == "Cake Prince [Lv. 2300] [Raid Boss]" or v.Name == "Dought King [Lv.2300] [Raid Boss]" then
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        BusoAndKen()
                                        EquipTool(WeaponName)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Humanoid.WalkSpeed = 0
                                        v.HumanoidRootPart.Size = Vector3.new(200,200,200)
                                        Teleport(v.HumanoidRootPart.CFrame * CFrame.new(10,15,-7))
                                        sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge)
                                    until not getgenv().Config.AutoCakePrince or not v.Parent or v.Humanoid.Health <= 0
                                end
                            end
                        end
                    else
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Dought King [Lv. 2300] [Raid Boss]") then
                            Teleport(game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]").HumanoidRootPart.CFrame * CFrame.new(5,-30,10))
                        else
                            if tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner",true):split(">")[2]:split("<")[1]) == 0 then
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner",true)
                            end                    
                            if game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == 1 then
                                if game:GetService("Workspace").Enemies:FindFirstChild("Cookie Crafter [Lv. 2200]") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Guard [Lv. 2225]") or game:GetService("Workspace").Enemies:FindFirstChild("Baking Staff [Lv. 2250]") or game:GetService("Workspace").Enemies:FindFirstChild("Head Baker [Lv. 2275]") then
                                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                        if v.Name == "Cookie Crafter [Lv. 2200]" or v.Name == "Cake Guard [Lv. 2225]" or v.Name == "Baking Staff [Lv. 2250]" or v.Name == "Head Baker [Lv. 2275]" then
                                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                                repeat task.wait()
                                                    BusoAndKen()
                                                    EquipTool(WeaponName)
                                                    v.HumanoidRootPart.CanCollide = false
                                                    v.Humanoid.WalkSpeed = 16
                                                    v.Head.CanCollide = false 
                                                    v.HumanoidRootPart.Size = Vector3.new(1,1,1)
                                                    getgenv().PosMon = v.HumanoidRootPart.CFrame
                                                    Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                                                    Attack = true
                                                until not getgenv().Config.AutoCakePrince or not v.Parent or v.Humanoid.Health <= 0 or game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == 0 or game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") or KillMob == 0
                                                Attack = false
                                            end
                                        end
                                    end
                                else
                                    Attack = false
                                    Teleport(CFrame.new(-2166, 70, -12125))
                                end
                            else
                                if game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") or  game:GetService("Workspace").Enemies:FindFirstChild("Dought King [Lv. 2300] [Raid Boss]") then
                                    Teleport(game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]").HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                else
                                    if game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") or game:GetService("ReplicatedStorage"):FindFirstChild("Dought King [Lv. 2300] [Raid Boss]") then
                                        Teleport(game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]").HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end
    end);

    spawn(function()
        while task.wait(.15) do
            pcall(function()
                if AutoFarmBone or getgenv().Config.AutoCakePrince or getgenv().Config.AutoDoughtKing then
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if not string.find(v.Name,"Boss") and (v.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 600 then
                            if (v.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 200 then
                                v.HumanoidRootPart.CFrame = getgenv().PosMon;
                                v.HumanoidRootPart.Size = Vector3.new(1,1,1);
                                v.Humanoid.JumpPower = 0;
                                v.HumanoidRootPart.CanCollide = false;
                                v.Humanoid:ChangeState(11);
                            end;
                        end;
                    end;
                end;
            end);
        end;
    end);
end;

local Group2 = AutomaticsTab:AddRightGroupbox([[Elites]]);
do
    Group2:AddToggle("EliteHunter", {
        Text = 'Auto Elite Hunter',
        Default = getgenv().Config.AutoEliteHunter,
    }):OnChanged(function(t)
        getgenv().Config.AutoEliteHunter = t;
        getgenv().Config.Clip = t;
        save();
    end);

    local MoreElite = Group2:AddDependencyBox()

    do
        MoreElite:AddToggle("GodsChalice", {
            Text = "Stop at God's Chalice",
            Default = getgenv().Config.StopAtGodChalice,
        }):OnChanged(function(t)
            getgenv().Config.StopAtGodChalice = t;
            save();
        end);

        MoreElite:AddToggle("SavesGodsChalice", {
            Text = "Save a God's Chalice",
            Default = getgenv().Config.SaveGodChalice,
        }):OnChanged(function(t)
            getgenv().Config.SaveGodChalice = t;
            save();
        end);
    end;

    MoreElite:SetupDependencies({
        {Toggles.EliteHunter, true};
    });

    spawn(function()
        while task.wait() do
            pcall(function()
                if getgenv().Config.EliteHunter then
                    if getgenv().Config.SaveGodChalice then
                        if FindBackPack("God's Chalice") then
                            -- Warp to castle
                            --break
                        end
                    end
                    if getgenv.Config.StopAtGodChalice then
                        if FindBackPack("God's Chalice") then
                            --break
                        end
                    end
                    if game:GetService("Workspace").Enemies:FindFirstChild("Urban [Lv. 1750]") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre [Lv. 1750]") or game:GetService("Workspace").Enemies:FindFirstChild("Diablo [Lv. 1750]") then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if (v.Name:find("Diablo") or v.Name:find("Deandre") or v.Name:find("Urban")) and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") or v.Humanoid.Health >= 1 then
                                repeat task.wait()
                                    Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                                    Attack = true
                                until not getgenv().Config.AutoEliteHunter or v.Humanoid.Health <= 0 or not v.Parent or not v:FindFirstChild("HumanoidRootPart")
                            end
                        end
                    else
                        for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
                            if string.find(v.Name,"Diablo") then
                                Teleport(v.HumanoidRootPart.CFrame)
                            end	
                            if string.find(v.Name,"Urban") then
                                Teleport(v.HumanoidRootPart.CFrame)
                            end
                            if string.find(v.Name,"Deandre") then
                                Teleport(v.HumanoidRootPart.CFrame)
                            end
                        end
                    end
                end
            end)
        end
    end)
end;

local Tabbox5 = AutomaticsTab:AddLeftTabbox();
local Race = Tabbox5:AddTab([[Race V4]])
do
    local MoonState = Race:AddLabel('Moon State [0/5] : 🌑')
    local Mirage = Race:AddLabel('')
    local AwkEnergy = Race:AddLabel('Aweakening Energy : [ null ]')

    task.spawn(function()
        while task.wait() do
            pcall(function()
                if game:GetService("Lighting").Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149431" then
                    MoonState:SetText("Moon State [5/5] "..'🌕')
                elseif game:GetService("Lighting").Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149052" then
                    MoonState:SetText("Moon State [4/5] ".."🌙")
                elseif game:GetService("Lighting").Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709143733" then
                    MoonState:SetText("Moon State [3/5] "..'🌓')
                elseif game:GetService("Lighting").Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709150401" then
                    MoonState:SetText("Moon State [2/5] "..'🌗')
                elseif game:GetService("Lighting").Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149680" then
                    MoonState:SetText("Moon State [1/5] : "..'🌘')
                else
                    MoonState:SetText("Moon State [0/5] :  "..'🌑')
                end
            end)
        end
    end)

    task.spawn(function()
        while task.wait() do
            pcall(function()
                AwkEnergy:SetText("Aweakening Energy : [ ".. game.Players.LocalPlayer.Character:FindFirstChild("RaceEnergy").Value .." ]")
            end)
        end
    end)

    Race:AddButton('Teleport to temple of time',function()
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)
    end)

    Race:AddButton('Teleport to lever',function()
        plr.Character.HumanoidRootPart.CFrame = CFrame.new(28576.873046875, 14937.958984375, 76.49504852294922)
    end)

    Race:AddButton('Teleport to Trial door',function()
        if tostring(game.Players.LocalPlayer.Data.Race.Value) == "Mink" then
            Teleport(game:GetService("Workspace").Map["Temple of Time"].MinkCorridor.Door.Entrance.CFrame)
        elseif tostring(game.Players.LocalPlayer.Data.Race.Value) == "Fishman" then
            Teleport(game:GetService("Workspace").Map["Temple of Time"].FishmanCorridor.Door.Entrance.CFrame)
        elseif tostring(game.Players.LocalPlayer.Data.Race.Value) == "Skypiea" then
            Teleport(game:GetService("Workspace").Map["Temple of Time"].SkyCorridor.Door.Entrance.CFrame)
        elseif tostring(game.Players.LocalPlayer.Data.Race.Value) == "Human" then
            Teleport(game:GetService("Workspace").Map["Temple of Time"].HumanCorridor.Door.Entrance.CFrame)
        elseif tostring(game.Players.LocalPlayer.Data.Race.Value) == "Ghoul" then
            Teleport(game:GetService("Workspace").Map["Temple of Time"].GhoulCorridor.Door.Entrance.CFrame)
        elseif tostring(game.Players.LocalPlayer.Data.Race.Value) == "Cyborg" then
            Teleport(game:GetService("Workspace").Map["Temple of Time"].CyborgCorridor.Door.Entrance.Position)
        end
    end)

    Race:AddToggle("Indx", {
        Text = 'Auto Pull Lever',
        Default = getgenv().Config.AutoPullLever
    }):OnChanged(function(a)
        getgenv().Config.AutoPullLever = a
        save()
        task.spawn(function()
            while task.wait() do
                if getgenv().Config.AutoPullLever then
                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CheckTempleDoor") == true then
                        fireproximityprompt(game:GetService("Workspace").Map["Temple of Time"].Lever.Prompt.ProximityPrompt, math.huge, 1,true)
                    end
                end
            end
        end)
    end)

    Race:AddToggle("Indx", {
        Text = 'Auto Ancient One Quest',
        Default = getgenv().Config.AutoFarmV4Gate
    }):OnChanged(function(a)
        AutoFarmV4Gate = a
        getgenv().Config.AutoFarmV4Gate = a
        getgenv().Config.Clip = a
        save()
        task.spawn(function()
            while task.wait() do
                pcall(function()
                    if AutoFarmV4Gate then
                        if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("UpgradeRace", "Buy") ~= true then
                            if game.Players.LocalPlayer.Character:FindFirstChild("RaceEnergy").Value < 1 and game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed").Value == false then
                                if game:GetService('Workspace').Enemies:FindFirstChild('Reborn Skeleton [Lv. 1975]') or game:GetService('Workspace').Enemies:FindFirstChild('Living Zombie [Lv. 2000]') or game:GetService('Workspace').Enemies:FindFirstChild('Demonic Soul [Lv. 2025]') or game:GetService('Workspace').Enemies:FindFirstChild('Posessed Mummy [Lv. 2050]') then
                                    for _,v in pairs(game:GetService('Workspace').Enemies:GetChildren()) do
                                        if v.Name == 'Reborn Skeleton [Lv. 1975]' or v.Name == 'Living Zombie [Lv. 2000]' or v.Name == 'Demonic Soul [Lv. 2025]' or v.Name == 'Posessed Mummy [Lv. 2050]' then
                                            repeat task.wait()
                                                getgenv().PosMon = v.HumanoidRootPart.CFrame
                                                Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,30,3))
                                                BusoAndKen()
                                                EquipTool(WeaponName)
                                            until not AutoFarmV4Gate or not v.Parent or v.Humanoid.Health <= 0 or not v:FindFirstChild('Humanoid') or not v:FindFirstChild('HumanoidRootPart')
                                        end
                                    end
                                else
                                    Teleport(CFrame.new(-9479.2168, 200.215088, 5577.09277, 0, 0, 1, 0, 1, -0, -1, 0, 0))
                                end
                            else
                                SendKey("Y",0)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("UpgradeRace", "Check")
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("UpgradeRace", "Buy")
                            end
                        else
                        end
                    end
                end)
            end
        end)
    end);

    Race:AddToggle("Indx", {
        Text = 'Auto Complete Trial',
        Default = getgenv().AutoCompleteTrial
    }):OnChanged(function(a)
        getgenv().Config.AutoCompleteTrial = a
        CompleteTrial = a
        save()
        task.spawn(function()
            while CompleteTrial do task.wait()
                pcall(function()
                    if tostring(game.Players.LocalPlayer.Data.Race.Value) == "Mink" then
                        if not game:GetService("Workspace").Map:FindFirstChild("MinkTrial") then
                        else
                            if game:GetService("Workspace").Map:FindFirstChild("MinkTrial") then
                                if (game:GetService("Workspace").Map.MinkTrial.Ceiling.CFrame-plr.Character.HumanoidRootPart.Position).Magnitude <= 200 then
                                local Celling = Teleport(game:GetService("Workspace").Map.MinkTrial.Ceiling.CFrame*CFrame.new(0,-20,0))
                                Celling:Stop()
                                Teleport(plr.Character.HumanoidRootPart.CFrame)
                                else Teleport(game:GetService("Workspace").Map["Temple of Time"].MinkCorridor.Door.Entrance.CFrame) end
                            end
                        end
                    elseif tostring(game.Players.LocalPlayer.Data.Race.Value) == "Human" then
                        if not game:GetService("Workspace").Map:FindFirstChild("HumanTrial")  then
                        else
                            pcall(function()
                                for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 400 then
                                        repeat task.wait()
                                            EquipTool(Meele)
                                            BusoAndKen()
                                            local HumanBoss = Teleport(v.HumanoidRootPart.CFrame*CFrame.new(7,25,10))
                                            v.HumanoidRootPart.Size = Vector3.new(1,1,1)
                                            v.Humanoid:ChangeState(14)
                                            v.Humanoid:ChangeState(11)
                                            v.Humanoid.JumpPower = 0
                                        until not CompleteTrial or v.Humanoid.Health <= 0 or not v.Parent
                                        if HumanBoss then
                                            HumanBoss:Cancel()
                                        end
                                    end
                                end
                            end) 
                        end
                    elseif tostring(game.Players.LocalPlayer.Data.Race.Value) == "Cyborg" then
                        if not game:GetService("Workspace").Map:FindFirstChild("CybrogTrial") then
                            Teleport(game:GetService("Workspace").Map["Temple of Time"].CyborgCorridor.Door.Entrance.CFrame)
                        else
                            if game:GetService("Workspace").Map:FindFirstChild("CybrogTrial") then
                                local Ahh = Teleport(game:GetService("Workspace").Map.CyborgTrial.Floor.CFrame*CFrame.new(0,500,0))
                                Ahh:Cancel()
                            else Teleport(game:GetService("Workspace").Map["Temple of Time"].CyborgCorridor.Door.Entrance.CFrame)
                            end
                        end
                    elseif tostring(game.Players.LocalPlayer.Data.Race.Value) == "Skypiea" then
                        if not game:GetService("Workspace").Map:FindFirstChild("SkyTrial") then
                        else
                            if game:GetService("Workspace").Map:FindFirstChild("SkyTrial") then
                                if (game:GetService("Workspace").Map.SkyTrial.Model.FinishPart.CFrame-plr.Character.HumanoidRootPart.Position).Magnitude <= 750 then
                                    local FinishP =Teleport(game:GetService("Workspace").Map.SkyTrial.Model.FinishPart.CFrame)
                                    FinishP:Cancel()
                                else Teleport(game:GetService("Workspace").Map["Temple of Time"].SkypieaCorridor.Door.Entrance.CFrame)
                                end
                            end
                        end
                    elseif tostring(game.Players.LocalPlayer.Data.Race.Value) == "Ghoul" then
                        if not game:GetService("Workspace").Map:FindFirstChild("GhoulTrial") then
                        else
                            pcall(function()
                                for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 400 then
                                        repeat task.wait()
                                            EquipTool(Melee)
                                            BusoAndKen()
                                            getgenv().MobPos = v.HumanoidRootPart.CFrame
                                            Magnet = true
                                            v.Humanoid.Health = -math.huge
                                            local GhoulMob = Teleport(v.HumanoidRootPart.CFrame*CFrame.new(7,25,10))
                                            v.HumanoidRootPart.Size = Vector3.new(1,1,1)
                                            v.Humanoid:ChangeState(14)
                                            v.Humanoid:ChangeState(11)
                                            v.Humanoid.JumpPower = 0
                                        until not CompleteTrial or v.Humanoid.Health <= 0 or not v.Parent
                                        Magnet = false
                                        if GhoulMob then
                                            GhoulMob:Cancel()
                                        end
                                    end
                                end
                            end)
                        end
                    elseif tostring(game.Players.LocalPlayer.Data.Race.Value) == "Fishman" then
                        if not game:GetService("Workspace").Map:FindFirstChild("FishTrial") then
                            Teleport(game:GetService("Workspace").Map["Temple of Time"].FishmanCorridor.Door.Entrance.CFrame)
                        else
                            if game:GetService("Workspace").Map:FindFirstChild("FishTrial") then
                                if (game:GetService("Workspace").Map:FindFirstChild("FishTrial").Part.Position-plr.Character.HumanoidRootPart.Position).Magnitude <= 500 then
                                    local SeaBeast = Teleport(CFrame.new(25032.043, 75.04647064, 12619.5967))
                                    SeaBeast:Cancel()
                
                                    -- Spam Skill EEEEEEEEEEEE3EEE
                                    task.spawn(function()
                                        EquipTool(DevilFruit)
                                        SendKey('Z',0)
                                        task.wait(2)
                                        SendKey('X',0)
                                        task.wait(2)
                                        SendKey('C',0)
                                        task.wait(2)
                                        SendKey('V',0)
                                        task.wait(3)
                                        task.spawn(function()
                                            EquipTool(Melee);
                                            SendKey('Z',0)
                                            task.wait(2)
                                            SendKey('X',0)
                                            task.wait(2)
                                            SendKey('C',0)
                                        end)
                                    end)
                                end
                            else if not game:GetService("Workspace").Map:FindFirstChild("FishTrial") then
                                    Teleport(game:GetService("Workspace").Map["Temple of Time"].FishmanCorridor.Door.Entrance.CFrame)
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end);

    task.spawn(function()
        while task.wait() do
            if ThirdSea then
                if game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Mirage Island") then
                    Mirage:SetText('Ready To Spawn');
                elseif game:GetService("Workspace")["Map"]:FindFirstChild("Mystic Island") then
                    Mirage:SetText('Spawned');
                else
                    Mirage:SetText('Not Spawned');
                end;
            else
                Mirage:SetText('Go to Thirdsea first!')
            end;
        end;
    end);
    
    task.spawn(function()
        while true do task.wait()
            if game:GetService("Workspace").Map:FindFirstChild('MysticIsland') then
                for i,v in pairs(game:GetService("Workspace").Map:FindFirstChild('MysticIsland'):GetChildren()) do
                    if v.Name == 'Part' or v.Name == 'Gear' then
                        if v.ClassName == 'MeshPart' then
                            v.Name = 'Gear'
                            if TeleportGear then
                                Teleport(v.CFrame)
                            end
                            if ShowGear then
                                v.Transparency = 0
                            end
                            if GetQuestv4 then
                                local args = {
                                    [1] = "RaceV4Progress",
                                    [2] = "Check"
                                }
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                            end
                        end
                    end
                end
            end
        end
    end);
end;

local Race2 = Tabbox5:AddTab([[Races]])
do
    local Status = Race2:AddLabel("");

    Race2:AddToggle("Indx", {
        Text = "Auto Evo Race 1",
        Default = getgenv().Config.AutoEvoleRace,
        Tooltip = 'Get Ghoul Race Automaticly'
    }):OnChanged(function(a)
        getgenv().Config.AutoEvoleRace = a;
        save();
    end);

    Race2:AddToggle("Indx", {
        Text = "Auto Ghoul Race",
        Default = getgenv().Config.AutoGhoulRace,
        Tooltip = 'Get Ghoul Race Automaticly'
    }):OnChanged(function(a)
        getgenv().Config.AutoGhoulRace = a;
        save();
        task.spawn(function()
            while task.wait(.02) do
                if getgenv().Config.AutoGhoulRace then
                    
                end;
            end;
        end);
    end);

    Race2:AddToggle("Indx", {
        Text = "Auto Cybrog Race",
        Default = getgenv().Config.AutoCybrogRace,
        Tooltip = 'Get Cybrog Race Automaticly'
    }):OnChanged(function(a)
        getgenv().Config.AutoCybrogRace = a;
        save();
        task.spawn(function()
            while task.wait(.02) do
                if getgenv().Config.AutoCybrogRace then
                    
                end;
            end;
        end);
    end);

    spawn(function()
        while wait() do
            pcall(function()
                if getgenv().Config.AutoEvoleRace then
                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","1") ~= -2 then
                        pcall(function()
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","1")
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","2")
                        end)
                        if not game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 1") and not game.Players.LocalPlayer.Character:FindFirstChild("Flower 1") and game:GetService("Workspace"):FindFirstChild("Flower1") then
                            Status:SetText('Status : [ Finding Blue Flower ]')
                            repeat task.wait(1)
                                firetouchinterest(game:GetService("Workspace"):FindFirstChild("Flower1"), 1)
                                firetouchinterest(game:GetService("Workspace"):FindFirstChild("Flower1"), 0)
                            until game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 1") or game.Players.LocalPlayer.Character:FindFirstChild("Flower 1") or not getgenv().Config.AutoEvoleRace
                        elseif not game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 2") and not game.Players.LocalPlayer.Character:FindFirstChild("Flower 2") and game:GetService("Workspace"):FindFirstChild("Flower2") then
                            Status:SetText('Status : [ Finding Red Flower ]')
                            repeat task.wait(1)
                                firetouchinterest(game:GetService("Workspace"):FindFirstChild("Flower2"), 0)
                                firetouchinterest(game:GetService("Workspace"):FindFirstChild("Flower2"), 1)
                            until game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 2") or game.Players.LocalPlayer.Character:FindFirstChild("Flower 2") or not getgenv().Config.AutoEvoleRace
                        elseif not game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 3") and not game.Players.LocalPlayer.Character:FindFirstChild("Flower 3") then
                            Status:SetText('Status : [ Finding Yellow Flower ]')
                            if game:GetService("Workspace").Enemies:FindFirstChild("Zombie [Lv. 950]") then
                                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if v.Name == "Zombie [Lv. 950]" and v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') then
                                        repeat task.wait()
                                            EquipTool(WeaponName)
                                            Teleport(v.HumanoidRootPart.CFrame*CFrame.new(0,30,0))
                                            Attack = true
                                        until v.Humanoid.Health <= 0 or not v.Parent or game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 3") or not getgenv().Config.AutoEvoleRace
                                        Attack = false
                                    end
                                end
                            else
                                Teleport(CFrame.new(-2335.2026367188, 79.786659240723, -3245.8674316406))
                            end
                        elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 3") and game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 1") and game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 2") then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","1")
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","3")
                            getgenv().Config[99] = true
                            save()
                        else
                            Teleport(CFrame.new(-379.70889282227, 73.0458984375, 304.84692382813))
                        end
                    end
                end
            end)
        end
    end)
end;

local Tabbox4 = AutomaticsTab:AddRightTabbox();

local HakiColor = Tabbox4:AddTab("Haki Colors")
do
    local SpawnHaki = HakiColor:AddLabel('Selling Haki Color : [ RainBow ]',true);
    if SecondSea then
        spawn(function()
            while task.wait(1) do
                pcall(function()
                    SpawnHaki:SetText("Selling Color : ".. tostring(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ColorsDealer", "1")))
                end)
            end
        end)
    end
    
    HakiColor:AddDropdown('SelectColorTobuy',{
        Text = 'Select Color to Snipe',
        Values = {
            "Snow White",
            "Pure Red",
            "Winter Sky"
        },
        Default = getgenv().Config.SelectHakiColors or 1,
        Tooltip = "Select Colors for snipe this",
        Multi = true
    }):OnChanged(function(a)
        getgenv().Config.SelectHakiColors = a
        save()
        task.spawn(function()
            while task.wait() do
                pcall(function()
                end)
            end
        end)
    end)
    
    HakiColor:AddToggle("Indx", {
        Text = "Auto Snipe Select",
        Default = getgenv().Config.AutoSnipe,
        Tooltip = 'Snipe Select Colors haki'
    }):OnChanged(function(a)
        getgenv().Config.AutoSnipe = a
        save()
        task.spawn(function()
            while task.wait(.02) do
                if getgenv().Config.AutoSnipe then
                    
                end;
            end;
        end);
    end);
end;

local Swords = Tabbox4:AddTab("Legendary Swords")
do
    local SpawnSword = Swords:AddLabel('Selling Legendary Swords : [ Nil ]');
    
    Swords:AddDropdown('SelectSwordsTobuy',{
        Text = 'Select Swords to Snipe',
        Values = {
            "Shisui",
            "Wando",
            "Saddi"
        },
        Default = getgenv().Config.SelectLegendarySwords or 1,
        Tooltip = "Select swords for snipe this weapon",
        Multi = true
    }):OnChanged(function(a)
        getgenv().Config.SelectLegendarySwords = a
        save()
        task.spawn(function()
            while task.wait() do
                pcall(function()
    
                end);
            end;
        end);
    end);
    
    Swords:AddToggle("Indx", {
        Text = "Auto Snipe Select",
        Default = getgenv().Config.SnipeLegenSword,
        Tooltip = 'Make your attack speed faster!'
    }):OnChanged(function(a)
        getgenv().Config.SnipeLegenSword = a
        save()
        task.spawn(function()
            while task.wait(.02) do
                if getgenv().Config.SnipeLegenSword then
                    
                end;
            end;
        end);
    end);
end;

-- Visual Tab --

local Maket = Visural:AddLeftTabbox("Markets");
do
    local M1 = Maket:AddTab("Melee");
    do
        M1:AddButton("Buy Black Leg",function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
        end)
        
        M1:AddButton("Buy Electro",function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
        end)
        
        M1:AddButton("Buy Fishman Karate",function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
        end)
        
        M1:AddButton("Buy Dragon Claw",function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","1")
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2")
        end)
        
        M1:AddButton("Buy Superhuman",function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
        end)
        
        M1:AddButton("Buy Death Step",function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
        end)
        
        M1:AddButton("Buy Sharkman Karate",function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate",true)
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
        end)
        
        M1:AddButton("Buy Electric Claw",function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
        end)
        
        M1:AddButton("Buy Dragon Talon",function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
        end)
    end;

    local M2 = Maket:AddTab("Sword");
    do
        M2:AddButton("Cutlass",function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Cutlass")
        end)
        
        M2:AddButton("Katana",function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Katana")
        end)
        
        M2:AddButton("Iron Mace",function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Iron Mace")
        end)
        
        M2:AddButton("Duel Katana",function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Duel Katana")
        end)
        
        M2:AddButton("Triple Katana", function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Triple Katana")
        end)
        
        M2:AddButton("Pipe",function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Pipe")
        end)
        
        M2:AddButton("Dual Headed Blade",function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Dual-Headed Blade")
        end)
        
        M2:AddButton("Bisento",function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Bisento")
        end)
        
        M2:AddButton("Soul Cane",function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Soul Cane")
        end)
    end;

    local M3 = Maket:AddTab("Gun");
    do
        M3:AddButton("Slingshot",function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Slingshot")
        end)
        
        M3:AddButton("Musket",function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Musket")
        end)
        
        M3:AddButton("Flintlock",function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Flintlock")
        end)
        
        M3:AddButton("Refined Flintlock",function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Refined Flintlock")
        end)
        
        M3:AddButton("Cannon",function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Cannon")
        end)
        
        M3:AddButton("Kabucha",function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Slingshot","1")
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Slingshot","2")
        end)
    end;
end;

local OtherMaket = Visural:AddLeftGroupbox("Other Stuff")
do
    OtherMaket:AddButton("Random Cousin",function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin","Buy")
    end)

    OtherMaket:AddButton("Stat Refund",function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones","Buy",1,2)
    end)
        
    OtherMaket:AddButton("Race Reroll",function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones","Buy",1,3)
    end)
end;

-- Combat Tab

local Tabbox5 = Combat:AddLeftTabbox();

local Player = Tabbox5:AddTab([[ Players ]])
do
    local CurrentPlayer = {}
    
    pcall(function()
        for i,v in pairs(game:GetService("Players"):GetChildren()) do
            if v.Name ~= game.Players.LocalPlayer.Name then
                if not table.find(CurrentPlayer, v.Name) then
                    table.insert(CurrentPlayer, v.Name);
                            
                end;
            end;
        end;
    end);
        
    Player:AddDropdown('Selectayers',{
        Text = 'Select Players',
        Values = CurrentPlayer,
        Default = getgenv().Config.SelectPlayers or 1,
        Tooltip = "Select players for do something..",
        Multi = false
    }):OnChanged(function(a)
        getgenv().Config.SelectPlayers = a
        getgenv().SelectPly = a
        save()
        task.spawn(function()
            while task.wait() do
                pcall(function()
    
                end);
            end;
        end);
    end);
    
    task.spawn(function()
        while task.wait() do
            pcall(function()
                for i,v in pairs(game:GetService("Players"):GetChildren()) do
                    if v.Name ~= game.Players.LocalPlayer.Name then
                        if not table.find(CurrentPlayer, v.Name) then
                            table.insert(CurrentPlayer, v.Name);
                            Options.Selectayers:SetValue(v.Name);
                        end;
                    end;
                end;
            end);
        end;
    end);
    
    Player:AddToggle("Indx", {
        Text = "Auto Kill",
        Default = getgenv().Config.AutoKillSelect,
        Tooltip = 'Kill For FREE Bounty :'
    }):OnChanged(function(a)
        getgenv().Config.AutoKillSelect = a
        save()
        task.spawn(function()
            while task.wait(.02) do
                if getgenv().Config.AutoKillSelect then
                    
                end;
            end;
        end);
    end);
    
    Player:AddToggle("Indx", {
        Text = "Preview",
        Default = getgenv().Config.Preview,
        Tooltip = 'Woah what is he/she doing??'
    }):OnChanged(function(a)
        getgenv().Config.Preview = a
        save()
        task.spawn(function()
            while task.wait(.02) do
                if getgenv().Config.Prewiew then
                    
                end;
            end;
        end);
    end);
    
    Player:AddButton("Stafe Player",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[getgenv().SelectPly].Character.HumanoidRootPart.CFrame
        for i = 1,1 do

                                    SendKey("Z",0.2)

                                    SendKey("X",0.2)
                                    SendKey("C",0.2)
                                    SendKey("V",0.2)
        end
    end)
end;

local Esp = Tabbox5:AddTab([[ Esp ]])
do
    Esp:AddToggle("Indx", {
        Text = "Enabled Esp",
        Default = getgenv().Config.Esp,
        Tooltip = 'wow i can see everything'
    }):OnChanged(function(a)
        getgenv().Config.Esp = a
        save()
        task.spawn(function()
            while task.wait(.02) do
                if getgenv().Config.Esp then
                    
                end;
            end;
        end);
    end);
end;

local a3 = Combat:AddRightGroupbox([[Info]]);
do
    local Task = a3:AddLabel('Target : [ ... ]');
    local CurrentBounty = a3:AddLabel('Current Bounties : [ 0 ]');
    local EarnedBounty = a3:AddLabel('Earned Bounties : [ 0 ]');
    local OldBounty = game:GetService("Players").LocalPlayer.leaderstats["Bounty/Honor"].Value
    local Bounty = tostring(game:GetService("Players").LocalPlayer.leaderstats["Bounty/Honor"].Value)
    local Earned = tostring(game:GetService("Players").LocalPlayer.leaderstats["Bounty/Honor"].Value - OldBounty)
    local sub = string.sub 
    local len = string.len
    task.spawn(function()
        while task.wait() do
            pcall(function()
                if len(Earned) == 4 then
                    Earned1 = sub(Earned,1,1).."."..sub(Earned,2,3).."K"
                elseif len(Earned) == 5 then
                    Earned1 = sub(Earned,1,2).."."..sub(Earned,3,4).."K"
                elseif len(Earned) == 6 then
                    Earned1 = sub(Earned,1,3).."."..sub(Earned,4,5).."K"
                elseif len(Earned) == 7 then
                    Earned1 = sub(Earned,1,1).."."..sub(Earned,2,3).."M"
                elseif len(Earned) == 8 then
                    Earned1 = sub(Earned,1,2).."."..sub(Earned,3,4).."M"
                elseif len(Earned) <= 3 then
                    Earned1 = Earned
                end
                EarnedBounty:SetText("Earned Bounties : [ ".. Earned1 .." ]")
            end)
        end
    end)

    task.spawn(function()
        while task.wait() do
            pcall(function()
                CurrentBounty:SetText("Current Bounties : [ "..game:GetService("Players").LocalPlayer.leaderstats["Bounty/Honor"].Value .. " ]")
            end)
        end
    end)

    task.spawn(function()
        while task.wait() do
            pcall(function()
                if getgenv().AutoFarmBounty then
                    for i,v in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                        if v:IsA("Shirt") then
                            v:Destroy()
                        end
                        if v:IsA("Pants") then
                            v:Destroy()
                        end
                        if v:IsA("Accessory") then
                            v:Destroy()
                        end
                    end
                end
            end)
        end
    end)

    task.spawn(function()
        pcall(function()
            if getgenv().AutoFarmBounty then
                while task.wait() do
                    if getgenv().Config.AUTOBountyHop == true and game:GetService("Players").LocalPlayer.PlayerGui.Main:FindFirstChild("InCombat").Visible == false then
                        ServerHop()
                        task.wait(300)
                    end
                end
            end
        end)
    end)

    task.spawn(function()
        while task.wait() do
            pcall(function()
                if getgenv().AutoFarmBounty then
                    if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
                    end
                end
            end)
        end
    end)

    task.spawn(function()
        while task.wait() do
            pcall(function()
                if getgenv().AutoFarmBounty then
                    game:GetService("Players").LocalPlayer.Character[SelectWeaponGun].Cooldown.Value = 0
                    spawn(function()
                        game:GetService("Players")["LocalPlayer"].PlayerGui.Main.Beli.Visible = false
                        game:GetService("Players")["LocalPlayer"].PlayerGui.Main.HP.Visible = false
                        game:GetService("Players")["LocalPlayer"].PlayerGui.Main.Energy.Visible = false
                        game:GetService("Players")["LocalPlayer"].PlayerGui.Main.StatsButton.Visible = false
                        game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ShopButton.Visible = false
                        game:GetService("Players")["LocalPlayer"].PlayerGui.Main.Skills.Visible = false
                        game:GetService("Players")["LocalPlayer"].PlayerGui.Main.Level.Visible = false
                        game:GetService("Players")["LocalPlayer"].PlayerGui.Main.MenuButton.Visible = false
                        game:GetService("Players")["LocalPlayer"].PlayerGui.Main.Code.Visible = false
                        game:GetService("Players")["LocalPlayer"].PlayerGui.Main.Settings.Visible = false
                        game:GetService("Players")["LocalPlayer"].PlayerGui.Main.Mute.Visible = false
                        game:GetService("Players")["LocalPlayer"].PlayerGui.Main.CrewButton.Visible = false
                        game.Players.LocalPlayer.Character.Animate.Disabled = true
                    end)
                end
            end)
        end
    end)
    CastlePostoMansion = CFrame.new(-5084.8447265625, 316.48101806641, -3145.3752441406)
    MansiontoCastlePos = CFrame.new(-12464.596679688, 376.30590820312, -7567.2626953125)
    Castletophydra = CFrame.new(-5095.33984375, 316.48101806641, -3168.3134765625)
    HydratoCastle = CFrame.new(5741.869140625, 611.94750976562, -282.61154174805)
    getgenv().EscapeAt = 40
    task.spawn(function()
        while task.wait() do
            pcall(function()
                if getgenv().AutoFarmBounty then
                    for i,v in pairs(game:GetService("Workspace").Characters:GetChildren()) do
                        if v.Name ~= game.Players.LocalPlayer.Name then
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild('HumanoidRootPart') and v:WaitForChild("Humanoid").Health > 0 and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude <= 17000 then
                                plyselecthunthelpold = v.Humanoid.Health
                                repeat task.wait()
                                    NameTarget = v.Name
                                    BusoAndKen()
                                    getgenv().SelectPly = v.Name
                                    if tostring(game.Players.LocalPlayer.Team) == "Pirates" then
                                        if game.Players.LocalPlayer.Character.Humanoid.Health < game.Players.LocalPlayer.Character.Humanoid.MaxHealth * getgenv().EscapeAt/100 then
                                            Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,300,0))
                                        else
                                            Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,0,-3)*CFrame.Angles(math.rad(45), math.rad(90), math.rad(0)))
                                        end
                                    elseif tostring(game.Players.LocalPlayer.Team) == "Marines" then
                                        if game.Players[NameTarget].Team ~= game.Players.LocalPlayer.Team then
                                            if game.Players.LocalPlayer.Character.Humanoid.Health < game.Players.LocalPlayer.Character.Humanoid.MaxHealth * getgenv().EscapeAt/100 then
                                                Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,300,0))
                                            else
                                                Teleport(v.HumanoidRootPart.CFrame * CFrame.new(0,0,-3)*CFrame.Angles(math.rad(45), math.rad(90), math.rad(0)))
                                            end
                                        end
                                    end
                                    spawn(function()
                                        if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 375 then
                                            StartCheckTarget = true
                                        end
                                    end)
                                    v.HumanoidRootPart.CanCollide = false
                                    --v.HumanoidRootPart.Size = Vector3.new(120,120,120)
                                    --game.Players[getgenv().SelectPly].Character.HumanoidRootPart.Size = Vector3.new(120,120,120)
                                    spawn(function()
                                        pcall(function()
                                            local args = {
                                                [1] = v.HumanoidRootPart.Position,
                                                [2] = v.HumanoidRootPart
                                            }
                                            game:GetService("Players").LocalPlayer.Character[SelectWeaponGun].RemoteFunctionShoot:InvokeServer(unpack(args))
                                        end)
                                    end)
                                    TargetSelectHunt = v.Humanoid
                                    Task:SetText('Target : [ '.. v.Name ..' ]')
                                until getgenv().AutoFarmBounty == false or v.Humanoid.Health == 0 or not v:FindFirstChild("HumanoidRootPart") or not v:FindFirstChild("Humanoid") or not v.Parent or NextplySelect == true
                                NextplySelect = false
                                StartCheckTarget = false
                            end
                        end
                    end
                end
            end)
        end
    end)
    
    function CheckNotify(Text)
	    for i, v in pairs(game:GetService("Players")["LocalPlayer"].PlayerGui:FindFirstChild("Notifications"):GetChildren()) do
            if v.Name == "NotificationTemplate" then
                if string.lower(v.Text):find(Text) then
                    pcall(function()
                        --v:Destroy()
                        p.Text = "bruh he is died?"
                    end)
                    return true
                end
            end
        end
        return false
    end

end;

local B = Combat:AddRightGroupbox([[Combat]]);
do
    B:AddToggle("Indx", {
        Text = "Auto Farm Bounties",
        Default = getgenv().Config.AutoBounty,
        Tooltip = 'Auto farm bounty stuff'
    }):OnChanged(function(a)
        getgenv().AutoFarmBounty = a;
        getgenv().Config.Clip = a;
        save();
    end);
    
        B:AddToggle("Indx", {
        Text = "Enabled Hop",
        Default = getgenv().Config.AUTOBountyHop,
        Tooltip = 'Auto farm bounty stuff'
    }):OnChanged(function(a)
        getgenv().Config.AUTOBountyHop = a;
        save();
    end);
end;

if not FirstSea then
    local Raid = Combat:AddRightGroupbox([[\\ Raids //]]);
    do
        local a = require(game.ReplicatedStorage.Raids)
        local AllRaids = {}

        for i,v in pairs(a) do
            for a,b in pairs(v) do
                table.insert(AllRaids,b)
            end
        end

        Raid:AddDropdown("Chips", {
            Text = "Select Chip",
            Values = AllRaids,
            Multi = false,
            Default = getgenv().Config.SelectChip or 1,
            Callback = function(a)
                getgenv().Config.SelectChip = a
                save()
            end
        })

        Raid:AddToggle("Indx", {
            Text = "Auto Buy Chip",
            Default = getgenv().Config.AutoBuyChip,
            Tooltip = 'can i buy a chip?'
        }):OnChanged(function(a)
            getgenv().Config.AutoBuyChip = a
            save()
        end)

        Raid:AddToggle("AutoRaids", {
            Text = "Auto Farm Raid",
            Default = getgenv().Config.AutoRaid,
            Tooltip = "Why a raid is so hard :bushed:"
        }):OnChanged(function(a)
            getgenv().Config.AutoRaid = a
            getgenv().Config.Clip = a
            save()
            spawn(function()
                while wait() do
                    if getgenv().Config.AutoRaid then 
                        if game.Players.LocalPlayer.Backpack:FindFirstChild("Special Microchip") or game.Players.LocalPlayer.Character:FindFirstChild("Special Microchip") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") then
                            if game.Players.LocalPlayer.Backpack:FindFirstChild("Special Microchip") or game.Players.LocalPlayer.Character:FindFirstChild("Special Microchip") and game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false then
                                if SecondSea then
                                    fireclickdetector(Workspace.Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
                                elseif ThirdSea then
                                    fireclickdetector(Workspace.Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
                                end
                            elseif game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == true then				
                                pcall(function()
                                    repeat wait()
                                        if game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false then
            
                                        elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") then
                                            game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame.z)
                                            if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 2500 then
                                                Teleport(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame)
                                            end
                                        elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") then
                                            game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame.z)
                                            if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 2500 then
                                                Teleport(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame)
                                            end
                                        elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") then
                                            game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame.z)
                                            if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 2500 then
                                                Teleport(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame)
                                            end
                                        elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") then
                                            game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame.z)
                                            if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 2500 then
                                                Teleport(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame)
                                            end
                                        elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") then
                                            game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame.z)
                                            if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 2500 then
                                                Teleport(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame)
                                            end
                                        end
                                        for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                            if getgenv().U.Raids.AutoRaid and game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == true and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 400 then
                                                repeat task.wait()
                                                    v.Humanoid.Health = 0
                                                    v:BreakJoints()
                                                until not getgenv().U.Raids.AutoRaid or v.Humanoid.Health <= 0 or not v.Parent
                                            end
                                        end
                                    until not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") or game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false
                                end)
                            end           
                        else
                            if getgenv().Config.AutoBuyChip then
                                local args = {
                                    [1] = "RaidsNpc",
                                    [2] = "Select",
                                    [3] = tostring(getgenv().Config.SelectChip)
                                }
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                            end
                        end
                    end
                end
            end)
        end);

        local SubSetting = Raid:AddDependencyBox();
        do
            SubSetting:AddToggle("BringFruit", {
                Text = "Enabled Bring Fruit",
                Default = getgenv().Config.BringFruitEnabled,
                Callback = function(a)
                    getgenv().Config.BringFruitEnabled = a
                    save()
                    spawn(function()
                        while wait() do
                            pcall(function()
                                for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
                                    if v:IsA("Tool") then
                                        local OldCFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame;
                                        firetouchinterest(game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart"),v.Handle.CFrame,1);
                                        firetouchinterest(game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart"),v.Handle.CFrame,0);
                                        --game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame * CFrame.new(0,0,8)
                                        --v.Handle.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame;
                                        --wait(.1)
                                        task.wait(.2);
                                        --game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = OldCFrame
                                    end;
                                end;
                            end);
                        end;
                    end);
                end;
            });
        end;

        SubSetting:SetupDependencies({
            { Toggles.AutoRaids, true }
        })

        Raid:AddToggle("Indx", {
            Text = "Kill Around Mob (Dead)",
            Default = getgenv().Config.KillAura,
            Tooltip = 'why mobs ariund me is d3ad?'
        }):OnChanged(function(a)
            getgenv().Config.KillAura = a
            save()
            task.spawn(function()
                while wait(.2) do
                    if getgenv().Config.KillAura then
                        for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                            if game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == true and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 400 then
                                repeat wait()
                                    v.Humanoid.Health = 0;
                                    v:BreakJoints();
                                until not getgenv().Config.KillAura or v.Humanoid.Health <= 0 or not v.Parent;
                            end;
                        end;
                    end;
                end;
            end);
        end);

        Raid:AddToggle("Indx", {
            Text = "Auto Aweakening",
            Default = getgenv().Config.AutoAweakening,
            Tooltip = 'i can Awaken this?'
        }):OnChanged(function(a)
            getgenv().Config.AutoAweakening = a
            save()
            spawn(function()
                while wait(.2) do
                    if getgenv().Config.AutoAweakening then	
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Awakener","Awaken");
                    end
                end;
            end);
        end);
        
        Raid:AddToggle("Indx", {
            Text = "Auto Next Islands",
            Default = getgenv().Config.nextIslands,
            Tooltip = 'Where is a nextIslands?'
        }):OnChanged(function(a)
            getgenv().Config.nextIslands = a
            save()
            spawn(function()
                repeat wait()
                    if getgenv().Config.nextIslands and game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == true then
                        if game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") then
                            game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame.z)
                            if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 2500 then
                                Teleport(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame)
                            end
                        elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") then
                            game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame.z)
                            if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 2500 then
                                Teleport(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame)
                            end
                        elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") then
                            game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame.z)
                            if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 2500 then
                                Teleport(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame)
                            end
                        elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") then
                            game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame.z)
                            if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 2500 then
                                Teleport(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame)
                            end
                        elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") then
                            game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame.z)
                            if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 2500 then
                                Teleport(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame)
                            end
                        end
                    end
                until not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") or game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false
            end)
        end);
    end;
end;

local Teleport = Combat:AddRightGroupbox([[Teleports]]);
do
    local function GetLocations()
        local Locations = {}
        for _,v in pairs(game:GetService("Workspace")["_WorldOrigin"].Locations:GetChildren()) do
            table.insert(Locations, v.Name);
        end;
        return Locations;
    end;

    Teleport:AddDropdown("Locations", {
        Text = "Select Location",
        Values = GetLocations(),
        Default = getgenv().Config.SelectLocation,
        Callback = function(a)
            getgenv().Config.SelectLocation = a;
            save();
        end;
    });

    Teleport:AddToggle("Teleport", {
        Text = "Teleport to",
        Default = getgenv().Config.TelepotToLocation,
        Callback = function(a)
            getgenv().Config.TelepotToLocation = a;
            save();
            spawn(function()
                while wait(.1) do
                    pcall(function()
                        if getgenv().Config.TelepotToLocation then
                            for _,v in pairs(game:GetService("Workspace")["_WorldOrigin"].Locations:GetChildren()) do
                                if v.Name == getgenv().Config.SelectLocation then
                                    Teleport(v.CFrame * CFrame.new(0,500,500));
                                end;
                            end;
                        end;
                    end);
                end;
            end);
        end;
    });

    spawn(function()
        while wait() do
            pcall(function()
                Options.Locations:Setvalues(GetLocations());
            end);
        end;
    end);

    Teleport:AddButton("Sea 1",function()
        Sea1()
    end);

    Teleport:AddButton("Sea 2",function()
        Sea2()
    end);

    Teleport:AddButton("Sea 3",function()
        Sea3()
    end);
end;

local MenuGroup = Theme:AddLeftGroupbox([[Ui Configs]]);

MenuGroup:AddButton('Unload UI', function()
    Library:Unload()
end);
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind',{
    Default = 'End',
    NoUI = true,
    Text = 'Menu keybind'
});
Library.ToggleKeybind = Options.MenuKeybind;
ThemeManager:SetLibrary(Library);
SaveManager:SetLibrary(Library);
SaveManager:IgnoreThemeSettings();
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' });
ThemeManager:SetFolder('ZPU Hub');
SaveManager:SetFolder('ZPU Hub/SaveContents');
SaveManager:BuildConfigSection(Theme);
ThemeManager:ApplyToTab(Theme);

if not FirstSea then
    do
        print("Manager "..game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Manager","1"))
        local PlaceID = game.PlaceId
        local AllIDs = {}
        local foundAnything = ""
        local actualHour = os.date("!*t").hour
        local Deleted = false
        local File = pcall(function()
            AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
        end)
        if not File then
            table.insert(AllIDs, actualHour)
            writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
        end
        function TPReturner()
            local Site;
            if foundAnything == "" then
                Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
            else
                Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
            end
            local ID = ""
            if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
                foundAnything = Site.nextPageCursor
            end
            local num = 0;
            for i,v in pairs(Site.data) do
                local Possible = true
                ID = tostring(v.id)
                if tonumber(v.maxPlayers) > tonumber(v.playing) then
                    for _,Existing in pairs(AllIDs) do
                        if num ~= 0 then
                            if ID == tostring(Existing) then
                                Possible = false
                            end
                        else
                            if tonumber(actualHour) ~= tonumber(Existing) then
                                local delFile = pcall(function()
                                    delfile("NotSameServers.json")
                                    AllIDs = {}
                                    table.insert(AllIDs, actualHour)
                                end)
                            end
                        end
                        num = num + 1
                    end
                    if Possible == true then
                        table.insert(AllIDs, ID)
                        wait()
                        pcall(function()
                            writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                            wait(1)
                            game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                        end)
                        wait(3)
                    end
                end
            end
        end
        
        local function HopServer()
            while wait() do
                pcall(function()
                    TPReturner()
                    if foundAnything ~= "" then
                        TPReturner()
                    end
                end)
                wait(5)
            end
        end
        
        local function send(url,data)
            local data = data or {}
            local newdata = game:GetService("HttpService"):JSONEncode(data)
        
            local headers = {
                ["content-type"] = "application/json"
            }
        
            local R = {Url = url, Body = newdata, Method = "POST", Headers = headers}
        
            local request = http_request or request or HttpPost or syn.request
            local Urls = {Url = url, Body = newdata, Method = "POST", Headers = headers}
            request(Urls)
        end
        local httpbin = game:HttpGet("https://httpbin.org/get")
        local args = {
            [1] = "ColorsDealer",
            [2] = "1"
        }
        local Text = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        print("Color Name : ".. tostring(Text))
        if tonumber(Text) == 1 then HopServer() return end
        if not httpbin:match("Specific_PrivateGame") and Text ~= nil then  
            if Text==nil then
                return
            else
                local HakiColor = Text:split(" ")[1].." "..Text:split(" ")[2]
                local Price
                if tostring(Text) == "Snow White" or tostring(Text) == "Pure Red" or tostring(Text) == "Winter Sky" then
                    Price = "7500F"
                    send("https://discordapp.com/api/webhooks/1101976058133237900/44VNvJFGHaefiZkq1Rqx4A74Z8RF56x3l60OdqXdN4t96LVZ6GJLF2fXEB91PYu1ficS", {
                        ["content"] = "",
                        ["embeds"] = {
                            {
                                ["description"] = "**Scripts**\n```lua\n"..tostring('game:GetService("TeleportService"):TeleportToPlaceInstance('.. tonumber(game.PlaceId) .. ', "'.. game.JobId .. '")').."\n```",
                                ["color"] = 16711751,
                                ["fields"] = {
                                    {["name"] = "**Players**",["value"] = "```yaml\n"..(#game:GetService("Players"):GetChildren()-1).."/"..game:GetService("Players").MaxPlayers.."\n```",["inline"] = true,},
                                    {["name"] = "**Job Id**",["value"] = "```yaml\n"..game.JobId.."\n```",["inline"] = true,},
                                    {["name"] = "**Color Name**",["value"] = "```yaml\n" .. HakiColor .. "\n```",["inline"] = true,},
                                    {["name"] = "**Color Price**",["value"] = "```lua\n".. Price .."\n```",["inline"] = true,}
                                },
                                ["author"] = {
                                    ["name"] = "Kenei Hub : Legendary Color Notifyer",
                                    ["icon_url"] = "https://cdn.discordapp.com/attachments/774783682044887068/1101977198736445450/bdd00c140088eeaf2680aa3f6e22a0e7.jpg"
                                },
                                ["footer"] = {
                                    ["text"] = "Made by Kenei Kung#2472",
                                    ["icon_url"] = "https://cdn.discordapp.com/attachments/774783682044887068/1101977198736445450/bdd00c140088eeaf2680aa3f6e22a0e7.jpg"
                                },
                                ["timestamp"] = DateTime.now():ToIsoDate(),
                                ["thumbnail"] = {
                                    ["url"] = "https://cdn.discordapp.com/attachments/774783682044887068/1101977198736445450/bdd00c140088eeaf2680aa3f6e22a0e7.jpg"
                                }
                            }
                        },
                    })
                else
                    Price = "1500F"
                    send("https://discordapp.com/api/webhooks/1101930288239624242/Vy1TO4NJGMhQ_FQl2wN7M8QNVnmum-8oO7_w_FmpREtDhLAfmELiPe6eeBmPiVaZVPR2", {
                        ["content"] = "",
                        ["embeds"] = {
                            {
                                ["description"] = "**Scripts**\n```lua\n"..tostring('game:GetService("TeleportService"):TeleportToPlaceInstance('.. tonumber(game.PlaceId) .. ', "'.. game.JobId .. '")').."\n```",
                                ["color"] = 16711751,
                                ["fields"] = {
                                    {["name"] = "**Players**",["value"] = "```yaml\n"..(#game:GetService("Players"):GetChildren()-1).."/"..game:GetService("Players").MaxPlayers.."\n```",["inline"] = true,},
                                    {["name"] = "**Job Id**",["value"] = "```yaml\n"..game.JobId.."\n```",["inline"] = true,},
                                    {["name"] = "**Color Name**",["value"] = "```yaml\n" .. HakiColor .. "\n```",["inline"] = true,},
                                    {["name"] = "**Color Price**",["value"] = "```lua\n".. Price .."\n```",["inline"] = true,}
                                },
                                ["author"] = {
                                    ["name"] = "Kenei Hub : Color Notifyer",
                                    ["icon_url"] = "https://media.discordapp.net/attachments/1055528899326525582/1057352282863321198/1177-makimaisaiming.png"
                                },
                                ["footer"] = {
                                    ["text"] = "Made by Kenei Kung#2472",
                                    ["icon_url"] = "https://media.discordapp.net/attachments/1055528899326525582/1057352282863321198/1177-makimaisaiming.png"
                                },
                                ["timestamp"] = DateTime.now():ToIsoDate(),
                                ["thumbnail"] = {
                                    ["url"] = "https://media.discordapp.net/attachments/1055528899326525582/1057352282863321198/1177-makimaisaiming.png"
                                }
                            }
                        },
                    })
                end
            end
        end
        
        local SwordRemote = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer")
            
        print("Swords : ".. tostring(SwordRemote))
        local SwordName = tostring(SwordRemote)
        local SwordPrice = "2500000 B$"
        if not httpbin:match("Specific_PrivateGame") and SwordRemote ~= nil then
            send("https://discordapp.com/api/webhooks/1101958255963553845/wIIYnwNcz1Lm0MY-X9NzoNPcY38vpHsjDUKh1imu33Kdzz9A9a9ygV3WNXq62e2BhdCX", {
                ["content"] = "",
                ["embeds"] = {
                    {
                        ["description"] = "**Scripts**\n```lua\n"..tostring('game:GetService("TeleportService"):TeleportToPlaceInstance('.. tonumber(game.PlaceId) .. ', "'.. game.JobId .. '")').."\n```",
                        ["color"] = 16711751,
                        ["fields"] = {
                            {["name"] = "**Players**",["value"] = "```yaml\n"..(#game:GetService("Players"):GetChildren()-1).."/"..game:GetService("Players").MaxPlayers.."\n```",["inline"] = true,},
                            {["name"] = "**Job Id**",["value"] = "```yaml\n"..game.JobId.."\n```",["inline"] = true,},
                            {["name"] = "**Sword Name**",["value"] = "```yaml\n" .. tostring(SwordName) .. "\n```",["inline"] = true,},
                            {["name"] = "**Sword Price**",["value"] = "```lua\n".. SwordPrice .."\n```",["inline"] = true,}
                        },
                        ["author"] = {
                            ["name"] = "Kenei Hub : Swords Notifyer",
                            ["icon_url"] = "https://media.discordapp.net/attachments/1055528899326525582/1057352282863321198/1177-makimaisaiming.png"
                        },
                        ["footer"] = {
                            ["text"] = "Made by Kenei Kung#2472",
                            ["icon_url"] = "https://media.discordapp.net/attachments/1055528899326525582/1057352282863321198/1177-makimaisaiming.png"
                        },
                        ["timestamp"] = DateTime.now():ToIsoDate(),
                        ["thumbnail"] = {
                            ["url"] = "https://media.discordapp.net/attachments/1055528899326525582/1057352282863321198/1177-makimaisaiming.png"
                        }
                    }
                },
            })
        end
        
        if game.PlaceId == 7449423635 then -- Thirdsea
            local MoonPhase
            if game:GetService("Lighting").Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149431" then
                MoonPhase = "5/5"
            elseif game:GetService("Lighting").Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149052" then
                MoonPhase = "4/5"
            elseif game:GetService("Lighting").Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709143733" then
                MoonPhase = "3/5"
            elseif game:GetService("Lighting").Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709150401" then
                MoonPhase = "2/5"
            elseif game:GetService("Lighting").Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149680" then
                MoonPhase = "1/5"
            else
                MoonPhase = "0/5"
            end
            local EndAreound = "nil"
            local Lighting = game:GetService("Lighting")
            local Time = Lighting.TimeOfDay
            local Ends = 6
            local Hour = Time:split(":")[1]
            local Sec = Time:split(":")[2]
            if tonumber(Hour)>18 and tonumber(Hour)<23 then
            EndAreound = ("End Arounds in : " ..(tonumber(Hour)-5).. " : ".. (tonumber(Sec)-60))
            else EndAreound = ("It's a day fullmoon is ended!")
            end
        
            if not httpbin:match("Specific_PrivateGame") and (game:GetService("Lighting").Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149431" or game:GetService("Lighting").Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149052") then
                send("https://discordapp.com/api/webhooks/1102205690468110367/NjMCiqWr0QeY2MnARA2xsGCreL-HkHVd82hTj7EOTsxelQ4KP3OvNDmTse5ev_8TzZu7", {
                    ["content"] = "",
                    ["embeds"] = {
                        {
                            ["description"] = "**Scripts**\n```lua\n"..tostring('game:GetService("TeleportService"):TeleportToPlaceInstance('.. tonumber(game.PlaceId) .. ', "'.. game.JobId .. '")').."\n```",
                            ["color"] = 16711751,
                            ["fields"] = {
                                {["name"] = "**Players**",["value"] = "```yaml\n"..(#game:GetService("Players"):GetChildren()-1).."/"..game:GetService("Players").MaxPlayers.."\n```",["inline"] = true,},
                                {["name"] = "**Job Id**",["value"] = "```yaml\n"..game.JobId.."\n```",["inline"] = true,},
                                {["name"] = "**Moon Phase**",["value"] = "```yaml\n" .. tostring(MoonPhase) .. "\n```",["inline"] = true,},
                                {["name"] = "**Ends Around**",["value"] = "```lua\n".. tostring(EndAreound) .."\n```",["inline"] = true,}
                            },
                            ["author"] = {
                                ["name"] = "Kenei Hub : Moon Phase Notifyer",
                                ["icon_url"] = "https://media.discordapp.net/attachments/1055528899326525582/1057352282863321198/1177-makimaisaiming.png"
                            },
                            ["footer"] = {
                                ["text"] = "Made by Kenei Kung#2472",
                                ["icon_url"] = "https://media.discordapp.net/attachments/1055528899326525582/1057352282863321198/1177-makimaisaiming.png"
                            },
                            ["timestamp"] = DateTime.now():ToIsoDate(),
                            ["thumbnail"] = {
                                ["url"] = "https://media.discordapp.net/attachments/1055528899326525582/1057352282863321198/1177-makimaisaiming.png"
                            }
                        }
                    },
                })
            end
        
            if not httpbin:match("Specific_PrivateGame") and (game:GetService("Workspace").Map:FindFirstChild("MysticIsland") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Mirage Island")) then
                send("https://discordapp.com/api/webhooks/1095681283218215051/-oTXz92HVCdIjxinFhieojcjhM1aOLSQYK3TrommmtXkXO5zh5WgThMWUM6Ba4lXQ_C2", {
                    ["content"] = "",
                    ["embeds"] = {
                        {
                            ["description"] = "**Scripts**\n```lua\n"..tostring('game:GetService("TeleportService"):TeleportToPlaceInstance('.. tonumber(game.PlaceId) .. ', "'.. game.JobId .. '")').."\n```",
                            ["color"] = 16711751,
                            ["fields"] = {
                                {["name"] = "**Players**",["value"] = "```yaml\n"..(#game:GetService("Players"):GetChildren()-1).."/"..game:GetService("Players").MaxPlayers.."\n```",["inline"] = true,},
                                {["name"] = "**Job Id**",["value"] = "```yaml\n"..game.JobId.."\n```",["inline"] = true,},
                                {["name"] = "**Spawned**",["value"] = "```yaml\n" .. 'true' .. "\n```",["inline"] = true,}
                            },
                            ["author"] = {
                                ["name"] = "Kenei Hub : Mirage Notifyer",
                                ["icon_url"] = "https://media.discordapp.net/attachments/1055528899326525582/1057352282863321198/1177-makimaisaiming.png"
                            },
                            ["footer"] = {
                                ["text"] = "Made by Kenei Kung#2472",
                                ["icon_url"] = "https://media.discordapp.net/attachments/1055528899326525582/1057352282863321198/1177-makimaisaiming.png"
                            },
                            ["timestamp"] = DateTime.now():ToIsoDate(),
                            ["thumbnail"] = {
                                ["url"] = "https://media.discordapp.net/attachments/1055528899326525582/1057352282863321198/1177-makimaisaiming.png"
                            }
                        }
                    },
                })
            end
        end
        
        local function GetItemFromPlayers(args)
            local Player = {}
            for i,v in pairs(game:GetService("Players"):GetChildren()) do
                if v.Name==game.Players.LocalPlayer.Name then
                else
                    for a,b in pairs(v.Backpack:GetChildren()) do
                        if b.Name == args then
                            send("https://discordapp.com/api/webhooks/1102237918636019822/oTeB7uUT2jY1kO_qTN2ue5T13sKjqFFeltpwhDsND6vAUJsefBvaTobkGqqUmkNZnN1W", {
                                ["content"] = "",
                                ["embeds"] = {
                                    {
                                        ["description"] = "**Scripts**\n```lua\n"..tostring('game:GetService("TeleportService"):TeleportToPlaceInstance('.. tonumber(game.PlaceId) .. ', "'.. game.JobId .. '")').."\n```",
                                        ["color"] = 16711751,
                                        ["fields"] = {
                                            {["name"] = "**Players**",["value"] = "```yaml\n"..(#game:GetService("Players"):GetChildren()-1).."/"..game:GetService("Players").MaxPlayers.."\n```",["inline"] = true,},
                                            {["name"] = "**Job Id**",["value"] = "```yaml\n"..game.JobId.."\n```",["inline"] = true,},
                                            {["name"] = "**Items**",["value"] = "```yaml\n" .. tostring(b.Name) .. "\n```",["inline"] = true,},
                                            {["name"] = "**Item owner**",["value"] = "```lua\n" ..tostring(v.Name) .. " Has Owned this item" .."\n```",["inline"] = true,}
                                        },
                                        ["author"] = {
                                            ["name"] = "Kenei Hub : Item Notifyer",
                                            ["icon_url"] = "https://media.discordapp.net/attachments/1055528899326525582/1057352282863321198/1177-makimaisaiming.png"
                                        },
                                        ["footer"] = {
                                            ["text"] = "Made by Kenei Kung#2472",
                                            ["icon_url"] = "https://media.discordapp.net/attachments/1055528899326525582/1057352282863321198/1177-makimaisaiming.png"
                                        },
                                        ["timestamp"] = DateTime.now():ToIsoDate(),
                                        ["thumbnail"] = {
                                            ["url"] = "https://media.discordapp.net/attachments/1055528899326525582/1057352282863321198/1177-makimaisaiming.png"
                                        }
                                    }
                                },
                            })
                        end
                    end
                end
            end
            return Player
        end
        
        GetItemFromPlayers("God's Chalice")
        GetItemFromPlayers("Sweet Chalice")
        GetItemFromPlayers("Hallow Essence")
        GetItemFromPlayers("Fist of Darkness")
    end;
end;

return Library;
