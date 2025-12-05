# ==========================
# Config
# ==========================
$exeName = "truc.exe"
$goFile = "malware.go"
$versionJson = "versioninfo.json"
$sysoFile = "versioninfo.syso"

# ==========================
# Step 1: Generate 64-bit .syso
# ==========================
Write-Host "Generating 64-bit .syso from $versionJson..."
rsrc -arch=amd64 -manifest $versionJson -o $sysoFile

# ==========================
# Step 2: Clean Go cache
# ==========================
Write-Host "Cleaning Go build cache..."
go clean -cache
go clean -modcache

# ==========================
# Step 3: Build the EXE
# ==========================
Write-Host "Building $exeName..."
go build -a -o $exeName $goFile

Write-Host "Build complete! Check $exeName -> Properties -> Details tab for metadata."
