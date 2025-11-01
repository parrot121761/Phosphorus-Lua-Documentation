# Phosphorus Lua Documentation
Documentation for the Lua feature available in the Phosphorus script

# Creating a Lua file
(This documentation assumes you are already familiar with the Lua programming language and developing scripts on executors)

Your lua file must be located in workspace/Phosphorus/TC2/lua for the script to see them.\
You may also place your file inside workspace/Phosphorus/TC2/lua/autoexec, if you wish for it to be executed upon Phosphorus' execution\
The file extension doesn't actually matter, the file can be .lua, .luau, .txt etc.

To load your lua file, go to the Misc tab, and under the "Lua" groupbox select your script and execute it
If all has gone well, you will see an "Executed script" message in the top left corner.
If not, something has errored, please check the Roblox console (F9) for more info.

# The Phosphorus API
The Phosphorus Script has a few custom variables and functions that are used for communication between your lua scripts and the Phosphorus script.
These features are stored in your executor's custom global environment.

```lua
-- Example script
local genv = getgenv() -- Getting the executors global environment
print(genv.PhosphorusLoaded) -- Should print "true"
```

> [!NOTE]
> It is recommended to store the environment in a local variable so you don't have to constantly call getgenv().
> 
> You can also ditch getgenv entirely and just call PhosphorusLoaded directly (assuming you haven't previously defined a variable with the same name).

## UI Library functions
Phosphorus uses the [Obisidian UI Library](https://docs.mspaint.cc/obsidian).

### Library
The Library contains all essential functions and data used to create and get data from the UI.

```lua
-- Example script
genv.Library:Notify("Hello World!")
```

### Window
The Phosphorus UI Window itself.

```lua
-- Example script
local myTab = genv.Window:AddTab("Test", "box")
```

### Tabs
This is where all of Phosphorus' existing tabs are stored:

```lua
genv.Tabs = {
	Intro,
	Aim,
	Visuals,
	Automation,
	Mods,
	Misc,
	["UI Settings"],
}
```
You may use it in the following way to add your own custom UI elements inside existing tabs:

```lua
-- Example script
local GB_HBE = genv.Tabs.Aim:AddLeftGroupbox('Hitbox')
```

### Toggles
Used for interacting with Toggles in the UI.\
I am too lazy to list all of the toggle names in this documentation, but you may find all of them inside your config file. Have fun!

```lua
-- Example script
if Toggles.AimbotToggle.Value then
  -- Code here
end
```

### Options
Used for interacting with non-Toggle UI interactable elements (dropdowns, sliders, colorpickers etc.)\
I am too lazy to list all of the element names in this documentation, but you may find all of them inside your config file. Have fun!

```lua
-- Example script
if Options.AimbotTargets.Value["Players"] then
  -- Code here
end
```

## Phosphorus Functions

### PhosphorusLoaded
A boolean that has the value true if Phosphorus successfully executed

```lua
-- Example script
print(genv.PhosphorusLoaded) -- Should print "true"
```




