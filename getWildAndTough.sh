#!/bin/sh

GET="Get"
WILD="Wild"
AND="and"
TOUGH="Tough"

getWildAndTough=($GET $WILD $AND $TOUGH)
getChanceAndLuck=(0 0 0)
g_flg=false
w_flg=false
a_flg=false

function last () {
  status=$?
  echo '強制終了しました'
  echo "ステータス: $status"
  echo  in trap, status captured
  exit $status
}

trap 'last'  {1,2,3,15}


#for (( i = 0; i < ${#getWildAndTough[@]}; ++i )); do

while true; do
  random=$(( (RANDOM % 3) + 1 ))
  rnd=$(( random - 1 ))
  echo ${getWildAndTough[$rnd]}

  getChanceAndLuck[$rnd]=${getWildAndTough[$rnd]}

  # IFSバックアップ
  IFS_BACKUP="$IFS"
  # 配列の区切り文字を改行に変更
  IFS=$'\n' 
  both=(`{ echo "${getWildAndTough[*]}" ; echo "${getChanceAndLuck[*]}"; } | sort | uniq -u`) 
  # IFSを元に戻す
  IFS="$IFS_BACKUP"
  # IFS_BACKUP変数を削除
  unset IFS_BACKUP

  if [ $both = "Tough" ] ; then
    echo ${getWildAndTough[3]}
    break;
  fi
done

