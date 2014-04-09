" Vim syntax file
" Language:	Promela
" Maintainer:	Pieter Loubser <ploubser@cs.sun.ac.za>
" Last Change:	04 September 2003
" Filenames:	*.prom, *.prm, *.promela
" URL:		http://www.cs.sun.ac.za/~ploubser/
" Comments:	Promela is a language for describing
"		protocol validation models in SPIN


" Version 0.2 Changes:
" #define multi-line highlighting is now fixed, to be one color.
" Version 0.3 Changes:
" Other C-like comments '//' highlighting added



" Clear current syntax from system
if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

" Promela is a case sensitive language
syntax case match


" Some usefull Promela keywords
syn keyword	promConditional		if fi assert

syn keyword	promFunction		proctype init
syn keyword	promFunction		D_proctype provided active priority

syn keyword	promOperator		len printf run
syn keyword	promOperator		full nfull enabled eval pc_value empty n_empty

syn keyword	promRepeat		do od for

syn keyword	promStatement		atomic d_step
syn keyword	promStatement		goto break never skip timeout of
syn keyword	promStatement		else unless

syn keyword	promType		bool bit byte short int
syn keyword	promType		chan mtype
syn keyword	promType		unsigned hidden xr xs typedef

syn keyword	promStorageClass	inline


" special goto lables
syn match	promFlags	"\(end\|progress\|accept\)[a-zA-Z0-9_]*:"


" Adding matches for special strings in comments
syn keyword	promTodo	contained TODO FIXME XXX BUG
" syn cluster	cCommentGroup	contains=cTodo


" Some special character strings used
syn match	promFlags	"::\|->"
syn match	promCommands	"!\|?"


" Integer numbers (for both '-' and '+')
syn match	promNumber	"[+-]\=\<[0-9]\+\>"


" Strings (must be able to give arguments to printf-like function)
syn match	promFormat	display "%\(d\|u\|x\|o\|c\|e\)" contained
syn match	promFormat	display "%%" contained
syn match	promFormat	display "\\\(n\|t\|\\\|\"\|\)"  contained
syn region	promString	start=+"+ skip=+\\"+ end=+"+ contains=promFormat


" For C-like comments (comments cannot be nested)
syn region	promComment	    start="/\*" end="\*/" contains=promTodo
syn match	promCommentError    "\*/"
syn sync 	ccomment	    promComment	    minlines=30
syn region	promComment	    start="//" skip="\\$" end="$" keepend contains=promTodo


" Initialize useful constants
syn keyword	promConstant	true false TRUE FALSE


" Define derivitive (very C-like)
syn region	promDefine	start="^\s*#\s*\(define\)\>" skip="\\$" end="$" end="//"me=s-1


" Define includes
syn region	promIncluded	display contained start=+"+ skip=+\\\\\|\\"+ end=+"+
syn match	promIncluded	display contained "<[^>]*>"
syn match	promInclude	display "^\s*\(%:\|#\)\s*include\>\s*["<]" contains=promIncluded


" Define conditional preprocessor
syn region	promPreCondit	start="^\s*\(%:\|#\)\s*\(if\|ifdef\|ifndef\|elif\)\>" skip="\\$" end="$" keepend contains=promComment,promString,promNumber,promConstant
syn match	promPreCondit	display "^\s*\(%:\|#\)\s*\(else\|endif\)\>"



" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_c_syn_inits")
	if version < 508
		let did_c_syn_inits = 1
		command -nargs=+ HiLink hi link <args>
	else
		command -nargs=+ HiLink hi def link <args>
	endif
	HiLink promFlags		Function
	HiLink promCommands		promSpecial
	HiLink promFunction		promType
	HiLink promFormat		promSpecial
	HiLink promConditional		Conditional
	HiLink promRepeat		Repeat
	HiLink promNumber		Number
	HiLink promOperator		Operator
	HiLink promDefine		Macro
	HiLink promSartCommentError	promError
	HiLink promCommentError		promError
	HiLink promError		Error
	HiLink promStatement		Statement
	HiLink promType			Type
	HiLink promConstant		Constant
	HiLink promString		String
	HiLink promInclude		Include
	HiLink promIncluded		String
	HiLink promComment		Comment
	HiLink promSpecial		SpecialChar
	HiLink promTodo			Todo
	HiLink promStorageClass		StorageClass
	HiLink promPreCondit		PreCondit
 	delcommand HiLink
endif

let b:current_syntax = "promela"



" vim: ts=8
