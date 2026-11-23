local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

getgenv().Config = {
    -- Farm Settings (Coluna Direita Fixa)
    Weapon = "Melee",
    TweenSpeed = 250,
    FarmDistance = 15,
    BringRadius = 350,
    StartBring = true,
    FastAttack = true,
    AutoSkills = false,
    WalkOnWater = true,
    AntiAFK = true,

    -- Home & Sub Farm
    AutoFarmLevel = false,
    FarmMethod = "Quest",
    AutoChest = false,
    AutoFruits = false,
    AutoEliteHunter = false,
    AutoPirateRaid = false,
    AutoStats = false,
    StatTarget = "Melee",

    -- Dragon Update (Vulcão / Dojo / Berries)
    AutoPrehistoric = false,
    AutoCollectDragonEggs = false,
    AutoCollectBerries = false,

    -- Sea Events & Fishing
    AutoDriveSea = false,
    AutoSeaBeast = false,
    AutoTerrorShark = false,
    AutoMirage = false,
    AutoKitsune = false,
    AutoFishing = false,

    -- ESP Menu
    ESPFruits = false,
    ESPChests = false,
    ESPBerries = false,
    ESPPlayers = false,

    -- Dungeon & Raids
    SelectedChip = "Flame",
    AutoRaid = false,
    AutoAwaken = false,
    AutoRollFruit = false,
    AutoStoreFruit = false,

    -- Travel, Trials & Misc
    SelectedIsland = "Tiki Outpost",
    AutoLookMoon = false,
    SelectedMelee = "Godhuman",
    WalkSpeed = 50,
    CustomSpeed = false
}

-- =========================================================================
-- 1. BANCO DE MISSÕES E ILHAS DO SEA 3
-- =========================================================================
local Sea3Quests = {
    {Min = 1500, Max = 1524, Mob = "Pirate Millionaire", Quest = "PiratePortQuest", Level = 1, Pos = CFrame.new(-290, 44, 5580)},
    {Min = 1525, Max = 1574, Mob = "Pistol Billionaire", Quest = "PiratePortQuest", Level = 2, Pos = CFrame.new(-290, 44, 5580)},
    {Min = 1575, Max = 1599, Mob = "Dragon Crew Warrior", Quest = "AmazonQuest", Level = 1, Pos = CFrame.new(5832, 51, -1105)},
    {Min = 1600, Max = 1624, Mob = "Dragon Crew Archer", Quest = "AmazonQuest", Level = 2, Pos = CFrame.new(5832, 51, -1105)},
    {Min = 1625, Max = 1649, Mob = "Female Islander", Quest = "AmazonQuest2", Level = 1, Pos = CFrame.new(5446, 601, 749)},
    {Min = 1650, Max = 1699, Mob = "Giant Islander", Quest = "AmazonQuest2", Level = 2, Pos = CFrame.new(5446, 601, 749)},
    {Min = 1700, Max = 1724, Mob = "Marine Commodore", Quest = "MarineTreeIsland", Level = 1, Pos = CFrame.new(2180, 29, -6737)},
    {Min = 1725, Max = 1774, Mob = "Marine Rear Admiral", Quest = "MarineTreeIsland", Level = 2, Pos = CFrame.new(2180, 29, -6737)},
    {Min = 1775, Max = 1799, Mob = "Fishman Raider", Quest = "DeepForestIsland3", Level = 1, Pos = CFrame.new(-10581, 331, -8757)},
    {Min = 1800, Max = 1824, Mob = "Fishman Captain", Quest = "DeepForestIsland3", Level = 2, Pos = CFrame.new(-10581, 331, -8757)},
    {Min = 1825, Max = 1849, Mob = "Forest Pirate", Quest = "DeepForestIsland", Level = 1, Pos = CFrame.new(-13234, 331, -7625)},
    {Min = 1850, Max = 1899, Mob = "Mythological Pirate", Quest = "DeepForestIsland", Level = 2, Pos = CFrame.new(-13234, 331, -7625)},
    {Min = 1900, Max = 1924, Mob = "Jungle Pirate", Quest = "DeepForestIsland2", Level = 1, Pos = CFrame.new(-12680, 389, -9902)},
    {Min = 1925, Max = 1974, Mob = "Musketeer Pirate", Quest = "DeepForestIsland2", Level = 2, Pos = CFrame.new(-12680, 389, -9902)},
    {Min = 1975, Max = 1999, Mob = "Reborn Skeleton", Quest = "HauntedQuest1", Level = 1, Pos = CFrame.new(-9479, 141, 5566)},
    {Min = 2000, Max = 2024, Mob = "Living Zombie", Quest = "HauntedQuest1", Level = 2, Pos = CFrame.new(-9479, 141, 5566)},
    {Min = 2025, Max = 2049, Mob = "Demonic Soul", Quest = "HauntedQuest2", Level = 1, Pos = CFrame.new(-9516, 172, 6078)},
    {Min = 2050, Max = 2074, Mob = "Posessed Mummy", Quest = "HauntedQuest2", Level = 2, Pos = CFrame.new(-9516, 172, 6078)},
    {Min = 2075, Max = 2099, Mob = "Peanut Scout", Quest = "NutsIslandQuest", Level = 1, Pos = CFrame.new(-2104, 38, -10194)},
    {Min = 2100, Max = 2124, Mob = "Peanut President", Quest = "NutsIslandQuest", Level = 2, Pos = CFrame.new(-2104, 38, -10194)},
    {Min = 2125, Max = 2149, Mob = "Ice Cream Chef", Quest = "IceCreamIslandQuest", Level = 1, Pos = CFrame.new(-820, 65, -10965)},
    {Min = 2150, Max = 2199, Mob = "Ice Cream Commander", Quest = "IceCreamIslandQuest", Level = 2, Pos = CFrame.new(-820, 65, -10965)},
    {Min = 2200, Max = 2224, Mob = "Cookie Crafter", Quest = "CakeQuest1", Level = 1, Pos = CFrame.new(-2021, 37, -12028)},
    {Min = 2225, Max = 2249, Mob = "Cake Guard", Quest = "CakeQuest1", Level = 2, Pos = CFrame.new(-2021, 37, -12028)},
    {Min = 2250, Max = 2274, Mob = "Baking Staff", Quest = "CakeQuest2", Level = 1, Pos = CFrame.new(-1927, 37, -12842)},
    {Min = 2275, Max = 2299, Mob = "Head Baker", Quest = "CakeQuest2", Level = 2, Pos = CFrame.new(-1927, 37, -12842)},
    {Min = 2300, Max = 2324, Mob = "Cocoa Warrior", Quest = "ChocQuest1", Level = 1, Pos = CFrame.new(233, 29, -12201)},
    {Min = 2325, Max = 2349, Mob = "Chocolate Bar Battler", Quest = "ChocQuest1", Level = 2, Pos = CFrame.new(233, 29, -12201)},
    {Min = 2350, Max = 2374, Mob = "Sweet Thief", Quest = "ChocQuest2", Level = 1, Pos = CFrame.new(150, 30, -12774)},
    {Min = 2375, Max = 2399, Mob = "Candy Rebel", Quest = "ChocQuest2", Level = 2, Pos = CFrame.new(150, 30, -12774)},
    {Min = 2400, Max = 2424, Mob = "Candy Pirate", Quest = "CandyQuest1", Level = 1, Pos = CFrame.new(-1150, 20, -14446)},
    {Min = 2425, Max = 2449, Mob = "Snow Demon", Quest = "CandyQuest1", Level = 2, Pos = CFrame.new(-1150, 20, -14446)},
    {Min = 2450, Max = 2474, Mob = "Isle Outlaw", Quest = "TikiQuest1", Level = 1, Pos = CFrame.new(-16547, 55, -172)},
    {Min = 2475, Max = 2499, Mob = "Island Boy", Quest = "TikiQuest1", Level = 2, Pos = CFrame.new(-16547, 55, -172)},
    {Min = 2500, Max = 2524, Mob = "Sun-kissed Warrior", Quest = "TikiQuest2", Level = 1, Pos = CFrame.new(-16539, 55, 1051)},
    {Min = 2525, Max = 2549, Mob = "Isle Champion", Quest = "TikiQuest2", Level = 2, Pos = CFrame.new(-16539, 55, 1051)},
    {Min = 2550, Max = 2574, Mob = "Serpent Hunter", Quest = "TikiQuest3", Level = 1, Pos = CFrame.new(-16665, 105, 1579)},
    {Min = 2575, Max = 99999, Mob = "Skull Slayer", Quest = "TikiQuest3", Level = 2, Pos = CFrame.new(-16665, 105, 1579)}
}

local IslandsCFrame = {
    ["Port Town"] = CFrame.new(-290, 44, 5580),
    ["Hydra Island"] = CFrame.new(5229, 603, 345),
    ["Dragon Dojo"] = CFrame.new(5743, 1206, 936),
    ["Great Tree"] = CFrame.new(2681, 1682, -7190),
    ["Floating Turtle"] = CFrame.new(-13274, 532, -7579),
    ["Castle on the Sea"] = CFrame.new(-5075, 314, -3150),
    ["Haunted Castle"] = CFrame.new(-9515, 164, 5786),
    ["Sea of Treats"] = CFrame.new(-2021, 37, -12028),
    ["Tiki Outpost"] = CFrame.new(-16547, 55, -172),
    ["Temple of Time"] = CFrame.new(28286, 14896, 102)
}

local function GetCurrentQuest()
    local lvl = LocalPlayer.Data.Level.Value
    for _, q in ipairs(Sea3Quests) do
        if lvl >= q.Min and lvl <= q.Max then return q end
    end
    return Sea3Quests[#Sea3Quests]
end

-- =========================================================================
-- 2. MOVIMENTO, EQUIPAR ARMA, SKILLS E ESP VISUAL
-- =========================================================================
local ActiveTween = nil

local function TweenTo(targetCFrame)
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local dist = (root.Position - targetCFrame.Position).Magnitude
    if dist < 15 then
        root.CFrame = targetCFrame
        return
    end

    if ActiveTween then ActiveTween:Cancel() end
    local time = dist / getgenv().Config.TweenSpeed
    ActiveTween = TweenService:Create(root, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
    ActiveTween:Play()
end

local function EquipSelectedWeapon()
    local char = LocalPlayer.Character
    if not char then return end
    local targetTip = getgenv().Config.Weapon

    for _, item in pairs(char:GetChildren()) do
        if item:IsA("Tool") and item.ToolTip == targetTip then return end
    end
    for _, item in pairs(LocalPlayer.Backpack:GetChildren()) do
        if item:IsA("Tool") and item.ToolTip == targetTip then
            char.Humanoid:EquipTool(item)
            break
        end
    end
end

local function DoAttack()
    EquipSelectedWeapon()
    VirtualUser:CaptureController()
    VirtualUser:Button1Down(Vector2.new(1280, 672))
    if getgenv().Config.AutoSkills then
        for _, key in ipairs({"Z", "X", "C"}) do
            VirtualInputManager:SendKeyEvent(true, key, false, game)
            task.wait(0.05)
            VirtualInputManager:SendKeyEvent(false, key, false, game)
        end
    end
end

local function BringEnemies(targetName, centerPos)
    if not getgenv().Config.StartBring then return end
    for _, mob in pairs(workspace.Enemies:GetChildren()) do
        if mob.Name == targetName and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
            if (mob.HumanoidRootPart.Position - centerPos).Magnitude <= getgenv().Config.BringRadius then
                mob.HumanoidRootPart.CFrame = CFrame.new(centerPos)
                mob.HumanoidRootPart.CanCollide = false
                mob.Humanoid.WalkSpeed = 0
            end
        end
    end
end

-- Função de ESP (Cria etiqueta flutuante sobre Frutas, Baús, Berries e Players)
local function ApplyESP(part, text, color)
    if not part or part:FindFirstChild("CustomESP") then return end
    local bg = Instance.new("BillboardGui", part)
    bg.Name = "CustomESP"
    bg.Size = UDim2.new(0, 120, 0, 30)
    bg.AlwaysOnTop = true
    bg.StudsOffset = Vector3.new(0, 3, 0)

    local lbl = Instance.new("TextLabel", bg)
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = color
    lbl.TextStrokeTransparency = 0
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 12
end

local function ClearESP(tagText)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "CustomESP" and obj:FindFirstChildOfClass("TextLabel") then
            if string.find(obj:FindFirstChildOfClass("TextLabel").Text, tagText) then
                obj:Destroy()
            end
        end
    end
end

-- Loop de Atualização do ESP
task.spawn(function()
    while task.wait(2) do
        pcall(function()
            if getgenv().Config.ESPFruits then
                for _, obj in pairs(workspace:GetChildren()) do
                    if string.find(obj.Name, "Fruit") and obj:FindFirstChild("Handle") then
                        ApplyESP(obj.Handle, "[FRUTA] " .. obj.Name, Color3.fromRGB(255, 80, 80))
                    end
                end
            else
                ClearESP("[FRUTA]")
            end

            if getgenv().Config.ESPChests then
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and string.find(obj.Name, "Chest") then
                        ApplyESP(obj, "[BAÚ]", Color3.fromRGB(255, 215, 0))
                    end
                end
            else
                ClearESP("[BAÚ]")
            end

            if getgenv().Config.ESPBerries then
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and string.find(obj.Name, "Berry") then
                        ApplyESP(obj, "[BERRY]", Color3.fromRGB(180, 90, 255))
                    end
                end
            else
                ClearESP("[BERRY]")
            end

            if getgenv().Config.ESPPlayers then
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                        ApplyESP(plr.Character.Head, "[PLAYER] " .. plr.Name, Color3.fromRGB(80, 220, 255))
                    end
                end
            else
                ClearESP("[PLAYER]")
            end
        end)
    end
end)

LocalPlayer.Idled:Connect(function()
    if getgenv().Config.AntiAFK then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

task.spawn(function()
    while task.wait(0.2) do
        pcall(function()
            local water = workspace.Map:FindFirstChild("WaterBase-Plane")
            if water then
                water.Size = getgenv().Config.WalkOnWater and Vector3.new(1000, 112, 1000) or Vector3.new(1000, 80, 1000)
            end
            if getgenv().Config.CustomSpeed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().Config.WalkSpeed
            end
            if getgenv().Config.AutoLookMoon then
                local moonDir = Lighting:GetMoonDirection()
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, workspace.CurrentCamera.CFrame.Position + moonDir)
            end
        end)
    end
end)

-- =========================================================================
-- 3. LOOPS DE AUTOMAÇÃO (LEVEL, VULCÃO, SEA DRIVE, PESCA & RAIDS)
-- =========================================================================

task.spawn(function()
    while task.wait(0.5) do
        if getgenv().Config.AutoStats and LocalPlayer.Data.Points.Value > 0 then
            pcall(function() CommF:InvokeServer("AddPoint", getgenv().Config.StatTarget, 1) end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if getgenv().Config.AutoFarmLevel then
            pcall(function()
                local questInfo = GetCurrentQuest()
                local questGui = LocalPlayer.PlayerGui.Main.Quest
                if getgenv().Config.FarmMethod == "Quest" and not questGui.Visible then
                    TweenTo(questInfo.Pos)
                    if (LocalPlayer.Character.HumanoidRootPart.Position - questInfo.Pos.Position).Magnitude < 20 then
                        CommF:InvokeServer("StartQuest", questInfo.Quest, questInfo.Level)
                    end
                else
                    for _, mob in pairs(workspace.Enemies:GetChildren()) do
                        local isTarget = (getgenv().Config.FarmMethod == "Nearest") or (mob.Name == questInfo.Mob)
                        if isTarget and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and mob:FindFirstChild("HumanoidRootPart") then
                            repeat
                                task.wait()
                                local root = LocalPlayer.Character.HumanoidRootPart
                                local mobPos = mob.HumanoidRootPart.Position
                                root.CFrame = CFrame.new(mobPos + Vector3.new(0, getgenv().Config.FarmDistance, 0), mobPos)
                                BringEnemies(mob.Name, mobPos)
                                DoAttack()
                            until not getgenv().Config.AutoFarmLevel or not mob.Parent or mob.Humanoid.Health <= 0
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            if getgenv().Config.AutoChest then
                for _, obj in pairs(workspace:GetDescendants()) do
                    if not getgenv().Config.AutoChest then break end
                    if obj:IsA("BasePart") and string.find(obj.Name, "Chest") then
                        TweenTo(obj.CFrame)
                        task.wait(0.4)
                    end
                end
            end
            if getgenv().Config.AutoFruits then
                for _, obj in pairs(workspace:GetChildren()) do
                    if string.find(obj.Name, "Fruit") and obj:FindFirstChild("Handle") then
                        TweenTo(obj.Handle.CFrame)
                    end
                end
            end
            if getgenv().Config.AutoRollFruit then CommF:InvokeServer("Cousin", "Buy") end
            if getgenv().Config.AutoStoreFruit then
                for _, item in pairs(LocalPlayer.Backpack:GetChildren()) do
                    if string.find(item.Name, "Fruit") then
                        CommF:InvokeServer("StoreFruit", item:GetAttribute("OriginalName") or item.Name, item)
                    end
                end
            end
        end)
    end
end)

-- Dragon Update & Vulcão
task.spawn(function()
    while task.wait(0.2) do
        pcall(function()
            local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not root then return end

            if getgenv().Config.AutoPrehistoric then
                for _, mob in pairs(workspace.Enemies:GetChildren()) do
                    if string.find(mob.Name, "Lava Golem") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                        root.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 16, 0)
                        DoAttack()
                    end
                end
            end
            if getgenv().Config.AutoCollectDragonEggs then
                for _, obj in pairs(workspace:GetDescendants()) do
                    if string.find(obj.Name, "DragonEgg") and obj:IsA("BasePart") then TweenTo(obj.CFrame) end
                end
            end
            if getgenv().Config.AutoCollectBerries then
                for _, obj in pairs(workspace:GetDescendants()) do
                    if string.find(obj.Name, "Berry") and obj:IsA("BasePart") then TweenTo(obj.CFrame) end
                end
            end
        end)
    end
end)

-- Sea Events, Auto Drive (Navegar até Zona 6) & Auto Fishing
task.spawn(function()
    while task.wait(0.2) do
        pcall(function()
            local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not root then return end

            -- Auto Drive: Move o barco sentado em direção ao mar aberto (Zona 6 - Oeste)
            if getgenv().Config.AutoDriveSea then
                local seat = LocalPlayer.Character.Humanoid.SeatPart
                if seat and seat:IsA("VehicleSeat") then
                    seat.Parent:PivotTo(seat.Parent:GetPivot() * CFrame.new(0, 0, -4))
                end
            end

            -- Auto Fishing (Equipa vara e clica)
            if getgenv().Config.AutoFishing then
                for _, item in pairs(LocalPlayer.Backpack:GetChildren()) do
                    if string.find(item.Name, "Rod") then LocalPlayer.Character.Humanoid:EquipTool(item) end
                end
                VirtualUser:CaptureController()
                VirtualUser:Button1Down(Vector2.new(1280, 672))
            end

            if getgenv().Config.AutoTerrorShark then
                for _, mob in pairs(workspace.Enemies:GetChildren()) do
                    if string.find(mob.Name, "Terrorshark") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                        root.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 28, 0