local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/memejames/elerium-v2-ui-library//main/Library", true))()

local window = library:AddWindow("t.me/clientpython", {
	main_color = Color3.fromRGB(41, 74, 122), -- Color
	min_size = Vector2.new(250, 346), -- Size of the gui
	can_resize = true, -- true or false
})

local Main = window:AddTab("Main") -- Name of tab
Main:Show() -- shows the tab

Main:AddButton("Chams", function()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character then
            for _, part in pairs(player.Character:GetChildren()) do
                if part:IsA("BasePart") and not part:FindFirstChild("ChamsHighlight") then
                    local box = Instance.new("BoxHandleAdornment")
                    box.Name = "ChamsHighlight"
                    box.Adornee = part
                    box.AlwaysOnTop = true
                    box.ZIndex = 10
                    box.Size = part.Size + Vector3.new(0.1, 0.1, 0.1)
                    box.Color3 = Color3.new(1, 0, 0) -- Красный
                    box.Transparency = 0.5
                    box.Parent = part
                end
            end
        end
    end
end)

Main:AddButton("Enable ESP", function()
    local player = game.Players.LocalPlayer

    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            local head = otherPlayer.Character:FindFirstChild("Head")
            if head and not head:FindFirstChild("ESPLabel") then
                local billboard = Instance.new("BillboardGui")
                billboard.Name = "t.me/clientpython"
                billboard.Adornee = head
                billboard.Size = UDim2.new(0, 100, 0, 40)
                billboard.AlwaysOnTop = true
                billboard.StudsOffset = Vector3.new(0, 2, 0)

                local nameLabel = Instance.new("TextLabel")
                nameLabel.Parent = billboard
                nameLabel.Size = UDim2.new(1, 0, 1, 0)
                nameLabel.BackgroundTransparency = 1
                nameLabel.TextColor3 = Color3.new(1, 0, 0) -- Красный
                nameLabel.TextStrokeTransparency = 0.5
                nameLabel.TextScaled = true

                nameLabel.Text = otherPlayer.Name

                billboard.Parent = head

                -- Обновление расстояния
                game:GetService("RunService").RenderStepped:Connect(function()
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = math.floor((head.Position - player.Character.HumanoidRootPart.Position).Magnitude)
                        nameLabel.Text = string.format("%s [%sm]", otherPlayer.Name, dist)
                    end
                end)
            end
        end
    end
end)


local Misc = window:AddTab("Misc") -- Name of tab
Misc:Show() -- shows the tab

local flying = false
local speed = 50

local function toggleFly()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")

    if flying then
        flying = false
        hrp.Velocity = Vector3.zero
    else
        flying = true
    end

    local connection
    connection = game:GetService("RunService").RenderStepped:Connect(function()
        if not flying then
            connection:Disconnect()
            return
        end
        hrp.Velocity = Vector3.new(0, speed, 0)
    end)
end

local userInput = game:GetService("UserInputService")

if userInput.TouchEnabled and not userInput.KeyboardEnabled then
    
    Misc:AddButton("Toggle Fly (Mobile & PC)", function()
        toggleFly()
    end)
else
    
    Misc:AddLabel("NOTE: press F to Fly (PC)")

    userInput.InputBegan:Connect(function(input, gameProcessed)
        if input.KeyCode == Enum.KeyCode.F and not gameProcessed then
            toggleFly()
        end
    end)
end

local Credits = window:AddTab("Credits") -- Name of tab
Credits:Show() -- shows the tab

Credits:AddButton("Click to copy link",function()
	setclipboard("https://t.me/clientpython")
end)
