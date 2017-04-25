local pRarity		= { x = 5, y = 40, ox = 105, oy = 18 }
local pAttribute	= { x = 5, y = 90, oy = 22 }
local pOutput		= { x = 5, y = 185, oy = 18 }
local pOffset		= { x = 5, y = 235, ox = 105, oy = 18 }
local pScaling		= { x = 5, y = 285, oy = 18 }
local pToggles		= { x = 5, y = 335 }
local pButton		= { x = 5, y = 360 }

function DrawInterface()
	local m_Text = loveframes.Create("text")
	m_Text:SetText("Ring")
	m_Text:SetPos(pRarity.x, pRarity.y)
	
	m_Rarity = loveframes.Create("multichoice")
	m_Rarity:SetPos(pRarity.x, pRarity.y + pRarity.oy)
	m_Rarity:SetWidth(95)
	m_Rarity:SetChoice("SR")
	m_Rarity:AddChoice("N")
	m_Rarity:AddChoice("R")
	m_Rarity:AddChoice("SR")
	m_Rarity:AddChoice("SSR")
	m_Rarity:AddChoice("UR")

	local m_Text2 = loveframes.Create("text")
	m_Text2:SetText("Background")
	m_Text2:SetPos(pRarity.x + pRarity.ox, pRarity.y)
	
	m_Rarity2 = loveframes.Create("multichoice")
	m_Rarity2:SetPos(pRarity.x + pRarity.ox, pRarity.y + pRarity.oy)
	m_Rarity2:SetWidth(95)
	m_Rarity2:SetChoice("SR")
	m_Rarity2:AddChoice("N")
	m_Rarity2:AddChoice("R")
	m_Rarity2:AddChoice("SR")
	
	local attrs = {}
	c_Smile = loveframes.Create("radiobutton")
	c_Smile:SetText("Smile")
	c_Smile:SetPos(pAttribute.x, pAttribute.y)
	c_Smile:SetGroup(attrs)
	c_Smile:SetChecked(true)

	c_Cool = loveframes.Create("radiobutton")
	c_Cool:SetText("Cool")
	c_Cool:SetGroup(attrs)
	c_Cool:SetPos(pAttribute.x, pAttribute.y + pAttribute.oy)
	
	c_Pure = loveframes.Create("radiobutton")
	c_Pure:SetText("Pure")
	c_Pure:SetGroup(attrs)
	c_Pure:SetPos(pAttribute.x, pAttribute.y + (pAttribute.oy*2))
	
	c_All = loveframes.Create("radiobutton")
	c_All:SetText("Special")
	c_All:SetGroup(attrs)
	c_All:SetPos(pAttribute.x, pAttribute.y + (pAttribute.oy*3))
	
	local i_Text = loveframes.Create("text")
	i_Text:SetText("Output Name:")
	i_Text:SetPos(pOutput.x, pOutput.y)
	
	i_Box = loveframes.Create("textinput")
	i_Box:SetText("idolu")
	i_Box:SetPos(pOutput.x, pOutput.y + pOutput.oy)
	
	local i_XText = loveframes.Create("text")
	i_XText:SetText("Offset X")
	i_XText:SetPos(pOffset.x, pOffset.y)
	
	i_XBox = loveframes.Create("numberbox")
	i_XBox:SetPos(pOffset.x, pOffset.y + pOffset.oy)	
	i_XBox:SetWidth(95)
	i_XBox:SetHeight(25)
	i_XBox:SetMax(9999)
	i_XBox:SetMin(-9999)
	
	local i_YText = loveframes.Create("text")
	i_YText:SetText("Offset Y")
	i_YText:SetPos(pOffset.x + pOffset.ox, pOffset.y)
	
	i_YBox = loveframes.Create("numberbox")
	i_YBox:SetPos(pOffset.x + pOffset.ox, pOffset.y + pOffset.oy)	
	i_YBox:SetWidth(95)
	i_YBox:SetHeight(25)
	i_YBox:SetMax(9999)
	i_YBox:SetMin(-9999)
	
	local i_SText = loveframes.Create("text")
	i_SText:SetText("Scaling")
	i_SText:SetPos(pScaling.x, pScaling.y)	
	
	i_SBox = loveframes.Create("numberbox")
	i_SBox:SetPos(pScaling.x, pScaling.y + pScaling.oy)	
	i_SBox:SetWidth(200)
	i_SBox:SetHeight(25)
	i_SBox:SetValue(100)
	i_SBox:SetMin(0)
	
	i_Rank = loveframes.Create("checkbox")
	i_Rank:SetText("Idolized")
	i_Rank:SetPos(pToggles.x, pToggles.y)
	
	b_Create = loveframes.Create("button")
	b_Create:SetText("Create")
	b_Create:SetPos(pButton.x, pButton.y)
	b_Create:SetSize(200, 30)
	b_Create.OnClick = function(object)
		love.system.openURL("file://"..love.filesystem.getSaveDirectory())
		canvas:newImageData(330/2+220-64, sHeight/2-64, 128,128):encode("png", i_Box:GetText() ..".png")
	end
end

local pPreview = { x = 210, y = 0, w = sWidth - 210, h = sHeight }

function DebugPreviewBox()
	love.graphics.rectangle("fill", pPreview.x, pPreview.y, pPreview.w, pPreview.h)
end

function DrawPreviewBox()
	local ox = i_XBox:GetValue()
	local oy = i_YBox:GetValue()
	local s = i_SBox:GetValue()*0.01
	
	love.graphics.push()
	love.graphics.translate(pPreview.x, pPreview.y)
	
	love.graphics.setFont(font)
	love.graphics.print("Preview:", 5, 5)
	if loaded_image and loaded_timer > 0 then love.graphics.print("Loaded: " .. loaded_image, 5, pPreview.h - 20) end
	
	love.graphics.setCanvas(canvas)
	love.graphics.draw(bg, pPreview.w/2, pPreview.h/2, 0, 1, 1, iWidth/2, iHeight/2)
	love.graphics.stencil(function() 
		love.graphics.circle("fill", pPreview.w/2, pPreview.h/2, 60) 
	end, "replace", 1, false)
	love.graphics.setStencilTest("greater", 0)
	love.graphics.draw(idol, pPreview.w/2+ox, pPreview.h/2+oy, 0, s, s, idol:getWidth()/2, idol:getHeight()/2)
	love.graphics.setStencilTest()
	love.graphics.draw(border, pPreview.w/2, pPreview.h/2, 0, 1, 1, iWidth/2, iHeight/2)
	love.graphics.setCanvas()
	
	love.graphics.pop()
	
	love.graphics.draw(canvas)
end