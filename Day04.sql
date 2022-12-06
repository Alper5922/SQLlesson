drop table if exists calisanlar;
CREATE TABLE calisanlar 
(
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50) );

INSERT INTO calisanlar VALUES(123456789, 'Ali Can', 'Istanbul');  
INSERT INTO calisanlar VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO calisanlar VALUES(345678901, 'Mine Bulut', 'Izmir');

select * from calisanlar
-- Eğer iki sütunun verilerini birleştirmek istersek concat sembolü || kullanırız
select calisan_id as id, calisan_isim || calisan_dogdugu_sehir as calisan_bilgisi from calisanlar;
--arada boşluk istersek
select calisan_id as id, calisan_isim ||'   '|| calisan_dogdugu_sehir as calisan_bilgisi from calisanlar;

-- 2.YOL
select calisan_id as id, concat (calisan_isim , calisan_dogdugu_sehir) as calisan_bilgisi from calisanlar;
----------------------------------------------------
-----IS NULL CONDITION
CREATE TABLE insanlar
(
ssn char(9),
name varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');  
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');  
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa'); 
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');

--name sütununda değeri null olanları listeleyim
select name from insanlar where name=null

--Insanlar tablosunda sadece null olmayan değerleri listeleyiniz
select name from insanlar where name is not null

--Insanlar tablosunda null değer almış verileri no name olarak değiştiriniz
update insanlar
set name='no_name' where name is null;

--------------------------------
--ORDER BY
/*
Tablolardaki verileri sıralamak için ORDER BY komutu kullanırız
Büyükten küçüğe yada küçükten büyüğe sıralama yapabiliriz
Default olarak küçükten büyüğe sıralama yapar
Eğer BÜYÜKTEN KÜÇÜĞE sıralmak istersek ORDER BY komutundan sonra DESC komutunu kullanırız

NOT : Order By komutundan sonra field ismi yerine field numarasi da kullanilabilir
*/
CREATE TABLE insanlar1
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar1 VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar1 VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO insanlar1 VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO insanlar1 VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO insanlar1 VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

select * from insanlar1

--İnsanlar1 tablosundaki dataları adrese göre sıralayınız
select * from insanlar1 order by adres
select * from insanlar1 order by soyisim

--İnsanlar1 tablosunda ismi 'Mine' olanları  SSN göre sıralayınız
select * from insanlar1 where isim='Mine' order by ssn

--Insanlar1 tablosundaki soyismi Bulut olanlari isim sirali olarak listeleyin
select * from insanlar1 where soyisim='Bulut' order by 2 

--Insanlar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin
select * from insanlar1 order by ssn desc;

-- Insanlar tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyin
select * from insanlar1 order by isim asc, soyisim desc;


---- ORDER BY LENGTH

-- İsim ve soyisim değerlerini soyisim kelime uzunluklarına göre sıralayınız
select * from insanlar1 order by length(soyisim); 
select * from insanlar1 order by length(soyisim) desc; 
/*
Eger sutun uzunluguna gore siralamak istersek length komutu kullaniriz
Ve yine uzunlugu buyukten kucuge siralamak istersek sonuna DESC komutunu ekleriz.
 */
 
 ---- Tüm isim ve soyisim değerlerini aynı sutunda çağırarak her bir sütun değerini uzunluğuna göre sıralayınız
SELECT  isim||' '||soyisim as isim_soyisim from insanlar1 order by length(isim)+length(soyisim);
SELECT  isim||' '||soyisim as isim_soyisim from insanlar1 order by length(isim||soyisim)

---------------------------------------------
--GROUP BY
-GROUP BY CLAUSE
/*
Group By komutu sonuçları bir veya daha fazla sütuna göre gruplamak için SELECT
komutuyla birlikte kullanılır.
*/
CREATE TABLE manav
(
isim varchar(50),
Urun_adi varchar(50),
Urun_miktar int
);
INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);
select * from manav

-- Isme gore alinan toplam urunleri bulun
select isim, sum(urun_miktar) from manav group by(isim) 

--Isme gore alinan toplam urunleri bulun ve urunleri büyükten küçüğe listeleyiniz
SELECT isim,sum(urun_miktar) AS aldığı_toplam_urun FROM manav
GROUP BY isim
ORDER BY aldığı_toplam_urun DESC;

-- Urun ismine gore urunu alan toplam kisi sayisi
select Urun_adi, count(isim) from manav group by(Urun_adi) 

-- Alinan kilo miktarina gore musteri sayisi
select Urun_miktar, count(isim) from manav group by urun_miktar;