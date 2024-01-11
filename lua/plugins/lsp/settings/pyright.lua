return {
  settings = {
    python = {
      analysis = {
        diagnosticSeverityOverrides = {
          reportUnboundVariable = "none",
          reportGeneralTypeIssues = "none",
        },
        typeCheckingMode = "basic", -- off, basic, strict
      },
    },
  },
}
