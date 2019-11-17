curl -s https://github.com/marounmaroun | grep '<rect class="day"' | grep -oP '(?<=fill=").*?(?=" )'
if [[ $? -ne 0 ]]; then
    exit 1
fi
