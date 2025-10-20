-- Dynamically find the JDTLS launcher jar
local function get_jdtls_jar()
  local jdtls_path = vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/plugins/")
  local jar_patterns = vim.fn.glob(jdtls_path .. "org.eclipse.equinox.launcher_*.jar", true, true)

  if #jar_patterns > 0 then
    -- Sort to get the latest version and return the first match
    table.sort(jar_patterns)
    return jar_patterns[#jar_patterns]
  end

  -- Fallback error message
  error("JDTLS launcher jar not found in " .. jdtls_path)
end

require("jdtls").start_or_attach({
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", get_jdtls_jar(),
    "-configuration", vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/config_linux"),
    "-data", vim.fn.expand("~/.cache/jdtls/workspace")
  },
  root_dir = vim.fs.root(0, {".git", "mvnw", "gradlew"}),
})
