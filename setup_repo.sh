#!/bin/bash

# Bersihkan layar agar lebih rapi (opsional)
clear

echo "===================================="
echo "     Push ke GitHub Baru"
echo "===================================="
echo
echo "Masukkan URL repository GitHub (contoh: https://github.com/namauser/namarepo.git)"
echo "Atau format SSH: git@github.com:namauser/namarepo.git"
echo

# Baca input dan hilangkan spasi di awal/akhir + karakter aneh
read -p "→ Repo URL: " REPO_URL

# Hapus spasi di awal dan akhir
REPO_URL=$(echo "$REPO_URL" | xargs)

# Validasi apakah input kosong
if [[ -z "$REPO_URL" ]]; then
    echo "Error: URL tidak boleh kosong!"
    exit 1
fi

# Cek apakah sudah ada .git (folder sudah jadi repo atau belum)
if [ -d ".git" ]; then
    echo "Warning: Folder ini sudah menjadi git repository."
    read -p "Lanjutkan dan force push? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
else
    git init
fi

# Pastikan ada file untuk di-commit
if git status --porcelain | grep -q "^.[^?]" || git status --porcelain | grep -q "^??"; then
    git add .
    git commit -m "Initial commit" || echo "Commit gagal, mungkin tidak ada perubahan baru"
else
    echo "Warning: Tidak ada file yang bisa di-commit (folder kosong)"
    echo "Tambahkan setidaknya satu file (misal README.md) lalu jalankan lagi."
    exit 1
fi

git branch -M main

# Hapus remote origin kalau sudah ada (biar tidak error)
git remote remove origin 2>/dev/null || true
git remote add origin "$REPO_URL"

echo
echo "Sedang push ke $REPO_URL ..."
git push -u origin main

if [ $? -eq 0 ]; then
    echo
    echo "Success: Berhasil di-push ke GitHub!"
    echo "Repo: $REPO_URL"
else
    echo
    echo "Error: Gagal push. Periksa:"
    echo "   • Apakah repository GitHub sudah dibuat (kosong boleh)?"
    echo "   • Apakah URL benar (HTTPS/SSH)?"
    echo "   • Apakah kamu sudah login SSH key atau personal access token?"
fi