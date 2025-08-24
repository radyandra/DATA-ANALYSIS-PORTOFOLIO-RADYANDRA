# 🧹 Data Cleaning Project (MySQL & Excel)

## 📌 Project Overview
Project ini bertujuan untuk membersihkan dataset mentah agar siap digunakan untuk analisis.  
Proses cleaning dilakukan menggunakan **MySQL** atau **Microsoft Excel**.

Dataset yang digunakan:
1. Dirty Cafe Sales Dataset
- Sumber: [https://www.kaggle.com/datasets/ahmedmohamed2003/cafe-sales-dirty-data-for-cleaning-training]
- Ukuran data: [10.000 baris & 8 kolom] 
- Format: [CSV]

## 🎯 Objectives
1. Menghapus data duplikat
2. Menangani missing values
3. Standarisasi format kolom (tanggal, angka, teks)
4. Menghapus data yang tidak relevan
5. Mengoreksi inkonsistensi data

---

## 🛠 Tools & Technologies
- **MySQL** → Query cleaning, filtering, dan normalisasi data

---

## 📂 Data Cleaning Steps

### 1️⃣ MySQL
File SQL: [`Data-Cleaning-Project/CLEANING-DATA-CAFE-SALES-RADYANDRA.sql`](Data-Cleaning-Project/CLEANING-DATA-CAFE-SALES-RADYANDRA.sql)  
Langkah:
- Menghapus baris duplikat
- Mengubah format tanggal
- Menghapus nilai kosong
- Normalisasi nama brand/kategori

Contoh Query:
```sql
-- Menghapus duplikat
DELETE t1
FROM dataset t1
JOIN dataset t2 
ON t1.id > t2.id AND t1.column_name = t2.column_name;

