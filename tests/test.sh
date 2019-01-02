curl -s https://github.com/marounmaroun | grep '<rect class="day"' | grep -oqP '(?<=fill=").*?(?=" )'
if [[ $? -ne 0 ]]; then
    exit 1
fi
