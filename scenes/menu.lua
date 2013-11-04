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
local custFont --handler for custom font name (platform dependant)

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
	-- *** Place the logo ***
	------------------------------------------------
	--Logo image
	local logo = display.newImage( screenGroup, "images/SpartakGranardFC_crest_black.jpg" )
	logo.width = 170; logo.height = 197
	logo.x = _W * 0.5; logo.y = _H * 0.43
	screenGroup:insert( logo )


	------------------------------------------------
	-- *** Create the menu buttons and handlers***
	------------------------------------------------
	--Function to handle level select button clicked
	local function buttonTouched( event )
		if event.phase == "ended" then
			--Play the sound
			tapChannel = audio.play( tapSound )
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
		end
	end --end levelTouched
	
	------------------------------------------------
	-- *** Create the menu buttons***
	------------------------------------------------
	--menu layout variables
	local menuTop = _H * 0.75
	local menuSpacing = 44
	--menu buttons
	local btn_players = ui.newButton
	{
		default = "images/components/menu_players.jpg",
		over = "images/components/menu_players_clicked.jpg",
		onRelease = buttonTouched,
		x = _W * 0.5, 
		y = menuTop
	}
	--btn_players.x = _W * 0.5; btn_players.y = menuTop
	btn_players.id = "players"
	screenGroup:insert(btn_players)

	local btn_about = ui.newButton
	{
		default = "images/components/menu_about.jpg",
		over = "images/components/menu_about_clicked.jpg",
		onRelease = buttonTouched,
		x = _W * 0.5,
		y = menuTop + menuSpacing
	}
	--btn_about.x = _W * 0.5; btn_about.y = menuTop + menuSpacing
	btn_about.id = "about"
	screenGroup:insert(btn_about)

	local btn_contact = ui.newButton
	{
		default = "images/components/menu_contact.jpg",
		over = "images/components/menu_contact_clicked.jpg",
		onRelease = buttonTouched,
		x = _W * 0.5,
		y = menuTop + menuSpacing * 2
	}
	--btn_contact.x = _W * 0.5; btn_contact.y = menuTop + menuSpacing * 2
	btn_contact.id = "contact"
	screenGroup:insert(btn_contact)	

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