# Real-time OpenTelemetry Monitoring Script
Write-Host "Starting Real-Time OpenTelemetry Monitoring..." -ForegroundColor Green
Write-Host "Please use the application at: http://54.81.255.65:8888/checkout/payment" -ForegroundColor Yellow
Write-Host "Monitoring traces, logs, and application activity..." -ForegroundColor Cyan
Write-Host ""

# Function to monitor in parallel
function Start-Monitoring {
    # Monitor UI logs
    Start-Job -Name "UI-Logs" -ScriptBlock {
        kubectl logs -f ui-6fcdf7c9c7-vt7cg --tail=0
    }
    
    # Monitor Checkout logs  
    Start-Job -Name "Checkout-Logs" -ScriptBlock {
        kubectl logs -f checkout-5445b7f4f4-hmr2t --tail=0
    }
    
    # Monitor OTEL Traces
    Start-Job -Name "OTEL-Traces" -ScriptBlock {
        kubectl logs -f adot-traces-collector-86bbfdd9cb-z6hxk --tail=0
    }
    
    Write-Host "Started monitoring jobs. Use 'Get-Job' to check status."
    Write-Host "Use 'Receive-Job -Name UI-Logs' to see UI logs"
    Write-Host "Use 'Receive-Job -Name Checkout-Logs' to see Checkout logs" 
    Write-Host "Use 'Receive-Job -Name OTEL-Traces' to see OpenTelemetry traces"
    Write-Host ""
    Write-Host "Use 'Stop-Job -Name * | Remove-Job' to stop monitoring"
}

Start-Monitoring