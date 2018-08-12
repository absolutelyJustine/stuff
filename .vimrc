execute pathogen#infect()
"set number
set nocompatible              " be iMproved, required
filetype off                  " required
filetype plugin indent on
syntax on

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" other bundles and plugins here
Plugin 'leafgarland/typescript-vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'mtscout6/syntastic-local-eslint.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'uguu-org/vim-matrix-screensaver'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin on    " required
"filetype plugin indent on    " required
set background=light
highlight Normal guibg=Black guifg=White
"set t_Co=88
set t_Co=256
set fo=ql
au FileType * setl fo-=cro
au BufRead,BufNewFile *.yaml,*.yml so ~/.vim/yaml.vim
au BufRead,BufNewFile *.sass set filetype=css

" typescript stuff
" using leafgarland/typescript-vim
au BufRead,BufNewFile *.ts set filetype=typescript
"uncomment if the typescript indents are broken:
"let g:typescript_indent_disable=1

" make routines
" when doing programming this is good: map T :!source source_me.txt ; make<RETURN>, but I'm in IT now, so now we'll do a terminal
"map T :ConqueTerm bash -l<RETURN>
" better than ConqueTerm is tmux, so I'll do this instead
map T <C-W>T

" overrides go-to-bottom C-f keystroke, but C-d is better anyway
let g:ConqueTerm_EscKey = '<C-f>'
" ...and map it to insert mode as well so we don't accidentally insert ^F
imap <C-f> <ESC>

"map co :!./copy_work<RETURN>
"map cg :!./copy_group s<RETURN>
"map cG :!./copy_group sam10<RETURN>

" fancy splits
map msp :vsp<RETURN>:sp<RETURN><C-W>l:sp<RETURN>
map vsp :vsp<RETURN>
map sp :sp<RETURN>

" move between splits
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-I> <C-W>h
map <C-L> <C-W>l
nnoremap <A-DOWN> <C-W>j
nnoremap <A-UP> <C-W>k
nnoremap <A-LEFT> <C-W>h
nnoremap <A-RIGHT> <C-W>l
nnoremap <C-S-DOWN> <C-W>j
nnoremap <C-S-UP> <C-W>k
nnoremap <C-S-LEFT> <C-W>h
nnoremap <C-S-RIGHT> <C-W>l
" resize horizontal splits
map - <C-W>-
map + <C-W>+
" resize vertical splits
map < <C-W><
map > <C-W>>
" maximize split
map _ <C-W>_<C-W><BAR>
" equalize split
map = <C-W>=

" auto indent
"set cindent "(not for tcl) 
set autoindent "(for tcl)
set smarttab
" indent size, 2 spaces in this case
set tabstop=2
set shiftwidth=2
autocmd Filetype tcl setlocal ts=4 sts=4 sw=4
autocmd Filetype python setlocal ts=4 sts=4 sw=4
"" tabs are really spaces
set expandtab

" maps for tabwidths 2->4
map t2 :setlocal ts=2 sts=2 sw=2 expandtab<RETURN>
map t3 :setlocal ts=3 sts=3 sw=3 expandtab<RETURN>
map t4 :setlocal ts=4 sts=4 sw=4 expandtab<RETURN>
map t8 :setlocal ts=8 sts=8 sw=4 noexpandtab<RETURN>
" ...but don't stop me from normal 'til commands
noremap dt2 dt2
noremap dt3 dt3
noremap dt4 dt4
noremap dt8 dt8
noremap ct2 ct2
noremap ct3 ct3
noremap ct4 ct4
noremap ct8 ct8
noremap yt2 yt2
noremap yt3 yt3
noremap yt4 yt4
noremap yt8 yt8

" remap block indents
noremap [ <
noremap ] >

"set mouse=ra
set background=dark
colorscheme peaksea

" syntax highlighting help
syntax sync minlines=500
map <F12> :syntax sync fromstart<RETURN>

" highlight all search matches
set hlsearch

"" show line numbers (relative and absolute)
"set number relativenumber
"augroup numbertoggle
"  autocmd!
"  autocmd BufEnter,FocusGained,InsertLeave * set number relativenumber
"  autocmd BufLeave,FocusLost,InsertEnter   * set number norelativenumber
"augroup END

"" don't show line numbers (relative and absolute)
"set nonumber norelativenumber
"augroup numbertoggle
"  autocmd!
"  autocmd BufEnter,FocusGained,InsertLeave * set number norelativenumber
"  autocmd BufLeave,FocusLost,InsertEnter   * set number norelativenumber
"augroup END

"" go stuff...
""----------------------
"" Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
"" Use neocomplete.
"let g:neocomplete#enable_at_startup = 1
"" Use smartcase.
"let g:neocomplete#enable_smart_case = 1
"" Set minimum syntax keyword length.
"let g:neocomplete#sources#syntax#min_keyword_length = 3
"
"" Plugin key-mappings.
"inoremap <expr><C-g>     neocomplete#undo_completion()
"inoremap <expr><C-l>     neocomplete#complete_common_string()
"
"" Recommended key-mappings.
"" <CR>: close popup and save indent.
""inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
""function! s:my_cr_function()
""	 return neocomplete#close_popup() . "\<CR>"
""endfunction
"" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplete#close_popup()
"inoremap <expr><C-e>  neocomplete#cancel_popup()

" Go related mappings
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>r <Plug>(go-run)
au FileType go nmap <Leader>b <Plug>(go-build)
au FileType go nmap <Leader>t <Plug>(go-test)
au FileType go nmap gd <Plug>(go-def-tab)

" ctags/gotags stuff
nmap <F8> :TagbarToggle<CR>.
let g:tagbar_type_go = {  
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" mac stuff
"----------------------
" fix borken backspace
set backspace=indent,eol,start
let mapleader=','
set scroll=10

" auto-find file suffix from filetype for 'gf' command
"----------------------
augroup suffixes
    autocmd!

    let associations = [
                \["javascript", ".js,.javascript,.es,.esx,.json"],
                \["python", ".py,.pyw"]
                \]

    for ft in associations
        execute "autocmd FileType " . ft[0] . " setlocal suffixesadd=" . ft[1]
    endfor
augroup END

" vim-javascript stuff
"----------------------
let g:javascript_plugin_jsdoc = 1

" status line shows always, and with filename
set statusline+=%f
" and with modified flag
set statusline+=%m
set laststatus=2

" syntastic stuff
"----------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_debug = 0
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_write = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'eslint'
let g:syntastic_javascript_eslint_args = ['--fix']
let g:syntastic_mode_map = { 'mode': 'passive' }
set autoread
let g:syntastic_javascript_eslint_version = 'v4.19.1'
function! SyntasticCheckHook(errors)
  checktime
endfunction
map <F6> :SyntasticCheck eslint<RETURN>
" fix :E command after Syntastic install (created new Errors command that interfered)
cabbrev E Explore
