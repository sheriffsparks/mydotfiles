let g:IdeMode = !empty(findfile("pyproject.toml", getcwd() .. ';'))
if g:IdeMode != 0
    packadd lsp
    setlocal keywordprg=:LspHover
    call LspAddServer([#{name: 'pyright',
                \   filetype: 'python',
                \   path: '/usr/local/bin/pyright-langserver',
                \   args: ['--stdio'],
                \   workspaceConfig: #{
                \     python: #{
                \       pythonPath: '/usr/bin/python3.10'
                \   }}
                \ }])
    augroup LspCustom
        au!
        au CursorMoved * silent! LspDiag! current
    augroup END
    call LspOptionsSet({'aleSupport': 1})
endif


