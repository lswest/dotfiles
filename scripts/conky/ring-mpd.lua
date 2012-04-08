-- Change these settings to affect your background.
-- "corner_r" is the radius, in pixels, of the rounded corners. If you don't want rounded corners, use 0.
corner_r=35
-- Set the colour and transparency (alpha) of your background.
bg_colour=0x000000
bg_alpha=0.4

settings_table = {
	{
		name='mpd_percent',
		arg='',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.2,
		fg_colour=0xffffff,
		fg_alpha=0.7,
		x=70, y=90,
		radius=60,
		thickness=7,
		start_angle=0,
		end_angle=360
	},
}
require 'cairo'

function conky_my_flag(my_arg)
    flag = my_arg
    return ""
end

function rgb_to_r_g_b(colour,alpha)
    return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function draw_ring(cr,t,pt)
    local w,h=conky_window.width,conky_window.height
    local port=pt['max']
    local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
    local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']

    local arc_w = 2*math.pi/port -- Sets width of arc to 1/"max"nth of a circle
    local angle_0 = sa*(2*math.pi/360)-math.pi/2 -- Converts the starting angle to radians & translates to starting from the top
    local angle_f = ea*(2*math.pi/360)-math.pi/2
    local t_arc = angle_0 + t*2*math.pi -- Converts the percentage to a part of 2*pi radians & adds the starting angle

    -- Draw background ring
    cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
    cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
    cairo_set_line_width(cr,ring_w)
    cairo_stroke(cr)
    -- Draw indicator ring
    cairo_arc(cr, xc, yc, ring_r, angle_0, t_arc+arc_w)
    cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
    cairo_stroke(cr)
end
function conky_ring_stats()
    local function setup_rings(cr,pt)
        local str=''
        local value=0

        str=string.format('${%s %s}',pt['name'],pt['arg'])
        str=conky_parse(str)
        value=tonumber(str)
        pct=value/pt['max']
	draw_ring(cr,pct,pt)
    end
    local function draw_bg()
        if conky_window==nil then return end
        local w=conky_window.width
        local h=conky_window.height
        local cs=cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, w, h)
        cr=cairo_create(cs)
        
        cairo_move_to(cr,corner_r,0)
        cairo_line_to(cr,w-corner_r,0)
        cairo_curve_to(cr,w,0,w,0,w,corner_r)
        cairo_line_to(cr,w,h-corner_r)
        cairo_curve_to(cr,w,h,w,h,w-corner_r,h)
        cairo_line_to(cr,corner_r,h)
        cairo_curve_to(cr,0,h,0,h,0,h-corner_r)
        cairo_line_to(cr,0,corner_r)
        cairo_curve_to(cr,0,0,0,0,corner_r,0)
        cairo_close_path(cr)
        
        cairo_set_source_rgba(cr,rgb_to_r_g_b(bg_colour,bg_alpha))
        cairo_fill(cr)
    end

    if conky_window==nil then return end
    local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)

    local cr=cairo_create(cs)
if tonumber(flag) == 1 then
    local updates=conky_parse('${updates}')
    update_num=tonumber(updates)

    if update_num>5 then
        for i in pairs(settings_table) do
            draw_bg()
            setup_rings(cr,settings_table[i])
        end
    end
end
cairo_destroy(cr)
end
