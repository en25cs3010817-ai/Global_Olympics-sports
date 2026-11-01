# ==============================================================================
# Script: verify_benchmarks.ps1
# Description: Automated benchmark validation against project scenario requirements
# ==============================================================================

$baseDir = Split-Path -Parent $PSScriptRoot
$dataDir = Join-Path $baseDir "data"

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host " Olympic Analytics: Validating Benchmark Data Assertions" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan

$passed = 0
$total = 0

function Assert-Benchmark($testName, $actual, $expected) {
    $script:total++
    $epsilon = 0.001
    $isMatch = $false
    
    if ($actual -is [string]) {
        $isMatch = ($actual -eq $expected)
    } else {
        $isMatch = [Math]::Abs($actual - $expected) -lt $epsilon
    }

    if ($isMatch) {
        Write-Host " [PASS] $testName : Actual = $actual | Expected = $expected" -ForegroundColor Green
        $script:passed++
    } else {
        Write-Host " [FAIL] $testName : Actual = $actual | Expected = $expected" -ForegroundColor Red
    }
}

# ----------------------------------------------------
# 1. SCENARIO 1: MS. PRIYA (SPORTS CATEGORY & COUNTRY METRICS)
# ----------------------------------------------------
Write-Host "`n--- Checking Scenario 1: Ms. Priya ---" -ForegroundColor Yellow

# Sports Summary
$sports = Import-Csv (Join-Path $dataDir "sports_summary.csv")
$rowing = $sports | Where-Object { $_.Sport_Category -eq "Rowing" }
Assert-Benchmark "Rowing Avg Medals per Athlete" ([double]$rowing.Avg_Medals_Per_Athlete) 6.916

$shooting = $sports | Where-Object { $_.Sport_Category -eq "Shooting" }
Assert-Benchmark "Shooting Avg Medals per Athlete" ([double]$shooting.Avg_Medals_Per_Athlete) 6.731

# Countries
$countries = Import-Csv (Join-Path $dataDir "country_performance_investment.csv")
$usa = $countries | Where-Object { $_.NOC -eq "USA" }
Assert-Benchmark "USA Total Medals" ([int]$usa.Total_Medals) 735

$chn = $countries | Where-Object { $_.NOC -eq "CHN" }
Assert-Benchmark "China Total Medals" ([int]$chn.Total_Medals) 696

# ----------------------------------------------------
# 2. SCENARIO 2: MR. CARLOS (INVESTMENT & EFFICIENCY)
# ----------------------------------------------------
Write-Host "`n--- Checking Scenario 2: Mr. Carlos ---" -ForegroundColor Yellow

$regions = Import-Csv (Join-Path $dataDir "regional_investment.csv")
$sa = $regions | Where-Object { $_.Region -eq "South America" }
Assert-Benchmark "South America Regional Efficiency" ([double]$sa.Avg_Medal_Efficiency_Pct) 49.64

$ea = $regions | Where-Object { $_.Region -eq "Europe/Asia" }
Assert-Benchmark "Europe/Asia Regional Efficiency" ([double]$ea.Avg_Medal_Efficiency_Pct) 45.98

# Overperforming nations check
$slovakia = $countries | Where-Object { $_.Country -eq "Slovakia" }
$georgia = $countries | Where-Object { $_.Country -eq "Georgia" }
$ethiopia = $countries | Where-Object { $_.Country -eq "Ethiopia" }

Assert-Benchmark "Slovakia exists with high efficiency (>50%)" ($slovakia -ne $null -and [double]$slovakia.Medal_Efficiency_Pct -gt 50.0) $true
Assert-Benchmark "Georgia exists with high efficiency (>50%)" ($georgia -ne $null -and [double]$georgia.Medal_Efficiency_Pct -gt 50.0) $true
Assert-Benchmark "Ethiopia exists with high efficiency (>50%)" ($ethiopia -ne $null -and [double]$ethiopia.Medal_Efficiency_Pct -gt 50.0) $true

# ----------------------------------------------------
# 3. SCENARIO 3: WILLIAM ROBERT (TIMELINE & HOST MEDALS)
# ----------------------------------------------------
Write-Host "`n--- Checking Scenario 3: William Robert ---" -ForegroundColor Yellow

$timeline = Import-Csv (Join-Path $dataDir "olympic_editions_timeline.csv")
$y2000 = $timeline | Where-Object { $_.Year -eq "2000" }
Assert-Benchmark "2000 Total Medals (Low)" ([int]$y2000.Total_Medals_Awarded) 305

$y2020 = $timeline | Where-Object { $_.Year -eq "2020" }
Assert-Benchmark "2020 Total Medals (Peak)" ([int]$y2020.Total_Medals_Awarded) 363

$y2026 = $timeline | Where-Object { $_.Year -eq "2026" }
Assert-Benchmark "2026 Total Medals" ([int]$y2026.Total_Medals_Awarded) 334

# Host nation medals
$hosts = Import-Csv (Join-Path $dataDir "host_nation_performance.csv")
$japanHost = $hosts | Where-Object { $_.Host_Country -eq "Japan" }
Assert-Benchmark "Japan Host Medals" ([int]$japanHost.Total_Host_Medals) 105

$usaHost = $hosts | Where-Object { $_.Host_Country -eq "United States" }
Assert-Benchmark "USA Host Medals" ([int]$usaHost.Total_Host_Medals) 100

$chinaHost = $hosts | Where-Object { $_.Host_Country -eq "China" }
Assert-Benchmark "China Host Medals" ([int]$chinaHost.Total_Host_Medals) 93

# ----------------------------------------------------
# SUMMARY
# ----------------------------------------------------
Write-Host "`n============================================================" -ForegroundColor Cyan
Write-Host " Validation Results: $passed / $total Tests Passed" -ForegroundColor $(if ($passed -eq $total) { "Green" } else { "Red" })
Write-Host "============================================================" -ForegroundColor Cyan

if ($passed -ne $total) {
    exit 1
}
exit 0
