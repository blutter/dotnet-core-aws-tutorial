#!/bin/sh

set -x

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

cd $SCRIPT_DIR/../dotnet-core-tutorial
rm -rf site publish dotnet-core-tutorial.zip
dotnet publish -o site
mkdir publish
pushd site
powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::CreateFromDirectory('.', '..\\publish\\site.zip'); }"
popd
cp aws-windows-deployment-manifest.json publish

pushd publish
powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::CreateFromDirectory('.', '..\\dotnet-core-tutorial.zip'); }"
popd