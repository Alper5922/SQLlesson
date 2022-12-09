CREATE TABLE musteri_urun 
(
urun_id int, 
musteri_isim varchar(50),
urun_isim varchar(50) 
);
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (20, 'Veli', 'Elma'); 
INSERT INTO musteri_urun VALUES (30, 'Ayse', 'Armut'); 
INSERT INTO musteri_urun VALUES (20, 'Ali', 'Elma'); 
INSERT INTO musteri_urun VALUES (10, 'Adem', 'Portakal'); 
INSERT INTO musteri_urun VALUES (40, 'Veli', 'Kaysi'); 
INSERT INTO musteri_urun VALUES (20, 'Elif', 'Elma');
select * from musteri_urun

-------DISTINCT -----------
select distinct (urun_isim) from musteri_urun;

--Tabloda kaç farklı meyve vardır
select count (distinct urun_isim) from musteri_urun

----------FETCH NEXT (SAYI) ROW ONLY / OFFSET / LIMIT---------------
--Tabloyu urun_id ye göre sıralayınız. ilk   3 kaydı listeleyiniz
select * from musteri_urun order by urun_id fetch next 3 row only

--OFFSET --> satır atlamak istediğimizde kullanırız


CREATE TABLE maas 
(
id int, 
musteri_isim varchar(50),
maas int 
);
INSERT INTO maas VALUES (10, 'Ali', 5000); 
INSERT INTO maas VALUES (10, 'Ali', 7500); 
INSERT INTO maas VALUES (20, 'Veli', 10000); 
INSERT INTO maas VALUES (30, 'Ayse', 9000); 
INSERT INTO maas VALUES (20, 'Ali', 6500); 
INSERT INTO maas VALUES (10, 'Adem', 8000); 
INSERT INTO maas VALUES (40, 'Veli', 8500); 
INSERT INTO maas VALUES (20, 'Elif', 5500);

--en yüksek maaş alan müşteriyi listele
select * from maas order by maas desc limit 1

--maaş tablosundan en yüksek ikinci maaşı listeleyiniz
select * from maas order by maas desc offset 1 limit 1
select * from maas order by maas desc offset 1 fetch next 1 row only

--Maaş tablosundan en düşük 4.maaşı alınız
select * from maas order by maas offset 3 limit 1


------DDL ALTER TABLE --------

CREATE TABLE personel  (
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

--ADD
alter table personel
add ulke_isim varchar(20) default 'turkiye'

alter table personel add deneme char(8)


select * from personel

-- DROP tablodan sutun silme
ALTER TABLE personel 
DROP COLUMN deneme;

-- RENAME COLUMN sutun adi degistirme
ALTER TABLE personel
RENAME COLUMN ulke_isim TO ulke_adi;

--RENAME tablonun ismini degistirme
ALTER TABLE personel 
RENAME TO isciler;

--TYPE/SET sutunlarin ozelliklerini degistirme

ALTER TABLE isciler
ALTER COLUMN ulke_adi TYPE varchar(30), 
ALTER COLUMN ulke_adi SET NOT NULL;

select * from isciler
--String data türünü int data türüne dönüştürmek
ALTER COLUMN maas
TYPE varchar(30) USING(maas::int)

-------TRANSACTION ---------
CREATE TABLE ogrenciler2
(
id serial,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real       
);
BEGIN;
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3);
savepoint x;
INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
savepoint y;
INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5);
ROLLBACK to x;
COMMIT;

select * from ogrenciler2
delete from ogrenciler2
