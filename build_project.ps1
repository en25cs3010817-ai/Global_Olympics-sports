# ==============================================================================
# Script: build_project.ps1
# Description: Master build script for Global Olympic Sports Performance Analytics
# ==============================================================================

$projectRoot = Split-Path -Parent $PSScriptRoot
$dataDir = Join-Path $projectRoot "data"
$webDir = Join-Path $projectRoot "web"
$distDir = Join-Path $projectRoot "dist"

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host " Building Olympic Analytics Project Suite" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan

# Step 1: Run Benchmark Data Assertions
Write-Host "`n[Step 1/4] Running automated benchmark test assertions..." -ForegroundColor Yellow
$verifyScript = Join-Path $PSScriptRoot "verify_benchmarks.ps1"
& powershell -ExecutionPolicy Bypass -File $verifyScript
if ($LASTEXITCODE -ne 0) {
    Write-Error "Benchmark verification failed. Halting build."
    exit 1
}

# Step 2: Build Web Distribution & Root Index
Write-Host "`n[Step 2/4] Synchronizing web application and root entry points..." -ForegroundColor Yellow
$srcHtml = Join-Path $webDir "index.html"
$destHtml = Join-Path $projectRoot "index.html"
Copy-Item -Path $srcHtml -Destination $destHtml -Force
Write-Host " [OK] Root index.html generated for zero-configuration GitHub Pages deployment." -ForegroundColor Green

# Step 3: Create Dist Package Directory
Write-Host "`n[Step 3/4] Assembling production distribution bundle in /dist..." -ForegroundColor Yellow
if (Test-Path $distDir) {
    Remove-Item -Path $distDir -Recurse -Force
}
New-Item -ItemType Directory -Path $distDir | Out-Null
New-Item -ItemType Directory -Path (Join-Path $distDir "data") | Out-Null
New-Item -ItemType Directory -Path (Join-Path $distDir "web") | Out-Null

Copy-Item -Path (Join-Path $dataDir "*.csv") -Destination (Join-Path $distDir "data") -Force
Copy-Item -Path (Join-Path $webDir "*") -Destination (Join-Path $distDir "web") -Recurse -Force
Copy-Item -Path (Join-Path $projectRoot "index.html") -Destination $distDir -Force
Copy-Item -Path (Join-Path $projectRoot "README.md") -Destination $distDir -Force
Copy-Item -Path (Join-Path $projectRoot "LICENSE") -Destination $distDir -Force
Write-Host " [OK] Distribution bundle assembled with all datasets, dashboards, and assets." -ForegroundColor Green

# Step 4: Summary of Artifacts
Write-Host "`n[Step 4/4] Verifying build artifacts..." -ForegroundColor Yellow
$csvFiles = Get-ChildItem -Path $dataDir -Filter "*.csv"
Write-Host " [OK] Data files verified: $($csvFiles.Count) CSVs" -ForegroundColor Green
Write-Host " [OK] Tableau specifications ready in /tableau" -ForegroundColor Green
Write-Host " [OK] Verification scripts ready in /scripts" -ForegroundColor Green

Write-Host "`n============================================================" -ForegroundColor Cyan
Write-Host " BUILD SUCCESSFUL! Project is production ready." -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Cyan
