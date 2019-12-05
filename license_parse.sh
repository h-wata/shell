#!/bin/bash
find $PWD -type f -name package.xml | while read file;do
# packageの名称を取得
name_xml=`echo "cat /package/name" | xmllint --shell ${file}`
# licenseを取得
license_xml=`echo "cat /package/license" | xmllint --shell ${file}`
url_xml=`echo "cat /package/url" | xmllint --shell ${file} | sed -e "s/^.*<url.*>\(.*\)<\/url>.*$/\1/" |grep http |tr "\n" ","`


# 全て取得した場合、ループを抜ける
if [  "${name_xml}" = "/ > / > " ]; then
    break
fi

# 取得内容を整形
name=`echo ${name_xml} | sed -e "s/^.*<name.*>\(.*\)<\/name>.*$/\1/"`
license=`echo ${license_xml} | sed -e "s/^.*<license.*>\(.*\)<\/license>.*$/\1/"`
url=`echo ${url_xml}`

# 取得結果を表示
# if [ "${license}" != "BSD" ]; then
# if [ "${license}" != "BSD" -a "${license}" != "MIT" ]    ; then
    # if  $(echo ${license} | grep -v Apache > /dev/null) ; then
        echo "${name}, ${license}, ${url}"
    # fi
# fi
done
