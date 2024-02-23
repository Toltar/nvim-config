local typescript_tools = require 'typescript-tools'

typescript_tools.setup {
  settings = {
    tsserver_max_memory = 'auto',
  },
}
