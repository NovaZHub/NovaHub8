local allowedPlaceIds = {
    [10622089237] = true -- Grow a Garden
}

if not allowedPlaceIds[game.PlaceId] then
    game.Players.LocalPlayer:Kick("Esse script só funciona em Grow a Garden.")
end

-- Carrega a Orion Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- Janela principal
local Window = OrionLib:MakeWindow({
    Name = "Novax | Grow a Garden",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "NovaxGrowConfig"
})

-- Variáveis
_G.autoFarm = false
_G.autoSell = false
_G.autoBuy = false

-- Funções
function AutoFarm()
    while _G.autoFarm do
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "ClickDetector" and v.Parent:FindFirstChild("Crop") then
                fireclickdetector(v)
            end
        end
        wait(2)
    end
end

function AutoSell()
    while _G.autoSell do
        local args = {
            [1] = "Sell"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Server"):FireServer(unpack(args))
        wait(5)
    end
end

function AutoBuy()
    while _G.autoBuy do
        local args = {
            [1] = "Buy",
            [2] = "Seed"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Server"):FireServer(unpack(args))
        wait(10)
    end
end

-- Aba: Automação
local Tab = Window:MakeTab({
    Name = "Auto Farm",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

Tab:AddToggle({
    Name = "Auto Farm (Plantar + Colher)",
    Default = false,
    Callback = function(Value)
        _G.autoFarm = Value
        if Value then
            AutoFarm()
        end
    end
})

Tab:AddToggle({
    Name = "Auto Sell",
    Default = false,
    Callback = function(Value)
        _G.autoSell = Value
        if Value then
            AutoSell()
        end
    end
})

Tab:AddToggle({
    Name = "Auto Buy Seeds",
    Default = false,
    Callback = function(Value)
        _G.autoBuy = Value
        if Value then
            AutoBuy()
        end
    end
})

-- Anti-AFK
Tab:AddButton({
    Name = "Ativar Anti-AFK",
    Callback = function()
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
        OrionLib:MakeNotification({
            Name = "Anti-AFK Ativado",
            Content = "Você não será desconectado por inatividade.",
            Time = 5
        })
    end
})

-- Créditos
local CreditTab = Window:MakeTab({
    Name = "Créditos",
    Icon = "rbxassetid://7733658504",
    PremiumOnly = false
})

CreditTab:AddParagraph("Feito por:", "NovaxHuv com base no Tbao Hub")
