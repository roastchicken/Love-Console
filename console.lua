local console = {}
local info

function Color( red, green, blue )
  return { r = red, g = green, b = blue }
end

function console:init( xPos, yPos, xSize, ySize, bgColor, font )
  if console.initiated then return end
  
  console.initiated = true
  console.info = {}
  console.history = {}
  console.lines = {}
  
  console.info.xPos = xPos or 0
  console.info.yPos = yPos or 0
  console.info.xSize = xSize or love.graphics.getWidth()
  console.info.ySize = ySize or love.graphics.getHeight()
  console.info.bgColor = bgColor or Color( 0, 0, 0 )
  console.info.font = font or love.graphics.newFont(12)
  
  -- the number of lines the bottom displayed line is offset from the latest printed line
  console.info.lineOffset = 0
  console.info.maxLines = math.floor( ( console.info.ySize - 20 ) / 12 )
end

local function getOffset()
  return console.info.lineOffset
end

local function refreshLines()
  local offset = getOffset()
  console.lines = {}
  
  -- add 1 because otherwise maxLines + 1 are placed into lines
  local firstLine = #console.history - console.info.maxLines - offset + 1
  if firstLine < 1 then
    firstLine = 1
  end
  
  for i = firstLine, #console.history - offset do
    table.insert( console.lines, console.history[i] )
  end
end

local function setOffset( offset )
  if offset > #console.history - console.info.maxLines then
    offset = #console.history - console.info.maxLines
  end
  
  if offset < 0 then
    offset = 0
  end
  
  console.info.lineOffset = offset
  refreshLines()
end

function console:scroll( amount )
  if not console.initiated then return end
  setOffset( getOffset() + amount )
end

function console:scrollToBottom()
  if not console.initiated then return end
  setOffset( 0 )
end

function console:print( text )
  if not console.initiated then return end
  local width, wrapped = console.info.font:getWrap( text, console.info.xSize - 20 ) -- wrap the text, using the console width - 20 to take the padding into account
  for k, line in ipairs( wrapped ) do
    table.insert( console.history, line )
  end
  console:scrollToBottom()
end

function console:draw()
  if not console.initiated then return end
  
  local bgColor = console.info.bgColor
  love.graphics.setColor( bgColor.r, bgColor.g, bgColor.b )
  love.graphics.rectangle( "fill", console.info.xPos, console.info.yPos, console.info.xSize, console.info.ySize )
  
  love.graphics.setColor( 255, 255, 255 )
  love.graphics.setFont( console.info.font )
  
  for line, text in ipairs( console.lines ) do -- draw the lines
    love.graphics.print( text, 10, 12 * ( line - 1 ) + 10 )
  end
end

return console