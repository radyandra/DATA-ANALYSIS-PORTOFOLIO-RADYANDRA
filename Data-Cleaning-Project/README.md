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
- Membuat tabel baru yang sama untuk data cleaning
	  Contoh Query:
	```sql
	CREATE TABLE cafe_sales
	LIKE dirty_cafe_sales;
	
	INSERT cafe_sales
	SELECT* FROM dirty_cafe_sales;

- Mencari baris duplikat menggunakan ROW_NUMBER() sebagai window function dengan OVER (PARTITION BY ...) untuk mengelompokkan data berdasarkan semua kolom, lalu memberi nomor urut pada setiap baris di tiap kelompok; baris dengan row_num > 1 diidentifikasi sebagai duplikat. Hasil penomoran ini disimpan sementara dalam CTE (Common Table Expression) menggunakan WITH ... AS, kemudian difilter untuk menampilkan hanya baris duplikat tersebut.
	  Contoh Query:
	```sql
	SELECT*,
	ROW_NUMBER() OVER(
	PARTITION BY Transaction_ID, Item, Quantity, Price_Per_Unit, Total_Spent, Payment_Method, Location, Transaction_Date ) AS row_num
	FROM cafe_sales;
 
	 	WITH duplicate_cte AS
	(
		SELECT*,
		ROW_NUMBER() OVER(
		PARTITION BY Transaction_ID, Item, Quantity, Price_Per_Unit, Total_Spent, Payment_Method, Location, Transaction_Date ) AS row_num
		FROM cafe_sales
	)
	SELECT* FROM duplicate_cte
	WHERE row_num>1;
- Membuat tabel baru dengan menginput data yang sudah dikelompokkan dan diurutkan sebelumnya, kemudian pilih baris dengan row_num > 1
  Contoh Query:
	```sql
	CREATE TABLE `cafe_sales2` (
	  `Transaction_ID` text,
	  `Item` text,
	  `Quantity` int,
	  `Price_Per_Unit` double,
	  `Total_Spent` text,
	  `Payment_Method` text,
	  `Location` text,
	  `Transaction_Date` text,
	  `row_num` int
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

	SELECT* FROM cafe_sales2;
 	INSERT cafe_sales2
	SELECT*,
		ROW_NUMBER() OVER(
		PARTITION BY Transaction_ID, Item, Quantity, Price_Per_Unit, Total_Spent, Payment_Method, Location, Transaction_Date ) AS row_num
		FROM cafe_sales;
	
	SELECT* FROM cafe_sales2
	WHERE row_num>1;
- Menghapus baris duplikat
	  Contoh Query:
	```sql
	DELETE
	FROM cafe_sales2
	WHERE row_num>1;
- Standarisasi data dengan mengubah format kolom 'Transaction_Date' menjadi DATE
	  Contoh Query:
	```sql
	ALTER TABLE cafe_sales2
	MODIFY COLUMN Transaction_Date DATE;
- Mengisi kolom kosong yang bisa diisi dengan menggunakan informasi dari kolom lain
	  Contoh Query:
	```sql
	SELECT* FROM cafe_sales2
	WHERE Total_Spent='ERROR';
	
	UPDATE cafe_sales2
	SET Total_Spent=Price_per_unit*Quantity
	WHERE Total_Spent='ERROR';
	
	SELECT* FROM cafe_sales2
	WHERE Total_Spent='' OR Total_Spent='UNKNOWN';
	
	UPDATE cafe_sales2
	SET Total_Spent=Price_per_unit*Quantity
	WHERE Total_Spent='' OR Total_Spent='UNKNOWN';

- Menghapus nilai kosong
  Contoh Query:
```sql
DELETE 
FROM cafe_sales2
WHERE Item='' AND Payment_Method='' AND Location='' AND Transaction_Date='';

- Menghapus kolom yang tidak diperlukan
	Contoh Query:
	```sql
	ALTER TABLE cafe_sales2
	DROP COLUMN row_num;
