#!/bin/bash

username=$1
if [[ -z $username ]]; then
    echo "Usage: mycontribution <username>"
    exit 1
fi

declare -a months=("  J a n" "  F e b" "   M a r" "   A p r" "    M a y" "   J u n" "   J u l" "     A u g" "   S e p" "     O c t" "   N o v" "    D e c")

declare -a graph=($(curl -s https://github.com/"$1" | grep '<rect class="day"' | grep -oP '(?<=fill=").*?(?=" )'))

# print months
echo
for month in "${months[@]}"
do
    printf "%s" "$month"
done

# print contribution graph
echo
i=0
while [[ "$i" -le 6 ]]; do
    for (( n="$i";n<${#graph[@]};n+=7 )); do
        if [[ "${graph[$n]}" == "#c6e48b" ]]; then
            printf "\\e[38;5;71m▣\\e[0m|"
        elif [[ "${graph[$n]}" == "#7bc96f" ]]; then
            printf "\\e[38;5;64m▣\\e[0m|"
        elif [[ "${graph[$n]}" == "#239a3b" ]]; then
            printf "\\e[38;5;22m▣\\e[0m|"
        elif [[ "${graph[$n]}" == "#196127" ]]; then
            printf "\\e[38;5;238m▣\\e[0m|"
        # no contribution
        elif [[ "${graph[$n]}" == "#ebedf0" ]]; then
            printf "\\e[38;5;252m▣\\e[0m|"
        fi
    done
    echo
    (( i++ ))
done
echo
printf "Less \\e[38;5;252m▣\\e[0m|\\e[38;5;71m▣\\e[0m|\\e[38;5;64m▣\\e[0m|\\e[38;5;22m▣\\e[0m|\\e[38;5;238m▣\\e[0m More"
echo
