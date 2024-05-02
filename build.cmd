::http://nginx.org/en/docs/configure.html

::Procs module disable for win32.
::https://github.com/alibaba/tengine/blob/master/docs/modules/ngx_procs_module.md

@echo off

title Build nginx

::Project path with slash for MSYS
set _unixpath=d:/WIP/C++/Project/.GIT/tengine-win32
::MSYS 1.0 bin path
set _msyspath=d:\WIP_TOOLS\MSYS\1.0\
::sed bin path
set _sedpath=d:\WIP_TOOLS\sed\bin\
::tee bin path
set _teepath=d:\WIP_TOOLS\tee\
::Perl bin path
set _perlpath=d:\WIP_TOOLS\Perl\bin\
::MSVC compiler bin path
set _clpath=d:\WIP\C++\VCPP2017v140\bin\x86\
::MSVC include path
set _incpath=d:\WIP\C++\VCPP2017v140\include\
::MSVC lib path
set _libpath=d:\WIP\C++\VCPP2017v140\lib\x86\

@RMDIR /S /Q "%cd%\auto" > nul
@RMDIR /S /Q "%cd%\conf" > nul
@RMDIR /S /Q "%cd%\contrib" > nul
@RMDIR /S /Q "%cd%\docs" > nul
@RMDIR /S /Q "%cd%\html" > nul
@RMDIR /S /Q "%cd%\man" > nul
@RMDIR /S /Q "%cd%\modules" > nul
@RMDIR /S /Q "%cd%\objs" > nul
@RMDIR /S /Q "%cd%\src" > nul
@DEL /Q "%cd%\Makefile" > nul
@DEL /Q "%cd%\msys.sh" > nul
@DEL /Q "%cd%\build.log" > nul

cls
echo Build nginx...
echo.


:START
echo Build nginx         - N
echo Build tengine       - T
echo Exit                - X
set /p _strt=Your choice: 
set _strt=q%_strt%
if /I %_strt%==qn goto :NGINX
if /I %_strt%==qt goto :TENGINE
if /I %_strt%==qx goto :EXIT
cls
echo Build nginx...
echo.
echo Unknown choice. Try again...
goto :START

:NGINX
echo.
echo Create workspace and copy nginx sources and libs...
@MD "%cd%\objs\lib" > nul
XCOPY "%cd%\!src\lib\openssl-3.0.10\" "%cd%\objs\lib\openssl-3.0.10\" /s /e /q
XCOPY "%cd%\!src\lib\pcre2-10.39\" "%cd%\objs\lib\pcre2-10.39\" /s /e /q
XCOPY "%cd%\!src\lib\zlib-1.3\" "%cd%\objs\lib\zlib-1.3\" /s /e /q
XCOPY "%cd%\!src\nginx\nginx-1.24.0\auto\" "%cd%\auto\" /s /e /q
XCOPY "%cd%\!src\nginx\nginx-1.24.0\man\" "%cd%\man\" /s /e /q
XCOPY "%cd%\!src\nginx\nginx-1.24.0\src\" "%cd%\src\" /s /e /q
COPY "%cd%\!src\nginx\nginx-1.24.0\configure" "%cd%\auto\configure"
goto :COMPILE

:TENGINE
echo.
echo Create workspace and copy tengine sources and libs...
@MD "%cd%\objs\lib" > nul
XCOPY "%cd%\!src\lib\openssl-3.0.10\" "%cd%\objs\lib\openssl-3.0.10\" /s /e /q
XCOPY "%cd%\!src\lib\pcre2-10.39\" "%cd%\objs\lib\pcre2-10.39\" /s /e /q
XCOPY "%cd%\!src\lib\zlib-1.3\" "%cd%\objs\lib\zlib-1.3\" /s /e /q
XCOPY "%cd%\!src\nginx\tengine-3.1.0\auto\" "%cd%\auto\" /s /e /q
XCOPY "%cd%\!src\nginx\tengine-3.1.0\man\" "%cd%\man\" /s /e /q
XCOPY "%cd%\!src\nginx\tengine-3.1.0\modules\" "%cd%\modules\" /s /e /q
XCOPY "%cd%\!src\nginx\tengine-3.1.0\src\" "%cd%\src\" /s /e /q
XCOPY "%cd%\!src\nginx\nginx-1.24.0\src\os\win32\" "%cd%\src\os\win32\" /s /e /q
COPY "%cd%\!src\nginx\tengine-3.1.0\src\os\unix\ngx_sysinfo.c" "%cd%\src\os\win32\ngx_sysinfo.c"
COPY "%cd%\!src\nginx\tengine-3.1.0\src\os\unix\ngx_sysinfo.h" "%cd%\src\os\win32\ngx_sysinfo.h"
XCOPY "%cd%\!src\nginx\dns\auto\" "%cd%\auto\" /s /e /q /y
XCOPY "%cd%\!src\nginx\dns\src\" "%cd%\src\" /s /e /q /y
@RMDIR /S /Q "%cd%\src\proc" > nul
@RMDIR /S /Q "%cd%\src\os\unix" > nul
goto :COMPILE

:COMPILE
set PATH=%PATH%;%_msyspath%;%_sedpath%;%_teepath%;%_perlpath%;%_clpath%;
set INCLUDE=%INCLUDE%;%_incpath%;
set LIB=%LIB%;%_libpath%;

echo.
echo Create msys.sh...
echo #!/bin/sh>msys.sh
echo.>>msys.sh
echo cd %_unixpath%>>msys.sh
echo.>>msys.sh
echo sh auto/configure \>>msys.sh
echo --crossbuild="win32" \>>msys.sh
echo --with-cc=cl \>>msys.sh
echo --with-debug \>>msys.sh
echo --with-cc-opt="-DFD_SETSIZE=1024" \>>msys.sh
echo --with-http_ssl_module \>>msys.sh
echo --with-http_gzip_static_module \>>msys.sh
echo --with-compat \>>msys.sh
echo --prefix="" \>>msys.sh
echo --sbin-path="nginx.exe" \>>msys.sh
echo --conf-path="conf/nginx.conf" \>>msys.sh
echo --pid-path="logs/nginx.pid" \>>msys.sh
echo --http-log-path="logs/access.log" \>>msys.sh
echo --error-log-path="logs/error.log" \>>msys.sh
echo --http-client-body-temp-path="temp/client_body_temp" \>>msys.sh
echo --http-proxy-temp-path="temp/proxy_temp" \>>msys.sh
echo --http-fastcgi-temp-path="temp/fastcgi_temp" \>>msys.sh
echo --http-scgi-temp-path="temp/scgi_temp" \>>msys.sh
echo --http-uwsgi-temp-path="temp/uwsgi_temp" \>>msys.sh
echo --with-pcre="objs/lib/pcre2-10.39" \>>msys.sh
echo --with-pcre-opt="" \>>msys.sh
echo --with-zlib="objs/lib/zlib-1.3" \>>msys.sh
echo --with-zlib-opt="" \>>msys.sh
echo --with-openssl="objs/lib/openssl-3.0.10" \>>msys.sh
echo --with-openssl-opt="no-asm">>msys.sh

echo sh %_unixpath%/msys.sh ^&^& exit>sh.txt
clip<sh.txt
@DEL /Q "%cd%\sh.txt" > nul
rem echo sh %_unixpath%/msys.sh|clip

echo.
echo Run msys and creating makefile...
echo After close MSYS console press any key for build.
echo Past command from clipboard to MSYS console.
start msys.bat
pause

echo.
echo Building...
nmake.exe -f objs/Makefile|tee con>%cd%\build.log

:EXIT
echo.
pause
exit /b