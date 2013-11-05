---------------------------------
-- INITIAL SETUP
---------------------------------

--Initial Settings
display.setStatusBar( display.HiddenStatusBar )
system.activate("multitouch")

-- Setup storyboard
local storyboard = require("storyboard")
storyboard.purgeOnSceneChange = true --So it automatically purges for us.

---------------------------------
-- MEMORY LOGGING TO THE CONSOLE
---------------------------------
--Function to log memory usage to the console
local function checkMemory()
   collectgarbage( "collect" )
   local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
   print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end
timer.performWithDelay( 5000, checkMemory, 0 )


---------------------------------
-- SETUP BACKGROUND SOUNDS
---------------------------------

--Create a constantly looping background sound...
local bgSound = audio.loadStream("sounds/Frontier_Psychiatrist.mp3")
audio.reserveChannels(1)   --Reserve its channel
audio.play(bgSound, {channel=1, loops=-1}) --Start looping the sound.


---------------------------------
-- SETUP CUSTOM FONT
---------------------------------

--set custom font name for each platform
local custFont
if "Win" == system.getInfo( "platformName" ) then
    custFont = "Eras Bold ITC"
    print("Platform: Windows")
elseif "Android" == system.getInfo( "platformName" ) then
    custFont = "ErasBoldITC"
    print("Platform: Android")
else
    -- Mac and iOS
    custFont = "ErasBoldITC" --not sure what the font name is on Mac
    print("Platform: Mac")
end
--local custFont = "ErasBoldITC"
print("Custom Font name: " ..custFont)

-----------------
--find font names
-----------------
-- Code to have Corona display the font names found
--[[
local fonts = native.getFontNames()
count = 0
-- Count the number of total fonts
for i,fontname in ipairs(fonts) do
    count = count+1
end
print( "\rFont count = " .. count )

local name = "eras"     -- part of the Font name we are looking for
name = string.lower( name )

-- Display each font in the terminal console
for i, fontname in ipairs(fonts) do
    j, k = string.find( string.lower( fontname ), name )

    if( j ~= nil ) then
        print( "fontname = " .. tostring( fontname ) )
    end
end
--]]
---------------------------------
-- SETUP HEADER CONTENT
---------------------------------

-- background should appear behind all scenes
--local background = display.newImage( "bg.png" )

-- header should appear above all scenes
--set Club Text options
local optionsClub = {
	--parent = mydisplaygroup,
	text = "SPARTAK GRANARD FC",
	x = display.actualContentWidth/2,
	y = 50,
	width = 280,	--required for multiline and alignment
	height = 45,	--required for multiline and alignment
	font = custFont,
	fontSize = 23,
	align = "center"
}
--create Club text display object
local headerClub = display.newText( optionsClub );
headerClub:setTextColor( 245,245,245 )

--set Club Text options
local optionsYear = {
	--parent = mydisplaygroup,
	text = "2013 - 2014",
	x = display.actualContentWidth/2,
	y = 70,
	width = 280,	--required for multiline and alignment
	height = 14,	--required for multiline and alignment
	font = custFont,
	fontSize = 13,
	align = "center"
}
--create Club text display object
local headerYear = display.newText( optionsYear );
headerYear:setTextColor( 245,245,245 )


-- local header = display.newText( options )
-- header:setReferencePoint( display.BottomLeftReferencePoint )
-- tabBar.x, tabBar.y = 0, display.contentHeight


---------------------------------
-- SETUP DISPLAY STACK
---------------------------------

-- put everything in the right order
local display_stage = display.getCurrentStage() --root group for all display objects and groups, single instance
--display_stage:insert( background )
display_stage:insert( storyboard.stage )
display_stage:insert( headerClub )
display_stage:insert( headerYear )


---------------------------------
-- MOVE TO MENU SCENE
---------------------------------

--Now change scene to go to the menu.
local optionsStoryboard =
{
    effect = "fade",
    time = 1000,
    params =
    {
        appfont = custFont,
    }
}
storyboard.gotoScene( "scenes.menu", optionsStoryboard )
