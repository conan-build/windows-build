FROM mcr.microsoft.com/windows/servercore:ltsc2019

SHELL ["cmd.exe", "/S", "/C"]

ENV PYTHONIOENCODING=UTF-8

ADD  https://aka.ms/vs/16/release/vs_buildtools.exe vs_buildtools.exe
RUN start /w vs_buildtools.exe --quiet --wait --norestart --nocache \
	--installPath "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\BuildTools"  \	
	--add Microsoft.VisualStudio.Workload.MSBuildTools \
	--add Microsoft.VisualStudio.Workload.VCTools  \
	--add Microsoft.VisualStudio.Component.VC.ATL  \
	--add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 \	
	--add Microsoft.VisualStudio.Component.Windows10SDK.19041 
RUN del vs_buildtools.exe

ADD https://github.com/Kitware/CMake/releases/download/v3.23.1/cmake-3.23.1-windows-x86_64.msi cmake-3.23.1-windows-x86_64.msi
RUN start /w msiexec /quiet /qn /norestart /i cmake-3.23.1-windows-x86_64.msi ADD_CMAKE_TO_PATH=System
RUN del cmake-3.23.1-windows-x86_64.msi

ADD https://www.python.org/ftp/python/3.10.4/python-3.10.4-amd64.exe python-3.10.4-amd64.exe
RUN start /w python-3.10.4-amd64.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
RUN del python-3.10.4-amd64.exe

ADD https://github.com/git-for-windows/git/releases/download/v2.36.1.windows.1/Git-2.36.1-64-bit.exe Git-2.36.1-64-bit.exe
RUN start /w Git-2.36.1-64-bit.exe /SILENT /VERYSILENT /ALLUSERS /NORESTART /NOCLOSEAPPLICATIONS /NOICONS
RUN del Git-2.36.1-64-bit.exe
