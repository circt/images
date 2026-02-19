# escape=`

ARG FROM_IMAGE=mcr.microsoft.com/windows/servercore:ltsc2025
FROM ${FROM_IMAGE}

# Reset the shell.
SHELL ["cmd", "/S", "/C"]

# Download channel for fixed install.
ARG CHANNEL_URL=https://aka.ms/vs/17/release/channel
ADD ${CHANNEL_URL} C:\TEMP\VisualStudio.chman

# Download and install Build Tools for Visual Studio 2019 for native desktop workload.
ADD https://aka.ms/vs/17/release/vs_buildtools.exe C:\TEMP\vs_buildtools.exe
RUN C:\TEMP\vs_buildtools.exe --quiet --wait --norestart --nocache `
  --channelUri C:\TEMP\VisualStudio.chman `
  --installChannelUri C:\TEMP\VisualStudio.chman `
  --add Microsoft.VisualStudio.Workload.VCTools --includeRecommended `
  --add Microsoft.VisualStudio.Component.VC.ATL `
  --add Microsoft.VisualStudio.Component.VC.ATLMFC `
  --installPath C:\BuildTools

# Install NuGet as package provider (needed for find-vs.ps1).
RUN powershell Install-PackageProvider -Name NuGet -Force

# Download, unzip, and add ccache to path
ADD https://github.com/ccache/ccache/releases/download/v4.7.1/ccache-4.7.1-windows-x86_64.zip C:\TEMP\ccache.zip
RUN powershell Expand-Archive -Path C:\TEMP\ccache.zip -DestinationPath C:\ccache
RUN setx /M PATH "%PATH%;C:\ccache\ccache-4.7.1-windows-x86_64"

# Download and install git.
ADD https://github.com/git-for-windows/git/releases/download/v2.38.0.windows.1/Git-2.38.0-64-bit.exe C:\TEMP\git-install.exe
RUN C:\TEMP\git-install.exe /VERYSILENT /NORESTART
RUN setx /M PATH "%PATH%;C:\Program Files\Git\bin"

# Get latest version of cmake
ADD https://github.com/Kitware/CMake/releases/download/v3.26.0/cmake-3.26.0-windows-x86_64.msi C:\TEMP\cmake.msi
RUN msiexec /i C:\TEMP\cmake.msi

# Install PowerShell
ADD https://github.com/PowerShell/PowerShell/releases/download/v7.3.0/PowerShell-7.3.0-win-x86.msi C:\TEMP\pwsh-install.msi
RUN msiexec /i C:\TEMP\pwsh-install.msi

# Clone and bootstrap vcpkg.
RUN cd c:\ && git clone https://github.com/Microsoft/vcpkg.git && .\vcpkg\bootstrap-vcpkg.bat

# Install zlib via vcpkg.
RUN c:\vcpkg\vcpkg install --triplet x64-windows install zlib

# Install capnproto via vcpkg.
RUN c:\vcpkg\vcpkg install --triplet x64-windows install grpc

# Use developer command prompt and start PowerShell if no other command specified.
ENTRYPOINT C:\BuildTools\Common7\Tools\VsDevCmd.bat -arch=x64 -host_arch=x64 &&
CMD powershell.exe -NoLogo -ExecutionPolicy Bypass
