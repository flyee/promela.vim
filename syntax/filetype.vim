"
" include new syntax highlighting
"

augroup filetypedetect

" Promela
au BufNewFile,BufRead *.prom,*.prm,*.promela,*.pml		setf promela

augroup END

