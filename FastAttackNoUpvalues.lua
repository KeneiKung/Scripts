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
	if v6 and v6.equipped then
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
		if #v8 > 0 then
			pcall(function()
				for v19, v20 in pairs(v6.animator.anims.basic) do
					v20:Play()
				end
			end)
			if v1.Character:FindFirstChildOfClass("Tool") and v6.blades and v6.blades[1] then
				game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange", tostring(G_1_()))
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
