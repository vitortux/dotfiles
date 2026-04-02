return {
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      opts.settings = vim.tbl_deep_extend("force", opts.settings or {}, {
        java = {
          format = {
            enabled = true,
            settings = {
              url = vim.fn.expand("~/dev/maven/apache-maven-3.9.12/codestyle/magna-sistemas-java-code-formatter.xml"),
              profile = "Magna Sistemas",
            },
          },
          completion = {
            importOrder = {
              "#",
              "java",
              "javax",
              "jakarta",
              "lombok",
              "springfox",
              "org",
              "com",
              "io",
              "br",
              "",
            },
          },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
        },
      })
    end,
  },
}
