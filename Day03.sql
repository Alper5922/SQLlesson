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
select * from ogrenciler3;
delete from ogrenciler3 where isim='Mustafa Bak' or isim='Nesibe Yilmaz';
-- Veli isimi Hasan olan datayı silelim
delete from ogrenciler3 where veli_isim='Hasan';
----TRUNCATE --
-- Verileri geri alınamayacak şekilde siler
truncate table ogrenciler3;

-- ON DELETE CASCADE
drop table if exists talebeler -- Eğer tablo varsa tabloyu siler
drop table if exists notlar

CREATE TABLE talebeler
(
id CHAR(3) primary key, 
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

CREATE TABLE notlar( 
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) 
REFERENCES talebeler(id)
--on delete cascade
);

INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO notlar VALUES ('123', 'kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);

select * from talebeler;
select * from  notlar;

-- Notlar tablosundan id=123 olan datayı silelim
delete from notlar where talebe_id='123';

-- Talebeler tablosundan id=126 olan datayı silelim
delete from talebeler where id='126';

/*
    Her defasında önce child tablodaki verileri silmek yerine ON DELETE CASCADE silme özelliği ile
parent tablo dan da veri silebiliriz. Yanlız ON DELETE CASCADE komutu kullanımında parent tablodan sildiğimiz
data child tablo dan da silinir
*/

-- and or

drop table if exists musteriler
CREATE TABLE musteriler  (
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (20, 'John', 'Apple');
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm');
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple');
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange');
INSERT INTO musteriler VALUES (40, 'John', 'Apricot');
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

select * from musteriler
-- Müşteriler tablosundan ürün ismi orange apple ve apricot olan dataları listeleyiniz
select * from musteriler where urun_isim='Orange' or urun_isim='Apple' or urun_isim='Apricot';

--IN CONDITION
select * from musteriler where urun_isim in('Orange','Apple','Apricot');

--NOT IN
select * from musteriler where urun_isim not in('Orange','Apple','Apricot');

--BETWEEN (İKİ DEĞERRE DE EŞİT yani >= <=)
--Müşteriler tablosundan ürün _ıd si 20 ile 40 arasıdna olan verileri toplayınız
SELECT * FROM musteriler WHERE urun_id>=20 AND urun_id<=40;

SELECT * FROM musteriler WHERE urun_id BETWEEN 20 AND 40 ;

--NOT BETWEEN
SELECT * FROM musteriler WHERE urun_id NOT BETWEEN 20 AND 40 ;

