loveframes 	= require 'lib.loveframes'
assets		= require('lib.cargo').init('assets')

local font = love.graphics.newFont('assets/fonts/MotoyaLMaru.ttf', 12)

local sWidth 	= love.graphics.getWidth() 
local sHeight 	= love.graphics.getHeight() 
local iWidth	= 128
local iHeight	= 128

local idol_attr
local idol_bg
local idol_ring
local idol_state
local loaded_image = false

local i = assets.images

local message = [[
	SukuFes Icon Builder by -Nitrous (https://osu.ppy.sh/u/7293512)
	for use with osu! mania skin: https://osu.ppy.sh/forum/t/539048
	Thanks for using!
]]

local back = {
	N = {
		default = {
			all		= i.bg_N_all,
			cool	= i.bg_N_cool,
			pure	= i.bg_N_pure,
			smile	= i.bg_N_smile
		},
		idolized = {
			all		= i.bg_N_all,
			cool	= i.bg_N_cool_idolized,
			pure	= i.bg_N_pure_idolized,
			smile	= i.bg_N_smile_idolized
		}
	},
	R = {
		default = {
			all		= i.bg_R_all,
			cool	= i.bg_R_cool,
			pure	= i.bg_R_pure,
			smile	= i.bg_R_smile
		},
		idolized = {
			all		= i.bg_R_all,
			cool	= i.bg_R_cool_idolized,
			pure	= i.bg_R_pure_idolized,
			smile	= i.bg_R_smile_idolized
		}
	},
	SR = {
		default = {
			all		= i.bg_SR_all,
			cool	= i.bg_SR_cool,
			pure	= i.bg_SR_pure,
			smile	= i.bg_SR_smile
		},
		idolized = {
			all		= i.bg_SR_all,
			cool	= i.bg_SR_cool_idolized,
			pure	= i.bg_SR_pure_idolized,
			smile	= i.bg_SR_smile_idolized
		}
	},
}

local ring = {
	N = {
		all		= i.ring_N_all,
		cool	= i.ring_N_cool,
		pure	= i.ring_N_pure,
		smile	= i.ring_N_smile
	},
	R = {
		all		= i.ring_R_all,
		cool	= i.ring_R_cool,
		pure	= i.ring_R_pure,
		smile	= i.ring_R_smile
	},
	SR = {
		all		= i.ring_SR_all,
		cool	= i.ring_SR_cool,
		pure	= i.ring_SR_pure,
		smile	= i.ring_SR_smile
	},
	SSR = {
		all		= i.ring_SR_all,
		cool	= i.ring_SR_cool,
		pure	= i.ring_SR_pure,
		smile	= i.ring_SR_smile
	},
	UR = {
		all		= i.ring_SR_all,
		cool	= i.ring_SR_cool,
		pure	= i.ring_SR_pure,
		smile	= i.ring_SR_smile
	}
}

function love.load()
	love.graphics.setBackgroundColor(35, 42, 50, 255)
	canvas = love.graphics.newCanvas(sWidth, sHeight, "rgb10a2")
	canvas:setFilter("linear", "linear", 16)
	-- UI Stuff
	local m_Text = loveframes.Create("text")
	m_Text:SetText("Ring")
	m_Text:SetPos(5, 7)
	
	m_Rarity = loveframes.Create("multichoice")
	m_Rarity:SetPos(5, 25)
	m_Rarity:SetWidth(95)
	m_Rarity:SetChoice("SR")
	m_Rarity:AddChoice("N")
	m_Rarity:AddChoice("R")
	m_Rarity:AddChoice("SR")
	m_Rarity:AddChoice("SSR")
	m_Rarity:AddChoice("UR")

	local m_Text2 = loveframes.Create("text")
	m_Text2:SetText("Background")
	m_Text2:SetPos(110, 7)
	
	m_Rarity2 = loveframes.Create("multichoice")
	m_Rarity2:SetPos(110, 25)
	m_Rarity2:SetWidth(95)
	m_Rarity2:SetChoice("SR")
	m_Rarity2:AddChoice("N")
	m_Rarity2:AddChoice("R")
	m_Rarity2:AddChoice("SR")

	local attrs = {}
	c_Smile = loveframes.Create("radiobutton")
	c_Smile:SetText("Smile")
	c_Smile:SetPos(5, 55.5)
	c_Smile:SetGroup(attrs)
	c_Smile:SetChecked(true)

	c_Cool = loveframes.Create("radiobutton")
	c_Cool:SetText("Cool")
	c_Cool:SetGroup(attrs)
	c_Cool:SetPos(5, 77.5)
	
	c_Pure = loveframes.Create("radiobutton")
	c_Pure:SetText("Pure")
	c_Pure:SetGroup(attrs)
	c_Pure:SetPos(5, 102.5)
	
	c_All = loveframes.Create("radiobutton")
	c_All:SetText("Special")
	c_All:SetGroup(attrs)
	c_All:SetPos(5, 127.5)

	local i_Text = loveframes.Create("text")
	i_Text:SetText("Output Name:")
	i_Text:SetPos(5, 152)
	
	i_Box = loveframes.Create("textinput")
	i_Box:SetText("idolu")
	i_Box:SetPos(5, 170)
	
	local i_XText = loveframes.Create("text")
	i_XText:SetText("Offset X")
	i_XText:SetPos(5, 200)
	
	i_XBox = loveframes.Create("numberbox")
	i_XBox:SetPos(5, 220)	
	i_XBox:SetWidth(95)
	i_XBox:SetHeight(25)
	i_XBox:SetMax(9999)
	i_XBox:SetMin(-9999)
	
	local i_YText = loveframes.Create("text")
	i_YText:SetText("Offset Y")
	i_YText:SetPos(110, 200)
	
	i_YBox = loveframes.Create("numberbox")
	i_YBox:SetPos(110, 220)	
	i_YBox:SetWidth(95)
	i_YBox:SetHeight(25)
	i_YBox:SetMax(9999)
	i_YBox:SetMin(-9999)
	
	local i_SText = loveframes.Create("text")
	i_SText:SetText("Scaling")
	i_SText:SetPos(5, 250)	
	
	i_SBox = loveframes.Create("numberbox")
	i_SBox:SetPos(5, 270)	
	i_SBox:SetWidth(200)
	i_SBox:SetHeight(25)
	i_SBox:SetValue(100)
	i_SBox:SetMin(0)
	
	i_Rank = loveframes.Create("checkbox")
	i_Rank:SetText("Idolized")
	i_Rank:SetPos(5, 305)

	b_Create = loveframes.Create("button")
	b_Create:SetText("Create")
	b_Create:SetPos(5, 355)
	b_Create:SetSize(200, 30)
	b_Create.OnClick = function(object)
		love.system.openURL("file://"..love.filesystem.getSaveDirectory())
		canvas:newImageData(330/2+220-64, sHeight/2-64, 128,128):encode("png", i_Box:GetText() ..".png")
	end
	--
	love.filesystem.write('credits.txt', message)
	--
	bg		= assets.images.bg_R_smile
	border	= assets.images.ring_R_smile
	idol	= assets.images.default
	idol_bg = "smile"
	idol_ring = "smile"
end

function love.update(dt)
	if i_Box:GetText() == "" then b_Create:SetClickable(false) else b_Create:SetClickable(true) end
	-- Preview Stuff
	idol_ring_type = m_Rarity:GetChoice()
	idol_bg_type = m_Rarity2:GetChoice()
	local s = c_Smile:GetChecked()
	local c = c_Cool:GetChecked()
	local p = c_Pure:GetChecked()
	local a = c_All:GetChecked()
	local r = i_Rank:GetChecked()
	if s then idol_attr = "smile" end
	if c then idol_attr = "cool" end
	if p then idol_attr = "pure" end
	if a then idol_attr = "all" end
	if r then idol_state = "idolized" else idol_state = "default" end
	bg		= back[idol_bg_type][idol_state][idol_attr]
	border	= ring[idol_ring_type][idol_attr]
	--
	loveframes.update(dt)
end

function love.draw()	
	local ox = i_XBox:GetValue()
	local oy = i_YBox:GetValue()
	local s = i_SBox:GetValue()*0.01
	-- Preview Pane
	love.graphics.push()
	love.graphics.translate(210,0)
	love.graphics.setFont(font)
	love.graphics.print("Preview:", 5, 5)

--[[
	if loaded_image then
		love.graphics.print("Loaded: " .. loaded_image, 5, sHeight - 20)
	end
]]

	love.graphics.setCanvas(canvas)
	
	love.graphics.draw(bg, 330/2, sHeight/2, 0, 1, 1, iWidth/2, iHeight/2)
	
	love.graphics.stencil(function() 
		love.graphics.circle("fill", 330/2, sHeight/2, 60) 
	end, "replace", 1, false)
	love.graphics.setStencilTest("greater", 0)
	
	love.graphics.draw(idol, 330/2+ox, sHeight/2+oy, 0, s, s, idol:getWidth()/2, idol:getHeight()/2)
	love.graphics.setStencilTest()
	
	love.graphics.draw(border, 330/2, sHeight/2, 0, 1, 1, iWidth/2, iHeight/2)

	love.graphics.setCanvas()

	love.graphics.pop()
	
	love.graphics.draw(canvas)
	
	love.graphics.setColor(55, 62, 70)
	love.graphics.rectangle("fill", 0, 0, 210, love.graphics.getHeight())
	love.graphics.setColor(255,255,255)
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