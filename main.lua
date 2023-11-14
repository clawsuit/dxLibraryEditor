local old_click;

addEventHandler("onClientRender", root,
    function()

    	local click = getKeyState 'mouse1' and not old_click;
        old_click = getKeyState 'mouse1'

    	local x = 0
    	for i, v in ipairs(settings.buttoms) do

        	dxDrawImage(414*sw+x, 715*sh, 40*sw, 40*sw, settings.backgroundButtom, 0, 0, 0, tocolor(255,255,255,settings.alpha))

            if v.func == 'Create'  then
                dxDrawImage(414*sw+x, 715*sh, 40*sw, 40*sw, v.path, 0, 0, 0, tocolor(255, 255, 255, settings.alpha), false)
            elseif v.func == 'Reset'  then
                dxDrawImage(419*sw+x, 720*sh, 30*sw, 30*sw, v.path, 0, 0, 0, tocolor(255, 255, 255, settings.alpha), false)
            else
                dxDrawImage((419+2.5)*sw+x, (720+2.5)*sh, 25*sw, 25*sw, v.path, 0, 0, 0, tocolor(255, 255, 255, settings.alpha), false)
            end

            if not state.bt.name and isCursorOver(414*sw+x, 715*sh, 40*sw, 40*sw) then
                dxDrawText2(v.func, 414*sw+x, 700*sh, 40*sw, 15, tocolor(255,255,255,settings.alpha), 1, "default-bold", "center", "top", false, false, false)
            end

       	 	if click and settings.alpha == 255 then
       	 		if isCursorOver(414*sw+x, 715*sh, 40*sw, 40*sw) then

                    if v.func == 'Create' then
           	 			if state.bt.name ~= v.func then
           	 				state.bt = {name=v.func, tick=getTickCount(  ), state='in'}
           	 			elseif state.bt.name == v.func then
           	 				state.bt = {name=v.func, tick=getTickCount(  ), state='out'}
           	 			end

                    elseif v.func == 'Copy Code' then

                        dxFormatCode(true)

                    elseif v.func == 'Reset' then

                        for i = #settings.creados, 1, -1 do
                            destroyElement( (table.remove(settings.creados, i)) )
                        end

                    end
       	 		end
       	 	end
       	 	

       	 	x = x + 50*sw
       	end 

       	if state.bt.name == 'Create' then

       		local util = state.elements[state.bt.name]
       		local py, ph

       		if state.bt.state == 'in' then
 				py, ph = interpolate(state.bt.tick, 500, {(549+156)*sh, 0}, {549*sh, 156*sh}, 'Linear')
 			else
 				py, ph = interpolate(state.bt.tick, 250, {549*sh, 156*sh}, {(549+156)*sh, 0}, 'Linear')
 			end

   	 		dxDrawImage(379*sw, py, 110*sw, ph, settings.backgroundListCreate, 0, 0, 0, tocolor(255, 255, 255, settings.alpha))

   	 		if state.bt.state == 'out' then
   	 			if py >= (549+156)*sh then
   	 				state.bt = {}
   	 				
   	 			end

   	 			if util.visibleList then
   	 				dxSetVisible(util.list, false)
   	 				util.visibleList = nil
   	 			end
   	 		else
   	 			if py <= 549*sh then

   	 				if not util.visibleList then
   	 					util.visibleList = true
   	 					dxSetVisible(util.list, true)
   	 				end
   	 			end
   	 		end
   	 	end

        if isElement(state.selected.element) then
            local x, y, w, h = dxGetProperty(state.selected.element, 'x'), dxGetProperty(state.selected.element, 'y'), dxGetProperty(state.selected.element, 'w'), dxGetProperty(state.selected.element, 'h')
            x = x - 1
            y = y - 1
            w = w + 1
            h = h + 1
            dxDrawRectangle(x, y, 1, h, tocolor(255,255,255), true)
            dxDrawRectangle(x, y, w, 1, tocolor(255,255,255), true)
            dxDrawRectangle(x+w, y, 1, h, tocolor(255,255,255), true)
            dxDrawRectangle(x, y+h, w, 1, tocolor(255,255,255), true)
        end
    end
)


bindKey("d","down",
	function()
		if getKeyState( 'lshift' ) then
			settings.alpha = settings.alpha == 50 and 255 or 50
			showCursor(settings.alpha == 255)
		end
	end
)



addEventHandler("onClientClick", root,
    function(b, s, ax, ay)
        if b == 'left' then
        	if s == 'down' then

        		if state.selected.name then
        			if not isElement(state.selected.element) then

                        local parent
                        for i = #settings.creados, 1, -1 do

                            local v = settings.creados[i]
                            if v and dxIsElementParent(v) and isPointOverElement(ax, ay, v) then
                                
                                parent = v
                                --dxSetParent(state.selected.element, v)
                                break
                            end
                        end

        				state.selected.px = ax
        				state.selected.py = ay

        				state.selected.element = dxCreateElement(state.selected.name, ax, ay, parent, state.selected.path)
        				table.insert(settings.creados, state.selected.element)

                        --if not dxIsElementParent(state.selected.element) then
                        
                        --end

        				state.cursorMoved = 'size'


        			end
        		end
        	else
        		state.cursorMoved = nil
                if isElement(state.selected.element) then
        		    state.selected.name = nil
                end
        	end
        else
            if s == 'down' then
                for i = #settings.creados, 1, -1 do

                    local v = settings.creados[i]
                    if v and isPointOverElement(ax, ay, v) then
                        
                        state.selected.element = v
                        return 
                    end
                end

                state.selected.element = nil
            end
        end
    end
)



addEventHandler( "onClientCursorMove", root,
    function ( _, _, ax, ay )
    	if isCursorShowing() then
    		if state.selected.name then

        		if isElement(state.selected.element) then
        			if state.cursorMoved == 'size' then

	        			local w, h = dxGetProperty(state.selected.element, 'w'), dxGetProperty(state.selected.element, 'h')

	        			if ax >= state.selected.px then
	        				w = ax - state.selected.px
	        			end

	        			if ay >= state.selected.py then
	        				h = ay - state.selected.py
	        			end

                       -- print(dxGetProperty(state.selected.element, 'text'))
	        			dxSetSize(state.selected.element, math.max(2, w), math.max(2, h))

	        		end
        		end
        	end
        end
    end
);



function dxFormatCode(copy)

    local code = 'local sx, sy = guiGetScreenSize()'
    code = code..'\nlocal sw, sh = sx/'..sx..', sy/'..sy
    code = code..'\n\ndxEditor = {}'

    local count = {}

    for i = 1, #settings.creados, 1 do
        local v = settings.creados[i]
        local type = dxGetProperty(v, 'type')

        if not count[type] then

            code = code.."\ndxEditor['"..type.."'] = {}"

            count[type] = true
        end
    end

    code = code..'\n'

    local count = {}
    local variables = {}

    for i = 1, #settings.creados, 1 do
        local v = settings.creados[i]
        local elementType = dxGetProperty(v, 'type')
       -- local elementParent = dxGetProperty(v, property)

        local arguments = {}
        for _, property in ipairs(settings.defaultPropertys[elementType]) do

            local value = dxGetProperty(v, property)

            if property == 'wh' then

                if dxGetProperty(v, 'vertical') then
                    value = dxGetProperty(v, 'h')..'*sh'
                else
                    value = dxGetProperty(v, 'w')..'*sw'
                end

            elseif property == 'x' or property == 'w' then 

                value = value..'*sw'

            elseif property == 'y' or property == 'h' then

                value = value..'*sh'

            elseif type(value) == 'string' then

                value = "'"..value.."'"

            elseif property ~= 'parent' then

                value = tostring(value)

            end

            --print(inspect({v, property, value}))
            if property == 'parent' then
                value = tostring(variables[value])
            end

            table.insert(arguments, value)
        end
            
        if not count[elementType] then
            count[elementType] = 0
        end

        count[elementType] = count[elementType] + 1
        code = code.."\ndxEditor['"..elementType.."']["..count[elementType]..'] = '..elementType..'('..table.concat(arguments, ', ')..')'

        variables[v] = "dxEditor['"..elementType.."']["..count[elementType]..']'
    end

    if copy then
        outputChatBox('* dxEditor copy!', 0, 220, 0)
        setClipboard( code )
    end

    return code
end

