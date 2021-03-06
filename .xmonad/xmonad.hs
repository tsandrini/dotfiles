-- Base
import           System.Directory
import           System.Exit                    ( exitSuccess )
import           System.IO                      ( hPutStrLn )
import           XMonad

-- Actions
import           XMonad.Actions.CopyWindow      ( kill1 )
import           XMonad.Actions.CycleWS         ( toggleWS )
import           XMonad.Actions.MouseResize
import           XMonad.Actions.WindowGo        ( runOrRaise )

-- Data
import qualified Data.Map                      as M
import           Data.Maybe                     ( fromJust
                                                , fromMaybe
                                                )
import           Data.Monoid

-- Hooks
import           XMonad.Hooks.DynamicLog        ( PP(..)
                                                , dynamicLogWithPP
                                                , shorten
                                                , wrap
                                                , xmobarColor
                                                , xmobarPP
                                                )
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks       ( avoidStruts
                                                , manageDocks
                                                )
import           XMonad.Hooks.ManageHelpers     ( doFullFloat
                                                , isFullscreen
                                                )

-- Layout
import           XMonad.Layout.GridVariants     ( Grid(Grid) )
import           XMonad.Layout.ResizableTile
import           XMonad.Layout.SimplestFloat
import           XMonad.Layout.Tabbed


-- Layout modifiers
import           XMonad.Layout.LayoutModifier
import           XMonad.Layout.LimitWindows     ( limitWindows )
import           XMonad.Layout.Magnifier
import           XMonad.Layout.MultiToggle      ( (??)
                                                , EOT(EOT)
                                                , mkToggle
                                                , single
                                                )
import qualified XMonad.Layout.MultiToggle     as MT
                                                ( Toggle(..) )
import           XMonad.Layout.MultiToggle.Instances
                                                ( StdTransformers
                                                  ( MIRROR
                                                  , NBFULL
                                                  , NOBORDERS
                                                  )
                                                )
import           XMonad.Layout.NoBorders
import           XMonad.Layout.Renamed
import           XMonad.Layout.Simplest
import           XMonad.Layout.Spacing
import           XMonad.Layout.SubLayouts
import qualified XMonad.Layout.ToggleLayouts   as T
                                                ( toggleLayouts )
import           XMonad.Layout.WindowArranger   ( windowArrange )


-- Utilities
import           XMonad.Util.EZConfig           ( additionalKeysP )
import           XMonad.Util.NamedScratchpad
import           XMonad.Util.Run                ( spawnPipe )
import           XMonad.Util.SpawnOnce

-- TODO: add some text
import           Graphics.X11.ExtraTypes.XorgDefault

myFont :: String
myFont =
  "xft:SauceCodePro Nerd Font Mono:regular:size=9:antialias=true:hinting=true"

myModMask :: KeyMask
myModMask = mod4Mask

myTerminal :: String
myTerminal = "alacritty"

myBrowser :: String
myBrowser = "firefox-developer-edition"

myEditor :: String
myEditor = "nvim"

myBorderWidth :: Dimension
myBorderWidth = 2

myWorkspaces :: [String]
myWorkspaces = map show [1 .. 9]

mySpacing
  :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

mySpacing'
  :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

getConfigFilePath :: [Char] -> IO [Char]
getConfigFilePath f = getHomeDirectory >>= \hd -> return $ hd ++ "/" ++ f

getWalColors :: IO [String]
getWalColors = do
  file     <- getConfigFilePath ".cache/wal/colors"
  contents <- readFile file
  let colors = lines contents
  return (colors ++ replicate (16 - length colors) "#000000")

tall =
  renamed [Replace "tall"]
    $ smartBorders
    $ addTabs shrinkText myTabTheme
    $ subLayout [] (smartBorders Simplest)
    $ limitWindows 30
    $ mySpacing 25
    $ ResizableTall 1 (3 / 100) (1 / 2) []
magnify =
  renamed [Replace "magnify"]
    $ smartBorders
    $ addTabs shrinkText myTabTheme
    $ subLayout [] (smartBorders Simplest)
    $ magnifier
    $ limitWindows 30
    $ mySpacing 25
    $ ResizableTall 1 (3 / 100) (1 / 2) []
grid =
  renamed [Replace "grid"]
    $ smartBorders
    $ addTabs shrinkText myTabTheme
    $ subLayout [] (smartBorders Simplest)
    $ limitWindows 30
    $ mySpacing 25
    $ mkToggle (single MIRROR)
    $ Grid (16 / 10)

floats =
  renamed [Replace "floats"] $ smartBorders $ limitWindows 20 simplestFloat

-- TODO: set wal colors
myTabTheme :: Theme
myTabTheme = def { fontName            = myFont
                 , activeColor         = "#46d9ff"
                 , inactiveColor       = "#313846"
                 , activeBorderColor   = "#46d9ff"
                 , inactiveBorderColor = "#282c34"
                 , activeTextColor     = "#282c34"
                 , inactiveTextColor   = "#d0d0d0"
                 }

myWorkspaceIndices :: M.Map String Integer
myWorkspaceIndices = M.fromList $ zip myWorkspaces [1 ..] -- (,) == \x y -> (x,y)

clickable :: [Char] -> [Char]
clickable ws =
  "<action=xdotool key super+" ++ show i ++ ">" ++ ws ++ "</action>"
  where i = fromJust $ M.lookup ws myWorkspaceIndices

myLayoutHook =
  avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats $ mkToggle
    (NBFULL ?? NOBORDERS ?? EOT)
    myDefaultLayout
 where
  myDefaultLayout =
    withBorder myBorderWidth tall ||| magnify ||| floats ||| grid

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "picom &"
  spawnOnce "nm-applet &"
  spawnOnce "dunst &"
  spawnOnce "volumeicon &"
  spawnOnce "xfce4-clipman &"
  spawnOnce
    "trayer --edge top --align right --widthtype request --padding 6 \
    \--SetDockType true --SetPartialStrut true --expand true --monitor 0 \
    \--transparent true --alpha 0 --tint 0x282c34  --height 22 &"

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
  [ className =? "confirm" --> doFloat
  , className =? "file_progress" --> doFloat
  , className =? "dialog" --> doFloat
  , className =? "download" --> doFloat
  , className =? "error" --> doFloat
  , className =? "Gimp" --> doFloat
  , className =? "notification" --> doFloat
  , className =? "pinentry-gtk-2" --> doFloat
  , className =? "splash" --> doFloat
  , className =? "toolbar" --> doFloat
  , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
  , isFullscreen --> doFullFloat
  ]

myKeys :: [(String, X ())]
myKeys =
  --  XMonad
  [ --("M-S-q"     , io exitSuccess)
    ("M-S-r"         , spawn "xmonad --recompile")
  , ("M-r"           , spawn "xmonad --restart")
  -- Programs
  , ("M-<Return>"    , spawn myTerminal)
  , ("M-d", spawn "~/.local/bin/dmen.sh -i -p 'Run: '")
  , ("M-f"           , spawn (myTerminal ++ " -e ranger"))
  , ("M-S-i"         , spawn "i3lock-fancy")
  -- Kill windows
  , ("M-S-q"         , kill1)     -- Kill the currently focused client
  -- Workspaces
  , ("M-<Tab>"       , toggleWS)
  -- Increase/decrease spacing (gaps)
  , ("C-j"           , decWindowSpacing 4)         -- Decrease window spacing
  , ("C-k"           , incWindowSpacing 4)         -- Increase window spacing
  -- Multimedia keys
  , ("<XF86Mail>", runOrRaise "thunderbird" (resource =? "thunderbird"))
  , ("<XF86HomePage>", runOrRaise myBrowser (resource =? myBrowser))
  , ("<Print>"       , spawn "xfce4-screenshooter")
  ]

remap
  :: (KeySym -> KeySym)
  -> (XConfig l -> M.Map (KeyMask, KeySym) (X ()))
  -> (XConfig l -> M.Map (KeyMask, KeySym) (X ()))
remap f keybinds = M.mapKeys (\(m, k) -> (m, f k)) . keybinds

toCzech :: KeySym -> KeySym
toCzech = \ks -> fromMaybe ks (M.lookup ks cz) where
  cz = M.fromList $ zip
    [xK_1 .. xK_9]
    [ xK_plus
    , xK_ecaron
    , xK_scaron
    , xK_ccaron
    , xK_rcaron
    , xK_zcaron
    , xK_yacute
    , xK_aacute
    , xK_iacute
    ]

main :: IO ()
main = do
  colors <- getWalColors
  xmproc <- spawnPipe "xmobar $HOME/.config/xmobar/xmobarrc"
  xmonad
    $                 ewmh def
                        { manageHook         = myManageHook <+> manageDocks
                        , modMask            = myModMask
                        , terminal           = myTerminal
                        , startupHook        = myStartupHook
                        , layoutHook         = myLayoutHook
                        , borderWidth        = myBorderWidth
                        , workspaces         = myWorkspaces
                        , keys               = remap toCzech (keys def)
                        , normalBorderColor  = colors !! 10
                        , focusedBorderColor = colors !! 12
                        , logHook            =
                          dynamicLogWithPP $ namedScratchpadFilterOutWorkspacePP $ xmobarPP
                            { ppOutput = hPutStrLn xmproc
                            , ppCurrent = xmobarColor (colors !! 14) "" . wrap "[" "]"           -- Current workspace
                            , ppVisible = xmobarColor (colors !! 13) "" . clickable              -- Visible but not current workspace
                            , ppHidden = xmobarColor (colors !! 15) "" . wrap "*" "" . clickable -- Hidden workspaces
                            , ppHiddenNoWindows = xmobarColor (colors !! 11) "" . clickable     -- Hidden workspaces (no windows)
                            , ppTitle = xmobarColor (colors !! 14) "" . shorten 60               -- Title of active window
                            , ppSep = "<fc=" ++ (colors !! 2) ++ "> | </fc>"                    -- Separator character
                            , ppUrgent = xmobarColor (colors !! 15) "" . wrap "!" "!"            -- Urgent workspace
                            -- , ppExtras = [windowCount]                                     -- # of windows current workspace
                            , ppOrder = \(ws : l : t : ex) -> [ws, l] ++ ex ++ [t]                    -- order
                            }
                        }
    `additionalKeysP` myKeys
