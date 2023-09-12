local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
local CombatFrameworkR = getupvalues(CombatFramework)[2]
local RigController = require(game:GetService("Players")["LocalPlayer"].PlayerScripts.CombatFramework.RigController)
local RigControllerR = getupvalues(RigController)[2]
local realbhit = require(game.ReplicatedStorage.CombatFramework.RigLib)
local cooldownfastattack = tick()

function CurrentWeapon()
	local ac = CombatFrameworkR.activeController
	local ret = ac.blades[1]
	if not ret then return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name end
	pcall(function()
		while ret.Parent~=game.Players.LocalPlayer.Character do ret=ret.Parent end
	end)
	if not ret then return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name end
	return ret
end

function getAllBladeHitsPlayers(Sizes)
	local Hits = {}
	local Client = game.Players.LocalPlayer
	local Characters = game:GetService("Workspace").Characters:GetChildren()
	for i=1,#Characters do local v = Characters[i]
		local Human = v:FindFirstChildOfClass("Humanoid")
		if v.Name ~= game.Players.LocalPlayer.Name and Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < Sizes+5 then
			table.insert(Hits,Human.RootPart)
		end
	end
	return Hits
end

function getAllBladeHits(Sizes)
	local Hits = {}
	local Client = game.Players.LocalPlayer
	local Enemies = game:GetService("Workspace").Enemies:GetChildren()
	for i=1,#Enemies do local v = Enemies[i]
		local Human = v:FindFirstChildOfClass("Humanoid")
		if Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < Sizes+5 then
			table.insert(Hits,Human.RootPart)
		end
	end
	return Hits
end

function AttackFunction()
	local ac = CombatFrameworkR.activeController
	if ac and ac.equipped then
		for indexincrement = 1, 1 do
			local bladehit = getAllBladeHits(60)
			if #bladehit > 0 then
				local AcAttack8 = debug.getupvalue(ac.attack, 5)
				local AcAttack9 = debug.getupvalue(ac.attack, 6)
				local AcAttack7 = debug.getupvalue(ac.attack, 4)
				local AcAttack10 = debug.getupvalue(ac.attack, 7)
				local NumberAc12 = (AcAttack8 * 798405 + AcAttack7 * 727595) % AcAttack9
				local NumberAc13 = AcAttack7 * 798405
				(function()
					NumberAc12 = (NumberAc12 * AcAttack9 + NumberAc13) % 1099511627776
					AcAttack8 = math.floor(NumberAc12 / AcAttack9)
					AcAttack7 = NumberAc12 - AcAttack8 * AcAttack9
				end)()
				AcAttack10 = AcAttack10 + 1
				debug.setupvalue(ac.attack, 5, AcAttack8)
				debug.setupvalue(ac.attack, 6, AcAttack9)
				debug.setupvalue(ac.attack, 4, AcAttack7)
				debug.setupvalue(ac.attack, 7, AcAttack10)
				for k, v in pairs(ac.animator.anims.basic) do
					v:Play(0.01,0.01,0.01)
				end                 
				if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and ac.blades and ac.blades[1] then 
					game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(CurrentWeapon()))
					game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(NumberAc12 / 1099511627776 * 16777215), AcAttack10)
					game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, 2, "") 
				end
			end
		end
	end
end
local plr = game.Players.LocalPlayer
           local CbFw = debug.getupvalues(require(plr.PlayerScripts.CombatFramework))
           local CbFw2 = CbFw[2]
           
           function GetCurrentBlade() 
               local p13 = CbFw2.activeController
               local ret = p13.blades[1]
               if not ret then return end
               while ret.Parent~=game.Players.LocalPlayer.Character do ret=ret.Parent end
               return ret
           end
           function AttackNoCD() 
               local AC = CbFw2.activeController
               for i = 1, 1 do 
                   local bladehit = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
                       plr.Character,
                       {plr.Character.HumanoidRootPart},
                       60
                   )
                       local cac = {}
                       local hash = {}
                       for k, v in pairs(bladehit) do
                           if v.Parent:FindFirstChild("HumanoidRootPart") and not hash[v.Parent] then
                               table.insert(cac, v.Parent.HumanoidRootPart)
                               hash[v.Parent] = true
                           end
                       end
                       bladehit = cac
                   if #bladehit > 0 then
                       local u8 = debug.getupvalue(AC.attack, 5)
                       local u9 = debug.getupvalue(AC.attack, 6)
                       local u7 = debug.getupvalue(AC.attack, 4)
                       local u10 = debug.getupvalue(AC.attack, 7)
                       local u12 = (u8 * 798405 + u7 * 727595) % u9
                       local u13 = u7 * 798405
                       (function()
                       u12 = (u12 * u9 + u13) % 1099511627776
                           u8 = math.floor(u12 / u9)
                           u7 = u12 - u8 * u9
                       end)()
                       u10 = u10 + 1
                       debug.setupvalue(AC.attack, 5, u8)
                       debug.setupvalue(AC.attack, 6, u9)
                       debug.setupvalue(AC.attack, 4, u7)
                       debug.setupvalue(AC.attack, 7, u10)
                       pcall(function()
                           for k, v in pairs(AC.animator.anims.basic) do
                               v:Play()
                           end                  
                       end)
                       if plr.Character:FindFirstChildOfClass("Tool") and AC.blades and AC.blades[1] then 
                           game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(GetCurrentBlade()))
                           game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(u12 / 1099511627776 * 16777215), u10)
                           game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, i, "") 
                       end
                   end
               end
           end
           function AttackNoCD2()
            local ac = CombatFrameworkR.activeController
            if ac and ac.equipped then
                for indexincrement = 1, 1 do
                    local bladehit = getAllBladeHits(60)
                    if #bladehit > 0 then
                        local AcAttack8 = debug.getupvalue(ac.attack, 5)
                        local AcAttack9 = debug.getupvalue(ac.attack, 6)
                        local AcAttack7 = debug.getupvalue(ac.attack, 4)
                        local AcAttack10 = debug.getupvalue(ac.attack, 7)
                        local NumberAc12 = (AcAttack8 * 798405 + AcAttack7 * 727595) % AcAttack9
                        local NumberAc13 = AcAttack7 * 798405
                        (function()
                            NumberAc12 = (NumberAc12 * AcAttack9 + NumberAc13) % 1099511627776
                            AcAttack8 = math.floor(NumberAc12 / AcAttack9)
                            AcAttack7 = NumberAc12 - AcAttack8 * AcAttack9
                        end)()
                        AcAttack10 = AcAttack10 + 1
                        debug.setupvalue(ac.attack, 5, AcAttack8)
                        debug.setupvalue(ac.attack, 6, AcAttack9)
                        debug.setupvalue(ac.attack, 4, AcAttack7)
                        debug.setupvalue(ac.attack, 7, AcAttack10)
                        for k, v in pairs(ac.animator.anims.basic) do
                            v:Play(0.01,0.01,0.01)
                        end                 
                        if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and ac.blades and ac.blades[1] then 
                            game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(CurrentWeapon()))
                            game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(NumberAc12 / 1099511627776 * 16777215), AcAttack10)
                            game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, 2, "") 
                        end
                    end
                end
            end
        end
        
        function AttackNoCD3() 
        local AC = CbFw2.activeController
        for i = 1, 1 do 
          local bladehit = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
              plr.Character,
              {plr.Character.HumanoidRootPart},
              60
          )
          local cac = {}
          local hash = {}
          for k, v in pairs(bladehit) do
              if v.Parent:FindFirstChild("HumanoidRootPart") and not hash[v.Parent] then
                  table.insert(cac, v.Parent.HumanoidRootPart)
                  hash[v.Parent] = true
              end
          end
          bladehit = cac
          if #bladehit > 0 then
              local u8 = debug.getupvalue(AC.attack, 5)
              local u9 = debug.getupvalue(AC.attack, 6)
              local u7 = debug.getupvalue(AC.attack, 4)
              local u10 = debug.getupvalue(AC.attack, 7)
              local u12 = (u8 * 798405 + u7 * 727595) % u9
              local u13 = u7 * 798405
              (function()
                  u12 = (u12 * u9 + u13) % 1099511627776
                  u8 = math.floor(u12 / u9)
                  u7 = u12 - u8 * u9
              end)()
              u10 = u10 + 1
              debug.setupvalue(AC.attack, 5, u8)
              debug.setupvalue(AC.attack, 6, u9)
              debug.setupvalue(AC.attack, 4, u7)
              debug.setupvalue(AC.attack, 7, u10)
              pcall(function()
                  for k, v in pairs(AC.animator.anims.basic) do
                      v:Play()
                  end                  
              end)
              if plr.Character:FindFirstChildOfClass("Tool") and AC.blades and AC.blades[1] then 
                  game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(GetCurrentBlade()))
                  game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(u12 / 1099511627776 * 16777215), u10)
                  game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, i, "") 
              end
          end
        end
        end
local Client = game.Players.LocalPlayer
local STOP = require(Client.PlayerScripts.CombatFramework.Particle)
local STOPRL = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib)
spawn(function()
    while task.wait() do
        pcall(function()
            if not shared.orl then shared.orl = STOPRL.wrapAttackAnimationAsync end
            if not shared.cpc then shared.cpc = STOP.play end
                STOPRL.wrapAttackAnimationAsync = function(a,b,c,d,func)
                local Hits = STOPRL.getBladeHits(b,c,d)
                if Hits then
                    if _G.FastAttack then
                        STOP.play = function() end
                        a:Play(0.01,0.01,0.01)
                        func(Hits)
                        STOP.play = shared.cpc
                        wait(a.length * 0.5)
                        a:Stop()
                    else
                        a:Play()
                    end
                end
            end
        end)
    end
end)

function GetBladeHit()
local CombatFrameworkLib = debug.getupvalues(require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework))
local CmrFwLib = CombatFrameworkLib[2]
local p13 = CmrFwLib.activeController
local weapon = p13.blades[1]
if not weapon then 
    return weapon
end
while weapon.Parent ~= game.Players.LocalPlayer.Character do
    weapon = weapon.Parent 
end
return weapon
end
local SeraphFrame = debug.getupvalues(require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework")))[2]
	local VirtualUser = game:GetService('VirtualUser')
	local RigControllerR = debug.getupvalues(require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework.RigController))[2]
	local Client = game:GetService("Players").LocalPlayer
	local DMG = require(Client.PlayerScripts.CombatFramework.Particle.Damage)

	function SeraphFuckWeapon() 
		local p13 = SeraphFrame.activeController
		local wea = p13.blades[1]
		if not wea then return end
		while wea.Parent~=game.Players.LocalPlayer.Character do wea=wea.Parent end
		return wea
	end

	function getHits(Size)
		local Hits = {}
		local Enemies = workspace.Enemies:GetChildren()
		local Characters = workspace.Characters:GetChildren()
		for i=1,#Enemies do local v = Enemies[i]
			local Human = v:FindFirstChildOfClass("Humanoid")
			if Human and Human.RootPart and Human.Health > 0 and game.Players.LocalPlayer:DistanceFromCharacter(Human.RootPart.Position) < Size+5 then
				table.insert(Hits,Human.RootPart)
			end
		end
		for i=1,#Characters do local v = Characters[i]
			if v ~= game.Players.LocalPlayer.Character then
				local Human = v:FindFirstChildOfClass("Humanoid")
				if Human and Human.RootPart and Human.Health > 0 and game.Players.LocalPlayer:DistanceFromCharacter(Human.RootPart.Position) < Size+5 then
					table.insert(Hits,Human.RootPart)
				end
			end
		end
		return Hits
	end

	task.spawn(
		function()
			while wait(0) do
				if  _G.FastAttack then
					if SeraphFrame.activeController then
						SeraphFrame.activeController.timeToNextAttack = 0
						SeraphFrame.activeController.focusStart = 0
						SeraphFrame.activeController.hitboxMagnitude = 40
						SeraphFrame.activeController.humanoid.AutoRotate = true
						SeraphFrame.activeController.increment = 1 + 1 / 1
					end
				end
			end
		end)

	function Boost()
		spawn(function()
			game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(SeraphFuckWeapon()))
		end)
	end

	function Unboost()
		spawn(function()
			game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("unequipWeapon",tostring(SeraphFuckWeapon()))
		end)
	end

	local cdnormal = 0
	local Animation = Instance.new("Animation")
	local CooldownFastAttack = 0
	Attack = function()
		local ac = SeraphFrame.activeController
		if ac and ac.equipped then
			task.spawn(
				function()
					if tick() - cdnormal > 0.5 then
						ac:attack()
						cdnormal = tick()
					else
						Animation.AnimationId = ac.anims.basic[2]
						ac.humanoid:LoadAnimation(Animation):Play(2, 2) --ท่าไม่ทำงานแก้เป็น (1,1)
						game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", getHits(120), 2, "")
					end
				end)
		end
	end

	b = tick()
	spawn(function()
		while wait(0) do
			if  _G.FastAttack then
				if b - tick() > 0.75 then
					wait(.2)
					b = tick()
				end
				pcall(function()
					for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
						if v.Humanoid.Health > 0 then
							if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 40 then
								Attack()
								wait(0)
								Boost()
							end
						end
					end
				end)
			end
		end
	end)

	k = tick()
	spawn(function()
		while wait(0) do
			if  _G.FastAttack then
				if k - tick() > 0.75 then
					wait(0)
					k = tick()
				end
				pcall(function()
					for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
						if v.Humanoid.Health > 0 then
							if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 40 then
								wait(0)
								Unboost()
							end
						end
					end
				end)
			end
		end
	end)

	tjw1 = true
	task.spawn(
		function()
			local a = game.Players.LocalPlayer
			local b = require(a.PlayerScripts.CombatFramework.Particle)
			local c = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib)
			if not shared.orl then
				shared.orl = c.wrapAttackAnimationAsync
			end
			if not shared.cpc then
				shared.cpc = b.play
			end
			if tjw1 then
				pcall(
					function()
						c.wrapAttackAnimationAsync = function(d, e, f, g, h)
							local i = c.getBladeHits(e, f, g)
							if i then
								b.play = function()
								end
								d:Play(15.25, 15.25, 15.25)
								h(i)
								b.play = shared.cpc
								wait(0)
								d:Stop()
							end
						end
					end
				)
			end
		end
    )

	local Client = game.Players.LocalPlayer
	local STOP = require(Client.PlayerScripts.CombatFramework.Particle)
	local STOPRL = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib)
	task.spawn(function()
		pcall(function()
			if not shared.orl then
				shared.orl = STOPRL.wrapAttackAnimationAsync
			end
			if not shared.cpc then
				shared.cpc = STOP.play 
			end
			spawn(function()
				require(game.ReplicatedStorage.Util.CameraShaker):Stop()
				game:GetService("RunService").Stepped:Connect(function()
					STOPRL.wrapAttackAnimationAsync = function(a,b,c,d,func)
						local Hits = STOPRL.getBladeHits(b,c,d)
						if Hits then
							if  _G.FastAttack then
								STOP.play = function() end
								a:Play(10.1,9.1,8.1)
								func(Hits)
								STOP.play = shared.cpc
								wait(a.length * 10.5)
								a:Stop()
							else
								func(Hits)
								STOP.play = shared.cpc
								wait(a.length * 10.5)
								a:Stop()
							end
						end
					end
				end)
			end)
		end)
	end)
