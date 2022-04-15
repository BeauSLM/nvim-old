local overwrite =function()
  require('overwrite.event')
  require('overwrite.mapping')
  require('overwrite.options')
end

_G.lprint=require'utils.log'.lprint

overwrite()
