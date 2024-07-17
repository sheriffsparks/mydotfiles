" let g:IdeMode = !empty(findfile("pyproject.toml", getcwd() .. ';'))
if g:IdeMode != 0
    call LspAddServer([#{name: 'pyright',
                \   filetype: 'python',
                \   path: '/usr/local/bin/pyright-langserver',
                \   args: ['--stdio'],
                \   workspaceConfig: #{
                \     python: #{
                \       pythonPath: '/usr/bin/python3.10'
                \   }}
                \ }])
    " call LspOptionsSet({'aleSupport': 1})
endif


