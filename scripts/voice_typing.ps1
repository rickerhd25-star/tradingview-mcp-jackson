Add-Type @"
using System;
using System.Runtime.InteropServices;
using System.Threading;
public class KB {
    [DllImport("user32.dll")]
    public static extern void keybd_event(byte vk, byte scan, uint flags, UIntPtr extra);
    public static void WinH() {
        keybd_event(0x5B, 0, 0, UIntPtr.Zero);
        Thread.Sleep(50);
        keybd_event(0x48, 0, 0, UIntPtr.Zero);
        Thread.Sleep(50);
        keybd_event(0x48, 0, 2, UIntPtr.Zero);
        Thread.Sleep(50);
        keybd_event(0x5B, 0, 2, UIntPtr.Zero);
    }
}
"@

Start-Sleep -Seconds 1
$wsh = New-Object -ComObject WScript.Shell
$wsh.AppActivate('Program Manager')
Start-Sleep -Milliseconds 500
[KB]::WinH()
