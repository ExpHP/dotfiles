
if g:auto_rusty_tags
	setlocal tags=rusty-tags.vi;/,/home/lampam/build/rust/rusty-tags.vi
	autocmd BufWrite *.rs :silent !rusty-tags vi >/dev/null
endif
