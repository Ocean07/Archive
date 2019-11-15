#!/bin/bash

scheme="OCCallJS"
#假设脚本放置在与项目相同的路径下
project_path=$(pwd)

function export_adhoc() {
        ARCHIVE_METHOD="Adhoc"
        ARCHIVE_PATH="${project_path}/export/archives/${ARCHIVE_METHOD}"
        xcodebuild archive -scheme ${scheme} -configuration ${ARCHIVE_METHOD}  -archivePath ${ARCHIVE_PATH}  DWARF_DSYM_FOLDER_PATH="${project_path}/export/ipas/${scheme}_adhoc"

        EXPORT_PATH="${project_path}/export/ipas/${scheme}_adhoc"
        EXPORT_PLIST_PATH="${project_path}/export/ExportOptions_Adhoc.plist"
        xcodebuild -exportArchive -archivePath ${ARCHIVE_PATH}.xcarchive -exportPath ${EXPORT_PATH}  -exportOptionsPlist ${EXPORT_PLIST_PATH}
}

function export_debug() {
        ARCHIVE_METHOD="Debug"
        ARCHIVE_PATH="${project_path}/export/archives/${ARCHIVE_METHOD}"
        xcodebuild archive -scheme ${scheme} -configuration ${ARCHIVE_METHOD}  -archivePath ${ARCHIVE_PATH}

        EXPORT_PATH="${project_path}/export/ipas/${scheme}_dev"
        EXPORT_PLIST_PATH="${project_path}/export/ExportOptions_Debug.plist"
        xcodebuild -exportArchive -archivePath ${ARCHIVE_PATH}.xcarchive -exportPath ${EXPORT_PATH}  -exportOptionsPlist ${EXPORT_PLIST_PATH}
}

if [ $1 = "adhoc" ]; then
   echo "打包 ---> adhoc"
   export_adhoc
elif [ $1 == "debug" ]; then
   echo "打包 ---> debug"
   export_debug
fi


#输出总用时
echo "=======> 完成 <======="



