hi NoteGroup guifg=Green ctermfg=Green cterm=bold
hi TodoGroup guifg=Red ctermfg=Red cterm=bold
hi ImportantGroup guifg=Yellow ctermfg=Yellow cterm=bold
let m = matchadd("NoteGroup", "NOTE")
let m = matchadd("TodoGroup", "TODO")
let m = matchadd("ImportantGroup", "IMPORTANT")
