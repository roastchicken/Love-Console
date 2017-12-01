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
  
  console.info.lineOffset = 1
  console.info.maxLines = math.floor( ( console.info.ySize - 20 ) / 12 )
end

local function getOffset()
  return console.info.lineOffset
end

local function refreshLines()
  local offset = getOffset()
  console.lines = {}
  for i = offset, offset + console.info.maxLines - 1 do -- subtract one to leave a space of one line at the end
    if not console.history[i] then break end
    table.insert( console.lines, console.history[i] )
  end
end

local function setOffset( offset )
  if offset > #console.history - console.info.maxLines then
    offset = #console.history - console.info.maxLines + 1 -- add one in order to show last line
  end
  
  if offset < 1 then
    offset = 1
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
  local bottomOffset = #console.history - console.info.maxLines + 1 -- add one in order to show last line
  if bottomOffset <= 0 then bottomOffset = 1 end
  setOffset( bottomOffset )
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