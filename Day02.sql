-- DDL - DATA DEFINITION LANG.
-- CREATE - TABLO OLUŞTURMA
CREATE TABLE ogrencilerr7
(
ogrenci_no char(7) unique,
isim varchar(20) not null,
soyisim varchar(25),
not_ort real,-- Ondalıklı sayılar için kullanılır(Double gibi)
kayit_tarih date    
);
INSERT INTO ogrencilerr7 VALUES ('1234567','Erol','Evren',75.5,now());
INSERT INTO ogrencilerr7 VALUES ('1234568','Erol','Evren',75.5,now());
INSERT INTO ogrencilerr7 (ogrenci_no,isim, soyisim, not_ort) VALUES ( '1234569','evren','evren',56);
select * from ogrencilerr7

CREATE TABLE ogrenciler8
(
ogrenci_no char(7) primary  key,
isim varchar(20) not null,
soyisim varchar(25),
not_ort real,-- Ondalıklı sayılar için kullanılır(Double gibi)
kayit_tarih date    
);
--FOREIGN KEY
create table tedarikciler3
(

tedarikci_id char(5) primary key,
tedarikci_ismi varchar(20),
iletisim_isim varchar(20)

);

CREATE table urunler
(
tedarikci_id char(5),
urun_id char(5),
foreign key (tedarikci_id) references tedarikciler3(tedarikci_id)	
);
select * from urunler;
select * from tedarikciler3;
-- ------------------------------------------------------------
/*
calisanlar” isimli bir Tablo olusturun. Icinde “id”, “isim”, “maas”, “ise_baslama”
field’lari olsun. “id” yi Primary Key yapin, “isim” i Unique, “maas” i Not Null yapın.
“adresler” isminde baska bir tablo olusturun.Icinde “adres_id”, “sokak”, “cadde” ve
“sehir” fieldlari olsun.  “adres_id” field‘i ile Foreign Key oluşturun.
*/
create table calisanlar
(
    id char(5) primary key,
	isim varchar(20) unique,
	maas int not null,
	ise_baslama date
);

create table adresler
(
adres_id char(5),
	sokak varchar(20),
	cadde varchar(20),
	sehir varchar(15),
	foreign key (adres_id) references calisanlar(id)
);
INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14'); -- UNIQUE CONS. Kabul etmez
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); -- NOT NULL CONS. Kabul etmez
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); -- UNIQUE CONS. Kabul etmez
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); -- PRIMARY KEY
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); -- PRIMARY KEY
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); -- PRIMARY KEY
INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');
-- Parent tabloda olmayan id ile child a ekleme yapamayiz
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');
-- FK'ye null değeri atanabilir.
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Maraş');

select * from calisanlar;

select * from adresler;

----------------------------------------------

-- CHECK CONSTRAINT
create table calisanlar1
(
    id char(5) primary key,
	isim varchar(20) unique,
	maas int check (maas>10000),
	ise_baslama date
);

INSERT INTO calisanlar1 VALUES('10002', 'Mehmet Yılmaz' ,19000, '2018-04-14');
INSERT INTO calisanlar1 VALUES('10992', 'Mehmdet Yılmaz' ,19000, '2018-04-14');
INSERT INTO calisanlar1 VALUES('10992', 'Mehmet Yılmjaz' ,3000, '2018-04-14');
SELECT * FROM calisanlar1;

--DQL -- WHERE KULANIMI

select * from calisanlar;
select isim from calisanlar;

--calisanlar tablodundan maaşı 500 den büyük olanların isimlerini lsteleyiniz
select isim from calisanlar where maas>5000;
select isim,maas from calisanlar where maas>5000;

--calisanlar tablosundan ismi Veli Han olan veriyi isteyiniz
select * from calisanlar where isim='Veli Han';

--calisanlar tablosundan maaşı 500  olan tüm  veriyi isteyiniz
select * from calisanlar where maas=5000;


--DML  --DELETE KOMUTU
delete from calisanlar; -- Eğer parent table başka bir child tablo ile ilişkili ise önce child silinmeli
delete from adresler;
select * from adresler;

-- Adresler tablosundan şehri Antep olan verileri silelim
delete from adresler where sehir='Antep';

------------
CREATE TABLE ogrenciler3
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
INSERT INTO ogrenciler3 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler3 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler3 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler3 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler3 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler3 VALUES(127, 'Mustafa Bak', 'Ali', 99);
/*
-- ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.

*/
