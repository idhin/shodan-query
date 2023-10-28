#!/bin/bash
max_retries=10

IFS=':' # Set pemisah kolon sebagai IFS (Internal Field Separator)

for ((start_page=1; start_page<=3000; start_page++))
do
    while IFS= read -r line; do
        ip_port=($line)
        ip=${ip_port[0]}
        port=${ip_port[1]}

        if [[ -n $ip && -n $port ]]; then
            if [[ $port == "443" ]]; then
                url="https://$ip"
            elif [[ $port == "80" ]]; then
                url="http://$ip"
            else
                url="http://$ip:$port"
            fi

            echo "URL: $url"
            echo "$url" >> httpduaratusamazon.txt
        fi

    done <<< "$(python3 Shodan_So.py --search "query'" --list_ip_port --page $start_page | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+:[0-9]+$')"

done

unset IFS # Kembalikan IFS ke nilai default
