-- Example usage

local console = require( "console" )

function love.load()
  love.window.setMode( 1280, 720 )
  love.window.setTitle( "LÖVE2D Console Test" )
  
  love.graphics.setBackgroundColor( 102, 102, 102 )
  
  console:init()
end

function love.draw()
  console:draw()
end