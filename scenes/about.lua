---------------------------------
-- INITIAL SETUP
---------------------------------

--Setup storyboard and create a scene.
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
--require ui.lua
local ui = require("ui")
--Variables etc we need
local _W = display.actualContentWidth --Width and height parameters
local _H = display.actualContentHeight
--Set up some of the sounds we want to use....
local tapChannel, tapSound

------------------------------------------------
-- *** STORYBOARD SCENE EVENT FUNCTIONS ***
------------------------------------------------
-- Called when the scene's view does not exist:
-- Create all your display objects here.
function scene:createScene( event )

	print( "menu: createScene event")
	--create screen group object
	local screenGroup = self.view
	--Load sound.
	tapSound = audio.loadSound("sounds/tapsound.wav")
	--load custom font name
	if event.params.appfont then 
		--print("Font name: " .. event.params.appfont) 
		custFont = event.params.appfont
	end

	------------------------------------------------
	-- *** Create the button touch handler***
	------------------------------------------------
	--Function to handle level select button clicked
	local function buttonTouched( event )
		if event.phase == "ended" then
			--Play the sound
			tapChannel = audio.play( tapSound )
			--Now change to the selected level.
			--Now change to the selected level.
			local optionsStoryboard =
			{
			    effect = "zoomOutInFade",
			    time = 400,
			    params =
			    {
			        appfont = custFont,
			    }
			} 
			storyboard.gotoScene( "scenes."..event.target.id, optionsStoryboard )
--			storyboard.gotoScene( "scenes/"..event.target.id, "zoomOutInFade", 400 )
		end
	end --end levelTouched


	------------------------------------------------
	-- *** Create the navbar***
	------------------------------------------------
	
	--create navbar group
	local navbar = display.newGroup( )
	
	--add navbar buttons
	local btn_home = ui.newButton
	{
		default = "images/components/navbar_white_home.jpg",
		onRelease = buttonTouched,
		x = 37, 
		y = 112
	}
	btn_home.id = "menu"
	navbar:insert(btn_home)
	
	local btn_players = ui.newButton
	{
		default = "images/components/navbar_white_players.jpg",
		onRelease = buttonTouched,
		x = 114, 
		y = 112
	}
	btn_players.id = "players"
	navbar:insert(btn_players)
	
	local btn_about = ui.newButton
	{
		default = "images/components/navbar_white_about.jpg",
		onRelease = buttonTouched,
		x = 188, 
		y = 112
	}
	btn_about.id = "about"
	navbar:insert(btn_about)

	local btn_contact = ui.newButton
	{
		default = "images/components/navbar_white_contact.jpg",
		onRelease = buttonTouched,
		x = 271, 
		y = 112
	}
	btn_contact.id = "contact"
	navbar:insert(btn_contact)
	
	--place navbar in top display
	--local display_stage = display.getCurrentStage() --root group for all display 
	--display_stage:insert( navbar )
	screenGroup:insert( navbar )
	

	------------------------------------------------
	-- *** Create the content title text***
	------------------------------------------------
	local options = {
		text = "About",
		x = display.actualContentWidth/2,
		y = 155,
		width = 280,	--required for multiline and alignment
		height = 18,	--required for multiline and alignment
		font = custFont,
		fontSize = 14,
		align = "center"
	}
	local title = display.newText( options )
	screenGroup:insert( title )

	------------------------------------------------
	-- *** Create the about info display***
	------------------------------------------------
	local bg = display.newRect( screenGroup, 0, 180, 320, 270 )
	bg:setFillColor( 245,245,245 )

	--load contact details text
	local path = system.pathForFile( "about.txt", system.ResourceDirectory )
	local file = io.open( path, "r" )
	local aboutText
	if file then    -- nil if no file found
	    aboutText = file:read( "*a" )
	    io.close( file )
	else
		aboutText = "No details available"
	end
	

	--set text options
	local optionsAbout = {
		--parent = mydisplaygroup,
		text = aboutText,
		x = display.actualContentWidth/2,
		y = 315,
		width = 280,	--required for multiline and alignment
		height = 230,	--required for multiline and alignment
		font = custFont,
		fontSize = 13,
		align = "left"
	}
	--create Club text display object
	local aboutDetails = display.newText( optionsAbout );
	aboutDetails:setTextColor( 150,150,150 )
	screenGroup:insert( aboutDetails )
	

end --end createScene


-- Called immediately after scene has moved onscreen:
-- Start timers/transitions etc.
function scene:enterScene( event )
	print( "levelSelect: enterScene event" )

	-- Completely remove the previous scene/all scenes.
	-- Handy in this case where we want to keep everything simple.
	storyboard.removeAll()
end

-- Called when scene is about to move offscreen:
-- Cancel Timers/Transitions and Runtime Listeners etc.
function scene:exitScene( event )
	print( "levelSelect: exitScene event" )
end

--Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	print( "levelSelect: destroying view" )
	audio.dispose( tapSound ); tapSound = nil;
end


-----------------------------------------------
-- Add the story board event listeners
-----------------------------------------------
scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )


--Return the scene to storyboard.
return scene