-- Example hitbox expander script for Phosphorus

-- You can directly call variables and functions in the executor's environment without getgenv(), as shown here
local hbeTab = Window:AddTab("Hitbox Expander", "box")
local ExpandableHitboxes = {'HeadHB', 'RightUpperLeg', 'Hitbox'}
local BodyPartSizes = {
    ["HeadHB"] = Vector3.new(2, 2, 2),
    ["RightUpperLeg"] = Vector3.new(1, 1.5, 1),
    ["Hitbox"] = Vector3.new(5.59, 5.175, 5.175),
}

-- Creating the Hitbox Expander tab
do
    local GB_HBE = hbeTab:AddLeftGroupbox('Hitbox Expander')
    GB_HBE:AddToggle('HBEToggle', { Text = 'Hitbox Expander', Default = true, Tooltip = 'Expand Hitboxes of enemies'})
    GB_HBE:AddSlider('HBESize', {Text = 'Size', Default = 10, Min = 1, Max = 25, Rounding = 0, Suffix = '', Compact = true})
    GB_HBE:AddDropdown("HBEPlayerParts", {Values = ExpandableHitboxes, Default = {'HeadHB'}, Multi = true, Text = "Parts"})
    GB_HBE:AddToggle('HBEIgnoreInvis', { Text = 'Ignore Invis', Default = true, Tooltip = 'Ignore Invisible Agents'})
end

-- There are no global variables for player-related stuff so you will have to initialize them yourself
local Players = cloneref(game:GetService("Players"))
local LocalPlayer = Players.LocalPlayer

-- Function used for expanding hitboxes
local function ExpandPart(part, size, transparency)
	if part then
		part.Massless = true
		part.CanCollide = false
		part.Transparency = transparency
		part.Size = size
	end
end

-- Now do remember, global variables are slower than local variables
-- In this example the performance impact is negligible, however you might want to cache them for bigger scripts:
-- local Toggles = getgenv().Toggles
-- etc, etc...
task.spawn(function()
	while task.wait(0.5) do
		for i, v in Players:GetPlayers() do 
			local Character = v.Character
			if Character then
				if Toggles.HBEToggle.Value and v.Team ~= LocalPlayer.Team and (Toggles.HBEIgnoreInvis.Value or Character["Head"].Transparency < .9) then
					for i,v in ExpandableHitboxes do							
						local Actual = Character:FindFirstChild(v)
						if Actual then
							if Options.HBEPlayerParts.Value[v] then
								ExpandPart(Actual, Vector3.one * Options.HBESize.Value, 1)
							else
								ExpandPart(Actual, BodyPartSizes[v], 1)
							end
						end
					end
				else
					ExpandPart(Character:FindFirstChild("HeadHB"), Vector3.new(2, 2, 2), 1)
					ExpandPart(Character:FindFirstChild("RightUpperLeg"), Vector3.new(1, 1.5, 1), 0)
					ExpandPart(Character:FindFirstChild("Hitbox"), Vector3.new(5.59, 5.175, 5.175), 1)
				end
			end
		end
	end
end)
