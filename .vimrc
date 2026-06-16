set number
set noexpandtab
set tabstop=4
set shiftwidth=4
set cursorline
set smartcase
set ignorecase
set hlsearch
set wildmenu
set hidden
" set wildmode=longest:full,full

call plug#begin()

Plug 'sheerun/vim-polyglot'
Plug 'ayu-theme/ayu-vim' " or other package manager
Plug 'tpope/vim-unimpaired'
Plug 'rhysd/conflict-marker.vim'
Plug 'tpope/vim-commentary'
" "autocomplete
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
Plug 'skywind3000/asyncrun.vim'
" Plug 'vim-scripts/AutoComplPop'

Plug 'zivyangll/git-blame.vim'
Plug 'romainl/vim-qf'
Plug 'chrisbra/NrrwRgn'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'sgur/vim-textobj-parameter'
Plug 'tpope/vim-abolish'
" Plug 'rstacruz/vim-closer'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
"themes
Plug 'jacoborus/tender.vim'
Plug 'sainnhe/sonokai'
Plug 'morhetz/gruvbox'
Plug 'Yggdroot/indentLine'
Plug 'kshenoy/vim-signature'
Plug 'puremourning/vimspector'
Plug 'azabiong/vim-highlighter'
Plug 'tpope/vim-repeat'
Plug 'rakr/vim-one'
Plug 'flazz/vim-colorschemes'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-obsession'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Plug 'ryanoasis/vim-devicons'
Plug 'PhilRunninger/nerdtree-buffer-ops'

call plug#end()
" set encoding=UTF-8

let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

autocmd VimEnter * GitGutterEnable
autocmd VimEnter * GitGutterBufferEnable

let g:vimspector_enable_mappings = 'HUMAN'
" packadd! vimspector

" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" set termguicolors     " enable true colors support
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
let ayucolor="dark"   " for dark version of theme
" colorscheme ayu
"

vnoremap p "_dP

let g:ctrlp_cmd = 'CtrlP .'
nmap <C-t> :CtrlPBuffer<CR>
nmap <C-n> :CtrlPMRU<CR>
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_open_multiple_files = 'ij'
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:100'
let g:ctrlp_custom_ignore = '.*log$'


xmap <leader>ww :NR!<cr>
xmap <leader>wp :NRP<cr>
nmap <leader>wm :NRM!<cr>

let g:vim_textobj_parameter_mapping = 'a'

let g:conflict_marker_enable_mappings = 0
nmap ]c <Plug>(conflict-marker-next-hunk)
nmap [c <Plug>(conflict-marker-prev-hunk)
nmap ct <Plug>(conflict-marker-themselves)
nmap co <Plug>(conflict-marker-ourselves)
nmap cn <Plug>(conflict-marker-none)
nmap cb <Plug>(conflict-marker-both)
nmap cB <Plug>(conflict-marker-both-rev)

let g:tmux_navigator_no_mappings = 1

nmap <silent><C-l> :b#<cr>
function Insert_log()
        if &ft == "cpp"
                execute('normal! ilogging::logger()->info("{}: {}",__FUNCTION__, );')
        elseif &ft == "python"
                execute('normal! iLOG.info(f"{}")')
        endif
endfunction
" imap <c-k> LOG.info(f"{}")<left><left><left>
imap <c-k> <c-o>:call Insert_log()<cr><left><left><left>

" let g:surround_no_mappings = 0
" nmap sd  <Plug>Dsurround
" nmap sr  <Plug>Csurround
" nmap cS  <Plug>CSurround
" nmap sa  <Plug>Ysurround
" nmap yS  <Plug>YSurround
" nmap yss <Plug>Yssurround
" nmap ySs <Plug>YSsurround
" nmap ySS <Plug>YSsurround
" xmap sa   <Plug>VSurround
" xmap gS  <Plug>VgSurround


let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key
" binding.
" " `s{char}{label}`
" nmap <space> <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap <space> <Plug>(easymotion-overwin-f2)
"
" " Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1
" JK motions: Line motions
map <Leader>i <Plug>(easymotion-k)
map <Leader>k <Plug>(easymotion-j)

nnoremap <Leader>g :Git blame<CR>
nnoremap <leader>n :NERDTreeToggle<CR>

" set background=dark    " Setting dark mode
" autocmd vimenter * ++nested colorscheme gruvbox
" if (has("termguicolors"))
"        set termguicolors
"  endif

if !has('gui_running') && &term =~ '\%(screen\|tmux\)'
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
set termguicolors

let g:airline_theme = 'molokai'
syntax enable
colorscheme molokai

" let g:airline_theme='one'
" colorscheme one
" set background=dark " for the dark version

" let g:sonokai_style = 'atlantis'

" let g:sonokai_disable_italic_comment = 1
" let g:airline_theme = 'sonokai'
" colorscheme sonokai



let g:airline#extensions#tabline#enabled = 1

nnoremap <leader>fg :botright copen<CR>:AsyncRun rg --no-ignore-vcs -g '!*.log' -g '!*vendor*' -n ""<left>
" nnoremap <leader>fg :botright copen<CR>:AsyncRun grep -r -n
nnoremap <leader>fs :AsyncRun rg --no-ignore-vcs -g '!*.log' -g '!*vendor*'  -n <cword><cr>:botright copen<CR>
nnoremap <leader>ff :botright copen<CR>:AsyncRun find . -name "" -printf "\%p:1:1:\%f\n"<left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>
nnoremap <leader>fw :AsyncRun find . -iname "*<cword>*" -printf "\%p:1:1:\%f\n"<cr>:botright copen<cr>
" <esc>:botright copen<CR>
augroup vimrc
        autocmd QuickFixCmdPost * botright copen 8
augroup END

" map <silent><esc> :noh <CR>
map <silent><C-c> :noh <CR>:cclose<cr>
nnoremap <C-s> <C-a>
nmap <silent><leader>d :bp\|bd #<CR>

let g:qf_mapping_ack_style = 1
nmap <leader>q <Plug>(qf_qf_toggle)

nnoremap <silent> <Leader>l ml:execute 'match Search /\%'.line('.').'l/'<CR>
" :match
if argc() == 0
        if !isdirectory(expand('~/.sessions'))
                call mkdir(expand('~/.sessions'), 'p')
        endif

        let s:cwd = getcwd()
        let s:safe_dir = substitute(s:cwd, '[^A-Za-z0-9]', '_', 'g')
        let s:session_file = expand("~/.sessions/" . s:safe_dir . ".vim")

        " Automatically load session if the file exists
        if filereadable(s:session_file)
                autocmd VimEnter * ++nested execute 'source ' . fnameescape(s:session_file) | silent!  filetype detect
        endif

        " Start tracking the session with Obsession
        autocmd VimEnter * execute 'Obsession ' . fnameescape(s:session_file)
endif

