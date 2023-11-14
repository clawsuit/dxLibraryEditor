sx, sy = guiGetScreenSize(  )
sw, sh = sx/1366, sy/768

loadstring(exports.dxLibrary:dxGetLibrary())()

function svgCreateRoundedRectangle(width, height, ratio, color1, borderWidth, color2)
	local r,g,b,a = bitExtract(color1,16,8),bitExtract(color1,8,8), bitExtract(color1,0,8), bitExtract(color1,24,8)
	local _color1 = string.format("#%.2X%.2X%.2X", r,g,b)
	--
	local r2,g2,b2,a2 = bitExtract((color2 or color1),16,8),bitExtract((color2 or color1),8,8), bitExtract((color2 or color1),0,8), bitExtract((color2 or color1),24,8)
	local _color2 = string.format("#%.2X%.2X%.2X", r2,g2,b2)
	--
	local rawSvgData = [[
	    <svg width="]]..(width+1.0)..[[" height="]]..(height+1.0)..[[">
		  	<rect x="1" y="1" rx="]]..ratio..[[" ry="]]..ratio..[[" width="]]..(width-1.5)..[[" height="]]..(height-1)..[["
		  	fill="]].._color1..[[" stroke="]].._color2..[[" stroke-width="]]..(borderWidth or 0)..[[" stroke-opacity="]]..(a2/255)..[[" fill-opacity="]]..(a/255)..[[" />
		</svg>
	]]
	--
	return svgCreate(width, height, rawSvgData)
end

function isCursorOver(x, y, width, height)
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )

	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end


function isCursorText(posX, posY, sizeX, sizeY)
	if ( not isCursorShowing( ) ) then
		return false
	end
	local cX, cY = getCursorPosition()
	local screenWidth, screenHeight = guiGetScreenSize()
	local cX, cY = (cX*screenWidth), (cY*screenHeight)

	return ( (cX >= posX and cX <= posX+(sizeX - posX)) and (cY >= posY and cY <= posY+(sizeY - posY)) )
end

function dxDrawText2(t, x,y,w,h,...)
	return dxDrawText(t, x,y,w+x,h+y,...)
end

function isCuboidInCuboid3D(x, y, w, d, x2, y2, w2, d2)
    return (x <= x2 and x+w >= x2+w2) and (y <= y2 and y+d >= y2+d2)
end

function math.lerp(from,to,alpha)
    return from + (to-from) * alpha
end


function interpolate(tick, time, from, to, easing, ...)
    local f = (getTickCount() - tick)/time
    local new = {}

    for i in ipairs(from) do
        local fun = from[i] > to[i] and math.max or math.min

        local factor = interpolateBetween( from[i], 0, 0, to[i], 0, 0, f, (easing or "Linear"), ...)
        new[i] = fun(factor, to[i])

    end

    return unpack(new)
end

function math.round(number, decimals)
    return tonumber(string.format(("%."..(decimals or 0).."f"), number))
end

function dxCreateElement(name, x, y, parent, ...)
	local element;
	local args = {...}

	if name == 'dxCheckBox' or name == 'dxRadioButton' then

		element = _G[name](x, y, 'Nuevo element', parent)

	elseif name == 'dxGridList' or name == 'dxList' or name == 'dxProgressBar' or name == 'dxScrollPane' or name == 'dxTabPanel' or name == 'dxSwitchButton' then

		element = _G[name](x, y, 40, 40, parent)

	elseif name == 'dxImage' then

		element = _G[name](x, y, 40,40, args[1], parent)

	elseif name == 'dxScroll' then

		element = _G[name](x, y, 40, false, parent)

	elseif name == 'dxWindow' then

		element = _G[name](x, y, 40, 40, 'Nuevo element')

	else

		element = _G[name](x, y, 40, 40, 'Nuevo element', parent)
	end

	dxSetProperty(element, 'isMoved', false)
	return element
end

function isPointOverElement(px, py, element)
    local x, y, w, h = dxGetProperty(element, 'x'), dxGetProperty(element, 'y'), dxGetProperty(element, 'w'), dxGetProperty(element, 'h')
    return (px >= x and px <= x+w) and (py >= y and py <= y+h)
end