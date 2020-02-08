#!/bin/bash

username=$1
symbol=${2:-▣}
if [[ -z $username ]]; then
    echo "Usage: mycontribution <username>"
    exit 1
fi

declare -a months=("  F e b" "  M a r" "   A p r" "   M a y" "    J u n" "   J u l" "   A u g" "     S e p" "   O c t" "     N o v" "   D e c" "    J a n")

declare -a graph=($(curl -s https://github.com/"$username" | ggrep '<rect class="day"' | ggrep -oP '(?<=fill=").*?(?=" )'))

if [[ -z "$graph" ]]; then
    echo "User $username doesn't exist"
    exit 1
fi

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
            printf "\\e[38;5;71m$symbol\\e[0m|"
        elif [[ "${graph[$n]}" == "#7bc96f" ]]; then
            printf "\\e[38;5;64m$symbol\\e[0m|"
        elif [[ "${graph[$n]}" == "#239a3b" ]]; then
            printf "\\e[38;5;22m$symbol\\e[0m|"
        elif [[ "${graph[$n]}" == "#196127" ]]; then
            printf "\\e[38;5;238m$symbol\\e[0m|"
        # no contribution
        elif [[ "${graph[$n]}" == "#ebedf0" ]]; then
            printf "\\e[38;5;252m$symbol\\e[0m|"
        fi
    done
    echo
    (( i++ ))
done
echo
printf "Less \\e[38;5;252m$symbol\\e[0m|\\e[38;5;71m$symbol\\e[0m|\\e[38;5;64m$symbol\\e[0m|\\e[38;5;22m$symbol\\e[0m|\\e[38;5;238m$symbol\\e[0m More"
echo
