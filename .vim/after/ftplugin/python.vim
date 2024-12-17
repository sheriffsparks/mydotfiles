call LspAddServer([#{name: 'pyright',
            \   filetype: 'python',
            \   path: '/home/luke/.local/bin/basedpyright-langserver',
            \   args: ['--stdio'],
            \   workspaceConfig: #{
            \     python: #{
            \       pythonPath: '/usr/bin/python3'
            \   }}
            \ }])
    " call LspOptionsSet({'aleSupport': 1})

