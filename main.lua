-- Example usage

local console = require( "console" )

function love.load()
  love.window.setMode( 1280, 720 )
  love.window.setTitle( "LÖVE2D Console Test" )
  
  love.graphics.setBackgroundColor( 102, 102, 102 )
  
  console:init()
  
  console:print( "This is the first line." )
  console:print( "Text wrap test. Text wrap test. Text wrap test. Text wrap test. Text wrap test. Text wrap test. Text wrap test. Text wrap test. Text wrap test. Text wrap test. Text wrap test. Text wrap test. Text wrap test. Text wrap test. Text wrap test." )
  console:print( "After a wrapped line, the rest of the lines continue like normal." )
end

function love.draw()
  console:draw()
end