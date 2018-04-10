function love.conf(t)
	t.identity 	= "SIF Icon Builder"
	t.version  	= "11.0"
	t.console	= false
	
	t.window.title 	= "SukuFes Icon Builder"
	t.window.icon	= "icon.png"
	t.window.width	= 560
	t.window.height = 400
	t.window.msaa = 0
	t.window.borderless	= false
	t.window.resizeable	= false
	t.window.fullscreen = false
	
    t.modules.audio = false
    t.modules.joystick = false
    t.modules.physics = false
    t.modules.sound = false
    t.modules.thread = false
    t.modules.touch = false
    t.modules.video = false
end