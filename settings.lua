settings = {} --
settings.alpha = 255 -- 50
showCursor(settings.alpha == 255)

settings.parentWindow = Element('_windowParent_')

settings.backgroundButtom = svgCreateRoundedRectangle(40*sw, 40*sw, 5, tocolor(17, 17, 17, 255), 2, tocolor(150, 150, 150, 255))
settings.backgroundListCreate = svgCreateRoundedRectangle(110*sw, 156*sh, 5, tocolor(17, 17, 17, 255))

settings.buttoms = {
	{func='Create', path=dxCreateTexture("files/create.png", "dxt5", true, 'clamp')},
	{func='Output', path=dxCreateTexture("files/output.png", "dxt5", true, 'clamp')},
	{func='Copy Code', path=dxCreateTexture("files/copy.png", "dxt5", true, 'clamp')},
	{func='Reset', path=dxCreateTexture("files/reset.png", "dxt5", true, 'clamp')},

}
 
settings.elements = {
	'dxWindow',
	'dxButton',
	'dxLabel',
	'dxEdit',
	'dxTabPanel',
	'dxGridList',
	'dxCheckBox',
	'dxImage',
	'dxList',
	'dxProgressBar',
	'dxRadioButton',
	'dxScroll',
	'dxScrollPane',
	'dxSwitchButton',
}

settings.defaultPropertys = {
	['dxWindow']       = {'x', 'y', 'w', 'h', 'title', 'closebutton', 'rounded', 'border', 'colorbackground', 'colortitle', 'colorborder'},
	['dxButton']       = {'x', 'y', 'w', 'h', 'text', 'parent', 'rounded', 'colorbackground', 'colortext', 'colorselected'},
	['dxLabel']        = {'x', 'y', 'w', 'h', 'text', 'parent', 'alignX', 'alignY', 'border', 'colortext', 'colorborder', 'guiCoord'},
	['dxEdit']         = {'x', 'y', 'w', 'h', 'title', 'parent', 'rounded', 'colorbackground', 'colortile', 'colorborder', 'colorselected'},
	['dxTabPanel']     = {'x', 'y', 'w', 'h', 'parent', 'rounded', 'vertical', 'columnWidth', 'colorbackground', 'colortext', 'colorselected'},
	['dxGridList']     = {'x', 'y', 'w', 'h', 'parent', 'colorbackground', 'colortext', 'colorselected', 'colorLine', 'colorScrollBack', 'colorScrollBoton', 'colorScrollText'},
	['dxCheckBox']     = {'x', 'y', 'text', 'parent', 'rounded', 'colorbackground', 'colortext', 'colorborder', 'colorchecker'},
	['dxImage']        = {'x', 'y', 'w', 'h', 'path', 'parent', 'colorbackground', 'colorformat', 'mipmaps', 'textureType'},
	['dxList']         = {'x', 'y', 'w', 'h', 'parent', 'rounded', 'colorbackground', 'colortext', 'colorrectangle', 'colorrectangle2'},
	['dxProgressBar']  = {'x', 'y', 'w', 'h', 'parent', 'colorbackground', 'colorprogress', 'colortext'},
	['dxRadioButton']  = {'x', 'y', 'text', 'parent', 'colorbackground', 'colortext', 'colorselected', 'colorborder'},
	['dxScroll']       = {'x', 'y', 'wh', 'vertical', 'parent', 'rounded', 'colorbackground', 'colorboton', 'colortext'},
	['dxScrollPane']   = {'x', 'y', 'w', 'h', 'parent', 'colorbackground'},
	['dxSwitchButton'] = {'x', 'y', 'w', 'h', 'parent', 'colorbackground', 'colorOn', 'colorOff'},
}

settings.options = {
	['dxWindow']       = {'Move', 'Move X', 'Move Y', 'Size', 'Size W', 'Size H', 'title', 'closebutton', 'rounded', 'border', 'colorbackground', 'colortitle', 'colorborder'},
	-- ['dxButton']       = {'x', 'y', 'w', 'h', 'text', 'parent', 'rounded', 'colorbackground', 'colortext', 'colorselected'},
	-- ['dxLabel']        = {'x', 'y', 'w', 'h', 'text', 'parent', 'alignX', 'alignY', 'border', 'colortext', 'colorborder', 'guiCoord'},
	-- ['dxEdit']         = {'x', 'y', 'w', 'h', 'title', 'parent', 'rounded', 'colorbackground', 'colortile', 'colorborder', 'colorselected'},
	-- ['dxTabPanel']     = {'x', 'y', 'w', 'h', 'parent', 'rounded', 'vertical', 'columnWidth', 'colorbackground', 'colortext', 'colorselected'},
	 ['dxGridList']     = {'Move', 'Move X', 'Move Y', 'Size', 'Size W', 'Size H', 'colorbackground', 'colortext', 'colorselected', 'colorLine', 'colorScrollBack', 'colorScrollBoton', 'colorScrollText'},
	-- ['dxCheckBox']     = {'x', 'y', 'text', 'parent', 'rounded', 'colorbackground', 'colortext', 'colorborder', 'colorchecker'},
	-- ['dxImage']        = {'x', 'y', 'w', 'h', 'path', 'parent', 'colorbackground', 'colorformat', 'mipmaps', 'textureType'},
	-- ['dxList']         = {'x', 'y', 'w', 'h', 'parent', 'rounded', 'colorbackground', 'colortext', 'colorrectangle', 'colorrectangle2'},
	-- ['dxProgressBar']  = {'x', 'y', 'w', 'h', 'parent', 'colorbackground', 'colorprogress', 'colortext'},
	-- ['dxRadioButton']  = {'x', 'y', 'text', 'parent', 'colorbackground', 'colortext', 'colorselected', 'colorborder'},
	-- ['dxScroll']       = {'x', 'y', 'wh', 'vertical', 'parent', 'rounded', 'colorbackground', 'colorboton', 'colortext'},
	-- ['dxScrollPane']   = {'x', 'y', 'w', 'h', 'parent', 'colorbackground'},
	-- ['dxSwitchButton'] = {'x', 'y', 'w', 'h', 'parent', 'colorbackground', 'colorOn', 'colorOff'},
}

settings.creados = {}


state = {
	bt = {},

	elements = {
		['Create'] = {
			list = dxGridList(380*sw, 549*sh, 108*sw, 156*sh, nil, tocolor(0,0,0,0), tocolor(255,255,255), tocolor(30,30,30), -1, tocolor(0,0,0,0), tocolor(20, 190, 86, 0), tocolor(20, 190, 86, 0)),
			visibleList = nil
		}
	},

	selected = {
		name = nil,
		element = nil,
	},

	cursorMoved = nil,
}

do
	dxGridListAddColumn(state.elements.Create.list, 'Elementos', 0.5, 'center')
	dxSetPostGui(state.elements.Create.list, true)
	dxSetVisible(state.elements.Create.list, false)


	for _, v in ipairs(settings.elements) do
		dxGridListAddItem(state.elements.Create.list, v)
	end

	local h, v = dxGridListGetScrollHV(state.elements.Create.list)
	dxSetProperty(h, 'forcedVisibleFalse', not false)
end


function createPanelOpciones(element)
	if not isElement(panelOpciones) then
		panelOpciones = dxWindow(1100*sw, 194*sh, 260*sw, 360*sh, 'Propiedades', true, true)
		listaOpciones = dxGridList(1110*sw, 217*sh, 240*sw, 285*sh, panelOpciones, nil, tocolor(255,255,255), tocolor(30,30,30), -1, tocolor(0,0,0,0), tocolor(20, 190, 86, 0), tocolor(20, 190, 86, 0))
		botonOpciones = dxButton(1150*sw, 509*sh, 160*sw, 37*sh, 'Cambiar', panelOpciones, true)
		
		dxGridListAddColumn(listaOpciones, 'Opcion', 2.5, 'left')
		dxGridListAddColumn(listaOpciones, 'Value', 3, 'left')
		refreshListOptions(element)

		dxSetPostGui(panelOpciones, true)
	end
end

function createInputChange(name, title)
	panelChange = dxWindow(525.5*sw, 285*sh, 315*sw, 120*sh, name, true, true)
	editChange  = dxEdit(535.5*sw, 315*sh, 295*sw, 30*sh, (title or '...'), panelChange, 10)
	botonChange = dxButton(618.5*sw, 359*sh, 131*sw, 30*sh, 'Aplicar', panelChange, true)

	dxSetToFront(panelChange)
	dxSetPostGui(panelChange, true)

	addEventHandler( 'onClose', panelChange, 
		function()
			optionSelected = nil
			createPanelOpciones(state.selected.element)
		end
	)
end


function refreshListOptions(element)
	
	dxGridListClear(listaOpciones)
	
	for _, v in ipairs(settings.options[element:getType()]) do

		local value = dxGetProperty(element, v)
		dxGridListAddItem(listaOpciones, v, value or '-')

	end
	
end


addEventHandler( 'onClose', settings.parentWindow, 
	function()
		cancelEvent()
	end
)

addEventHandler( 'onClick', getRootElement(),
	function()
		if state.elements.Create.list == source then

			local v = select(2, dxGridListGetItemSelected(source))
			if v then

				state.selected = {}
				state.selected.name = v[1]
				state.bt = {name='Create', tick=getTickCount(  ), state='out'}

			end

		elseif isElement(botonChange) and source == botonChange then
			
			local text = dxGetText(editChange)
			if optionSelected == 'title' or optionSelected == 'text' then
				dxSetProperty(state.selected.element, optionSelected, text)

			elseif optionSelected == 'rounded' then
				if text == '' or text == 'true' or tonumber(text) then

					local value = tonumber(text)
					if text == 'true' then
						value = true
					end

					dxSetRounded(state.selected.element, value)
				end
			end
			optionSelected = nil
			panelChange:destroy()
			createPanelOpciones(state.selected.element)

		elseif isElement(panelOpciones) and source == botonOpciones then
			local v = select(2, dxGridListGetItemSelected(listaOpciones))
			if v then

				local check
				local update

				if v[1] == 'Move' or v[1] == 'Move X' or v[1] == 'Move Y' or v[1] == 'Size' or v[1] == 'Size W' or v[1] == 'Size H' then

					if v[1] == 'Size' or v[1] == 'Size W' or v[1] == 'Size H' then

						local x, y, w, h = dxGetProperty(state.selected.element, 'x'), dxGetProperty(state.selected.element, 'y'), dxGetProperty(state.selected.element, 'w'), dxGetProperty(state.selected.element, 'h')
						if v[1] == 'Size' then
							setCursorPosition((x+w),(y+h))
						elseif v[1] == 'Size W' then
							setCursorPosition((x+w),(y+h/2))
						else
							setCursorPosition((x+w/2),(y+h))
						end

						state.moveXY = {x,y}
					end

					check = true

				elseif v[1] == 'title' or v[1] == 'text' then

					createInputChange(v[1])
					optionSelected = v[1]
					panelOpciones:destroy()

				elseif v[1] == 'closebutton' then

					dxSetProperty(state.selected.element, v[1], not dxGetProperty(state.selected.element, v[1]))
					update = true

				elseif v[1] == 'rounded' then 

					createInputChange(v[1], 'true or number or empty')
					optionSelected = v[1]
					panelOpciones:destroy()

				end

				if check then
					state.cursorMoved = v[1]
					setTimer(destroyElement, 100, 1, panelOpciones)
				end

				if update then
					panelOpciones:destroy()
					createPanelOpciones(state.selected.element)
				end

				outputChatBox('* Seleccionaste '..v[1], 0, 255, 0)
			end
		end
	end
)