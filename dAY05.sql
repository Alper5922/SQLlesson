CREATE TABLE personel
(
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456789012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');
delete from personel
select * from personel


--Isme göre toplam maaşları bulun
select isim, sum(maas) from personel group by isim;

--sehre göre toplam personel sayısını bulunuz
select sehir, count(isim) from personel group by (sehir);

------------ HAVİNG----------------
--Her sirketin MIN maaslarini eger 4000’den buyukse goster
select sirket, min(maas) from personel group by sirket having min(maas) >4000;

--2)Ayni isimdeki kisilerin aldigi toplam gelir 10000 liradan fazla ise ismi 
--ve toplam maasi gosteren sorgu yaziniz
select isim, sum(maas) from personel group by isim having sum(maas)>10000;

--3) Eger bir sehirde calisan personel sayisi 1’den coksa sehir ismini ve personel sayisini veren sorgu yaziniz
select sehir, count(isim) from personel group by sehir having count(isim)>1;

--4) Eger bir sehirde alinan MAX maas 5000’den dusukse sehir ismini ve MAX maasi veren sorgu yaziniz
select sehir, max(maas) from personel group by sehir having max(maas)<5000;

---------- UNION -----------

--Iki farkli sorgulamanin sonucunu birlestiren islemdir. Secilen Field SAYISI ve DATA TYPE’i ayni olmalidir.

--1) Maasi 4000’den cok olan isci isimlerini ve 5000 liradan fazla maas alinan
     --sehirleri gosteren sorguyu yaziniz
select isim from personel where maas >4000 union 
select sehir  from personel where maas >5000;

--2) Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki personelin maaslarini
      --bir tabloda gosteren sorgu yaziniz
select maas,isim from personel where isim='Mehmet Ozturk' union 	
select maas,sehir from personel where sehir='Istanbul';

-------UNION OPERATOR 2 TABLODAN DATA BİRLERŞTİME------
CREATE TABLE personel1
(
id int,
isim varchar(50), 
sehir varchar(50), 
maas int, 
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
);
INSERT INTO personel1 VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel1 VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel1 VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel1 VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel1 VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel1 VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel1 VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

CREATE TABLE personel_bilgi  (
id int,
tel char(10) UNIQUE ,  
cocuk_sayisi int,
CONSTRAINT personel_bilgi_fk FOREIGN KEY (id) REFERENCES personel1(id)
);

INSERT INTO personel_bilgi VALUES(123456789, '5302345678', 5);  
INSERT INTO personel_bilgi VALUES(234567890, '5422345678', 4);
INSERT INTO personel_bilgi VALUES(345678901, '5354561245', 3);
INSERT INTO personel_bilgi VALUES(456789012, '5411452659', 3);
INSERT INTO personel_bilgi VALUES(567890123, '5551253698', 2);
INSERT INTO personel_bilgi VALUES(456789012, '5524578574', 2);
INSERT INTO personel_bilgi VALUES(123456710, '5537488585', 1);
select * from personel

--id’si 12345678 olan personelin Personel tablosundan sehir ve maasini, personel_bilgi 
--tablosundan da tel ve cocuk sayisini yazdirin
SELECT sehir AS Sehir_tel ,maas AS cocuk_sayisi_veya_maas FROM personel  WHERE id='123456789'
UNION
SELECT tel,cocuk_sayisi FROM personel_bilgi WHERE id= '123456789';

-----------unıon all -------------
--Personel tablosundada maasi 5000’den az olan tum isimleri ve maaslari bulunuz
SELECT isim,maas FROM personel WHERE maas<5000
union all
SELECT isim,maas FROM personel WHERE maas<5000

--------INTERSECT -------
--1) Personel tablosundan Istanbul veya Ankara’da calisanlarin id’lerini yazdir
  -- Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin
  --Iki sorguyu INTERSECT ile birlestirin
  SELECT id from personel where sehir in('Istanbul','Ankara')
  INTERSECT
  select id from personel_bilgi where cocuk_sayisi in (2,3)

