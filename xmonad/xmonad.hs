import XMonad
import Data.Monoid
import Data.List
import System.Exit
import XMonad.Actions.CycleWindows -- classic alt-tab
import XMonad.Actions.DwmPromote   -- swap master like dwm
import XMonad.Hooks.DynamicLog     -- statusbar 
import XMonad.Hooks.EwmhDesktops   -- fullscreenEventHook fixes chrome fullscreen
import XMonad.Hooks.ManageDocks    -- dock/tray mgmt
<<<<<<< HEAD
import XMonad.Hooks.ManageHelpers  -- isFullscreen and doFullFloat
import XMonad.Hooks.SetWMName --hopefully making matlab run
=======
>>>>>>> a7ecb387723b7359c61db5abf86650e0674b35f2
import XMonad.Hooks.UrgencyHook    -- window alert bells 
import XMonad.Layout.NoBorders     -- smart borders on solo clients
import XMonad.Util.EZConfig        -- append key/mouse bindings
import XMonad.Util.Run(spawnPipe)  -- spawnPipe and hPutStrLn
import XMonad.Layout.Named
import XMonad.Layout.PerWorkspace
import System.IO 
 
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
 

escapeColor :: String -> String
escapeColor = wrap "'" "'"

myFont = "'Togoshi Gothic:size=9'"
<<<<<<< HEAD
--myFgColor   = "#9c9c9c"
--myBgColor   = "#0c0c0c"
myFgColor = "#687CA4"
myBgColor = "#0d111b"
myFontColor = "#a7b9dc"
=======
myFgColor   = "#9c9c9c"
myBgColor   = "#0c0c0c"
myFontColor = "#ffffff"
>>>>>>> a7ecb387723b7359c61db5abf86650e0674b35f2
myHighlightColor = "#9F6B00"

myPanelHeight = "18"
myPanelY      = "0"

myMainPanelWidth  = "660"
myConkyPanelWidth = "1040"

<<<<<<< HEAD
ppCurrentColor = dzenColor myHighlightColor "" 
=======
ppCurrentColor = dzenColor myHighlightColor "#0c0c0c" 
>>>>>>> a7ecb387723b7359c61db5abf86650e0674b35f2
ppVisibleColor = dzenColor myHighlightColor ""
ppHiddenColor = dzenColor myFontColor ""
ppHiddenNWColor = dzenColor myFgColor ""
ppLayoutColor = dzenColor myFontColor ""
ppTitleColor = dzenColor myFontColor ""
<<<<<<< HEAD
ppUrgentColor = dzenColor myBgColor myFgColor
myLogHook = ewmhDesktopsLogHook >> setWMName "LG3D"
=======
ppUrgentColor = dzenColor "#ffffff" myFontColor
myLogHook = ewmhDesktopsLogHook
>>>>>>> a7ecb387723b7359c61db5abf86650e0674b35f2

imagePath = "/home/lswest/.xmonad/images/"

--Workspace dzen
myDzenFlags = " -bg " ++ escapeColor myBgColor
            ++ " -fg " ++ escapeColor myFontColor
            ++ " -h " ++ myPanelHeight
            ++ " -fn " ++ myFont
            ++ " -sa c "
            ++ " -y " ++ myPanelY
            ++ " -xs 2 "

statusBarCmd = "dzen2 "
             ++ myDzenFlags
             ++ " -w " ++ myMainPanelWidth
             ++ " -ta l "

--Conky dzen
<<<<<<< HEAD
secondBarCmd = "conky -c ~/.xmonad/.conkyrc_dwm_bar| dzen2 "
=======
secondBarCmd = "conky -c ~/.conkyrc_dwm_bar| dzen2 "
>>>>>>> a7ecb387723b7359c61db5abf86650e0674b35f2
             ++ myDzenFlags
             ++ " -w " ++ myConkyPanelWidth
             ++ " -x " ++ myMainPanelWidth
             ++ " -ta r "
--Pretty Printer (PP)
myPP = dzenPP
    { ppCurrent = ppCurrentColor . \a -> setBgColor ++ "^fg(" ++ myHighlightColor ++ ")" ++ a
    , ppVisible = ppVisibleColor . wrapClickable . (\a -> (a,a))
    , ppHidden  = ppHiddenColor  . wrapClickable . (\a -> (a,setFgColor  ++ setTextColor ++ a))
    , ppHiddenNoWindows = ppHiddenNWColor . wrapClickable . (\wsId -> (wsId,if (':' `elem` wsId) then drop 2 wsId else wsId))
    , ppUrgent  = ppUrgentColor  . wrapClickable . (\a -> (a,a ++ setTextColor)) . dzenStrip 
    , ppLayout  = ppLayoutColor  . wrapLayoutSwitch . 
                          (\ x -> fill (case x of
                              "tiled"       ->  setFgColor ++ imagePad "tall"
                              "mtiled"      ->  setFgColor ++ imagePad "mtall"
                              "full"        ->  setFgColor ++ imagePad "full"
                              _ -> pad x) 4)
    , ppWsSep = " "
    , ppTitle = ppTitleColor . dzenEscape
    }
    where
      setFgColor = "^fg(" ++ myFgColor ++ ")"
      setTextColor = "^fg(" ++ myFontColor ++ ")"
      setBgColor = "^fg(" ++ myBgColor ++ ")"
      fill :: String -> Int -> String
      fill h i = "^p(" ++ show i ++ ")" ++ h ++ "^p(" ++ show i ++ ")"
      image :: String -> String
      image img = "^i(" ++ imagePath ++ img ++ ".xbm)"
      imagePad :: String -> String
      imagePad img = " " ++ (image img)
      currentWsIndex w = case (elemIndex w myWorkspaces) of -- needs to be modified should I decide to use DynamicWorkspaces one day
                                Nothing -> "1"
                                Just n -> show (n+1)
      --wrapClickable expects a tuple in the form (<workspace index>, <text to display>)
<<<<<<< HEAD
      wrapClickable (idx,str) = "^ca(1," ++ xdo index ++ ")" ++ "^ca(3," ++ xdo index ++ ")" ++ str ++ "^ca()^ca()"
=======
      wrapClickable (idx,str) = "^ca(1," ++ xdo "c;" ++ xdo index ++ ")" ++ "^ca(3," ++ xdo "e;" ++ xdo index ++ ")" ++ str ++ "^ca()^ca()"
>>>>>>> a7ecb387723b7359c61db5abf86650e0674b35f2
        where
            index = currentWsIndex idx
            xdo key   = "xdotool key super+" ++ key
      wrapLayoutSwitch content = "^ca(1,xdotool key super+space)" ++ content ++ "^ca()"
-- The main function.
main :: IO ()
main = do
    din <- spawnPipe statusBarCmd
    spawn secondBarCmd
<<<<<<< HEAD
    xmonad (ewmh $ uhook $ defaultConfig { terminal = myTerminal
=======
    xmonad $ ewmh defaultConfig { terminal = myTerminal
>>>>>>> a7ecb387723b7359c61db5abf86650e0674b35f2
                          , focusFollowsMouse  = myFocusFollowsMouse
                          , borderWidth        = myBorderWidth
                          , modMask            = myModMask
                          , workspaces         = myWorkspaces
                          , normalBorderColor  = myNormalBorderColor
                          , focusedBorderColor = myFocusedBorderColor
                        
                          --key bindings
                          , keys               = myKeys
                          , mouseBindings      = myMouseBindings
                        
                          --hooks, layouts
                          , layoutHook         = myLayout
                          , manageHook         = myManageHook
                          , logHook = myLogHook >> (dynamicLogWithPP $ myPP { ppOutput = hPutStrLn din })
                        
<<<<<<< HEAD
                        })
        where
            uhook = withUrgencyHook NoUrgencyHook
=======
                        }
        --where
            --uhook = withUrgencyHookC NoUrgencyHook urgentConfig
>>>>>>> a7ecb387723b7359c61db5abf86650e0674b35f2
            -- Custom PP, configure it as you like. It determines what's being written to the bar.
            --myPP = xmobarPP { ppCurrent = xmobarColor "#9F6B00" "#0c0c0c"
            --                  , ppTitle = shorten 80
            --                  , ppHidden = xmobarColor "#ffffff" "#0c0c0c"
            --                  , ppHiddenNoWindows = xmobarColor "#9c9c9c" "#0c0c0c"
            --                  , ppUrgent = xmobarColor "#0c0c0c" "#ffffff"}
            
            -- Keybinding to toggle the gap for the bar.
            --toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
          --  conf = uhook 

<<<<<<< HEAD
=======
--urgentConfig = UrgencyConfig { suppressWhen = Focused, remindWhen = Dont } 
>>>>>>> a7ecb387723b7359c61db5abf86650e0674b35f2
-- yes, these are functions; just very simple ones
-- that accept no input and return static values
myTerminal    = "urxvt -e uim-fep"
myModMask     = mod4Mask -- Win key or Super_L
myBorderWidth = 0
-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
myWorkspaces    = ["命令","文書","話","ウェブ","日本語","六","七","八","音楽"]
 
-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#0c0c0c"
myLayout = avoidStruts $ smartBorders ( tiled ||| mtiled ||| full )
  where
    full    =  named "full" $ Full
    mtiled  =  named "mtiled" $ Mirror tiled
    tiled   =  named "tiled" $ Tall 1 (5/100) (2/(1+(toRational(sqrt(5)::Double))))

myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
<<<<<<< HEAD
    , className =? "XCalc"          --> doFloat
    , className =? "Thunar"         --> doF (W.shift "文書")
    , className =? "VirtualBox"     --> doFloat
    , className =? "Skype"          --> doFloat <+> doF(W.focusDown) <+> doF (W.shift "話")
    , className =? "Pidgin"         --> doFloat <+> doF (W.shift "話")
    , className =? "Amsn"           --> doFloat <+> doF (W.shift "話")
    , className =? "Kmess"          --> doFloat <+> doF (W.shift "話")
    , className =? "Emesene"        --> doFloat <+> doF (W.shift "話")
    , className =? "Chatwindow"     --> doFloat <+> doF (W.shift "話")
    , className =? "Google-chrome"  --> doF(W.shift "ウェブ")
    , className =? "Vlc"            --> doF(W.shift "六")
    , title =? "Browser"            --> doFloat <+> doF(W.shift "ウエブ")
    , title =? "Download"           --> doFloat <+> doF(W.shift "ウエブ")
    , title =? "Navigator"          --> doF(W.shift "ウエブ")
    , title =? "File Operation Progress" --> doFloat
    , title =? "ncmpcpp"            --> doF(W.shift "音楽")
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore 
    , (isFullscreen --> doFullFloat)
=======
    , className =? "Thunar"         --> doF (W.shift "文書")
    , className =? "VirtualBox"     --> doFloat
    , className =? "Skype"          --> doFloat <+> doF (W.shift "話")
    , className =? "Pidgin"         --> doFloat <+> doF (W.shift "話")
    , className =? "Google-chrome"  --> doF(W.shift "ウェブ")
    , title =? "ncmpcpp"            --> doF(W.shift "音楽")
    , title =? "Browser"            --> doFloat <+> doF(W.shift "ウエブ")
    , title =? "Download"           --> doFloat <+> doF(W.shift "ウエブ")
    , title =? "Navigator"          --> doF(W.shift "ウエブ")
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore 
>>>>>>> a7ecb387723b7359c61db5abf86650e0674b35f2
    , manageDocks
    ]

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
 
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
 
    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
 
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
 
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
 
    [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)   
    -- launch dmenu
<<<<<<< HEAD
    , ((modm,               xK_p     ), spawn "exe=`dmenu_run -nb '#0d111b' -nf '#a7b9dc'` && eval \"exec $exe\"")
=======
    , ((modm,               xK_p     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
>>>>>>> a7ecb387723b7359c61db5abf86650e0674b35f2

    ,((modm, xK_b     ), sendMessage ToggleStruts)
 
    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- Lock screen
<<<<<<< HEAD
    , ((modm,               xK_Escape   ), spawn "xscreensaver-command -lock")
=======
    , ((modm,               xK_F12   ), spawn "xscreensaver-command -lock")
>>>>>>> a7ecb387723b7359c61db5abf86650e0674b35f2
    
    -- Thunar
    , ((modm,               xK_d   ), spawn "thunar")
 
    -- Guitar script 
    , ((modm,               xK_g   ), spawn "guitar")
 
    -- Skype
    , ((modm,               xK_s   ), spawn "skype")
 
    -- Chrome 
    , ((modm,               xK_w   ), spawn "google-chrome")
 
<<<<<<< HEAD
    -- Ncmpcpp 
    , ((modm,               xK_v   ), spawn "urxvt -name ncmpcpp -e ncmpcpp")
 
=======
>>>>>>> a7ecb387723b7359c61db5abf86650e0674b35f2
    --Screenshot
    , ((0 , xK_Print), spawn "screenshot")
 
    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)
 
     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)
 
    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
 
    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)
 
    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)
 
    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)
 
    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )
 
    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )
 
    -- Swap the focused window and the master window
    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)
 
    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
 
    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
 
    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)
 
    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)
 
    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
 
    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
 
    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)
 
    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
 
    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    --From: /usr/include/X11/XF86keysym.h
    --XF86AudioMute
    , ((0 , 0x1008FF12), spawn "dvol -t")
    --XF86AudioLowerVolume
    , ((0 , 0x1008FF11), spawn "dvol -d 5")
    --XF86AudioRaiseVolume
    , ((0 , 0x1008FF13), spawn "dvol -i 5")
    --XF86AudioPlay
    , ((0 , 0x1008FF14), spawn "ncmpcpp toggle")
    --XF86AudioStop
    , ((0 , 0x1008FF15), spawn "ncmpcpp stop")
    --XF86AudioNext
    , ((0 , 0x1008FF17), spawn "ncmpcpp next")
    --XF86AudioPrev
    , ((0 , 0x1008FF16), spawn "ncmpcpp prev")
    --XF86Launch1 :1008FF41
    , ((0 , 0x1008FF41), windows $ W.greedyView "1")
    --XF86Launch2 :1008FF42
    , ((0 , 0x1008FF42), windows $ W.greedyView "2")
    --XF86Launch3 :1008FF43
    , ((0 , 0x1008FF43), windows $ W.greedyView "3")
    --XF86Launch4 :1008FF44
    , ((0 , 0x1008FF44), windows $ W.greedyView "4")
    --XF86Launch5 :1008FF45
    , ((0 , 0x1008FF45), windows $ W.greedyView "5")
    --XF86Launch6 :1008FF46
    , ((0 , 0x1008FF46), windows $ W.greedyView "6")
    ]
    ++
 
    --
    -- mod-[1..9], Switch to workspace N
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
<<<<<<< HEAD
=======
    ++
>>>>>>> a7ecb387723b7359c61db5abf86650e0674b35f2
 
    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
<<<<<<< HEAD
    --[((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
    --    | (key, sc) <- zip [xK_f, xK_e, xK_r] [0..]
    --    , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
=======
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_f, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
>>>>>>> a7ecb387723b7359c61db5abf86650e0674b35f2

