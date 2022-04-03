local M_opts = require("telescope._extensions.terraform_doc.config").opts
local curl = require("plenary.curl")

local M = {}
local base_url = "https://raw.githubusercontent.com/ANGkeith/test-cron/api"

---
---Returns the url to the documentation
function M.get_modules()
  local result = {}
  local modules = curl.request({
    url = base_url .. "/modules.csv",
    method = "get",
  }).body

  for m in modules:gmatch("[^\n]+") do
    local name, namespace, provider_name, description, source, id = m:match(string.rep("%s*(.-),", 5) .. "%s*(.*)")
    result[#result + 1] = {
      name = name,
      namespace = namespace,
      provider_name = provider_name,
      description = description,
      source = source,
      id = id,
    }
  end
  return result
end

return M
