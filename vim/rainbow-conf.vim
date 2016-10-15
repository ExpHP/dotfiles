
let g:rainbow_active = 1

"==== Global config ===="
let s:tmp = {}

" Note: directly from example at luochen1990/rainbow
let s:tmp['guifgs'] = ['royalblue', 'darkorange', 'seagreen', 'firebrick', 'darkorchid']

" Note: Hand-picked by ExpHP for use with Tango colors
"let s:tmp['ctermfgs'] = [226,40,207,39,202]  " YGVBR
let s:tmp['ctermfgs'] = [39,207,226,40,202]  " BYVGR

" Global highlighting
let s:tmp['operators'] = '_,_'
let s:tmp['parentheses'] = []

let g:rainbow_conf = s:tmp
unlet s:tmp

"==== Lang config ===="

" Note: directly from example; no idea what the '*' entry is for.
let g:rainbow_conf['separately'] = {'*': {}}
let s:lang = g:rainbow_conf['separately']

let s:lang['tex']
	\= {'parentheses': ['start=/{/ end=/}/', 'start=/\[/ end=/\]/']}

" TOML has inline arrays which could possibly use highlighting,
" but at the same time I don't want it to match table headings.
let s:lang['toml'] = {'parentheses': []}

" TBH I didn't want to add coloring for most things beyond parentheses,
" but the coloring gets buggy (i.e. toggles back and forth) unless I
" include all things that can contain commas.
let s:tmp = []
let s:tmp += ['start=/(/ end=/)/'] " fn foo(x:i32, y:i32)
let s:tmp += ['start=/vec!\[/ end=/\]/'] " vec![1,2,3]
let s:tmp += ['start=/{/ end=/}/'] " struct A{x:i32, y:i32}
"let s:tmp += ['start=/|/ end=/|/'] " |a,b| a + b
let s:lang['rust'] = {'parentheses': s:tmp}

" Note: directly from example
let s:lang['vim'] = {'parentheses': [
	\'start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold',
	\'start=/(/ end=/)/ containedin=vimFuncBody',
	\'start=/\[/ end=/\]/ containedin=vimFuncBody',
	\'start=/{/ end=/}/ fold containedin=vimFuncBody',
	\]}

