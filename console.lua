local util = require( "util" )

local console = {}
local info

function console:init( xPos, yPos, xSize, ySize, font, bgColor )
  if console.initiated then return end
  
  console.initiated = true
  console.info = {}
  console.lines = {}
  
  console.info.xPos = xPos or 0
  console.info.yPos = yPos or 0
  console.info.xSize = xSize or love.graphics.getWidth()
  console.info.ySize = ySize or love.graphics.getHeight()
  console.info.bgColor = bgColor or util.Color( 0, 0, 0 )
  console.info.font = font or love.graphics.newFont(12)
end

function console:draw()
  if not console.initiated then return end
  
  local bgColor = console.info.bgColor
  love.graphics.setColor( bgColor.r, bgColor.g, bgColor.b )
  love.graphics.rectangle( "fill", console.info.xPos, console.info.yPos, console.info.xSize, console.info.xSize )
end

return console