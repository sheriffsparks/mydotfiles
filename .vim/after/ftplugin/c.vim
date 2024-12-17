if g:IdeMode != 0
    call LspAddServer([#{name: 'ccls',
                \   filetype: ['c','cpp'],
                \   path: '/usr/bin/ccls',
                \   args: [],
                \ }])
endif
