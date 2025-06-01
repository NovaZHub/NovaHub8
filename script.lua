-- Carrega a biblioteca Orion
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- Cria a janela principal
local Window = OrionLib:MakeWindow({
	Name = "Nova Hub 2.0",
	HidePremium = false,
	SaveConfig = true,
	ConfigFolder = "NovaHubConfig",
	Icon = "rbxassetid://7797712589"
})

-- Notificação ao iniciar
OrionLib:MakeNotification({
	Name = "Nova Hub 2.0",
	Content = "Bem-vindo ao Nova Hub!",
	Image = "rbxassetid://7797712589",
	Time = 5
})

-- Aba de Auto Farm
local FarmTab = Window:MakeTab({
	Name = "🌽 Auto Farm",
	Icon = "rbxassetid://6035078882",
	PremiumOnly = false
})

FarmTab:AddToggle({
	Name = "Ativar Auto Farm",
	Default = false,
	Callback = function(Value)
		_G.AutoFarm = Value
		while _G.AutoFarm and task.wait(1) do
			print("🌱 Farmando...")
		end
	end
})

FarmTab:AddButton({
	Name = "Vender Tudo 💰",
	Callback = function()
		print("💰 Vendendo tudo...")
	end
})

-- Aba de Configurações
local ConfigTab = Window:MakeTab({
	Name = "⚙️ Configurações",
	Icon = "rbxassetid://6031280882",
	PremiumOnly = false
})

ConfigTab:AddSlider({
	Name = "Velocidade da Farm",
	Min = 0.1,
	Max = 5,
	Default = 1,
	Increment = 0.1,
	ValueName = "s",
	Callback = function(Value)
		print("Velocidade: " .. Value)
	end
})

-- Aba de Créditos
local CreditsTab = Window:MakeTab({
	Name = "👑 Créditos",
	Icon = "rbxassetid://6031280886",
	PremiumOnly = false
})

CreditsTab:AddParagraph("Créditos", "Feito por você 😎")

-- Iniciar a interface
OrionLib:Init()
