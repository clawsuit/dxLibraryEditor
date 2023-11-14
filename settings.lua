settings = {}
settings.alpha = 255
showCursor(true)

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

addEventHandler( 'onClick', getRootElement(),
	function()
		if state.elements.Create.list == source then

			local v = select(2, dxGridListGetItemSelected(source))
			if v then

				state.selected = {}
				state.selected.name = v[1]
				state.bt = {name='Create', tick=getTickCount(  ), state='out'}

			end
		end
	end
)


