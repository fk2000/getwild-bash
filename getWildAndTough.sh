#!/bin/sh

GET="Get"
WILD="Wild"
AND="and"
TOUGH="Tough"

getWildAndTough=($GET $WILD $AND $TOUGH)
getChanceAndLuck=(9 9 9)

# 途中でキャンセルするための処理
function last () {
  status=$?
  echo '強制終了しました'
  echo "ステータス: $status"
  echo  in trap, status captured
  exit $status
}
trap 'last'  {1,2,3,15}

# 初期化
dream=false

# 無限ループ
while true; do

  # ランダムに１～３の数値を取得
  random=$(( (RANDOM % 3) + 1 ))

  # 数値を配列用に０～２に変換
  rnd=$(( random - 1 ))
  
  # 文字列を取得
  echo ${getWildAndTough[$rnd]}

  # 一つ目の文字列を格納
  if test ${getChanceAndLuck[0]} -eq 9 ; then
    getChanceAndLuck[0]=$rnd
  else

    # 二つ目の文字列を格納
    if test ${getChanceAndLuck[1]} -eq 9 ; then
      getChanceAndLuck[1]=$rnd

    # 三つ目の文字列を格納（以降、毎回三つ目に格納して判定する）
    else
      getChanceAndLuck[2]=$rnd
    fi
  fi

  # 判定条件「０，１，２」
  if test ${getChanceAndLuck[0]} -eq 0 && test ${getChanceAndLuck[1]} -eq 1 && test ${getChanceAndLuck[2]} -eq 2 ; then
    dream=true

  # 判定NGの場合
  else
    dream=false

    # 3要素の合計が６以下の場合
    if [ $(( ${getChanceAndLuck[0]} + ${getChanceAndLuck[1]} + ${getChanceAndLuck[2]} )) -le 6 ] ; then

      # 各要素を左にシフトする（三つ目を空ける）
      getChanceAndLuck[0]=${getChanceAndLuck[1]}
      getChanceAndLuck[1]=${getChanceAndLuck[2]}
    fi
  fi

  # 判定OKの場合ループを抜ける
  if [ $dream = true ] ; then
    echo ${getWildAndTough[3]}
    break;
  fi

done

