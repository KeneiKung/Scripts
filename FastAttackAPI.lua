getgenv().Loadded = false
local FastAttack = true
local v1 = game.Players.LocalPlayer
local v2 = debug.getupvalues(require(v1.PlayerScripts.CombatFramework))
local v3 = v2[2]
G_1_ = function()
	local v4 = v3.activeController
	local v5 = v4.blades[1]
	if not v5 then
		return
	end
	while v5.Parent ~= game.Players.LocalPlayer.Character do
		v5 = v5.Parent
	end
	return v5
end

G_2_ = function()
	local v6 = v3.activeController
	for v7 = 1, 1 do
		local v8 = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
            v1.Character, {
			v1.Character.HumanoidRootPart
		}, 60)
		local v9 = {}
		local v10 = {}
		for v11, v12 in pairs(v8) do
			if v12.Parent:FindFirstChild("HumanoidRootPart") and not v10[v12.Parent] then
				table.insert(v9, v12.Parent.HumanoidRootPart)
				v10[v12.Parent] = true
			end
		end
		v8 = v9
		if # v8 > 0 then
			local v13 = debug.getupvalue(v6.attack, 5)
			local v14 = debug.getupvalue(v6.attack, 6)
			local v15 = debug.getupvalue(v6.attack, 4)
			local v16 = debug.getupvalue(v6.attack, 7)
			local v17 = (v13 * 798405 + v15 * 727595) % v14
			local v18 = v15 * 798405
			(function()
				v17 = (v17 * v14 + v18) % 1099511627776
				v13 = math.floor(v17 / v14)
				v15 = v17 - v13 * v14
			end)()
			v16 = v16 + 1
			debug.setupvalue(v6.attack, 5, v13)
			debug.setupvalue(v6.attack, 6, v14)
			debug.setupvalue(v6.attack, 4, v15)
			debug.setupvalue(v6.attack, 7, v16)
			pcall(function()
				for v19, v20 in pairs(v6.animator.anims.basic) do
					v20:Play()
				end
			end)
			if v1.Character:FindFirstChildOfClass("Tool") and v6.blades and v6.blades[1] then
				game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange", tostring(G_1_()))
				game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(v17 / 1099511627776 * 16777215), v16)
				game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", v8, 4, "")
			end
		end
	end
end

coroutine.wrap(function()
	while task.wait() do
		if FastAttack then
			coroutine.resume(coroutine.create(G_2_))
				if getgenv().Loadded then
					coroutine.yield()
				end
		end
	end
end)()
