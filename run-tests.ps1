param(
    [switch]$OpenCoverage
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$reportDir = Join-Path $scriptDir "reports"
$reportFile = Join-Path $reportDir "test-report.txt"
$htmlDir = Join-Path $reportDir "coverage-html"
$summaryFile = Join-Path $reportDir "coverage-summary.txt"
$coverageDb = Join-Path $scriptDir "cover_db"
$mainCoverageReport = Join-Path $htmlDir "coverage.html"

New-Item -ItemType Directory -Force -Path $reportDir | Out-Null

Push-Location $scriptDir
try {
    $testFiles = Get-ChildItem -Path "test" -Filter "*.t" | Sort-Object Name | ForEach-Object { $_.FullName }

    if (-not $testFiles) {
        Write-Error "No test files found under test/*.t."
        exit 1
    }

    if (Test-Path $coverageDb) {
        Remove-Item -Recurse -Force $coverageDb
    }

    if (Test-Path $htmlDir) {
        Remove-Item -Recurse -Force $htmlDir
    }

    $startTime = Get-Date
    "Test run started: $($startTime.ToString('s'))" | Set-Content -Path $reportFile
    "" | Add-Content -Path $reportFile

    $testExitCode = 0

    foreach ($testFile in $testFiles) {
        "Running test with coverage: $testFile" | Tee-Object -FilePath $reportFile -Append
        & perl -MDevel::Cover=-db,cover_db -Itest/lib $testFile 2>&1 | Tee-Object -FilePath $reportFile -Append

        if ($LASTEXITCODE -ne 0) {
            $testExitCode = $LASTEXITCODE
            break
        }
    }

    "" | Add-Content -Path $reportFile
    "ExitCode: $testExitCode" | Add-Content -Path $reportFile
    "Test run finished: $((Get-Date).ToString('s'))" | Add-Content -Path $reportFile

    & cover -summary -report html_basic -outputdir $htmlDir -select_re "10_MMSOMFY\.pm$" $coverageDb 2>&1 |
        Tee-Object -FilePath $summaryFile
    $coverExitCode = $LASTEXITCODE

    Write-Host "Test report written to: $reportFile"
    Write-Host "Coverage summary written to: $summaryFile"
    Write-Host "Coverage HTML report: $mainCoverageReport"

    if ($OpenCoverage) {
        Start-Process $mainCoverageReport
    }

    if ($testExitCode -ne 0) {
        exit $testExitCode
    }

    exit $coverExitCode
}
finally {
    Pop-Location
}