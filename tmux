#| .--------------. || .--------------. || .--------------. || .--------------. |
#| |  _________   | || | ____    ____ | || | _____  _____ | || |  ____  ____  | |
#| | |  _   _  |  | || ||_   \  /   _|| || ||_   _||_   _|| || | |_  _||_  _| | |
#| | |_/ | | \_|  | || |  |   \/   |  | || |  | |    | |  | || |   \ \  / /   | |
#| |     | |      | || |  | |\  /| |  | || |  | '    ' |  | || |    > `' <    | |
#| |    _| |_     | || | _| |_\/_| |_ | || |   \ `--' /   | || |  _/ /'`\ \_  | |
#| |   |_____|    | || ||_____||_____|| || |    `.__.'    | || | |____||____| | |
#| |              | || |              | || |              | || |              | |
#| '--------------' || '--------------' || '--------------' || '--------------' |
# '----------------'  '----------------'  '----------------'  '----------------' 

# tmux theme
source-file "${HOME}/.tmuxtheme"

set -g default-terminal "screen-256color"

bind-key c command-prompt -p "window name:" "new-window; rename-window '%%'"

# toggle status bar
bind-key t set-option status

set -g prefix C-a
unbind C-b
bind-key C-a send-prefix

unbind %
bind | split-window -h

unbind '"'
bind - split-window -v

unbind r
bind r source-file ~/.tmux.conf

bind -r j resize-pane -D 5
bind -r k resize-pane -U 5
bind -r l resize-pane -R 5
bind -r h resize-pane -L 5

bind -r m resize-pane -Z

set -g mouse on

set-window-option -g mode-keys vi

bind-key -T copy-mode-vi 'v' send -X begin-selection # start selecting text with "v"
bind-key -T copy-mode-vi 'y' send -X copy-selection # copy text with "y"

unbind -T copy-mode-vi MouseDragEnd1Pane # don't exit copy mode after dragging with mouse

# tpm plugin
set -g @plugin 'tmux-plugins/tpm'

# list of tmux plugins
set -g @plugin 'christoomey/vim-tmux-navigator' # for navigating panes and vim/nvim with Ctrl-hjkl
# set -g @plugin 'jimeh/tmux-themepack' # to configure tmux theme
# set -g @plugin 'tmux-plugins/tmux-continuum' # automatically saves sessions for you every 15 minutes
# set -g @resurrect-capture-pane-contents 'on' # allow tmux-ressurect to capture pane contents
# set -g @continuum-restore 'on' # enable tmux-continuum functionality
# set -g @plugin 'tmux-plugins/tmux-resurrect'
# set -g @plugin 'tmux-plugins/tmux-continuum'

### List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'christoomey/vim-tmux-navigator'
set -g @plugin 'tmux-plugins/tmux-yank'
# set -g @plugin 'catppuccin/tmux'
set -g @plugin 'tmux-plugins/tmux-continuum'
set -g @plugin 'joshmedeski/t-smart-tmux-session-manager'

# smart tmux session manager settings
bind-key x kill-pane # skip "kill-pane 1? (y/n)" prompt
set -g detach-on-destroy off  # don't exit from tmux when closing a session

run '~/.tmux/plugins/tpm/tpm'

# copied from https://www.reddit.com/r/tmux/comments/utbt7m/any_tips_on_making_tmux_pretty_plugins_welcome/
