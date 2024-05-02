<h1 align="center" style="border-bottom: none">
    <br>Tengine fork for Windows
</h1>

<p align="center">
Original source repository <a href="https://github.com/alibaba/tengine/" target="_blank">Tengine on github</a>
<br>
Visit <a href="https://tengine.taobao.org" target="_blank">tengine.taobao.org</a> for the full documentation, examples and guides.
</p>

## Introduction
It a fork Tengine web server for Windows originated by [Taobao](http://en.wikipedia.org/wiki/Taobao). Based on the [Nginx](http://nginx.org) HTTP server and has many advanced features.

## Features
* Proc module disabled for windows build.
* OpenSSL Async and DTLS enabled by default.

## Requirements
* MSVC compiler.
* Perl for windows.
* MSYS 1.0.
* Sed for windows.
* Tee for windows.

## Building
Open build.cmd for editing.
Specify environment variables:
```bash
set _unixpath=
set _msyspath=
set _sedpath=
set _teepath=
set _perlpath=
set _clpath=
set _incpath=
set _libpath=
```
RUN build.cmd and choose what you want to build.
When the msys console window opens, paste the command by right-clicking and wait for completion.
After console msys closes, press any button in window build.cmd to start building.
The compiled nginx.exe will be in .\objs\.

## Build configuration
Configuration commands can be specified in section build.cmd:
```bash
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
```
--crossbuild="win32" must be specified!
