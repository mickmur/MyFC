---------------------------------
-- INITIAL SETUP
---------------------------------

--Setup storyboard and create a scene.
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
--require the UI and table list libraries
local ui = require("ui")
local tableView = require("tableView")
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
	end --end buttonTouched


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
		text = "Defenders",
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
	-- *** Create the Defender list***
	------------------------------------------------
	local myList

	--local bg = display.newRect( screenGroup, 0, 180, 320, 270 )
	--bg:setFillColor( 245,245,245 )

	local data = {}

	--setup functions to execute on touch of the list view items
	function listButtonRelease( event )
		self = event.target -- the target is the row 
		local id = self.id  -- this is the row id in the table

		print(self.data.title) -- the rows data.title
		print(self.data.subtitle) -- the rows data.subtitle
		print(self.data.image) -- the rows data.image
			
		local options =
		{
			effect = "slideLeft",
    		time = 400,
			params =
			 {
			  var1 = self.data.title,
			  var2 = self.data.subtitle,
			  var3 = self.data.image,
			  var4 = self.data.position,
			  var5 = self.data.caption
			 }
		}

		storyboard.gotoScene( "scenes.profiler", options )
	end --end function listButtonRelease

	--setup each row as a new table, then add title, subtitle, and image
	data[6] = {}
	data[6].title = "Name:\nGary Carroll"
	data[6].subtitle = "Squad No: 1"
	data[6].image = "images/players/gary.jpg"
	data[6].position = "Defender"
	data[6].caption = "That boy needs therapy"

	data[2] = {}
	data[2].title = "Name:\nMicheal Murray"
	data[2].subtitle = "Squad No: 4"
	data[2].image = "images/players/micheal.jpg"
	data[2].position = "Defender"
	data[2].caption = "Lie down on the couch"

	data[1] = {}
	data[1].title = "Name:\nPeter Sheridan"
	data[1].subtitle = "Squad No: 23"
	data[1].image = "images/players/peter.jpg"
	data[1].position = "Defender"
	data[1].caption = "His truancy problem is way out of hand"

	data[3] = {}
	data[3].title = "Name:\nBob Neilon"
	data[3].subtitle = "Squad No: 24"
	data[3].image = "images/players/bob.jpg"
	data[3].position = "Defender"
	data[3].caption = "Crazy in the coconut!"

	data[5] = {}
	data[5].title = "Name:\nMark Murtagh"
	data[5].subtitle = "Squad No: 25"
	data[5].image = "images/players/mark.jpg"
	data[5].position = "Defender"
	data[5].caption = "Grab a kazoo, let's have a duel"

	data[4] = {}
	data[4].title = "Name:\nTimmy Jackson"
	data[4].subtitle = "Squad No: 26"
	data[4].image = "images/players/timmy.jpg"
	data[4].position = "Defender"
	data[4].caption = "Ranagazoo, let's have a tune"


	local topBoundary = display.screenOriginY + 180
	local bottomBoundary = display.screenOriginY + 0

	myList = tableView.newList
	{
		data=data, --A table containing elements that the list can iterate through to display in each row.
		default="images/components/list_item.jpg", --An image for the row background. Defines the hit area for the touch.
		over="images/components/list_item_clicked.jpg", --An image that will show on touch.
		onRelease=listButtonRelease, --A function name that defines the action to take after a row is tapped.
		top=topBoundary, --The upper boundary of the list. The list will start and snap back to this position.
		bottom=bottomBoundary, --The bottom boundary of the list. The list will snap back to this position when scrolled upward.
		
		-- callback = A function that defines how to display the data in each row. Each element in the data table will be used in place of the 
		-- argument ("item")  assigned to the callback function. 
		callback = function( row ) 
							 local g = display.newGroup()

							 local img = display.newImage(row.image)
							 g:insert(img)
							 img.x = math.floor(img.width*0.5 + 6)
							 img.y = math.floor(img.height*0.5 + 5) 

							 local title =  display.newText( row.title, 0, 0, custFont, 14 )
							 title:setTextColor(150, 150, 150)
							 g:insert(title)
							 title.x = title.width*0.5 + img.width + 20
							 title.y = 30

							 local subtitle =  display.newText( row.subtitle, 0, 0, custFont, 12 )
							 subtitle:setTextColor(150,150,150)
							 g:insert(subtitle)
							 subtitle.x = subtitle.width*0.5 + img.width + 20
							 subtitle.y = title.y + title.height + 6

							 return g  


					  end 
	}
	screenGroup:insert(myList)


	

end --end createScene


-- Called immediately after scene has moved onscreen:
-- Start timers/transitions etc.
function scene:enterScene( event )
	print( "levelSelect: enterScene event" )

	--reference the current screen group object
	local screenGroup = self.view
	----------------------------------------
	--***Create overlay of header section 
	--   allow list to move underneath it
	----------------------------------------

	local headerBG = display.newRect( screenGroup, 0, 0, 320, 180 )
	headerBG:setFillColor( 0,0,0 )

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
	end --end buttonTouched

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
		text = "Defenders",
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