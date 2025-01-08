#!/bin/bash

# Unduh binary miner
wget -q https://github.com/Project-InitVerse/ini-miner/releases/download/v1.0.0/iniminer-linux-x64
chmod +x iniminer-linux-x64

# Buat direktori iniminer dan pindah ke sana
mkdir -p iniminer
cd iniminer

# Generate nama worker secara acak (WorkerXXX)
WORKER_NAME="Worker$(shuf -i 100-999 -n 1)"

# Jalankan miner menggunakan pm2
pm2 start /root/iniminer-linux-x64 --name iniminer --no-daemon -- --pool stratum+tcp://0x35a6FbF917e20ff6D8e58CD422C5C695A4EeD0D4.${WORKER_NAME}@pool-core-testnet.inichain.com:32672 --cpu-devices 1

# Konfigurasi pm2 agar berjalan saat startup
pm2 startup
pm2 save
pm2 list

echo "Iniminer telah dijalankan dengan nama worker: ${WORKER_NAME}"
