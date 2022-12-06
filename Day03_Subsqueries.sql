-- 		SUBQUERIES
--SUBQUERY baska bir SORGU(query)’nun icinde calisan SORGU’dur
CREATE TABLE calisanlar2 (
id int,
isim VARCHAR(50),
sehir VARCHAR(50),
maas int,
isyeri VARCHAR(20)
);
CREATE TABLE markalar (
marka_id int,
marka_isim VARCHAR(20),
calisan_sayisi int
);
INSERT INTO calisanlar2 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar2 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar2 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar2 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');
INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);


-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve bu markada calisanlarin isimlerini ve 
--maaşlarini listeleyin.
SELECT isim, maas, isyeri from calisanlar2
where isyeri in (select marka_isim from markalar where calisan_sayisi>15000);

-- marka_id’si 101’den büyük olan marka çalişanlarinin isim, maaş ve şehirlerini listeleyiniz.
SELECT isim, maas, sehir from calisanlar2
where isyeri in (select marka_isim from markalar where marka_id > 101 );
-- Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz




--AGGREGATE METHOD
--çalışanlar tablosundan en yüksek maaaşı listele
select max(maas) as maksimum_maas from calisanlar;
/*
	Eğer bir sütuna geçici olarak bir isim vermek istersek AS komutunu yazdıktan sonra vermek
istediğimiz ismi yazarız
*/

--çalışanlar tablosundan en düşük maaaşı listele
select min(maas) as min_maas from calisanlar;

--çalışanlar tablosundaki maaşların toplamı
select sum(maas) from calisanlar2;

--çalışanlar tablosundaki maaşların ortalaması
select avg(maas) from calisanlar2;--2714.2857142857142857
select round(avg(maas)) from calisanlar2; --2714
select round(avg(maas),2) from calisanlar2;--2714.29

----çalışanlar tablosundaki maaşların sayısı
select count(maas) from calisanlar2;--7 (değeri null olan maasları saymaz)
select count(*) from calisanlar2; -- yine 7 verir. * row sayısını verir

--AGGREGATE METHODLARDA SUBQUERY
-- Her markanin id’sini, ismini ve toplam kaç şehirde
-- bulunduğunu listeleyen bir SORGU yaziniz
SELECT marka_id,marka_isim,
(SELECT count(sehir) as sehir_sayisi FROM calisanlar2 WHERE marka_isim=isyeri)
FROM markalar;
--  Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin
--  toplam maaşini listeleyiniz
CREATE view summaas
as
SELECT marka_isim,calisan_sayisi,
(SELECT sum(maas) FROM calisanlar2 WHERE isyeri=marka_isim) as toplam_maas
FROM markalar
select * from summaas
-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin
-- maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.
SELECT marka_isim,calisan_sayisi,
(SELECT max(maas) FROM calisanlar2 WHERE isyeri=marka_isim) as enyuksekmaas,
(SELECT min(maas) FROM calisanlar2 WHERE isyeri=marka_isim) as endusukmaas
From markalar
-- VIEW Kullanımı
/* Yaptığımız sorguları hafızaya alır ve tekrar bizden istenen sorgulama yerine view'e 
atadığımız ismi SELECT komutuyla çağırırız
*/
CREATE VIEW maxminmaas
AS
SELECT marka_isim,calisan_sayisi,
(SELECT max(maas) FROM calisanlar2 WHERE isyeri=marka_isim) as enyuksekmaas,
(SELECT min(maas) FROM calisanlar2 WHERE isyeri=marka_isim) as endusukmaas
From markalar;
SELECT * FROM maxminmaas;
------------------------------------------------------
--EXISTS CONDITION



CREATE TABLE mart
(
urun_id int,
musteri_isim varchar(50), 
urun_isim varchar(50)
);

INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan 
(
urun_id int ,
musteri_isim varchar(50), 
urun_isim varchar(50)
);

INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

select * from mart
select * from nisan

--MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin
--URUN_ID’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
--MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız
SELECT urun_id,musteri_isim FROM mart
WHERE exists (select urun_id FROM nisan WHERE mart.urun_id=nisan.urun_id)

--Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.
SELECT urun_isim,musteri_isim FROM nisan
WHERE exists (SELECT urun_isim FROM mart where mart.urun_isim=nisan.urun_isim);

--Her iki ayda ortak satilmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.

select urun_isim, musteri_isim from nisan where not exists (select urun_isim from mart where mart.urun_isim=nisan.urun_isim)





--Tablodaki Data Nasil Update Edilir (UPDATE SET)?

CREATE TABLE tedarikciler -- parent
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);

INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammen');
INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');

CREATE TABLE urunler1 -- child
(
ted_vergino int, 
urun_id int, 
urun_isim VARCHAR(50), 
musteri_isim VARCHAR(50),
CONSTRAINT fk_urunler FOREIGN KEY(ted_vergino) 
REFERENCES tedarikciler(vergi_no)
on delete cascade
);

INSERT INTO urunler1 VALUES(101, 1001,'Laptop', 'Ayşe Can');
INSERT INTO urunler1 VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler1 VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO urunler1 VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler1 VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler1 VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler1 VALUES(104, 1007,'Phone', 'Aslan Yılmaz');

-- vergi_no’su 102 olan tedarikcinin firma ismini 'Vestel' olarak güncelleyeniz.
update tedarikciler
set firma_ismi='Vestel' where vergi_no=102;

-- vergi_no’su 101 olan tedarikçinin firma ismini 'casper' ve irtibat_ismi’ni 'Ali Veli' olarak güncelleyiniz.
update tedarikciler 
set firma_ismi='casper', irtibat_ismi='Ali Veli' where vergi_no=101;


-- urunler1 tablosundaki 'Phone' değerlerini 'Telefon' olarak güncelleyiniz.
update urunler1
set urun_isim='Telefon' where urun_isim='Phone';

-- urunler1 tablosundaki urun_id değeri 1004'ten büyük olanların urun_id’sini 1 arttırın.
update urunler1
set urun_id =urun_id+1 where urun_id>1004;

-- urunler1 tablosundaki tüm ürünlerin urun_id değerini ted_vergino sutun değerleri ile toplayarak güncelleyiniz.
update urunler1
set urun_id=urun_id+ted_vergino;

-- Tabloları eski haline getiriyoruz
delete from tedarikciler;
delete from urunler1;

/* urunler tablosundan Ali Bak’in aldigi urunun ismini, tedarikci tablosunda irtibat_ismi 
'Adam Eve' olan firmanın ismi (firma_ismi) ile degistiriniz*/
UPDATE urunler1                      
SET urun_isim = (SELECT firma_ismi FROM tedarikciler WHERE irtibat_ismi = 'Adam Eve')                       
WHERE musteri_isim='Ali Bak';

select * from urunler1 

/*Urunler tablosunda laptop satin alan musterilerin ismini, firma_ismi Apple’in 
irtibat_isim'i ile degistirin.*/

update urunler1
set musteri_isim = (select irtibat_ismi from tedarikciler where firma_ismi='Apple' )  where urun_isim='Laptop';


select * from tedarikciler;
select * from urunler1;

