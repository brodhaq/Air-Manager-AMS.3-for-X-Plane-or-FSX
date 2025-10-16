--AMS.3 for AM3
--user variables
user_ICAO = user_prop_add_string("Airport ICAO code", "LKPR", "ICAO designator of the airport")
user_airportelevation = user_prop_add_integer("Airport elevation", -1000, 15000, 1240, "Elevation of the airport (feet)")
user_rwy1_hdg = user_prop_add_integer("Magnetic heading of the Primary runway", 001, 360, 241, "Magnetic heading of the primary runway")
user_rwy2_hdg = user_prop_add_integer("Magnetic heading of the Secondary runway", 001, 360, 303, "Magnetic heading of the secondary runway. This is intended for airports with multiple runways. Do NOT use for opposite heading of Primary runway.")
RWY1_heading = user_prop_get(user_rwy1_hdg)
    if RWY1_heading < 5 then
        RWY1_heading = 360
    end
RWY2_heading = user_prop_get(user_rwy2_hdg)
    if RWY2_heading < 5 then
        RWY2_heading = 360
    end
user_defaultTL = user_prop_add_integer("Default traisition level", 10, 200, 60, "Default Transition Level")
RWY1_dir1 = string.format("%02d",tostring(var_round(RWY1_heading/10)))
    if var_round(RWY1_heading/10) > 18 then
        RWY1_dir2 = string.format("%02d",tostring(var_round((RWY1_heading-180)/10)))
    else
        RWY1_dir2 = string.format("%02d",tostring(var_round((RWY1_heading+180)/10)))
    end

RWY2_dir1 = string.format("%02d",tostring(var_round(RWY2_heading/10)))
    if var_round(RWY2_heading/10) > 18 then
        RWY2_dir2 = string.format("%02d",tostring(var_round((RWY2_heading-180)/10)))
    else
        RWY2_dir2 = string.format("%02d",tostring(var_round((RWY2_heading+180)/10)))
    end
ICAO = user_prop_get(user_ICAO)
defaultTL = user_prop_get(user_defaultTL)
airportelevation = user_prop_get(user_airportelevation)
user_language = user_prop_add_enum("Menu language", "English,Czech", "English", "Choose main menu language. This changes only few of menu items, exactly like real unit")

--system initialization, do not touch
RWY1_dir_primary = 1
RWY2_dir_primary = 1

--common items
img_background = img_add_fullscreen("background.png")
img_top_bar = img_add("top_bar.png",0,0,1280,67)
img_menu = img_add("menu.png",0,0,187,1024)
img_vfr = img_add("vfr.png",978,33,58,38)
txt_vfr = txt_add("VFR", "font:ARIALN.TTF; size:19; color:white; halign:center;", 978, 41, 58, 20)
img_atis = img_add("atis.png",1042,33,40,38)
txt_atis = txt_add("K", "font:ARIALN.TTF; size:19; color:white; halign:center;", 1042, 41, 40, 20)
img_date = img_add("date.png",1090,33,86,38)
txt_date = txt_add("04.12. 17:55", "font:ARIALN.TTF; size:17; color:white; halign:center;", 1090, 43, 86, 20)
img_role = img_add("role.png",1183,33,87,38)
txt_role = txt_add("TEC", "font:ARIALN.TTF; size:17; color:white; halign:center;", 1183, 43, 87, 20)

--window runway 1
img_window_runway1 = img_add("window.png",196,148,269,302)
img_window_header_runway1 = img_add("window_header.png",196,119,269,29)
img_runway1_wind_dir_left = img_add("wind_2.png",199,154,73,27)
img_runway1_wind_speed_left = img_add("wind_2.png",199,184,73,27)
img_runway1_wind_dir_center = img_add("wind_1.png",275,154,109,27)
img_runway1_wind_speed_center = img_add("wind_1.png",275,184,109,27)
img_runway1_wind_dir_right = img_add("wind_2.png",387,154,73,27)
img_runway1_wind_speed_right = img_add("wind_2.png",387,184,73,27)
img_runway1_headwind = img_add("wind_2.png",199,350,108,27)
img_runway1_crosswind = img_add("wind_2.png",354,350,108,27)
img_runway1_cloudbase = img_add("wind_2.png",199,380,263,27)
img_runway1_circle = img_add("rwy_circle.png",257,218,149,135)
img_runway1_rvr1 = img_add("rvr.png",223,420,77,27)
img_runway1_rvr1_red = img_add("red.png",223,420,77,27)
img_runway1_rvr1_green = img_add("green.png",223,420,77,27)
img_runway1_rvr1_yellow = img_add("yellow.png",223,420,77,27)
img_runway1_rvr2 = img_add("rvr.png",303,420,77,27)
img_runway1_rvr2_red = img_add("red.png",303,420,77,27)
img_runway1_rvr2_green = img_add("green.png",303,420,77,27)
img_runway1_rvr2_yellow = img_add("yellow.png",303,420,77,27)
img_runway1_rvr3 = img_add("rvr.png",383,420,79,27)
img_runway1_rvr3_red = img_add("red.png",383,420,79,27)
img_runway1_rvr3_green = img_add("green.png",383,420,79,27)
img_runway1_rvr3_yellow = img_add("yellow.png",383,420,79,27)
img_runway1_windsymbol = img_add("windsymbol.png",325,229,10,104)
rotate(img_runway1_windsymbol, 89)
img_runway1_rwysymbol = img_add("rwysymbol.png",324,237,12,88)
rotate(img_runway1_rwysymbol, RWY1_heading)
txt_weather_rwy1_window = txt_add("WEATHER "..RWY1_dir1.."/"..RWY1_dir2, "font:ARIALN.TTF; size:17; color:white; halign:left;", 201, 126, 130, 20)
txt_wd_rwy1_1 = txt_add("WD", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 203, 163, 30, 10)
txt_wd__val_rwy1_1 = txt_add("070", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 203, 158, 60, 30)
txt_wd_unit_rwy1_1 = txt_add("DEG", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 250, 163, 30, 10)
txt_wd_rwy1_2 = txt_add("WD", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 282, 163, 30, 10)
txt_wd__val_rwy1_2 = txt_add("090", "font:ARIALNB.TTF; size:25; color:black; halign:center;", 297, 156, 60, 30)
txt_wd_unit_rwy1_2 = txt_add("DEG", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 360, 163, 30, 10)
txt_wd_rwy1_3 = txt_add("WD", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 391, 163, 30, 10)
txt_wd__val_rwy1_3 = txt_add("110", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 391, 158, 60, 30)
txt_wd_unit_rwy1_3 = txt_add("DEG", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 438, 163, 30, 10)
txt_ws_rwy1_1 = txt_add("WS", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 203, 193, 30, 10)
txt_ws__val_rwy1_1 = txt_add("2", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 203, 188, 60, 30)
txt_ws_unit_rwy1_1 = txt_add("KT", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 250, 193, 30, 10)
txt_ws_rwy1_2 = txt_add("WS", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 282, 193, 30, 10)
txt_ws__val_rwy1_2 = txt_add("3", "font:ARIALNB.TTF; size:25; color:black; halign:center;", 297, 186, 60, 30)
txt_ws_unit_rwy1_2 = txt_add("KT", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 360, 193, 30, 10)
txt_ws_rwy1_3 = txt_add("WS", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 391, 193, 30, 10)
txt_ws_val_rwy1_3 = txt_add("6", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 391, 188, 60, 30)
txt_ws_unit_rwy1_3 = txt_add("KT", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 438, 193, 30, 10)
txt_hw_rwy1 = txt_add("HW", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 203, 358, 30, 10)
txt_hw_val_rwy1 = txt_add("T03", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 220, 354, 60, 30)
txt_hw_unit_rwy1 = txt_add("KT", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 291, 358, 30, 10)
txt_avg_rwy1 = txt_add("2' AVG", "font:ARIALN.TTF; size:12; color:white; halign:center;", 315, 358, 30, 10)
txt_cw_rwy1 = txt_add("CW", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 358, 358, 30, 10)
txt_cw_val_rwy1 = txt_add("L01", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 375, 354, 60, 30)
txt_cw_unit_rwy1 = txt_add("KT", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 446, 358, 30, 10)
txt_cldbase_rwy1 = txt_add("BASE NCD", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 205, 384, 250, 30)
txt_rvr_rwy1 = txt_add("RVR", "font:ARIALN.TTF; size:12; color:white; halign:left;", 200, 433, 30, 10)
txt_tdz_rwy1 = txt_add("TDZ", "font:ARIALN.TTF; size:12; color:white; halign:left;", 253, 409, 30, 10)
txt_mid_rwy1 = txt_add("MID", "font:ARIALN.TTF; size:12; color:white; halign:left;", 334, 409, 30, 10)
txt_end_rwy1 = txt_add("END", "font:ARIALN.TTF; size:12; color:white; halign:left;", 414, 409, 30, 10)
txt_10km_rwy1_1 = txt_add("10km", "font:ARIALN.TTF; size:12; color:black; halign:left;", 277, 420, 30, 10)
txt_10km_rwy1_2 = txt_add("10km", "font:ARIALN.TTF; size:12; color:black; halign:left;", 357, 420, 30, 10)
txt_10km_rwy1_3 = txt_add("10km", "font:ARIALN.TTF; size:12; color:black; halign:left;", 437, 420, 30, 10)
txt_m_rwy1_1 = txt_add("m", "font:ARIALN.TTF; size:12; color:black; halign:left;", 292, 436, 30, 10)
txt_m_rwy1_2 = txt_add("m", "font:ARIALN.TTF; size:12; color:black; halign:left;", 373, 436, 30, 10)
txt_m_rwy1_3 = txt_add("m", "font:ARIALN.TTF; size:12; color:black; halign:left;", 453, 436, 30, 10)
txt_rvr1_rwy1 = txt_add("PS", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 210, 427, 100, 30)
txt_rvr2_rwy1 = txt_add("PS", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 290, 427, 100, 30)
txt_rvr3_rwy1 = txt_add("PS", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 370, 427, 100, 30)
group_runway1= group_add(img_window_runway1, img_window_header_runway1, img_runway1_wind_dir_left, img_runway1_wind_speed_left, img_runway1_wind_dir_center, img_runway1_wind_speed_center, img_runway1_wind_dir_right, img_runway1_wind_speed_right, img_runway1_headwind, img_runway1_crosswind, img_runway1_cloudbase, img_runway1_circle, img_runway1_rvr1, img_runway1_rvr2, img_runway1_rvr3, img_runway1_windsymbol, img_runway1_rwysymbol, txt_weather_rwy1_window, txt_wd_rwy1_1, txt_wd__val_rwy1_1, txt_wd_unit_rwy1_1, txt_wd_rwy1_2, txt_wd__val_rwy1_2, txt_wd_unit_rwy1_2, txt_wd_rwy1_3, txt_wd__val_rwy1_3, txt_wd_unit_rwy1_3, txt_ws_rwy1_1, txt_ws__val_rwy1_1, txt_ws_unit_rwy1_1, txt_ws_rwy1_2, txt_ws__val_rwy1_2, txt_ws_unit_rwy1_2, txt_ws_rwy1_3, txt_ws_val_rwy1_3, txt_ws_unit_rwy1_3, txt_hw_rwy1, txt_hw_val_rwy1, txt_hw_unit_rwy1, txt_avg_rwy1, txt_cw_rwy1, txt_cw_val_rwy1, txt_cw_unit_rwy1, txt_cldbase_rwy1, txt_rvr_rwy1, txt_tdz_rwy1, txt_mid_rwy1, txt_end_rwy1, txt_10km_rwy1_1, txt_10km_rwy1_2, txt_10km_rwy1_3, txt_m_rwy1_1, txt_m_rwy1_2, txt_m_rwy1_3, txt_rvr1_rwy1, txt_rvr2_rwy1, txt_rvr3_rwy1)
visible(img_runway1_rvr1_red, false)
visible(img_runway1_rvr2_red, false)
visible(img_runway1_rvr3_red, false)
visible(img_runway1_rvr1_green, false)
visible(img_runway1_rvr2_green, false)
visible(img_runway1_rvr3_green, false)
visible(img_runway1_rvr1_yellow, false)
visible(img_runway1_rvr2_yellow, false)
visible(img_runway1_rvr3_yellow, false)

--window runway 2
img_window_runway2 = img_add("window.png",998,148,269,302)
img_window_header_runway2 = img_add("window_header.png",998,119,269,29)
img_runway2_wind_dir_left = img_add("wind_2.png",1003,154,73,27)
img_runway2_wind_speed_left = img_add("wind_2.png",1003,184,73,27)
img_runway2_wind_dir_center = img_add("wind_1.png",1079,154,109,27)
img_runway2_wind_speed_center = img_add("wind_1.png",1079,184,109,27)
img_runway2_wind_dir_right = img_add("wind_2.png",1191,154,73,27)
img_runway2_wind_speed_right = img_add("wind_2.png",1191,184,73,27)
img_runway2_headwind = img_add("wind_2.png",1001,350,108,27)
img_runway2_crosswind = img_add("wind_2.png",1156,350,108,27)
img_runway2_cloudbase = img_add("wind_2.png",1001,380,263,27)
img_runway2_circle = img_add("rwy_circle.png",1060,218,149,135)
img_runway2_rvr1 = img_add("rvr.png",1025,420,77,27)
img_runway2_rvr1_red = img_add("red.png",1025,420,77,27)
img_runway2_rvr1_green = img_add("green.png",1025,420,77,27)
img_runway2_rvr1_yellow = img_add("yellow.png",1025,420,77,27)
img_runway2_rvr2 = img_add("rvr.png",1105,420,77,27)
img_runway2_rvr2_red = img_add("red.png",1105,420,77,27)
img_runway2_rvr2_green = img_add("green.png",1105,420,77,27)
img_runway2_rvr2_yellow = img_add("yellow.png",1105,420,77,27)
img_runway2_rvr3 = img_add("rvr.png",1185,420,79,27)
img_runway2_rvr3_red = img_add("red.png",1185,420,79,27)
img_runway2_rvr3_green = img_add("green.png",1185,420,79,27)
img_runway2_rvr3_yellow = img_add("yellow.png",1185,420,79,27)
img_runway2_windsymbol = img_add("windsymbol.png",1128,229,10,104)
rotate(img_runway2_windsymbol, 89)
img_runway2_rwysymbol = img_add("rwysymbol.png",1127,237,12,88)
rotate(img_runway2_rwysymbol, RWY2_heading)
txt_weather_rwy2_window = txt_add("WEATHER 30/12", "font:ARIALN.TTF; size:17; color:white; halign:left;", 1003, 126, 130, 20)
txt_wd_rwy2_1 = txt_add("WD", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 1007, 163, 30, 10)
txt_wd__val_rwy2_1 = txt_add("070", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 1007, 158, 60, 30)
txt_wd_unit_rwy2_1 = txt_add("DEG", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 1054, 163, 30, 10)
txt_wd_rwy2_2 = txt_add("WD", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 1086, 163, 30, 10)
txt_wd__val_rwy2_2 = txt_add("090", "font:ARIALNB.TTF; size:25; color:black; halign:center;", 1101, 156, 60, 30)
txt_wd_unit_rwy2_2 = txt_add("DEG", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 1164, 163, 30, 10)
txt_wd_rwy2_3 = txt_add("WD", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 1195, 163, 30, 10)
txt_wd__val_rwy2_3 = txt_add("110", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 1195, 158, 60, 30)
txt_wd_unit_rwy2_3 = txt_add("DEG", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 1242, 163, 30, 10)
txt_ws_rwy2_1 = txt_add("WS", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 1007, 193, 30, 10)
txt_ws__val_rwy2_1 = txt_add("2", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 1007, 188, 60, 30)
txt_ws_unit_rwy2_1 = txt_add("KT", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 1054, 193, 30, 10)
txt_ws_rwy2_2 = txt_add("WS", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 1086, 193, 30, 10)
txt_ws__val_rwy2_2 = txt_add("3", "font:ARIALNB.TTF; size:25; color:black; halign:center;", 1101, 186, 60, 30)
txt_ws_unit_rwy2_2 = txt_add("KT", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 1164, 193, 30, 10)
txt_ws_rwy2_3 = txt_add("WS", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 1195, 193, 30, 10)
txt_ws__val_rwy2_3 = txt_add("6", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 1195, 188, 60, 30)
txt_ws_unit_rwy2_3 = txt_add("KT", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 1242, 193, 30, 10)
txt_hw_rwy1 = txt_add("HW", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 1007, 358, 30, 10)
txt_hw_val_rwy2 = txt_add("T03", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 1024, 354, 60, 30)
txt_hw_unit_rwy2 = txt_add("KT", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 1095, 358, 30, 10)
txt_avg_rwy2 = txt_add("2' AVG", "font:ARIALN.TTF; size:12; color:white; halign:center;", 1119, 358, 30, 10)
txt_cw_rwy2 = txt_add("CW", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 11628, 358, 30, 10)
txt_cw_val_rwy2 = txt_add("L01", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 1179, 354, 60, 30)
txt_cw_unit_rwy2 = txt_add("KT", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 1250, 358, 30, 10)
txt_cldbase_rwy2 = txt_add("BASE NCD", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 1009, 384, 250, 30)
txt_rvr_rwy2 = txt_add("RVR", "font:ARIALN.TTF; size:12; color:white; halign:left;", 1004, 433, 30, 10)
txt_tdz_rwy2 = txt_add("TDZ", "font:ARIALN.TTF; size:12; color:white; halign:left;", 1057, 409, 30, 10)
txt_mid_rwy2 = txt_add("MID", "font:ARIALN.TTF; size:12; color:white; halign:left;", 1138, 409, 30, 10)
txt_end_rwy2 = txt_add("END", "font:ARIALN.TTF; size:12; color:white; halign:left;", 1218, 409, 30, 10)
txt_10km_rwy2_1 = txt_add("10km", "font:ARIALN.TTF; size:12; color:black; halign:left;", 1079, 420, 30, 10)
txt_10km_rwy2_2 = txt_add("10km", "font:ARIALN.TTF; size:12; color:black; halign:left;", 1159, 420, 30, 10)
txt_10km_rwy2_3 = txt_add("10km", "font:ARIALN.TTF; size:12; color:black; halign:left;", 1239, 420, 30, 10)
txt_m_rwy2_1 = txt_add("m", "font:ARIALN.TTF; size:12; color:black; halign:left;", 1094, 436, 30, 10)
txt_m_rwy2_2 = txt_add("m", "font:ARIALN.TTF; size:12; color:black; halign:left;", 1175, 436, 30, 10)
txt_m_rwy2_3 = txt_add("m", "font:ARIALN.TTF; size:12; color:black; halign:left;", 1255, 436, 30, 10)
txt_rvr1_rwy2 = txt_add("PS", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 1014, 427, 100, 30)
txt_rvr2_rwy2 = txt_add("PS", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 1094, 427, 100, 30)
txt_rvr3_rwy2 = txt_add("PS", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 1174, 427, 100, 30)
group_runway2 = group_add(img_window_runway2, img_window_header_runway2, img_runway2_wind_dir_left, img_runway2_wind_speed_left, img_runway2_wind_dir_center, img_runway2_wind_speed_center, img_runway2_wind_dir_right, img_runway2_wind_speed_right, img_runway2_headwind, img_runway2_crosswind, img_runway2_cloudbase, img_runway2_circle, img_runway2_rvr1, img_runway2_rvr2, img_runway2_rvr3, img_runway2_windsymbol, img_runway2_rwysymbol, txt_weather_rwy2_window, txt_wd_rwy2_1, txt_wd__val_rwy2_1, txt_wd_unit_rwy2_1, txt_wd_rwy2_2, txt_wd__val_rwy2_2, txt_wd_unit_rwy2_2, txt_wd_rwy2_3, txt_wd__val_rwy2_3, txt_wd_unit_rwy2_3, txt_ws_rwy2_1, txt_ws__val_rwy2_1, txt_ws_unit_rwy2_1, txt_ws_rwy2_2, txt_ws__val_rwy2_2, txt_ws_unit_rwy2_2, txt_ws_rwy2_3, txt_ws__val_rwy2_3, txt_ws_unit_rwy2_3, txt_hw_rwy1, txt_hw_val_rwy2, txt_hw_unit_rwy2, txt_avg_rwy2, txt_cw_rwy2, txt_cw_val_rwy2, txt_cw_unit_rwy2, txt_cldbase_rwy2, txt_rvr_rwy2, txt_tdz_rwy2, txt_mid_rwy2, txt_end_rwy2, txt_10km_rwy2_1, txt_10km_rwy2_2, txt_10km_rwy2_3, txt_m_rwy2_1, txt_m_rwy2_2, txt_m_rwy2_3, txt_rvr1_rwy2, txt_rvr2_rwy2, txt_rvr3_rwy2)
visible(img_runway2_rvr1_red, false)
visible(img_runway2_rvr2_red, false)
visible(img_runway2_rvr3_red, false)
visible(img_runway2_rvr1_green, false)
visible(img_runway2_rvr2_green, false)
visible(img_runway2_rvr3_green, false)
visible(img_runway2_rvr1_yellow, false)
visible(img_runway2_rvr2_yellow, false)
visible(img_runway2_rvr3_yellow, false)


--airport weather
img_window_weather_airport = img_add("window.png",470,148,523,152)
img_window_header_weather_airport = img_add("window_header.png",470,119,523,29)
img_airport_QNH = img_add("wind_1.png",473,148,200,59)
img_airport_trl = img_add("wind_2.png",473,210,127,27)
img_airport_temp = img_add("wind_2.png",603,210,70,27)
img_airport_pvis = img_add("wind_2.png",473,240,127,27)
img_airport_dp = img_add("wind_2.png",603,240,70,27)
img_airport_trend = img_add("wind_2.png",473,270,517,27)
img_airport_cloud0 = img_add("clouds.png",823,180,167,27)
img_airport_cloud1 = img_add("clouds.png",823,210,167,27)
img_airport_cloud2 = img_add("clouds.png",823,240,167,27)
txt_weather_airport_window = txt_add(ICAO, "font:ARIALN.TTF; size:17; color:white; halign:left;", 475, 126, 130, 20)
txt_qnh = txt_add("QNH", "font:arial.ttf; size:26; color:black; halign:left;", 479, 160, 90, 40)
txt_hpa = txt_add("hPa", "font:arial.ttf; size:26; color:black; halign:left;", 626, 160, 90, 40)
txt_qnh_val = txt_add("1016", "font:arialbd.ttf; size:35; color:black; halign:left;", 539, 156, 90, 40)
txt_qfe = txt_add("QFE", "font:arial.ttf; size:13; color:black; halign:left;", 598, 193, 50, 40)
txt_qfe_val = txt_add("0970", "font:arialbd.ttf; size:13; color:black; halign:left;", 625, 193, 50, 40)
txt_qfe_hpa = txt_add("hPa", "font:arial.ttf; size:13; color:black; halign:left;", 651, 193, 50, 40)
txt_trl = txt_add("TRL", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 479, 219, 30, 10)
txt_trl_value = txt_add("50", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 492, 214, 80, 30)
txt_pvis = txt_add("PVIS", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 479, 249, 30, 10)
txt_pvis_value = txt_add("10KM", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 492, 244, 80, 30)
txt_trend = txt_add("TREND", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 479, 279, 30, 10)
txt_trend_value = txt_add("NOSIG", "font:ARIALNB.TTF; size:22; color:black; halign:left;", 530, 274, 150, 30)
txt_temp = txt_add("T", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 609, 219, 30, 10)
txt_temp_value = txt_add("20", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 598, 214, 80, 30)
txt_temp_unit = txt_add("C", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 661, 219, 30, 10)
txt_dp = txt_add("DP", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 609, 249, 30, 10)
txt_dp_value = txt_add("-20", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 598, 244, 80, 30)
txt_dp_unit = txt_add("C", "font:ARIALN.TTF; size:12; color:#3d3d3d; halign:left;", 661, 249, 30, 10)
txt_clouds_lowest = txt_add("FEW 1500", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 830, 184, 160, 30)
txt_clouds_lower = txt_add("BKN 6600", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 830, 214, 160, 30)
txt_clouds_upper = txt_add("OVC 8000", "font:ARIALNB.TTF; size:22; color:black; halign:center;", 830, 244, 160, 30)
group_airport_weather = group_add(img_window_weather_airport, img_window_header_weather_airport, img_airport_QNH, img_airport_trl, img_airport_temp, img_airport_pvis, img_airport_dp, img_airport_trend, txt_weather_airport_window, txt_qnh, txt_hpa, txt_qnh_val, txt_qfe, txt_qfe_val, txt_qfe_hpa, txt_trl, txt_trl_value, txt_pvis, txt_pvis_value, txt_trend, txt_trend_value, txt_temp, txt_temp_value, txt_temp_unit, txt_dp, txt_dp_value, txt_dp_unit) 
visible(txt_clouds_lowest, false)
visible(txt_clouds_lower, false)
visible(txt_clouds_upper, false)
visible(img_airport_cloud0, false)
visible(img_airport_cloud1, false)
visible(img_airport_cloud2, false)
local airportmeteoallowed = 1
local ATIS = "K"


--runway 1 lights window
--img_window_lights_runway1 = img_add("window.png",196,483,646,130)
--img_window_header_lights_runway1 = img_add("window_header.png",196,454,646,29)
--txt_lights_rwy1_window = txt_add("RWY 24/06", "font:ARIALN.TTF; size:17; color:white; halign:left;", 201, 461, 130, 20)

function rwy1_toggle()
    if RWY1_dir_primary == 1 then
        RWY1_dir_primary = 2
        txt_set(txt_rwyID_rwy1, RWY1_dir2)
        rotate(img_runway1_rwysymbol, RWY1_heading+180)
    else
        RWY1_dir_primary = 1
        txt_set(txt_rwyID_rwy1, RWY1_dir1)
        rotate(img_runway1_rwysymbol, RWY1_heading)
    end
    new_wind()
    new_rvr()
end

function rwy2_toggle()
    if RWY2_dir_primary == 1 then
        RWY2_dir_primary = 2
        txt_set(txt_rwyID_rwy2, ""..RWY2_dir2)
        rotate(img_runway2_rwysymbol, RWY2_heading+180)
    else
        RWY2_dir_primary = 1
        txt_set(txt_rwyID_rwy2, ""..RWY2_dir1)
        rotate(img_runway2_rwysymbol, RWY2_heading)
    end
    new_wind()
    new_rvr()
end

function rwy1_close()
    switch_set_position(switch_weather_rwy1, 1)
    visible(group_runway1, false)
end

function rwy2_close()
    switch_set_position(switch_weather_rwy2, 1)
    visible(group_runway2, false)
end

function weather_airport_close()
    airportmeteoallowed = 0
    switch_set_position(switch_weather_airport, 1)
    visible(group_airport_weather, false)
    request_callback(new_clouds)
end

function lights_runway1_close()
end

function weather_airport_toggle(position)
    if position == 0 then
        switch_set_position(switch_weather_airport, 1)
        visible(group_airport_weather, false)
        airportmeteoallowed = 0
    else
        switch_set_position(switch_weather_airport, 0)
        visible(group_airport_weather, true)
        airportmeteoallowed = 1
    end
    request_callback(new_clouds)
end

function weather_rwy1_toggle(position)
    if position == 0 then
        switch_set_position(switch_weather_rwy1, 1)
        visible(group_runway1, false)
    else
        switch_set_position(switch_weather_rwy1, 0)
        visible(group_runway1, true)
    end
end

function weather_rwy2_toggle(position)
    if position == 0 then
        switch_set_position(switch_weather_rwy2, 1)
        visible(group_runway2, false)
    else
        switch_set_position(switch_weather_rwy2, 0)
        visible(group_runway2, true)
    end
end

function set_defaults()
    switch_set_position(switch_weather_airport, 0)
        visible(group_airport_weather, true)
    switch_set_position(switch_weather_rwy1, 0)
        visible(group_runway1, true)
    switch_set_position(switch_weather_rwy2, 0)
        visible(group_runway2, true)
end


--buttons and switches
button_rwy1 = button_add("rwy_button.png","rwy_button_pressed.png",198,218,50,50,rwy1_toggle,nil)
button_rwy2 = button_add("rwy_button.png","rwy_button_pressed.png",1000,218,50,50,rwy2_toggle,nil)
button_window_cross_runway1 = button_add("cross.png","cross_pressed.png",407,121,57,23,rwy1_close,nil)
button_window_cross_runway2 = button_add("cross.png","cross_pressed.png",1209,121,57,23,rwy2_close,nil)
button_window_cross_weather_airport = button_add("cross.png","cross_pressed.png",936,121,57,23,weather_airport_close,nil)
--button_window_cross_lights_runway1 = button_add("cross.png","cross_pressed.png",785,456,57,23,lights_runway1_close,nil)
switch_weather_airport = switch_add("switch.png", "switch_empty.png",7,87,176,46,weather_airport_toggle)
switch_weather_rwy1 = switch_add("switch.png", "switch_empty.png",7,135,176,46,weather_rwy1_toggle)
switch_weather_rwy2 = switch_add("switch.png", "switch_empty.png",7,183,176,46,weather_rwy2_toggle)
button_defaults = button_add("switch_empty.png","switch.png",7,39,176,46,set_defaults,nil)

--button texts
txt_default = txt_add("VÝCHOZÍ NASTAVENÍ", "font:ARIALN.TTF; size:17; color:white; halign:left;", 28, 55, 130, 20)
    if user_prop_get(user_language) == "English" then
        txt_set(txt_default, "DEFAULT SETTINGS")
    end
txt_weather_airport = txt_add("WEATHER "..ICAO, "font:ARIALN.TTF; size:17; color:white; halign:left;", 28, 103, 130, 20)
txt_weather_rwy1 = txt_add("WEATHER "..RWY1_dir1.."/"..RWY1_dir2, "font:ARIALN.TTF; size:17; color:white; halign:left;", 28, 151, 130, 20)
txt_weather_rwy2 = txt_add("WEATHER 30/12", "font:ARIALN.TTF; size:17; color:white; halign:left;", 28, 199, 130, 20)
txt_lights_rwy1 = txt_add("RWY "..RWY1_dir1.."/"..RWY1_dir2, "font:ARIALN.TTF; size:17; color:white; halign:left;", 28, 247, 130, 20)
txt_lights_rwy2 = txt_add("RWY "..RWY2_dir1.."/"..RWY2_dir2, "font:ARIALN.TTF; size:17; color:white; halign:left;", 28, 295, 130, 20)
txt_twy_blocks = txt_add("TWY BLOKY", "font:ARIALN.TTF; size:17; color:white; halign:left;", 28, 343, 130, 20)
    if user_prop_get(user_language) == "English" then
        txt_set(txt_twy_blocks, "TWY BLOCKS")
    end
txt_twys = txt_add("TWY ÚSEKY", "font:ARIALN.TTF; size:17; color:white; halign:left;", 28, 391, 130, 20)
    if user_prop_get(user_language) == "English" then
        txt_set(txt_twys, "TWY SECTIONS")
    end
txt_relief = txt_add("RELIEF", "font:ARIALN.TTF; size:17; color:white; halign:left;", 28, 439, 130, 20)
txt_atis_btn = txt_add("ATIS", "font:ARIALN.TTF; size:17; color:white; halign:left;", 28, 487, 130, 20)
txt_snowtam = txt_add("SNOWTAM", "font:ARIALN.TTF; size:17; color:white; halign:left;", 28, 535, 130, 20)
txt_snowtam = txt_add("SNOWTAM", "font:ARIALN.TTF; size:17; color:white; halign:left;", 28, 535, 130, 20)
txt_srss = txt_add("SR/SS", "font:ARIALN.TTF; size:17; color:white; halign:left;", 28, 583, 130, 20)
txt_LVP = txt_add("LVP", "font:ARIALN.TTF; size:17; color:white; halign:left;", 28, 631, 130, 20)
txt_rwyID_rwy1 = txt_add(""..RWY1_dir1, "font:ARIALN.TTF; size:23; color:white; halign:center;", 202, 233, 40, 40)
txt_rwyID_rwy2 = txt_add(""..RWY2_dir1, "font:ARIALN.TTF; size:23; color:white; halign:center;", 1004, 233, 40, 40)
group_obj_add(group_runway1, txt_rwyID_rwy1, button_rwy1, button_window_cross_runway1)
group_obj_add(group_runway2, txt_rwyID_rwy2, button_rwy2, button_window_cross_runway2)
group_obj_add(group_airport_weather, button_window_cross_weather_airport)

function new_QNH(QNH)
    QNH = tonumber(string.format("%." .. (0) .. "f", QNH))
    QFE = tonumber(string.format("%." .. (0) .. "f", QNH-(airportelevation/28.0454545454545454545)))
    txt_set(txt_qnh_val, string.format("%04d",QNH))
    txt_set(txt_qfe_val, string.format("%04d",QFE))

    if QNH >= 1051 then
        txt_set(txt_trl_value, defaultTL-10)
    elseif QNH >= 1014 and QNH < 1051 then
        txt_set(txt_trl_value, defaultTL)  
    elseif QNH >= 978 and QNH < 1014 then
        txt_set(txt_trl_value, defaultTL+10)  
    else
        txt_set(txt_trl_value, defaultTL+20)
    end
      
end

function new_QNH_xpl(QNH)
    new_QNH(QNH * 33.863886666667)
end

function new_temp(temp)
    temp = tonumber(string.format("%." .. (0) .. "f", temp))
    txt_set(txt_temp_value, temp) 
end

function new_dp(dewpoint)
    dewpoint = tonumber(string.format("%." .. (0) .. "f", dewpoint))
    txt_set(txt_dp_value, dewpoint) 
end

random_dir_rwy1_1 = 0
random_dir_rwy1_2 = 0
random_dir_rwy2_1 = 0
random_dir_rwy2_2 = 0
random_vel_rwy1_1 = 0
random_vel_rwy1_2 = 0
random_vel_rwy2_1 = 0
random_vel_rwy2_2 = 0
dir = 0
vel = 0

function new_wind_read(direction,velocity)
    dir = direction
    vel = velocity
end

function new_wind()
    if dir+random_dir_rwy1_1 > 10 then
        dir_rwy1_1 = dir+random_dir_rwy1_1
    else
        dir_rwy1_1 = 360
    end
    if dir+random_dir_rwy1_2 > 10 then
        dir_rwy1_2 = dir+random_dir_rwy1_2
    else
        dir_rwy1_2 = 360
    end
    if dir+random_dir_rwy2_1 > 10 then
        dir_rwy2_1 = dir+random_dir_rwy2_1
    else
        dir_rwy2_1 = 360
    end
    if dir+random_dir_rwy2_2 > 10 then
        dir_rwy2_2 = dir+random_dir_rwy2_2
    else
       dir_rwy2_2 = 360
    end 
    vel_rwy1_1 = vel+random_vel_rwy1_1
    vel_rwy1_2 = vel+random_vel_rwy1_2
    vel_rwy2_1 = vel+random_vel_rwy2_1
    vel_rwy2_2 = vel+random_vel_rwy2_2

    if dir-10 >=20 then
        txt_set(txt_wd__val_rwy1_1,string.format("%03d",var_format((dir-10)/10,0).."0"))
        txt_set(txt_wd__val_rwy2_1,string.format("%03d",var_format((dir-10)/10,0).."0"))
    else
        txt_set(txt_wd__val_rwy1_1,"360")
        txt_set(txt_wd__val_rwy2_1,"360")
    end

    if dir+10 <=360 then
        txt_set(txt_wd__val_rwy1_3,string.format("%03d",var_format((dir+10)/10,0).."0"))
        txt_set(txt_wd__val_rwy2_3,string.format("%03d",var_format((dir+10)/10,0).."0"))
    else
        txt_set(txt_wd__val_rwy1_3,"360")
        txt_set(txt_wd__val_rwy2_3,"360")
    end

    txt_set(txt_ws__val_rwy1_1,var_format(var_cap(vel-3,0,99),0))
    txt_set(txt_ws_val_rwy1_3,var_format(var_cap(vel+3,0,99),0))
    txt_set(txt_ws__val_rwy2_1,var_format(var_cap(vel-3,0,99),0))
    txt_set(txt_ws__val_rwy2_3,var_format(var_cap(vel+3,0,99),0))

    if RWY1_dir_primary == 1 then 
        txt_set(txt_wd__val_rwy1_2,string.format("%03d",var_format(dir_rwy1_1/10,0).."0"))
        txt_set(txt_ws__val_rwy1_2,var_format(var_cap(vel_rwy1_1,0,99),0))
        rotate(img_runway1_windsymbol, (var_format(dir_rwy1_1/10,0)*10)-1)
        if math.cos(math.rad(dir_rwy1_1-RWY1_heading))> 0 then
            txt_set(txt_hw_val_rwy1,"H"..string.format("%02d",var_format(math.cos(math.rad(dir_rwy1_1-RWY1_heading))*var_cap(vel_rwy1_1,0,99),0)))
        else
            txt_set(txt_hw_val_rwy1,"T"..string.format("%02d",var_format(math.abs(math.cos(math.rad(dir_rwy1_1-RWY1_heading)))*var_cap(vel_rwy1_1,0,99),0)))
        end
        if  math.sin(math.rad(dir_rwy1_1-RWY1_heading))> 0 then
            txt_set(txt_cw_val_rwy1,"R"..string.format("%02d",var_format(math.sin(math.rad(dir_rwy1_1-RWY1_heading))*var_cap(vel_rwy1_1,0,99),0)))
        else
            txt_set(txt_cw_val_rwy1,"L"..string.format("%02d",var_format(math.abs(math.sin(math.rad(dir_rwy1_1-RWY1_heading)))*var_cap(vel_rwy1_1,0,99),0)))
        end
        
    else
        txt_set(txt_wd__val_rwy1_2,string.format("%03d",var_format(dir_rwy1_2/10,0).."0"))
        txt_set(txt_ws__val_rwy1_2,var_format(var_cap(vel_rwy1_2,0,99),0))
        rotate(img_runway1_windsymbol, (var_format(dir_rwy1_2/10,0)*10)-1)
        if math.cos(math.rad(dir_rwy1_2-(RWY1_heading-180)))> 0 then
            txt_set(txt_hw_val_rwy1,"H"..string.format("%02d",var_format(math.cos(math.rad(dir_rwy1_2-RWY1_heading-180))*var_cap(vel_rwy1_2,0,99),0)))
        else
            txt_set(txt_hw_val_rwy1,"T"..string.format("%02d",var_format(math.abs(math.cos(math.rad(dir_rwy1_2-RWY1_heading-180)))*var_cap(vel_rwy1_2,0,99),0)))
        end
        if  math.sin(math.rad(dir_rwy1_2-RWY1_heading-180))> 0 then
            txt_set(txt_cw_val_rwy1,"R"..string.format("%02d",var_format(math.sin(math.rad(dir_rwy1_2-RWY1_heading-180))*var_cap(vel_rwy1_2,0,99),0)))
        else
            txt_set(txt_cw_val_rwy1,"L"..string.format("%02d",var_format(math.abs(math.sin(math.rad(dir_rwy1_2-RWY1_heading-180)))*var_cap(vel_rwy1_2,0,99),0)))
        end

    end

    if RWY2_dir_primary == 1 then 
        txt_set(txt_wd__val_rwy2_2,string.format("%03d",var_format(dir_rwy2_1/10,0).."0"))
        txt_set(txt_ws__val_rwy2_2,var_format(var_cap(vel_rwy2_1,0,99),0))
        rotate(img_runway2_windsymbol, (var_format(dir_rwy2_1/10,0)*10)-1)
        if math.cos(math.rad(dir_rwy2_1-RWY2_heading))> 0 then
            txt_set(txt_hw_val_rwy2,"H"..string.format("%02d",var_format(math.cos(math.rad(dir_rwy2_1-RWY2_heading))*var_cap(vel_rwy2_1,0,99),0)))
        else
            txt_set(txt_hw_val_rwy2,"T"..string.format("%02d",var_format(math.abs(math.cos(math.rad(dir_rwy2_1-RWY2_heading)))*var_cap(vel_rwy2_1,0,99),0)))
        end
        if  math.sin(math.rad(dir_rwy2_1-RWY2_heading))> 0 then
            txt_set(txt_cw_val_rwy2,"R"..string.format("%02d",var_format(math.sin(math.rad(dir_rwy2_1-RWY2_heading))*var_cap(vel_rwy2_1,0,99),0)))
        else
            txt_set(txt_cw_val_rwy2,"L"..string.format("%02d",var_format(math.abs(math.sin(math.rad(dir_rwy2_1-RWY2_heading)))*var_cap(vel_rwy2_1,0,99),0)))
        end
    else
        txt_set(txt_wd__val_rwy2_2,string.format("%03d",var_format(dir_rwy2_2/10,0).."0"))
        txt_set(txt_ws__val_rwy2_2,var_format(var_cap(vel_rwy2_2,0,99),0))
        rotate(img_runway2_windsymbol, (var_format(dir_rwy2_2/10,0)*10)-1)
        if math.cos(math.rad(dir_rwy2_2-RWY2_heading-180))> 0 then
            txt_set(txt_hw_val_rwy2,"H"..string.format("%02d",var_format(math.cos(math.rad(dir_rwy2_2-RWY2_heading-180))*var_cap(vel_rwy2_2,0,99),0)))
        else
            txt_set(txt_hw_val_rwy2,"T"..string.format("%02d",var_format(math.abs(math.cos(math.rad(dir_rwy2_2-RWY2_heading)))*var_cap(vel_rwy2_2,0,99),0)))
        end
        if  math.sin(math.rad(dir_rwy2_2-RWY2_heading-180))> 0 then
            txt_set(txt_cw_val_rwy2,"R"..string.format("%02d",var_format(math.sin(math.rad(dir_rwy2_2-RWY2_heading-180))*var_cap(vel_rwy2_2,0,99),0)))
        else
            txt_set(txt_cw_val_rwy2,"L"..string.format("%02d",var_format(math.abs(math.sin(math.rad(dir_rwy2_2-RWY2_heading-180)))*var_cap(vel_rwy2_2,0,99),0)))
        end
    end
end

  

function calculate_wind_randoms()
    random_dir_rwy1_1 = math.random(-10,10)
    random_dir_rwy1_2 = math.random(-10,10)
    random_dir_rwy2_1 = math.random(-10,10)
    random_dir_rwy2_2 = math.random(-10,10)
    random_vel_rwy1_1 = math.random(-3,3)
    random_vel_rwy1_2 = math.random(-3,3)
    random_vel_rwy2_1 = math.random(-3,3)
    random_vel_rwy2_2 = math.random(-3,3)
    new_wind()
end

pvis = 0

function new_rvr()
--set VIS in METAR > 400 and <=1000 for LVP preparation
--set VIS in METAR <=400 for LVP activation
    rvr_rwy1_1 = random_rvr_rwy1_1*pvis
    rvr_rwy1_2 = random_rvr_rwy1_2*pvis
    rvr_rwy1_3 = random_rvr_rwy1_3*pvis
    rvr_rwy2_1 = random_rvr_rwy2_1*pvis
    rvr_rwy2_2 = random_rvr_rwy2_2*pvis
    rvr_rwy2_3 = random_rvr_rwy2_3*pvis

    if pvis <= 400 then
        var_cap(rvr_rwy1_1,75,600)
        var_cap(rvr_rwy1_2,75,600)
        var_cap(rvr_rwy1_3,75,600)
        var_cap(rvr_rwy2_1,75,600)
        var_cap(rvr_rwy2_2,75,600)
        var_cap(rvr_rwy2_3,75,600)
    elseif pvis > 400 and pvis <= 1000 then
        var_cap(rvr_rwy1_1,600,1500)
        var_cap(rvr_rwy1_2,600,1500)
        var_cap(rvr_rwy1_3,600,1500)
        var_cap(rvr_rwy2_1,600,1500)
        var_cap(rvr_rwy2_2,600,1500)
        var_cap(rvr_rwy2_3,600,1500)
    elseif pvis > 1000 then
        var_cap(rvr_rwy1_1,1600,2500)
        var_cap(rvr_rwy1_2,1600,2500)
        var_cap(rvr_rwy1_3,1600,2500)
        var_cap(rvr_rwy2_1,1600,2500)
        var_cap(rvr_rwy2_2,1600,2500)
        var_cap(rvr_rwy2_3,1600,2500)        
    end

    if rvr_rwy1_1 < 50 then
        rvr_rwy1_1 = "M50"
    elseif rvr_rwy1_1 >=50 and rvr_rwy1_1 < 400 then
        rvr_rwy1_1 = math.floor(rvr_rwy1_1/25)*25
    elseif rvr_rwy1_1 >=400 and rvr_rwy1_1 < 800 then
        rvr_rwy1_1 = math.floor(rvr_rwy1_1/50)*50
    elseif rvr_rwy1_1 >=800 and rvr_rwy1_1 < 2000 then
        rvr_rwy1_1 = math.floor(rvr_rwy1_1/100)*100
    elseif rvr_rwy1_1 > 2000 then
        rvr_rwy1_1 = "PS"
    end

    if rvr_rwy1_2 < 50 then
        rvr_rwy1_2 = "M50"
    elseif rvr_rwy1_2 >=50 and rvr_rwy1_2 < 400 then
        rvr_rwy1_2 = math.floor(rvr_rwy1_2/25)*25
    elseif rvr_rwy1_2 >=400 and rvr_rwy1_2 < 800 then
        rvr_rwy1_2 = math.floor(rvr_rwy1_2/50)*50
    elseif rvr_rwy1_2 >=800 and rvr_rwy1_2 < 2000 then
        rvr_rwy1_2 = math.floor(rvr_rwy1_2/100)*100
    elseif rvr_rwy1_2 > 2000 then
        rvr_rwy1_2 = "PS"
    end

    if rvr_rwy1_3 < 50 then
        rvr_rwy1_3 = "M50"
    elseif rvr_rwy1_3 >=50 and rvr_rwy1_3 < 400 then
        rvr_rwy1_3 = math.floor(rvr_rwy1_3/25)*25
    elseif rvr_rwy1_3 >=400 and rvr_rwy1_3 < 800 then
        rvr_rwy1_3 = math.floor(rvr_rwy1_3/50)*50
    elseif rvr_rwy1_3 >=800 and rvr_rwy1_3 < 2000 then
        rvr_rwy1_3 = math.floor(rvr_rwy1_3/100)*100
    elseif rvr_rwy1_3 > 2000 then
        rvr_rwy1_3 = "PS"
    end

    if rvr_rwy2_1 < 50 then
        rvr_rwy2_1 = "M50"
    elseif rvr_rwy2_1 >=50 and rvr_rwy2_1 < 400 then
        rvr_rwy2_1 = math.floor(rvr_rwy2_1/25)*25
    elseif rvr_rwy2_1 >=400 and rvr_rwy2_1 < 800 then
        rvr_rwy2_1 = math.floor(rvr_rwy2_1/50)*50
    elseif rvr_rwy2_1 >=800 and rvr_rwy2_1 < 2000 then
        rvr_rwy2_1 = math.floor(rvr_rwy2_1/100)*100
    elseif rvr_rwy2_1 > 2000 then
        rvr_rwy2_1 = "PS"
    end

    if rvr_rwy2_2 < 50 then
        rvr_rwy2_2 = "M50"
    elseif rvr_rwy2_2 >=50 and rvr_rwy2_2 < 400 then
        rvr_rwy2_2 = math.floor(rvr_rwy2_2/25)*25
    elseif rvr_rwy2_2 >=400 and rvr_rwy2_2 < 800 then
        rvr_rwy2_2 = math.floor(rvr_rwy2_2/50)*50
    elseif rvr_rwy2_2 >=800 and rvr_rwy2_2 < 2000 then
        rvr_rwy2_2 = math.floor(rvr_rwy2_2/100)*100
    elseif rvr_rwy2_2 > 2000 then
        rvr_rwy2_2 = "PS"
    end

    if rvr_rwy2_3 < 50 then
        rvr_rwy2_3 = "M50"
    elseif rvr_rwy2_3 >=50 and rvr_rwy2_3 < 400 then
        rvr_rwy2_3 = math.floor(rvr_rwy2_3/25)*25
    elseif rvr_rwy2_3 >=400 and rvr_rwy2_3 < 800 then
        rvr_rwy2_3 = math.floor(rvr_rwy2_3/50)*50
    elseif rvr_rwy2_3 >=800 and rvr_rwy2_3 < 2000 then
        rvr_rwy2_3 = math.floor(rvr_rwy2_3/100)*100
    elseif rvr_rwy2_3 > 2000 then
        rvr_rwy2_3 = "PS"
    end

    if RWY1_dir_primary == 1 then 
        txt_set(txt_rvr1_rwy1, rvr_rwy1_1)
        txt_set(txt_rvr2_rwy1, rvr_rwy1_2)
        txt_set(txt_rvr3_rwy1, rvr_rwy1_3)
    else
        txt_set(txt_rvr1_rwy1, rvr_rwy1_3)
        txt_set(txt_rvr2_rwy1, rvr_rwy1_2)
        txt_set(txt_rvr3_rwy1, rvr_rwy1_1)
    end       
    if RWY2_dir_primary == 1 then 
        txt_set(txt_rvr1_rwy2, rvr_rwy2_1)
        txt_set(txt_rvr2_rwy2, rvr_rwy2_2)
        txt_set(txt_rvr3_rwy2, rvr_rwy2_3)
    else
        txt_set(txt_rvr1_rwy2, rvr_rwy2_3)
        txt_set(txt_rvr2_rwy2, rvr_rwy2_2)
        txt_set(txt_rvr3_rwy2, rvr_rwy2_1)
    end

end

function calculate_rvr_randoms()
    random_rvr_rwy1_1 = math.random(13,17)/10
    random_rvr_rwy1_2 = math.random(13,17)/10
    random_rvr_rwy1_3 = math.random(13,17)/10
    random_rvr_rwy2_1 = math.random(13,17)/10
    random_rvr_rwy2_2 = math.random(13,17)/10
    random_rvr_rwy2_3 = math.random(13,17)/10
    new_rvr()
end

cldbase = 9999
function new_vfr()
    if pvis >= 5000 and cldbase >= 1500 then
        txt_set(txt_vfr, "VFR")
    else
        if pvis >= 1500 then
            txt_set(txt_vfr, "ZVFR")
        elseif pvis >= 800 and pvis < 1500 then
           txt_set(txt_vfr, "ZVFR-H")
        else
           txt_set(txt_vfr, "HEMS")       
        end
    end
end


function new_vis(vis)
      pvis = vis
    if vis < 50 then
        txt_set(txt_pvis_value,"M50")
    elseif vis >=50 and vis < 800 then
        txt_set(txt_pvis_value,math.floor(50*var_format(vis/50,0)))
    elseif vis >=800 and vis < 5000 then
        txt_set(txt_pvis_value,math.floor(100*var_format(vis/100,0)))
    elseif vis >= 5000 and vis < 10000 then
        txt_set(txt_pvis_value,math.floor(var_format(vis/1000,1)).."KM")
    elseif vis >= 10000 then
        txt_set(txt_pvis_value,"10KM")
    end
new_rvr()
new_vfr()
end



function new_clouds(lowercloudbase, uppercloudbase, stormcloudbase, lowercloudcover, uppercloudcover, stormcloudcover, stormcloudtype)
    lowercloudcover = math.abs(lowercloudcover/8192)
    if var_format(lowercloudcover,0) == "8" then
        lowercloud = "OVC "
    elseif var_format(lowercloudcover,0) == "7" or var_format(lowercloudcover,0) == "6" or var_format(lowercloudcover,0) == "5" then
        lowercloud = "BKN "
    elseif var_format(lowercloudcover,0) == "4" or var_format(lowercloudcover,0) == "3" then
        lowercloud = "SCT "
    elseif var_format(lowercloudcover,0) == "2" or var_format(lowercloudcover,0) == "1" then
        lowercloud = "FEW "
    elseif lowercloudcover == 0.0001220703125 then
        lowercloud = "OVC "
    else
        lowercloud = "BKN "
    end
    txt_set(txt_clouds_lowest, (lowercloud)..math.floor(((lowercloudbase-airportelevation+200)/100),0)*100)



    uppercloudcover = math.abs(uppercloudcover/8192)
    if var_format(uppercloudcover,0) == "8" then
        uppercloud = "OVC "
    elseif var_format(uppercloudcover,0) == "7" or var_format(uppercloudcover,0) == "6" or var_format(uppercloudcover,0) == "5" then
        uppercloud = "BKN "
    elseif var_format(uppercloudcover,0) == "4" or var_format(uppercloudcover,0) == "3" then
        uppercloud = "SCT "
    elseif var_format(uppercloudcover,0) == "2" or var_format(uppercloudcover,0) == "1" then
        uppercloud = "FEW "
    elseif uppercloudcover == 0.0001220703125 then
        uppercloud = "OVC "
    else
        uppercloud = "BKN "
    end
    txt_set(txt_clouds_lower, (uppercloud)..math.floor(((uppercloudbase-airportelevation+200)/100),0)*100)

    stormcloudcover = math.abs(stormcloudcover/8192)
    if var_format(stormcloudcover,0) == "8" then
        stormcloud = "OVC CB "
    elseif var_format(stormcloudcover,0) == "7" or var_format(stormcloudcover,0) == "6" or var_format(stormcloudcover,0) == "5" then
        stormcloud = "BKN CB "
    elseif var_format(stormcloudcover,0) == "4" or var_format(stormcloudcover,0) == "3" then
        stormcloud = "SCT CB "
    elseif var_format(stormcloudcover,0) == "2" or var_format(stormcloudcover,0) == "1" then
        stormcloud = "FEW CB "
    elseif stormcloudcover == 0.0001220703125 then
        stormcloud = "OVC CB "
    else
        stormcloud = "BKN CB "
    end
    txt_set(txt_clouds_upper, (stormcloud)..math.floor(((stormcloudbase-airportelevation+200)/100),0)*100)

    if  lowercloudcover ~= 0 and airportmeteoallowed == 1 then 
        visible(txt_clouds_lowest, true)
        visible(img_airport_cloud0, true)

        if lowercloud == "OVC " or lowercloud == "BKN " then
            txt_set(txt_cldbase_rwy1, "BASE "..math.floor(((lowercloudbase-airportelevation+200)/100),0)*100)
            txt_set(txt_cldbase_rwy2, "BASE "..math.floor(((lowercloudbase-airportelevation+200)/100),0)*100)
            cldbase = math.floor(((lowercloudbase-airportelevation+200)/100),0)*100
        else
            txt_set(txt_cldbase_rwy1, "BASE NCD")  
            txt_set(txt_cldbase_rwy2, "BASE NCD") 
            cldbase = 9999
        end           
    else
        visible(txt_clouds_lowest, false)
        visible(img_airport_cloud0, false) 
        txt_set(txt_cldbase_rwy1, "BASE NCD")  
        txt_set(txt_cldbase_rwy2, "BASE NCD") 
        cldbase = 9999 
    end   

    if  uppercloudcover ~= 0 and airportmeteoallowed == 1 then 
        visible(txt_clouds_lower, true)
        visible(img_airport_cloud1, true)
    else
        visible(txt_clouds_lower, false)
        visible(img_airport_cloud1, false)   
    end  

    if  stormcloudcover ~= 0 and airportmeteoallowed == 1 then 
        visible(txt_clouds_upper, true)
        visible(img_airport_cloud2, true)
    else
        visible(txt_clouds_upper, false)
        visible(img_airport_cloud2, false)   
    end  
new_vfr()
end

function new_atis()
    if ATIS == "K" then
        ATIS = "L"
        txt_set(txt_atis, "L")
    elseif ATIS == "L" then
        ATIS = "M"
        txt_set(txt_atis, "M")
    elseif ATIS == "M" then
        ATIS = "N"
        txt_set(txt_atis, "N")
    elseif ATIS == "N" then
        ATIS = "O"
        txt_set(txt_atis, "O")
    elseif ATIS == "O" then
        ATIS = "P"
        txt_set(txt_atis, "P")
    elseif ATIS == "P" then
        ATIS = "Q"
        txt_set(txt_atis, "Q")
    elseif ATIS == "Q" then
        ATIS = "R"
        txt_set(txt_atis, "R")
    elseif ATIS == "R" then
        ATIS = "K"
        txt_set(txt_atis, "K")
    end
end

local atis_called = 0

function atis_called_reset()
    atis_called = 0
end




function new_time(year,month,day,seconds)
    --txt_date = txt_add("04.12. 17:55"
    txt_set(txt_date, string.format("%02d",day).."."..string.format("%02d",month)..". "..string.format("%02d",math.floor(seconds/3600))..":"..(string.format("%02.f", math.floor(seconds/60 - (string.format("%02.f", math.floor(seconds/3600))*60)))))
    
    if atis_called == 0 and (string.format("%02.f", math.floor(seconds/60 - (string.format("%02.f", math.floor(seconds/3600))*60))))== "00" then
        atis_called = 1
        new_atis()
        timer_atis_called_reset = timer_start(90000,nil,atis_called_reset)
    end

    if atis_called == 0 and (string.format("%02.f", math.floor(seconds/60 - (string.format("%02.f", math.floor(seconds/3600))*60))))== "30" then
        atis_called = 1
        new_atis()
        timer_atis_called_reset = timer_start(90000,nil,atis_called_reset)
    end
end

function new_time_xpl(month,day,seconds)
    local year = os.date("%Y")
    new_time(year,month,day,seconds)
end

fsx_variable_subscribe("SEA LEVEL PRESSURE","Millibars",new_QNH)
xpl_dataref_subscribe("sim/weather/barometer_sealevel_inhg", "FLOAT", new_QNH_xpl)
fsx_variable_subscribe("AMBIENT TEMPERATURE","Celsius",new_temp)
xpl_dataref_subscribe("sim/weather/temperature_ambient_c", "FLOAT", new_temp)
fsx_variable_subscribe("L:DEWPOINT","number",new_dp)
xpl_dataref_subscribe("sim/weather/dewpoi_sealevel_c", "FLOAT", new_dp)
fsx_variable_subscribe("AMBIENT WIND DIRECTION", "Degrees",
                       "AMBIENT WIND VELOCITY", "Knots", new_wind_read)
xpl_dataref_subscribe("sim/weather/wind_direction_degt", "FLOAT",
                      "sim/weather/wind_speed_kt", "FLOAT", new_wind_read)
fsx_variable_subscribe("AMBIENT VISIBILITY","Meters",new_vis)
xpl_dataref_subscribe("sim/weather/visibility_reported_m", "FLOAT", new_vis)
fsx_variable_subscribe("L:LOWERCLOUDBASE", "number",
                       "L:UPPERCLOUDBASE", "number", 
                       "L:STORMCLOUDBASE", "number",
                       "L:LOWERCLOUDCOVER", "number",
                       "L:UPPERCLOUDCOVER", "number",
                       "L:STORMCLOUDCOVER", "number",
                       "L:STORMCLOUDTYPE", "number", new_clouds)
xpl_dataref_subscribe("sim/weather/cloud_base_msl_m[0]", "FLOAT",
                      "sim/weather/cloud_base_msl_m[1]", "FLOAT",
                      "sim/weather/cloud_base_msl_m[2]", "FLOAT",
                      "sim/weather/cloud_coverage[0]", "FLOAT",
                      "sim/weather/cloud_coverage[1]", "FLOAT",
                      "sim/weather/cloud_coverage[2]", "FLOAT", new_clouds)

fsx_variable_subscribe("ZULU YEAR", "number",
                       "ZULU MONTH OF YEAR", "number", 
                       "ZULU DAY OF MONTH", "number",
                       "ZULU TIME", "Seconds", new_time)
xpl_dataref_subscribe("sim/cockpit2/clock_timer/current_month", "INT",
                      "sim/cockpit2/clock_timer/current_day", "INT",
                      "sim/time/zulu_time_sec", "FLOAT", new_time_xpl)

timer_wind_randoms = timer_start(0,120000,calculate_wind_randoms)
timer_rvr_randoms = timer_start(0,500000,calculate_rvr_randoms)
calculate_rvr_randoms()
