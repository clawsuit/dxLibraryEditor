local old_click;

addEventHandler("onClientRender", root,
    function()

    	local click = getKeyState 'mouse1' and not old_click;
        old_click = getKeyState 'mouse1'

       -- dxDrawText(inspect(state), sx/2, 0)

    	local x = 0
    	for i, v in ipairs(settings.buttoms) do

            if v.func then
                dxDrawImage(414*sw+x, 715*sh, 40*sw, 40*sw, settings.backgroundButtom, 0, 0, 0, tocolor(255,255,255,settings.alpha), true)

                if v.func == 'Create'  then
                    dxDrawImage(414*sw+x, 715*sh, 40*sw, 40*sw, v.path, 0, 0, 0, tocolor(255, 255, 255, settings.alpha), true)
                elseif v.func == 'Reset'  then
                    dxDrawImage(419*sw+x, 720*sh, 30*sw, 30*sw, v.path, 0, 0, 0, tocolor(255, 255, 255, settings.alpha), true)
                else
                    dxDrawImage((419+2.5)*sw+x, (720+2.5)*sh, 25*sw, 25*sw, v.path, 0, 0, 0, tocolor(255, 255, 255, settings.alpha), true)
                end

                if not state.bt.name and isCursorOver(414*sw+x, 715*sh, 40*sw, 40*sw) then
                    dxDrawText2(v.func, 414*sw+x, 700*sh, 40*sw, 15, tocolor(255,255,255,settings.alpha), 1, "default-bold", "center", "top", false, false, true)
                end

                if click and settings.alpha == 255 then
                    if isCursorOver(414*sw+x, 715*sh, 40*sw, 40*sw) then

                        if v.func == 'Create' then
                            if not isElement(panelOpciones) and not isElement(panelChange) then
                                if state.bt.name ~= v.func then
                                    state.bt = {name=v.func, tick=getTickCount(  ), state='in'}
                                elseif state.bt.name == v.func then
                                    state.bt = {name=v.func, tick=getTickCount(  ), state='out'}
                                end
                            end
                        elseif v.func == 'Copy Code' then

                            dxFormatCode(true)

                        elseif v.func == 'Reset' then

                            if resetPress and resetPress:isValid() then 
                                for i = #settings.creados, 1, -1 do
                                    destroyElement( (table.remove(settings.creados, i)) )
                                end

                                if isElement(panelOpciones) then
                                    panelOpciones:destroy()
                                end
                
                                if isElement(panelChange) then
                                    panelChange:destroy()
                                    state.selected.element = nil
                                end

                                if optionSelected and optionSelected:find('color') then
                                    colorPicker.closeSelect(true)
                                end

                                optionSelected = nil
                                resetPress = nil
                                state.cursorMoved = nil
                                elementDuplicado = nil
                            else

                                resetPress = Timer(
                                    function()
                                        resetPress = nil
                                    end,
                                3000, 1)

                                outputChatBox('* Estas seguro que desear resetear el editor? #ff0000!!!', 255,255,255, true)
                            end

                        elseif v.func == 'Help' then

                            for i, v in ipairs(settings.helpMessages) do
                                outputChatBox(v, 255, 255, 0, true)
                            end

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
                    state.elements.Create.list:destroy()
   	 				util.visibleList = nil
   	 			end
   	 		else
   	 			if py <= 549*sh then

   	 				if not util.visibleList then
   	 					util.visibleList = true
   	 					createListElements()
   	 				end
   	 			end
   	 		end
   	 	end

        if isElement(state.selected.element) then
            local x, y, w, h = dxGetProperty(state.selected.element, 'x'), dxGetProperty(state.selected.element, 'y'), dxGetProperty(state.selected.element, 'w'), dxGetProperty(state.selected.element, 'h')
            x = x - 2
            y = y - 2
            w = w + 2
            h = h + 2
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

bindKey("c","down",
	function()
		if getKeyState( 'lctrl' ) then
			if settings.alpha == 255 then
                if isElement(state.selected.element) then
                    state.selected.element = dxDuplicateElement(state.selected.element)
                    table.insert(settings.creados, state.selected.element)

                    state.cursorMoved = 'Move'
                    elementDuplicado = true
                    outputChatBox('* Elemento duplicado, muevelo.', 0, 255, 0)
                end
            end
		end
	end
)

bindKey("x","down",
	function()
		if getKeyState( 'lctrl' ) then
			if settings.alpha == 255 then
                if isElement(state.selected.element) then

                    for i = 1, #settings.creados, 1 do
                        local v = settings.creados[i]
                        if isElement(v) and state.selected.element == v then
                            destroyElement( table.remove(settings.creados, i) )
                            break
                        end 
                    end
                    

                    if isElement(panelOpciones) then
                        panelOpciones:destroy()
                    end
    
                    if isElement(panelChange) then
                        panelChange:destroy()
                    end

                    if optionSelected and optionSelected:find('color') then
                        colorPicker.closeSelect(true)
                    end

                    optionSelected = nil
                    resetPress = nil
                    state.cursorMoved = nil
                    elementDuplicado = nil
                    state.selected.element = nil
                    outputChatBox('* Elemento borrado.', 0, 255, 0)
                end
            end
		end
	end
)
 


addEventHandler("onClientClick", root,
    function(b, s, ax, ay)
        if b == 'left' then
        	if s == 'down' then

                if state.cursorMoved == 'Move' or state.cursorMoved == 'Move X' or state.cursorMoved == 'Move Y' or state.cursorMoved == 'Size' or state.cursorMoved == 'Size W' or state.cursorMoved == 'Size H' then
                    state.moveXY = {ax, ay}  
                end

                if not getKeyState('lctrl') then
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

                            state.moveXY = {ax, ay}
                            --state.creando = true

                            state.selected.element = dxCreateElement(state.selected.name, ax, ay, parent, state.selected.path)
                            table.insert(settings.creados, state.selected.element)

                            if state.selected.name == 'dxWindow' then
                                state.selected.element:setParent(settings.parentWindow)
                            end

                            state.cursorMoved = 'Size'
                            state.selected.name = nil

                        end
                    end
                end     

        	else

                state.moveXY = nil
                if not (isElement(listaOpciones)) then

                    --if state.creando then

                        if not elementDuplicado then
                            state.cursorMoved = nil
                        else
                            elementDuplicado = nil
                        end
                       -- state.creando = nil
                    --end
                    
                end
        	end
        else
            if s == 'down' then
                for i = #settings.creados, 1, -1 do

                    local v = settings.creados[i]
                    if v and isPointOverElement(ax, ay, v) then
                        
                        if getKeyState('lctrl') then
                            createPanelOpciones(v)
                        end
                        state.selected.element = v
                        return 
                    end
                end

                if isElement(panelOpciones) then
                    panelOpciones:destroy()
                end

                if not isElement(panelChange) then
                    state.selected.element = nil
                end
            end
        end
    end
)



addEventHandler( "onClientCursorMove", root,
    function ( _, _, ax, ay )
    	if isCursorShowing() and getKeyState('mouse1') then
    		
            if isElement(state.selected.element) then
                if state.cursorMoved == 'Size' or state.cursorMoved == 'Size W' or state.cursorMoved == 'Size H' then

                    if not state.moveXY then return end

                    local x, y, w, h = dxGetProperty(state.selected.element, 'x'), dxGetProperty(state.selected.element, 'y'), dxGetProperty(state.selected.element, 'w'), dxGetProperty(state.selected.element, 'h')
                   -- local w, h = dxGetProperty(state.selected.element, 'w'), dxGetProperty(state.selected.element, 'h')

                    if state.cursorMoved == 'Size' or state.cursorMoved == 'Size W' then
                        if ax >= x then
                            w = ax - x
                        end
                    end

                    if state.cursorMoved == 'Size' or state.cursorMoved == 'Size H' then
                        if ay >= y then
                            h = ay - y
                        end
                    end

                    if state.cursorMoved == 'Size' then
                        setCursorPosition((x+w),(y+h))
                    elseif state.cursorMoved == 'Size W' then
                        setCursorPosition((x+w),(y+h/2))
                    else
                        setCursorPosition((x+w/2),(y+h))
                    end
                    

                    -- print(dxGetProperty(state.selected.element, 'text'))
                    dxSetSize(state.selected.element, math.max(2, w), math.max(2, h))

                elseif state.cursorMoved == 'Move' or state.cursorMoved == 'Move X' or state.cursorMoved == 'Move Y' then

                    if state.moveXY then

                        local x, y = dxGetProperty(state.selected.element, 'x'), dxGetProperty(state.selected.element, 'y')

                        if state.cursorMoved == 'Move' or state.cursorMoved == 'Move X' then
                            x = x + (ax-state.moveXY[1])
                        end

                        if state.cursorMoved == 'Move' or state.cursorMoved == 'Move Y' then
                            y = y + (ay-state.moveXY[2])
                        end

                        state.moveXY = {ax, ay}
                        dxSetPosition(state.selected.element, x, y)
                        
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
        if isElement(v) then
            local type = v:getType()

            if not count[type] then

                code = code.."\ndxEditor['"..type.."'] = {}"

                count[type] = true
            end
        end
    end

    code = code..'\n'

    local count = {}
    local variables = {}

    for i = 1, #settings.creados, 1 do
        local v = settings.creados[i]
        if isElement(v) then
            local elementType = v:getType()
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
    end

    if copy then
        outputChatBox('* dxEditor copy!', 0, 220, 0)
        setClipboard( code )
    end

    return code
end

function calcularNuevoAncho(posicionInicial, anchoInicial, posicionClic)
    -- Calcular la diferencia entre la posición de clic y la posición inicial
    local diferencia = posicionClic - posicionInicial
    
    -- El nuevo ancho es el ancho inicial más la diferencia
    local nuevoAncho = anchoInicial + diferencia
    
    return nuevoAncho
end