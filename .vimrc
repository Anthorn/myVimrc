""set t_Co=256   " This is may or may not needed.

execute pathogen#infect()

" Attempt to determine the type of a file based on its name and possibly its
" " contents. Use this to allow intelligent auto-indenting for each filetype,
" " and for plugins that are filetype specific.
filetype indent plugin on

set exrc
set secure
set softtabstop=2
set shiftwidth=2
set expandtab

let g:solarized_termcolors=256

syntax enable
set background=light
colorscheme solarized

set errorformat+=%f:%l\ %m

" Set 'nocompatible' to ward off unexpected things that your distro might
" " have made, as well as sanely reset options when re-sourcing .vimrc

set nocompatible



set hidden

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" " mapping of <C-L> below)
set hlsearch

set ignorecase
set smartcase

set backspace=indent,eol,start

" Stop certain movements from always going to the first character of a line.
" " While this behaviour deviates from that of Vi, it does what most users
" " coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" " line of a window
set ruler

" Instead of failing a command because of unsaved changes, instead raise a
" " dialogue asking if you wish to save changed files.
set confirm

set cmdheight=2

set number

autocmd BufWritePre * :%s/\s\+$//e

:map <F8> :bnext<cr>

:map <F7> :bprevious<cr>

:map <C-t> <ESC>:edit
" Enable list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#enabled = 1

set hidden




set mouse=a
if exists("b:loaded_toggle_mouse_plugin")
    finish
endif
let b:loaded_toggle_mouse_plugin = 1

fun! s:ToggleMouse()
    if !exists("s:old_mouse")
        let s:old_mouse = "a"
    endif

    if &mouse == ""
        let &mouse = s:old_mouse
        echo "Mouse is for Vim (" . &mouse . ")"
    else
        let s:old_mouse = &mouse
        let &mouse=""
        echo "Mouse is for terminal"
    endif
endfunction

" Add mappings, unless the user didn't want this.
" The default mapping is registered under to <F12> by default, unless the
" user remapped it already (or a mapping exists already for <F12>)
if !exists("no_plugin_maps") && !exists("no_toggle_mouse_maps")
     if !hasmapto('<SID>ToggleMouse()')
             noremap <F12> :call <SID>ToggleMouse()<CR>
             inoremap <F12> <Esc>:call <SID>ToggleMouse()<CR>a
     endif
endif
"nnoremap <F2> :BufExplorer<CR>


set tags=~/.vim/tags
fun! MatchCaseTag()
    let ic = &ic
    set noic
    try
        exe 'tjump ' . expand('<cword>')
    finally
        let &ic = ic
    endtry
endfun
nnoremap <silent><F4> :call MatchCaseTag()<CR>
fun! GITGREPTHIS()
    exe 'silent Ggrep!' expand('<cword>') 'dp tests web' | cw | redraw! | cclose | copen 20
endfun

nnoremap <silent><F6> :call GITGREPTHIS()<CR>
"nnoremap <silent><F9> :copen 20<CR>
nnoremap <silent><F9> :cclose<CR>


fun! s:ToggleNERDTree()
    if !exists("s:old_nerdtree")
        let s:old_nerdtree = "closed"
    endif
    if s:old_nerdtree == "open"
        let s:old_nerdtree = "closed"
        exe 'NERDTreeClose'
    else
        let s:old_nerdtree = "open"
        exe 'NERDTreeFind'
    endif
endfunction
nnoremap <silent><F5> :call <SID>ToggleNERDTree()<CR>
let g:NERDTreeWinSize = 80
let NERDTreeQuitOnOpen = 1

fun! STATIC_CODE_ANALYSIS()
    exe 'cfile target/logs/static_analysis.log' | cw | redraw! | cclose | copen 25
endfun
nnoremap <silent><F2> :call STATIC_CODE_ANALYSIS()<CR>


nnoremap <F3> :Tlist<CR>


inoremap ( ()<Esc>i
"inoremap { {<CR>}<Esc>ko"
inoremap [ []<Esc>i
""inoremap < <><Esc>i
inoremap " ""<Esc>i
