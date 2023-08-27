
#!/bin/bash
for i in {1..3000} #Sampe 3000 halaman
do
    # Menjalankan perintah Python dan menyimpan hasilnya dalam variabel output
    output=$(python3 Shodan_So.py --search "'queryshodandisini" --list_ip_port --page $i | tee -a output.txt)
    
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
