# -----------------------------
# 1. 기본 환경 설정 (Environment)
# -----------------------------

# Homebrew 경로 설정
eval "$(/opt/homebrew/bin/brew shellenv)"

# 기본 에디터를 Neovim으로 설정 (Git 등에서 자동으로 nvim이 열림)
export EDITOR="nvim"
export VISUAL="nvim"

# 언어 설정 (한글 깨짐 방지)
# export LANG=ko_KR.UTF-8

# -----------------------------
# 2. 히스토리 설정 (History)
# -----------------------------

# 명령어 기록을 저장할 파일 및 개수 설정
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

# 히스토리 관련 옵션 (중복 제거, 즉시 저장, 공유)
setopt HIST_IGNORE_ALL_DUPS  # 중복 커맨드 기록 안 함
setopt HIST_REDUCE_BLANKS    # 불필요한 공백 제거
setopt SHARE_HISTORY         # 여러 터미널 탭 간에 히스토리 공유
setopt INC_APPEND_HISTORY    # 명령어를 실행하자마자 파일에 기록

# -----------------------------
# 3. 초기화 (Init)
# -----------------------------

autoload -Uz compinit
compinit

# Sheldon 플러그인 매니저
eval "$(sheldon source)"

# Starship 프롬프트
eval "$(starship init zsh)"

# zoxide (cd 명령어를 zoxide로 대체하여 스마트하게 이동)
eval "$(zoxide init zsh --cmd cd)"

# -----------------------------
# 4. 현대적 도구 별칭 (Aliases)
# -----------------------------

export EZA_CONFIG_DIR="$HOME/.config/eza"
export EZA_THEME="theme.yml"

# eza (아이콘, 그룹별 정렬, 헤더 표시)
alias ls='eza --icons --group-directories-first'
alias ll='eza -l --icons --tree --level=1 --header --group-directories-first --time-style=long-iso'
alias la='eza -la --icons --tree --level=1 --header --group-directories-first --time-style=long-iso'
alias lt='eza --icons --tree --level=2'

# bat (문법 강조)
alias cat='bat'

# Neovim 단축키
alias vi='nvim'
alias vim='nvim'

# Git & Lazygit
alias g='git'
alias lg='lazygit'

# yazi
alias yz='yazi'

# Brewfile 관리 (Brewfile이 .config에 있다고 가정 시)
alias brewup='brew bundle --file=~/.config/Brewfile'

# -----------------------------
# 5. FZF 설정 (Preview 기능 추가)
# -----------------------------

# fzf --zsh 설정 (Ctrl+T, Ctrl+R 등 활성화)
eval "$(fzf --zsh)"

# fzf의 기본 검색 엔진을 fd로 변경
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

# CTRL-T (파일 검색 단축키)에도 적용
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# FZF custom
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:-1,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4 \
--style full \
--preview 'fzf-preview.sh {}' --bind 'focus:transform-header:file --brief {}'"

# fzf-tab 기본 보완 시스템 설정 (GitHub 예제 기반)
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons --color=always $realpath'
zstyle ':fzf-tab:complete:(nvim|bat):*' fzf-preview 'fzf-preview.sh $realpath'

zstyle ':fzf-tab:*' fzf-flags \
'--color=bg+:#313244,bg:-1,spinner:#F5E0DC,hl:#F38BA8' \
'--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC' \
'--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8' \
'--color=selected-bg:#45475A' \
'--color=border:#6C7086,label:#CDD6F4' \

# -----------------------------
# 6. 키 바인딩 (Key Bindings)
# -----------------------------

# Sheldon 이후에 적용되어야 안전함
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
