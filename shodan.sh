#!/bin/bash
start_page=1
for ((i=start_page; i<=3000; i++))
do
    # Menjalankan perintah Python dan menyimpan hasilnya dalam variabel output
    output=$(python3 Shodan_So.py --search "querymu" --list_ip_port --page $i | tee -a output.txt)
    
    # Memeriksa apakah output mengandung pesan error terkait koneksi atau parsing JSON
    if echo "$output" | grep -q -E "Shodan API Error: (Unable to parse JSON response|Unable to connect to Shodan)"; then
        echo "Shodan API Error terdeteksi, menunggu 3 detik..."
        sleep 3
        continue
    fi
    
    # Memeriksa apakah output sesuai dengan format "IP:Port" menggunakan regex
    if echo "$output" | grep -Eq '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+:[0-9]+$'; then
        echo "Halaman ke: $i"
    else
        echo "Keluaran bukan berupa IP:Port:"
        echo "$output"
        echo "Menghentikan looping."
        break
    fi
    
    sleep 3
done
