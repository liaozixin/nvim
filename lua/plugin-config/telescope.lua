require('telescope').setup{
    defaults = {
        file_ignore_patterns = {
            "^%.git", "^%.cache", "^%.xmake"
        }
    },
    extensions = {
        file_browser = {
            hidden = true,
            respect_gitignore = true,
        }
    }
}
