while true; do
    response=$(curl -s -o /dev/null -w "%{http_code}" https://ipinfo.io/country)
    if [ "$response" == "403" ]; then
        echo $response
        systemctl reload tor
    elif [ "$(curl -s https://ipinfo.io/country)" != "US" ]; then
        systemctl reload tor
    else
        ./activity.sh
        systemctl reload tor
    fi
done
