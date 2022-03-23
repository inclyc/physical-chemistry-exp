
#!/bin/bash

# 遍历文件夹中的所有文件，将字符集从GB18030转换为UTF

# 参数：
# $1：源文件夹
# $2：目标文件夹

# 获取文件夹中的所有文件：
FILES=`find $1 -type f`

# 遍历所有文件，转换字符集，转换行尾序列：
for FILE in $FILES 
do
    cp $FILE $FILE.tmp
    iconv -f GB18030 -t UTF-8 $FILE.tmp > $2/$FILE
    sed -i 's/\r$//' $2/$FILE
    rm $FILE.tmp
done