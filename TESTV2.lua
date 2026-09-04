--// IVORY HUB
--// Black & White UI with Integrated Aimbot

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local mouse = player:GetMouse()

local PlayerGui = player:WaitForChild("PlayerGui")

local Old = PlayerGui:FindFirstChild("IvoryHub")
if Old then Old:Destroy() end

--// COLORS
local BLACK = Color3.fromRGB(10,10,10)
local DARK = Color3.fromRGB(17,17,17)
local LIGHT = Color3.fromRGB(30,30,30)
local WHITE = Color3.fromRGB(245,245,245)
local GRAY = Color3.fromRGB(145,145,145)

--// GUI
local Gui = Instance.new("ScreenGui")
Gui.Name = "IvoryHub"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.Parent = PlayerGui

--// MAIN
local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(520,330)
Main.Position = UDim2.new(.5,-260,.5,-165)
Main.BackgroundColor3 = BLACK
Main.BorderSizePixel = 0
Main.Parent = Gui

Instance.new("UICorner",Main).CornerRadius = UDim.new(0,14)

local MainStroke = Instance.new("UIStroke",Main)
MainStroke.Color = Color3.fromRGB(55,55,55)
MainStroke.Thickness = 1

--// TOP
local Top = Instance.new("Frame")
Top.Size = UDim2.new(1,0,0,58)
Top.BackgroundColor3 = DARK
Top.BorderSizePixel = 0
Top.Parent = Main

Instance.new("UICorner",Top).CornerRadius = UDim.new(0,14)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-100,0,28)
Title.Position = UDim2.fromOffset(18,7)
Title.BackgroundTransparency = 1
Title.Text = "IVORY HUB"
Title.TextColor3 = WHITE
Title.TextSize = 19
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Top

local Sub = Instance.new("TextLabel")
Sub.Size = UDim2.new(1,-100,0,18)
Sub.Position = UDim2.fromOffset(19,32)
Sub.BackgroundTransparency = 1
Sub.Text = "clean • simple • ivory"
Sub.TextColor3 = GRAY
Sub.TextSize = 9
Sub.Font = Enum.Font.Gotham
Sub.TextXAlignment = Enum.TextXAlignment.Left
Sub.Parent = Top

--// CLOSE
local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(35,35)
Close.Position = UDim2.new(1,-45,0,11)
Close.BackgroundColor3 = LIGHT
Close.Text = "×"
Close.TextColor3 = WHITE
Close.TextSize = 22
Close.Font = Enum.Font.Gotham
Close.AutoButtonColor = false
Close.Parent = Top

Instance.new("UICorner",Close).CornerRadius = UDim.new(0,9)

--// SIDEBAR
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Size = UDim2.new(0,135,1,-78)
Sidebar.Position = UDim2.fromOffset(10,68)
Sidebar.BackgroundColor3 = DARK
Sidebar.BorderSizePixel = 0
Sidebar.ScrollBarThickness = 2
Sidebar.ScrollBarImageColor3 = GRAY
Sidebar.CanvasSize = UDim2.new(0,0,0,0)
Sidebar.Parent = Main

Instance.new("UICorner",Sidebar).CornerRadius = UDim.new(0,11)

local SideLayout = Instance.new("UIListLayout")
SideLayout.Padding = UDim.new(0,6)
SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SideLayout.Parent = Sidebar

local SidePadding = Instance.new("UIPadding")
SidePadding.PaddingTop = UDim.new(0,9)
SidePadding.PaddingBottom = UDim.new(0,9)
SidePadding.Parent = Sidebar

SideLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Sidebar.CanvasSize = UDim2.new(0,0,0,SideLayout.AbsoluteContentSize.Y + 18)
end)

--// CONTENT
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1,-155,1,-78)
Content.Position = UDim2.fromOffset(155,68)
Content.BackgroundColor3 = DARK
Content.BorderSizePixel = 0
Content.Parent = Main

Instance.new("UICorner",Content).CornerRadius = UDim.new(0,11)

--// PAGES
local Pages = {}

local function CreatePage(Name)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = Name
    Page.Size = UDim2.new(1,-20,1,-20)
    Page.Position = UDim2.fromOffset(10,10)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 2
    Page.ScrollBarImageColor3 = GRAY
    Page.CanvasSize = UDim2.new(0,0,0,0)
    Page.Visible = false
    Page.Parent = Content

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0,8)
    Layout.Parent = Page

    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Page.CanvasSize = UDim2.new(0,0,0,Layout.AbsoluteContentSize.Y + 10)
    end)

    Pages[Name] = Page
    return Page
end

--// BUTTON HELPER
local function CreateButton(Parent,Text,Color)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1,0,0,42)
    Button.BackgroundColor3 = Color or LIGHT
    Button.BorderSizePixel = 0
    Button.Text = Text
    Button.TextColor3 = WHITE
    Button.TextSize = 12
    Button.Font = Enum.Font.GothamMedium
    Button.AutoButtonColor = false
    Button.Parent = Parent

    Instance.new("UICorner",Button).CornerRadius = UDim.new(0,8)

    Button.MouseEnter:Connect(function()
        TweenService:Create(
            Button,
            TweenInfo.new(.12),
            {BackgroundColor3 = Color3.fromRGB(45,45,45)}
        ):Play()
    end)

    Button.MouseLeave:Connect(function()
        TweenService:Create(
            Button,
            TweenInfo.new(.12),
            {BackgroundColor3 = Color or LIGHT}
        ):Play()
    end)

    return Button
end

--// CREATE TABS
local Home = CreatePage("Home")
local MainPage = CreatePage("Main")
local AimbotPage = CreatePage("Aimbot")   -- NEW
local Visuals = CreatePage("Visuals")
local PlayersPage = CreatePage("Players")
local Teleports = CreatePage("Teleports")
local Settings = CreatePage("Settings")
local Info = CreatePage("Info")
local Credits = CreatePage("Credits")

--// CREATE TAB BUTTONS
local function CreateTab(Text,Page)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1,-18,0,39)
    Button.BackgroundColor3 = LIGHT
    Button.BorderSizePixel = 0
    Button.Text = Text
    Button.TextColor3 = GRAY
    Button.TextSize = 11
    Button.Font = Enum.Font.GothamMedium
    Button.AutoButtonColor = false
    Button.Parent = Sidebar

    Instance.new("UICorner",Button).CornerRadius = UDim.new(0,8)

    Button.MouseButton1Click:Connect(function()
        for _,P in pairs(Pages) do P.Visible = false end
        Page.Visible = true
        for _,B in ipairs(Sidebar:GetChildren()) do
            if B:IsA("TextButton") then
                B.BackgroundColor3 = LIGHT
                B.TextColor3 = GRAY
            end
        end
        Button.BackgroundColor3 = WHITE
        Button.TextColor3 = BLACK
    end)

    return Button
end

local HomeTab = CreateTab("Home",Home)
CreateTab("Main",MainPage)
CreateTab("Aimbot",AimbotPage)  -- NEW
CreateTab("Visuals",Visuals)
CreateTab("Players",PlayersPage)
CreateTab("Teleports",Teleports)
CreateTab("Settings",Settings)
CreateTab("Info",Info)
CreateTab("Credits",Credits)

Home.Visible = true
HomeTab.BackgroundColor3 = WHITE
HomeTab.TextColor3 = BLACK

--// SMALL TOGGLE BUTTON
local Toggle = Instance.new("TextButton")
Toggle.Name = "IvoryToggle"
Toggle.Size = UDim2.fromOffset(44,44)
Toggle.Position = UDim2.fromOffset(15,15)
Toggle.BackgroundColor3 = BLACK
Toggle.BorderSizePixel = 0
Toggle.Text = "I"
Toggle.TextColor3 = WHITE
Toggle.TextSize = 18
Toggle.Font = Enum.Font.GothamBold
Toggle.AutoButtonColor = false
Toggle.Parent = Gui

Instance.new("UICorner",Toggle).CornerRadius = UDim.new(0,12)

local ToggleStroke = Instance.new("UIStroke",Toggle)
ToggleStroke.Color = WHITE
ToggleStroke.Thickness = 1

--// DRAG FUNCTION
local function MakeDraggable(Object)
    local Dragging = false
    local DragStart
    local StartPosition

    Object.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = Input.Position
            StartPosition = Object.Position
            Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)

    UIS.InputChanged:Connect(function(Input)
        if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
            local Delta = Input.Position - DragStart
            Object.Position = UDim2.new(
                StartPosition.X.Scale,
                StartPosition.X.Offset + Delta.X,
                StartPosition.Y.Scale,
                StartPosition.Y.Offset + Delta.Y
            )
        end
    end)
end

MakeDraggable(Main)
MakeDraggable(Toggle)

--// OPEN/CLOSE
local Open = true

local function OpenGUI()
    Open = true
    Main.Visible = true
    Main.Size = UDim2.fromOffset(0,0)
    TweenService:Create(Main,TweenInfo.new(.3,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Size = UDim2.fromOffset(520,330)}):Play()
end

local function CloseGUI()
    Open = false
    local Tween = TweenService:Create(Main,TweenInfo.new(.25,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{Size = UDim2.fromOffset(0,0)})
    Tween:Play()
    Tween.Completed:Connect(function()
        Main.Visible = false
    end)
end

Toggle.MouseButton1Click:Connect(function()
    if Open then CloseGUI() else OpenGUI() end
end)

Close.MouseButton1Click:Connect(function()
    CloseGUI()
end)

-- ==================================================================
--                      IVORY AIMBOT INTEGRATION
-- ==================================================================

--// Aimbot configuration
local aimbotEnabled = false
local maxDistance = 3000
local targetPartName = "HumanoidRootPart"
local teamCheck = true
local showLine = true
local targetPlayers = true
local targetNPCs = true
local showFOV = false
local soruAimbot = false
local aimbotF = false   -- false = F excluded
local currentTarget = nil
local lastKey = nil

--// Drawing support (optional)
local hasDrawing = pcall(function()
    local c = Drawing.new("Circle")
    c:Remove()
    return true
end)

local FOVCircle, TargetLine
if hasDrawing then
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Visible = false
    FOVCircle.Color = Color3.fromRGB(255,255,0)
    FOVCircle.Radius = 150
    FOVCircle.Thickness = 2
    FOVCircle.Filled = false
    FOVCircle.Transparency = 0.5

    TargetLine = Drawing.new("Line")
    TargetLine.Visible = false
    TargetLine.Color = Color3.fromRGB(255,0,0)
    TargetLine.Thickness = 2
    TargetLine.Transparency = 0.6
end

--// Build Aimbot Page UI
local function createAimbotUI()
    -- Title label
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1,0,0,30)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "AIMBOT SETTINGS"
    titleLabel.TextColor3 = WHITE
    titleLabel.TextSize = 14
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Parent = AimbotPage

    -- Toggle ON/OFF
    local toggleBtn = CreateButton(AimbotPage, "AIMBOT: OFF", LIGHT)
    toggleBtn.BackgroundColor3 = LIGHT
    toggleBtn.MouseButton1Click:Connect(function()
        aimbotEnabled = not aimbotEnabled
        toggleBtn.Text = aimbotEnabled and "AIMBOT: ON" or "AIMBOT: OFF"
        toggleBtn.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(0,180,0) or LIGHT
        if FOVCircle then FOVCircle.Visible = (aimbotEnabled and showFOV) end
        if TargetLine then TargetLine.Visible = (aimbotEnabled and showLine) end
        updateTargetLabel()
    end)

    -- Players toggle
    local playersBtn = CreateButton(AimbotPage, "TARGET PLAYERS: ON", LIGHT)
    playersBtn.BackgroundColor3 = Color3.fromRGB(0,180,0)
    playersBtn.MouseButton1Click:Connect(function()
        targetPlayers = not targetPlayers
        playersBtn.Text = targetPlayers and "TARGET PLAYERS: ON" or "TARGET PLAYERS: OFF"
        playersBtn.BackgroundColor3 = targetPlayers and Color3.fromRGB(0,180,0) or LIGHT
    end)

    -- NPCs toggle
    local npcsBtn = CreateButton(AimbotPage, "TARGET NPCS: ON", LIGHT)
    npcsBtn.BackgroundColor3 = Color3.fromRGB(0,180,0)
    npcsBtn.MouseButton1Click:Connect(function()
        targetNPCs = not targetNPCs
        npcsBtn.Text = targetNPCs and "TARGET NPCS: ON" or "TARGET NPCS: OFF"
        npcsBtn.BackgroundColor3 = targetNPCs and Color3.fromRGB(0,180,0) or LIGHT
    end)

    -- Soru Aimbot toggle
    local soruBtn = CreateButton(AimbotPage, "SORU TELEPORT: OFF", LIGHT)
    soruBtn.MouseButton1Click:Connect(function()
        soruAimbot = not soruAimbot
        soruBtn.Text = soruAimbot and "SORU TELEPORT: ON" or "SORU TELEPORT: OFF"
        soruBtn.BackgroundColor3 = soruAimbot and Color3.fromRGB(0,180,0) or LIGHT
    end)

    -- F exclusion toggle
    local fBtn = CreateButton(AimbotPage, "F SKILL: EXCLUDED", LIGHT)
    fBtn.BackgroundColor3 = Color3.fromRGB(0,180,0)
    fBtn.MouseButton1Click:Connect(function()
        aimbotF = not aimbotF
        fBtn.Text = aimbotF and "F SKILL: AIMED" or "F SKILL: EXCLUDED"
        fBtn.BackgroundColor3 = aimbotF and Color3.fromRGB(0,180,0) or LIGHT
    end)

    -- Distance label & slider
    local distFrame = Instance.new("Frame")
    distFrame.Size = UDim2.new(1,0,0,40)
    distFrame.BackgroundTransparency = 1
    distFrame.Parent = AimbotPage

    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(0.6,0,1,0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = "DISTANCE: " .. maxDistance
    distLabel.TextColor3 = WHITE
    distLabel.TextSize = 11
    distLabel.Font = Enum.Font.GothamBold
    distLabel.TextXAlignment = Enum.TextXAlignment.Left
    distLabel.Parent = distFrame

    local minusBtn = Instance.new("TextButton")
    minusBtn.Size = UDim2.new(0,30,0,30)
    minusBtn.Position = UDim2.new(0.7,0,0.5,-15)
    minusBtn.BackgroundColor3 = LIGHT
    minusBtn.Text = "-"
    minusBtn.TextColor3 = WHITE
    minusBtn.TextSize = 14
    minusBtn.Font = Enum.Font.GothamBold
    minusBtn.AutoButtonColor = false
    minusBtn.Parent = distFrame
    Instance.new("UICorner",minusBtn).CornerRadius = UDim.new(0,6)

    local distVal = Instance.new("TextLabel")
    distVal.Size = UDim2.new(0,40,0,30)
    distVal.Position = UDim2.new(0.8,0,0.5,-15)
    distVal.BackgroundTransparency = 1
    distVal.Text = tostring(maxDistance)
    distVal.TextColor3 = WHITE
    distVal.TextSize = 12
    distVal.Font = Enum.Font.GothamBold
    distVal.TextXAlignment = Enum.TextXAlignment.Center
    distVal.Parent = distFrame

    local plusBtn = Instance.new("TextButton")
    plusBtn.Size = UDim2.new(0,30,0,30)
    plusBtn.Position = UDim2.new(0.9,0,0.5,-15)
    plusBtn.BackgroundColor3 = LIGHT
    plusBtn.Text = "+"
    plusBtn.TextColor3 = WHITE
    plusBtn.TextSize = 14
    plusBtn.Font = Enum.Font.GothamBold
    plusBtn.AutoButtonColor = false
    plusBtn.Parent = distFrame
    Instance.new("UICorner",plusBtn).CornerRadius = UDim.new(0,6)

    minusBtn.MouseButton1Click:Connect(function()
        maxDistance = math.max(500, maxDistance - 100)
        distVal.Text = tostring(maxDistance)
        distLabel.Text = "DISTANCE: " .. maxDistance
    end)

    plusBtn.MouseButton1Click:Connect(function()
        maxDistance = math.min(5000, maxDistance + 100)
        distVal.Text = tostring(maxDistance)
        distLabel.Text = "DISTANCE: " .. maxDistance
    end)

    -- Line toggle
    local lineBtn = CreateButton(AimbotPage, "TARGET LINE: ON", LIGHT)
    lineBtn.BackgroundColor3 = Color3.fromRGB(0,180,0)
    lineBtn.MouseButton1Click:Connect(function()
        showLine = not showLine
        lineBtn.Text = showLine and "TARGET LINE: ON" or "TARGET LINE: OFF"
        lineBtn.BackgroundColor3 = showLine and Color3.fromRGB(0,180,0) or LIGHT
        if TargetLine then TargetLine.Visible = (aimbotEnabled and showLine) end
    end)

    -- FOV circle toggle (only if Drawing available)
    if hasDrawing then
        local fovBtn = CreateButton(AimbotPage, "FOV CIRCLE: OFF", LIGHT)
        fovBtn.MouseButton1Click:Connect(function()
            showFOV = not showFOV
            fovBtn.Text = showFOV and "FOV CIRCLE: ON" or "FOV CIRCLE: OFF"
            fovBtn.BackgroundColor3 = showFOV and Color3.fromRGB(0,180,0) or LIGHT
            if FOVCircle then FOVCircle.Visible = (aimbotEnabled and showFOV) end
        end)
    end

    -- Target status label
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1,0,0,20)
    statusLabel.Position = UDim2.new(0,0,1,-20)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Target: None"
    statusLabel.TextColor3 = GRAY
    statusLabel.TextSize = 9
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.Parent = AimbotPage

    -- Return controls for updating
    return {
        status = statusLabel
    }
end

local aimbotUI = createAimbotUI()

--// Update target label
function updateTargetLabel()
    if aimbotEnabled and currentTarget then
        local name = "Unknown"
        local parent = currentTarget.Parent
        if parent then
            local p = Players:GetPlayerFromCharacter(parent)
            if p then name = p.Name else name = parent.Name end
        end
        aimbotUI.status.Text = "Target: " .. name
        aimbotUI.status.TextColor3 = Color3.fromRGB(0,255,100)
    else
        aimbotUI.status.Text = "Target: None"
        aimbotUI.status.TextColor3 = GRAY
    end
end

--// Aimbot core logic
function isIn180FOV(pos)
    if not pos or not camera then return false end
    local look = camera.CFrame.LookVector
    local char = player.Character
    if not char then return false end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return false end
    local dir = (pos - root.Position).Unit
    return look:Dot(dir) >= 0
end

function getScreenCenterDist(pos)
    if not pos or not camera then return math.huge end
    local sp, on = camera:WorldToViewportPoint(pos)
    if not on then return math.huge end
    local center = camera.ViewportSize / 2
    return (Vector2.new(sp.X, sp.Y) - center).Magnitude
end

function getClosestEnemy()
    local char = player.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local myPos = root.Position

    local best, bestScore = nil, math.huge

    if targetPlayers then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= player and p.Character then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                local part = p.Character:FindFirstChild(targetPartName) or p.Character:FindFirstChild("HumanoidRootPart")
                if hum and hum.Health > 0 and part then
                    if teamCheck and player.Team and p.Team and player.Team == p.Team then continue end
                    local pos = part.Position
                    local dist = (pos - myPos).Magnitude
                    if dist <= maxDistance and isIn180FOV(pos) then
                        local score = getScreenCenterDist(pos) + dist * 0.001
                        if score < bestScore then
                            bestScore, best = score, part
                        end
                    end
                end
            end
        end
    end

    if targetNPCs then
        local enemies = workspace:FindFirstChild("Enemies")
        if enemies then
            for _, npc in pairs(enemies:GetChildren()) do
                if npc:IsA("Model") then
                    local hum = npc:FindFirstChildOfClass("Humanoid")
                    local part = npc:FindFirstChild(targetPartName) or npc:FindFirstChild("HumanoidRootPart")
                    if hum and hum.Health > 0 and part then
                        local pos = part.Position
                        local dist = (pos - myPos).Magnitude
                        if dist <= maxDistance and isIn180FOV(pos) then
                            local score = getScreenCenterDist(pos) + dist * 0.001
                            if score < bestScore then
                                bestScore, best = score, part
                            end
                        end
                    end
                end
            end
        end
    end

    return best
end

--// Update target
RunService.Heartbeat:Connect(function()
    if aimbotEnabled then
        currentTarget = getClosestEnemy()
    else
        currentTarget = nil
    end
    updateTargetLabel()
end)

--// Visual updates
RunService.RenderStepped:Connect(function()
    if not camera then return end

    if FOVCircle then
        if aimbotEnabled and showFOV then
            FOVCircle.Visible = true
            local viewport = camera.ViewportSize
            FOVCircle.Position = Vector2.new(viewport.X/2, viewport.Y/2)
        else
            FOVCircle.Visible = false
        end
    end

    if TargetLine then
        if aimbotEnabled and showLine and currentTarget then
            local screenPos, onScreen = camera:WorldToViewportPoint(currentTarget.Position)
            if onScreen then
                local viewport = camera.ViewportSize
                local center = Vector2.new(viewport.X/2, viewport.Y/2)
                TargetLine.From = center
                TargetLine.To = Vector2.new(screenPos.X, screenPos.Y)
                TargetLine.Visible = true
            else
                TargetLine.Visible = false
            end
        else
            TargetLine.Visible = false
        end
    end
end)

--// Silent Aim Hooks
if mouse then
    local mt = getrawmetatable(game)
    if mt then
        local oldIndex = mt.__index
        setreadonly(mt, false)
        mt.__index = newcclosure(function(self, key)
            if not checkcaller() and self == mouse and (key == "Hit" or key == "Target") then
                if aimbotEnabled and currentTarget then
                    if not aimbotF and lastKey == "F" then
                        return oldIndex(self, key)
                    end
                    if key == "Hit" then
                        return CFrame.new(currentTarget.Position)
                    elseif key == "Target" then
                        return currentTarget
                    end
                end
            end
            return oldIndex(self, key)
        end)
        setreadonly(mt, true)
    end
end

--// Override remotes
local function overrideRemote(remote)
    if remote:IsA("RemoteEvent") then
        local oldFire = remote.FireServer
        remote.FireServer = function(self, ...)
            if aimbotEnabled and currentTarget then
                local args = {...}
                local isF = false
                for _, arg in ipairs(args) do
                    if typeof(arg) == "string" and string.upper(arg) == "F" then
                        isF = true
                        break
                    end
                end
                if not aimbotF and isF then
                    return oldFire(self, ...)
                end
                local targetPos = currentTarget.Position
                for i, arg in ipairs(args) do
                    if typeof(arg) == "Vector3" then
                        args[i] = targetPos
                    elseif typeof(arg) == "CFrame" then
                        args[i] = CFrame.new(targetPos)
                    end
                end
                local name = self.Name
                if name == "RE/RegisterHit" or name == "RegisterHit" then
                    local targetChar = currentTarget.Parent
                    if targetChar then
                        args[1] = currentTarget
                        args[2] = { { targetChar, currentTarget } }
                    end
                elseif name == "RE/RegisterAttack" or name == "RegisterAttack" then
                    local targetChar = currentTarget.Parent
                    if targetChar then
                        args[2] = { { targetChar, currentTarget } }
                    end
                elseif name == "RE/ShootGunEvent" or name == "ShootGunEvent" then
                    args[1] = targetPos
                    if currentTarget.Parent then
                        args[2] = { currentTarget.Parent }
                    end
                end
                return oldFire(self, unpack(args))
            end
            return oldFire(self, ...)
        end
    elseif remote:IsA("RemoteFunction") then
        local oldInvoke = remote.InvokeServer
        remote.InvokeServer = function(self, ...)
            if aimbotEnabled and currentTarget then
                local args = {...}
                local isF = false
                for _, arg in ipairs(args) do
                    if typeof(arg) == "string" and string.upper(arg) == "F" then
                        isF = true
                        break
                    end
                end
                if not aimbotF and isF then
                    return oldInvoke(self, ...)
                end
                local targetPos = currentTarget.Position
                for i, arg in ipairs(args) do
                    if typeof(arg) == "Vector3" then
                        args[i] = targetPos
                    elseif typeof(arg) == "CFrame" then
                        args[i] = CFrame.new(targetPos)
                    end
                end
                return oldInvoke(self, unpack(args))
            end
            return oldInvoke(self, ...)
        end
    end
end

task.spawn(function()
    for _, remote in ipairs(ReplicatedStorage:GetDescendants()) do
        if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
            overrideRemote(remote)
        end
    end
    ReplicatedStorage.DescendantAdded:Connect(overrideRemote)
end)

--// Fallback namecall
local oldNamecall
local mt2 = getrawmetatable(game)
if mt2 then
    oldNamecall = mt2.__namecall
    setreadonly(mt2, false)
    mt2.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if not checkcaller() and (method == "FireServer" or method == "InvokeServer") then
            if aimbotEnabled and currentTarget then
                local args = {...}
                local isF = false
                for _, arg in ipairs(args) do
                    if typeof(arg) == "string" and string.upper(arg) == "F" then
                        isF = true
                        break
                    end
                end
                if not aimbotF and isF then
                    return oldNamecall(self, ...)
                end
                local targetPos = currentTarget.Position
                for i, arg in ipairs(args) do
                    if typeof(arg) == "Vector3" then
                        args[i] = targetPos
                    elseif typeof(arg) == "CFrame" then
                        args[i] = CFrame.new(targetPos)
                    end
                end
                return oldNamecall(self, unpack(args))
            end
        end
        return oldNamecall(self, ...)
    end)
    setreadonly(mt2, true)
end

--// Key detection for F exclusion
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.F then
        lastKey = "F"
    end
end)

--// Soru / Flashstep Aimbot
function doSoruTeleport()
    if not soruAimbot or not aimbotEnabled or not currentTarget then return end
    local targetPos = currentTarget.Position
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    hrp.CFrame = CFrame.new(targetPos)
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    if remotes then
        local commF = remotes:FindFirstChild("CommF_")
        if commF then
            pcall(function()
                commF:InvokeServer("Flashstep", targetPos)
            end)
        end
    end
end

local function onCharacterAdded(char)
    local hum = char:WaitForChild("Humanoid", 5)
    if not hum then return end
    hum.AnimationPlayed:Connect(function(track)
        local animName = track.Name
        if string.find(animName, "Flashstep") or string.find(animName, "Soru") or string.find(animName, "FlashStep") then
            task.spawn(doSoruTeleport)
        end
    end)
end

if player.Character then onCharacterAdded(player.Character) end
player.CharacterAdded:Connect(onCharacterAdded)

--// Global hotkey F5 to toggle aimbot
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.F5 then
        aimbotEnabled = not aimbotEnabled
        -- Update UI toggle button (find it by searching)
        for _, child in ipairs(AimbotPage:GetChildren()) do
            if child:IsA("TextButton") and string.sub(child.Text,1,6) == "AIMBOT" then
                child.Text = aimbotEnabled and "AIMBOT: ON" or "AIMBOT: OFF"
                child.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(0,180,0) or LIGHT
                break
            end
        end
        if FOVCircle then FOVCircle.Visible = (aimbotEnabled and showFOV) end
        if TargetLine then TargetLine.Visible = (aimbotEnabled and showLine) end
        updateTargetLabel()
    end
end)

print("✅ Ivory Hub loaded with Integrated Aimbot!")
print("📌 Press F5 to toggle aimbot.")
print("📌 F key excluded from aimbot by default.")
