if g:IdeMode != 0
    call LspAddServer([#{name: 'ccls',
                \   filetype: 'c',
                \   path: '/home/luke/.local/bin/ccls',
                \   args: [],
                \ }])
endif
