###############################################################
# THIS SCRIPT MUST BE RAN AS ADMINISTRATOR                    #
# IT CAN BE RAN REMOTELY VIA SYSTEM OR FROM THE LOCAL MACHINE #
###############################################################
 
# Uninstall HP Security-related products silently and cleanly
 
$hpApps = @(

    "HP Sure Recover",

    "HP Sure Run Module",

    "HP Wolf Security Application Support for Sure Sense",

    "HP Wolf Security Application Support for Chrome",

    "HP Wolf Security",

    "HP Wolf Security - Console",

    "HP Security Update Service"

)
 
foreach ($app in $hpApps) {

    Write-Host "`nSearching for: $app" -ForegroundColor Cyan
 
    # Use exact matching to avoid removing wrong products

    $products = Get-CimInstance -ClassName Win32_Product | Where-Object {

        $_.Name -eq $app

    }
 
    if (-not $products) {

        Write-Host "No installed product found matching exactly: $app" -ForegroundColor DarkGray

        continue

    }
 
    foreach ($product in $products) {

        Write-Host "Uninstalling $($product.Name) ..." -ForegroundColor Yellow
 
        # Run msiexec silently and seamlessly (no extra window)

        $arguments = "/x $($product.IdentifyingNumber) /qn /norestart"

        Start-Process -FilePath "msiexec.exe" -ArgumentList $arguments -Wait -WindowStyle Hidden
 
        Write-Host "Uninstalled: $($product.Name)" -ForegroundColor Green

    }

}
 
Write-Host "`nAll done!" -ForegroundColor Cyan
 
 
 