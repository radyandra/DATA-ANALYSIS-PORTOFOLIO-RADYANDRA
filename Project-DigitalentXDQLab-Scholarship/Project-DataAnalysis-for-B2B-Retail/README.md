# 📊 Project Data Analysis for B2B Retail: Customer Analytics Report

## 📖 Latar Belakang
xyz.com adalah perusahan rintisan B2B yang menjual berbagai produk tidak langsung kepada end user tetapi ke bisnis/perusahaan lainnya. Sebagai data-driven company, maka setiap pengambilan keputusan di xyz.com selalu berdasarkan data. Setiap quarter xyz.com akan mengadakan townhall dimana seluruh atau perwakilan divisi akan berkumpul untuk me-review performance perusahaan selama quarter terakhir.

Contoh:
> Data transaksi penjualan diperoleh dari [sumber data] yang masih memerlukan proses pembersihan. Proyek ini dilakukan untuk memastikan kualitas data sebelum digunakan untuk analisis lebih lanjut.

## 🎯 Tugas
- Bagaimana pertumbuhan penjualan saat ini?
- Apakah jumlah customers xyz.com semakin bertambah ?
- Dan seberapa banyak customers tersebut yang sudah melakukan transaksi?
- Category produk apa saja yang paling banyak dibeli oleh customers?
- Seberapa banyak customers yang tetap aktif bertransaksi?

## 🛠 Langkah-langkah
1. Menggunakan klausa “Select … From …” untuk mengambil data di database
2. Menggunakan klausa Where dan Operator untuk menfilter data
3. Menggunakan “group by”dan fungsi aggregat untuk aggregasi penjualan dan revenue
4. Menggunakan “order by” untuk mengurutkan data
5. Menggunakan “union” untuk menggabungkan tabel data penjualan
6. Menggunakan “date and time function” dan fungsi text untuk data manipulation
7. Menggunakan subquery untuk menyimpan hasil sementara untuk digunakan kembali dalam query.

## Tabel yang digunakan
[!Tabel](tabel.png)
1. Tabel orders_1 : Berisi data terkait transaksi penjualan periode quarter 1 (Jan – Mar 2004)
2. Tabel Orders_2 : Berisi data terkait transaksi penjualan periode quarter 2 (Apr – Jun 2004)
3. Tabel Customer : Berisi data profil customer yang mendaftar menjadi customer xyz.com

## Memahami Tabel
- Mengecek tabel orders_1 :SELECT * FROM orders_1 limit 5;
  ```sql
  SELECT* FROM orders_1
  limit 5;
- Mengecek tabel orders_2 :SELECT * FROM orders_2 limit 5;
  ``sql
  SELECT* FROM orders_2
  limit 5;
- Mengecek tabel customer :SELECT * FROM customer limit 5;
  ```sql
  SELECT* FROM customer
  limit 5;

  [!MemahamiTabel](pahamtabel.png)
