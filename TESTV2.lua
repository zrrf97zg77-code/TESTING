--// IVORY HUB
--// Clean Black & White Mobile GUI

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--// Remove old GUI
local Old = PlayerGui:FindFirstChild("IvoryHub")
if Old then
    Old:Destroy()
end

--// Main GUI
local Gui = Instance.new("ScreenGui")
Gui.Name = "IvoryHub"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.Parent = PlayerGui

--// Colors
local BLACK = Color3.fromRGB(12, 12, 12)
local DARK = Color3.fromRGB(20, 20, 20)
local WHITE = Color3.fromRGB(245, 245, 245)
local GRAY = Color3.fromRGB(150, 150, 150)
local LIGHT = Color3.fromRGB(35, 35, 35)

--// Main frame
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(520, 330)
Main.Position = UDim2.new(0.5, -260, 0.5, -165)
Main.BackgroundColor3 = BLACK
Main.BorderSizePixel = 0
Main.Parent = Gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = Main

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(55, 55, 55)
Stroke.Thickness = 1
Stroke.Parent = Main

--// Top bar
local Top = Instance.new("Frame")
Top.Size = UDim2.new(1, 0, 0, 58)
Top.BackgroundColor3 = DARK
Top.BorderSizePixel = 0
Top.Parent = Main

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 14)
TopCorner.Parent = Top

--// Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -120, 1, 0)
Title.Position = UDim2.fromOffset(20, 0)
Title.BackgroundTransparency = 1
Title.Text = "IVORY HUB"
Title.TextColor3 = WHITE
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Top

--// Subtitle
local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -120, 0, 16)
Subtitle.Position = UDim2.fromOffset(21, 32)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "clean • simple • ivory"
Subtitle.TextColor3 = GRAY
Subtitle.TextSize = 10
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Top

--// Close button
local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(38, 38)
Close.Position = UDim2.new(1, -48, 0, 10)
Close.BackgroundColor3 = LIGHT
Close.Text = "×"
Close.TextColor3 = WHITE
Close.TextSize = 24
Close.Font = Enum.Font.GothamMedium
Close.AutoButtonColor = false
Close.Parent = Top

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = Close

--// Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 135, 1, -78)
Sidebar.Position = UDim2.fromOffset(10, 68)
Sidebar.BackgroundColor3 = DARK
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 12)
SideCorner.Parent = Sidebar

local SideLayout = Instance.new("UIListLayout")
SideLayout.Padding = UDim.new(0, 7)
SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SideLayout.VerticalAlignment = Enum.VerticalAlignment.Top
SideLayout.Parent = Sidebar

local SidePadding = Instance.new("UIPadding")
SidePadding.PaddingTop = UDim.new(0, 10)
SidePadding.Parent = Sidebar

--// Content
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -165, 1, -78)
Content.Position = UDim2.fromOffset(155, 68)
Content.BackgroundColor3 = DARK
Content.BorderSizePixel = 0
Content.Parent = Main

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 12)
ContentCorner.Parent = Content

--// Pages
local Pages = {}

local function CreatePage(Name)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = Name
    Page.Size = UDim2.new(1, -20, 1, -20)
    Page.Position = UDim2.fromOffset(10, 10)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = GRAY
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.Visible = false
    Page.Parent = Content

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 8)
    Layout.Parent = Page

    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Page.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 10)
    end)

    Pages[Name] = Page
    return Page
end

--// Button creator
local function CreateButton(Parent, Text)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 45)
    Button.BackgroundColor3 = LIGHT
    Button.Text = Text
    Button.TextColor3 = WHITE
    Button.TextSize = 13
    Button.Font = Enum.Font.GothamMedium
    Button.AutoButtonColor = false
    Button.Parent = Parent

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 9)
    Corner.Parent = Button

    Button.MouseEnter:Connect(function()
        TweenService:Create(
            Button,
            TweenInfo.new(0.15),
            {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
        ):Play()
    end)

    Button.MouseLeave:Connect(function()
        TweenService:Create(
            Button,
            TweenInfo.new(0.15),
            {BackgroundColor3 = LIGHT}
        ):Play()
    end)

    return Button
end

--// Create pages
local Home = CreatePage("Home")
local Settings = CreatePage("Settings")
local Info = CreatePage("Info")

--// Home content
local Welcome = CreateButton(Home, "Welcome to Ivory Hub")
Welcome.TextSize = 15

local HomeButton1 = CreateButton(Home, "Example Button")
local HomeButton2 = CreateButton(Home, "Another Button")

--// Settings content
local SettingTitle = CreateButton(Settings, "SETTINGS")
SettingTitle.TextSize = 15

local Toggle = CreateButton(Settings, "Example Toggle     OFF")

local Enabled = false

Toggle.MouseButton1Click:Connect(function()
    Enabled = not Enabled

    if Enabled then
        Toggle.Text = "Example Toggle     ON"
        Toggle.BackgroundColor3 = WHITE
        Toggle.TextColor3 = BLACK
    else
        Toggle.Text = "Example Toggle     OFF"
        Toggle.BackgroundColor3 = LIGHT
        Toggle.TextColor3 = WHITE
    end
end)

--// Info content
local InfoButton = CreateButton(Info, "IVORY HUB")
InfoButton.TextSize = 17

local Version = CreateButton(Info, "Version 1.0")
local MadeFor = CreateButton(Info, "Black & White Edition")

--// Sidebar button creator
local function CreateTab(Text, Page)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -20, 0, 42)
    Button.BackgroundColor3 = LIGHT
    Button.Text = Text
    Button.TextColor3 = GRAY
    Button.TextSize = 12
    Button.Font = Enum.Font.GothamMedium
    Button.AutoButtonColor = false
    Button.Parent = Sidebar

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 9)
    Corner.Parent = Button

    Button.MouseButton1Click:Connect(function()
        for _, P in pairs(Pages) do
            P.Visible = false
        end

        Page.Visible = true

        for _, B in ipairs(Sidebar:GetChildren()) do
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

local HomeTab = CreateTab("Home", Home)
local SettingsTab = CreateTab("Settings", Settings)
local InfoTab = CreateTab("Info", Info)

--// Open default page
Home.Visible = true
HomeTab.BackgroundColor3 = WHITE
HomeTab.TextColor3 = BLACK

--// Minimized button
local Mini = Instance.new("TextButton")
Mini.Name = "IvoryMini"
Mini.Size = UDim2.fromOffset(55, 55)
Mini.Position = UDim2.fromOffset(18, 18)
Mini.BackgroundColor3 = BLACK
Mini.Text = "I"
Mini.TextColor3 = WHITE
Mini.TextSize = 22
Mini.Font = Enum.Font.GothamBold
Mini.Visible = false
Mini.AutoButtonColor = false
Mini.Parent = Gui

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(0, 14)
MiniCorner.Parent = Mini

local MiniStroke = Instance.new("UIStroke")
MiniStroke.Color = WHITE
MiniStroke.Thickness = 1
MiniStroke.Parent = Mini

--// Close animation
Close.MouseButton1Click:Connect(function()
    local Tween = TweenService:Create(
        Main,
        TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
        {
            Size = UDim2.fromOffset(0, 0),
            BackgroundTransparency = 1
        }
    )

    Tween:Play()

    Tween.Completed:Connect(function()
        Main.Visible = false
        Main.Size = UDim2.fromOffset(520, 330)
        Main.BackgroundTransparency = 0
        Mini.Visible = true
    end)
end)

--// Reopen
Mini.MouseButton1Click:Connect(function()
    Mini.Visible = false
    Main.Visible = true
    Main.Size = UDim2.fromOffset(0, 0)

    TweenService:Create(
        Main,
        TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {
            Size = UDim2.fromOffset(520, 330)
        }
    ):Play()
end)

--// Dragging
local Dragging = false
local DragStart
local StartPos

Top.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true
        DragStart = Input.Position
        StartPos = Main.Position

        Input.Changed:Connect(function()
            if Input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if Dragging and (
        Input.UserInputType == Enum.UserInputType.MouseMovement
        or Input.UserInputType == Enum.UserInputType.Touch
    ) then

        local Delta = Input.Position - DragStart

        Main.Position = UDim2.new(
            StartPos.X.Scale,
            StartPos.X.Offset + Delta.X,
            StartPos.Y.Scale,
            StartPos.Y.Offset + Delta.Y
        )
    end
end)
