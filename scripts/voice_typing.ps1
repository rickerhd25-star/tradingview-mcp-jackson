Add-Type @"
using System;
using System.Runtime.InteropServices;
using System.Threading;
public class WinInput {
    [DllImport("user32.dll")] public static extern IntPtr GetShellWindow();
    [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr hWnd);
    [DllImport("user32.dll")] public static extern bool AllowSetForegroundWindow(int dwProcessId);
    [DllImport("user32.dll")] public static extern void keybd_event(byte vk, byte scan, uint flags, UIntPtr extra);

    public static void SendWinH() {
        AllowSetForegroundWindow(-1);
        IntPtr shell = GetShellWindow();
        SetForegroundWindow(shell);
        Thread.Sleep(600);
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

Start-Sleep -Seconds 2
[WinInput]::SendWinH()
