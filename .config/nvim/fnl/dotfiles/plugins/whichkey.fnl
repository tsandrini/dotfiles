(module dotfiles.plugins.whichkey
  {autoload {nvim aniseed.nvim}})


(nvim.ex.set "timeoutlen=500")
(nvim.set_keymap :n :<leader> ":WhichKey '<Space>'<CR>" {:noremap true :silent true})


(let [wk (require :whichkey_setup)]
  (wk.config {"hide_statusline" false
              "default_keymap_settings" {"silent" true "noremap" true}
              "default_mode" "n"})
  (wk.register_keymap :leader {"name" "+general"
                               ;"f" [":noh<CR>" "highlights-remove"]
                               "h" ["<C-w>h" "window-left"]
                               "j" ["<C-w>j" "window-below"]
                               "k" ["<C-w>k" "window-above"]
                               "l" ["<C-w>l" "window-right"]
                               "s" ["<C-w>s" "window-split-below"]
                               "v" ["<C-w>v" "window-split-right"]
                               "q" [":q<CR>" "file-quit"]
                               "Q" [":qall<CR>" "file-quit-all"]
                               "w" [":w<CR>" "file-save"]
                               "n" [":tabnew<CR>" "tab-new"]
                               "u" [":UndotreeToggle<CR>" "undotree-toggle"]
                               "t" [":terminal<CR>" "terminal-open"]
                               "f" [":NnnPicker %:p:h<CR>" "nnn-open"]
                               "g" {"name" "+git"
                                    "s" [":Git<CR>" "git-status"]
                                    "b" [":Git blame<CR>" "git-blame"]
                                    "d" [":Gdiff<CR>" "git-diff"]
                                    "p" [":Git push<CR>" "git-push"]
                                    "l" [":Git pull<CR>" "git-pull"]
                                    "f" [":Git fetch<CR>" "git-pull"]
                                    "a" [":Git add *<CR>" "git-add-all"]
                                    "c" [":Git commit --verbose<CR>" "git-commit-verbose"]
                                    "e" [":GitMessenger<CR>" "git-messenger"]}
                               ;"p" {"name" "+fzf"
                               ;     "f" [":Files<CR>" "fzf-files"]
                               ;     "g" [":GFiles<CR>" "fzf-git-files"]
                               ;     "b" [":Buffers<CR>" "fzf-buffers"]
                               ;     "l" [":Colors<CR>" "fzf-colors"]
                               ;     "r" [":Rg<CR>" "fzf-ripgrep"]
                               ;     "c" [":Commits<CR>" "fzf-commits"]
                               ;     "s" [":Snippets<CR>" "fzf-snippets"]
                               ;     "m" [":Commands<CR>" "fzf-commands"]
                               ;     "w" [":Windows<CR>" "fzf-windows"]}
                               "p" {"name" "+telescope"
                                    "f" [":Telescope file_browser<CR>" "telescope-files"]
                                    ;"g" [":GFiles<CR>" "telescope-git-files"]
                                    "b" [":Telescope buffers<CR>" "telescope-buffers"]
                                    "l" [":Colors<CR>" "telescope-colors"]
                                    "r" [":Telescope live_grep<CR>" "telescope-grep"]
                                    "g" [":Telescope git_commits<CR>" "telescope-commits"]
                                    ;"s" [":Snippets<CR>" "telescope-snippets"]
                                    "m" [":Telescope commands<CR>" "telescope-commands"]
                                    "h" [":Telescope man_pages<CR>" "telescope-man-pages"]
                                    "t" [":Telescope treesitter<CR>" "telescope-treesitter"]}
                               "b" {"name" "+bufexplorer"
                                    "e" "bufexplorer-open"
                                    "t" "bufexplorer-toggle"
                                    "s" "bufexplorer-horizontal-split"
                                    "v" "bufexplorer-vertical-split"}
  }))
