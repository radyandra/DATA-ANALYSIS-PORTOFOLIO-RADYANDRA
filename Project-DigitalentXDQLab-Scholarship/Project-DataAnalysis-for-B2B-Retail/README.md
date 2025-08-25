# 📊 Project Data Analysis for B2B Retail: Customer Analytics Report

## 📖 Latar Belakang
xyz.com adalah perusahan rintisan B2B yang menjual berbagai produk tidak langsung kepada end user tetapi ke bisnis/perusahaan lainnya. Sebagai data-driven company, maka setiap pengambilan keputusan di xyz.com selalu berdasarkan data. Setiap quarter xyz.com akan mengadakan townhall dimana seluruh atau perwakilan divisi akan berkumpul untuk me-review performance perusahaan selama quarter terakhir.

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
![Tabel](tabel.png)
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

![pahamtabel](pahamtabel.png)

## Mengetahui Total Penjualan dan Revenue pada Quarter-1 (Jan, Feb, Mar) dan Quarter-2 (Apr,Mei,Jun)
- Dari tabel orders_1 lakukan penjumlahan pada kolom quantity dengan fungsi aggregate sum() dan beri nama “total_penjualan”, kalikan kolom quantity dengan kolom priceEach kemudian jumlahkan hasil perkalian kedua kolom tersebut dan beri nama “revenue”
- Perusahaan hanya ingin menghitung penjualan dari produk yang terkirim saja, jadi kita perlu mem-filter kolom ‘status’ sehingga hanya menampilkan order dengan status “Shipped”.
- Lakukan Langkah 1 & 2, untuk tabel orders_2.
  ```sql
SELECT SUM(quantity) AS total_penjualan, SUM(quantity*priceeach) AS revenue FROM orders_1
WHERE status='Shipped';

SELECT SUM(quantity) AS total_penjualan, SUM(quantity*priceeach) AS revenue FROM orders_2
WHERE status='Shipped';

![Tabel](revenue_totalorder.png)

## Menghitung Persentasi Keseluruhan Penjualan
- Pilihlah kolom “orderNumber”, “status”, “quantity”, “priceEach” pada tabel orders_1, dan tambahkan kolom baru dengan nama “quarter” dan isi dengan value “1”. Lakukan yang sama dengan tabel orders_2, dan isi dengan value “2”, kemudian gabungkan kedua tabel tersebut.
- Gunakan statement dari Langkah 1 sebagai subquery dan beri alias “tabel_a”.
- Dari “tabel_a”, lakukan penjumlahan pada kolom “quantity” dengan fungsi aggregate sum() dan beri nama “total_penjualan”, dan kalikan kolom quantity dengan kolom priceEach kemudian jumlahkan hasil perkalian kedua kolom tersebut dan beri nama “revenue”
- Filter kolom ‘status’ sehingga hanya menampilkan order dengan status “Shipped”.
Kelompokkan total_penjualan berdasarkan kolom “quarter”, dan jangan lupa menambahkan kolom ini pada bagian select.
```sql
  SELECT 
      quarter,
      SUM(quantity) AS total_penjualan,
      SUM(quantity * priceEach) AS revenue
  FROM (
      SELECT orderNumber, status, quantity, priceEach, 1 AS quarter
      FROM orders_1
      UNION ALL
      SELECT orderNumber, status, quantity, priceEach, 2 AS quarter
      FROM orders_2
  ) AS tabel_a
  WHERE status = 'Shipped'
  GROUP BY quarter
  ORDER BY quarter;


## Perhitungan Growth Penjualan dan Revenue
%Growth Penjualan = (6717 – 8694)/8694 = -22%
%Growth Revenue = (607548320 – 799579310)/ 799579310 = -24%

## 


