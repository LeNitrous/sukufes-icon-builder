loveframes 	= require 'lib.loveframes'
assets		= require('lib.cargo').init('assets')

sWidth 	= love.graphics.getWidth() 
sHeight = love.graphics.getHeight()
iWidth	= 128
iHeight	= 128

font = love.graphics.newFont('assets/fonts/MotoyaLMaru.ttf', 12)
font:setFilter('nearest', 'nearest')

require 'images'
require 'interface'

loaded_timer = 0
loaded_image = false

local idol_attr
local idol_bg
local idol_ring
local idol_state

local message = [[
	SukuFes Icon Builder by -Nitrous (https://osu.ppy.sh/u/7293512)
	for use with osu! mania skin: https://osu.ppy.sh/forum/t/539048
	Thanks for using!
]]

function love.load()
	love.graphics.setBackgroundColor(35, 42, 50, 255)
	local icon = love.image.newImageData("icon.png")
	love.window.setIcon(icon)
	
	canvas = love.graphics.newCanvas(sWidth, sHeight, "rgb10a2")
	canvas:setFilter("linear", "linear", 16)
	
	DrawInterface()
	
	love.filesystem.write('credits.txt', message)
	
	bg			= assets.images.bg_R_smile
	border		= assets.images.ring_R_smile
	idol		= assets.images.default
	idol_bg 	= "smile"
	idol_ring 	= "smile"
end

function love.update(dt)
	local idol_ring_type = m_Rarity:GetChoice()
	local idol_bg_type = m_Rarity2:GetChoice()
	local s = c_Smile:GetChecked()
	local c = c_Cool:GetChecked()
	local p = c_Pure:GetChecked()
	local a = c_All:GetChecked()
	local r = i_Rank:GetChecked()
	local i = i_Box:GetText()
	local b = b_Create
	if s then idol_attr = "smile" end
	if c then idol_attr = "cool" end
	if p then idol_attr = "pure" end
	if a then idol_attr = "all" end
	if r then idol_state = "idolized" else idol_state = "default" end
	if loaded_timer > 0 then loaded_timer = loaded_timer - dt end
	if i == "" then b:SetClickable(false) else b:SetClickable(true) end
	
	
	bg		= back[idol_bg_type][idol_state][idol_attr]
	border	= ring[idol_ring_type][idol_attr]
	
	loveframes.update(dt)
end

function love.draw()	
	love.graphics.setColor(55, 62, 70)
	love.graphics.rectangle("fill", 0, 0, 210, sHeight)
	love.graphics.setColor(255,255,255)
	love.graphics.draw(assets.images.logo)
	
	DrawPreviewBox()
	
	loveframes.draw()
end

function love.mousemoved(x, y, dx, dy)

end

function love.filedropped(f)
	local lfn = love.filesystem.newFileData
	local lin = love.image.newImageData
	local lgn = love.graphics.newImage
	if f:open('r') then
		local data = f:read()
		f:close()
		success, img = pcall(function() return lgn(lin(lfn(data, 'img', 'file'))) end)
		idol = success and img
		loaded_image = f:getFilename()
		loaded_timer = 3
	end
end

function love.mousepressed(x, y, b, isTouch)
	loveframes.mousepressed(x, y, b)
end

function love.mousereleased(x, y, b, isTouch)
	loveframes.mousereleased(x, y, b)
end

function love.wheelmoved(x, y)
	loveframes.wheelmoved(x, y)
end

function love.keypressed(k, scancode, isRepeat)
	loveframes.keypressed(k, isRepeat)
end

function love.keyreleased(k)
	loveframes.keyreleased(k)
end

function love.textinput(t)
	loveframes.textinput(t)
end