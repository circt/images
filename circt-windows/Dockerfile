# escape=`

ARG FROM_IMAGE=mcr.microsoft.com/windows:ltsc2019
FROM ${FROM_IMAGE}

# Reset the shell.
SHELL ["cmd", "/S", "/C"]

# Download channel for fixed install.
ARG CHANNEL_URL=https://aka.ms/vs/16/release/channel
ADD ${CHANNEL_URL} C:\TEMP\VisualStudio.chman

# Download and install Build Tools for Visual Studio 2019 for native desktop workload.
ADD https://aka.ms/vs/16/release/vs_buildtools.exe C:\TEMP\vs_buildtools.exe
RUN C:\TEMP\vs_buildtools.exe --quiet --wait --norestart --nocache `
  --channelUri C:\TEMP\VisualStudio.chman `
  --installChannelUri C:\TEMP\VisualStudio.chman `
  --add Microsoft.VisualStudio.Workload.VCTools --includeRecommended `
  --add Microsoft.VisualStudio.Component.VC.ATL `
  --add Microsoft.VisualStudio.Component.VC.ATLMFC `
  --installPath C:\BuildTools

# Download git to somewhere in the devcmd path.
ADD https://github.com/git-for-windows/git/releases/download/v2.38.0.windows.1/Git-2.38.0-64-bit.exe C:\TEMP\git-install.exe
RUN C:\TEMP\git-install.exe /VERYSILENT /NORESTART

# Download and install python.
ADD https://www.python.org/ftp/python/3.10.7/python-3.10.7-amd64.exe C:\TEMP\python-install.exe
RUN C:\TEMP\python-install.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
RUN pip install wheel numpy pyyaml pybind11 cocotb cocotb-test jinja2

# Clone and bootstrap vcpkg.
RUN cd c:\ && git clone https://github.com/Microsoft/vcpkg.git && .\vcpkg\bootstrap-vcpkg.bat

# Use developer command prompt and start PowerShell if no other command specified.
ENTRYPOINT C:\BuildTools\Common7\Tools\VsDevCmd.bat &&
CMD powershell.exe -NoLogo -ExecutionPolicy Bypass
