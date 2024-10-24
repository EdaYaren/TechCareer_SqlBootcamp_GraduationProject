
/* BOOKSHELF */

/* Veri kümesi ve Tablolarının oluşturulması: */

CREATE DATABASE BOOKSHELF

USE BOOKSHELF

CREATE TABLE Users(
  UserID INT PRIMARY KEY IDENTITY(1,1),
  UserName NVARCHAR(50),
  Email NVARCHAR(100),
  Age INT,
  AnnualReadingTarget INT,
  FavoriteBookType NVARCHAR(50),
  RegistrationDate DATE
)

CREATE TABLE Books (
  BookID INT PRIMARY KEY IDENTITY(1,1),
  BookName NVARCHAR(100),
  AuthorName NVARCHAR(100),
  BookType NVARCHAR(50),
  YearOfPublication INT,
  NumberOfPages INT,
  WritingLanguage NVARCHAR(20)
)

CREATE TABLE ReadingSessions(
  SessionID INT PRIMARY KEY IDENTITY(1,1),
  UserID INT FOREIGN KEY (UserID) REFERENCES Users(UserID),
  BookID INT FOREIGN KEY (BookID) REFERENCES Books(BookID),
  -- Bir kitabın okunmaya başlama ve bitiş tarihleri
  SessionStartDate DATE,
  SessionEndDate DATE,
  NumberOfPagesRead INT,
  -- Kitabın bitimine kadar her oturumda okunan süre (dk)
  SessionDuration TIME
)

CREATE TABLE WishList(
  WishID INT PRIMARY KEY IDENTITY(1,1),
  UserID INT FOREIGN KEY (UserID) REFERENCES Users(UserID),
  BookID INT FOREIGN KEY (BookID) REFERENCES Books(BookID),
  WishAddedDate DATE
)

/* Tablolar için rasgele verilerin üretilmesi: */

/* Kullanıcılar tablosu için; */
DECLARE @I INT=1;
DECLARE @USERNAME NVARCHAR(50);
DECLARE @EMAIL NVARCHAR(100);
DECLARE @AGE INT;
DECLARE @ANNUALREADINGTARGET INT;
DECLARE @FAVORİTEBOOKTYPE NVARCHAR(50);
DECLARE @REGISTRATIONDATE DATE;

DECLARE @NAME TABLE (FirstNames NVARCHAR(50));
INSERT INTO @NAME VALUES
('Ali'), ('Ayşe'), ('Fatma'), ('Mehmet'), ('Can'), ('Zeynep'), 
('Deniz'), ('Emre'), ('Elif'), ('Murat'), ('Gizem'), ('Berk'), 
('Seda'), ('Selin'), ('Barış'), ('Sinem'), ('Okan'), ('Ece'), 
('Hakan'), ('Burcu'), ('Levent'), ('Aslı'), ('Cem'), ('Naz'), 
('Özgür'), ('Tamer'), ('Betül'), ('Erkan'), ('Şevval'), ('Hüseyin'), 
('Merve'), ('Serhat'), ('Ferhat'), ('Sevil'), ('Tolga'), ('Cansu'), 
('Derya'), ('Berna'), ('Onur'), ('Furkan'), ('Gülşah'), ('Taner'),
('Bora'), ('İpek'), ('Arda'), ('Nil'), ('Selim'), ('Neslihan'), 
('Eren'), ('Burak'), ('Esra'), ('Ozan'), ('Damla'), ('Sibel'), 
('Büşra'), ('Nihat'), ('Çağla'), ('Ceyda'), ('Yasin'), ('Alper'), 
('Meltem'), ('Tuna'), ('İsmail'), ('Pelin'), ('Tuğba'), ('Mustafa'), 
('Süleyman'), ('Selda'), ('Fikret'), ('Aylin'), ('Rıza'), ('Demet');

DECLARE @SURNAME TABLE (Surnames NVARCHAR(50));
INSERT INTO @SURNAME VALUES
('Yılmaz'), ('Kaya'), ('Demir'), ('Çelik'), ('Şahin'), ('Koç'), 
('Aydın'), ('Öztürk'), ('Yalçın'), ('Kara'), ('Yavuz'), ('Güney'), 
('Kılıç'), ('Taş'), ('Aksoy'), ('Erdem'), ('Çetin'), ('Uzun'), 
('Polat'), ('Özdemir'), ('Arslan'), ('Turan'), ('Toprak'), ('Aksu'), 
('Vural'), ('Gül'), ('Erdoğan'), ('Tekin'), ('Altın'), ('Pektaş'), 
('Dinçer'), ('Bozkurt'), ('Kocaman'), ('Soylu'), ('Eren'), ('Kurt'), 
('İnce'), ('Sezer'), ('Özkan'), ('Duman'), ('Karaca'),
('Balcı'), ('Bayrak'), ('Başar'), ('Gökçe'), ('Akbaş'), 
('Türkmen'), ('Şimşek'), ('Tanrıverdi'), ('Yıldırım'), 
('Karadağ'), ('Efeoğlu'), ('Ergin'), ('Kocatepe'), ('Demiroğlu'), 
('Yurtsever'), ('Karahan'), ('Orhan'), ('Güneş'), ('Özbay'), 
('Çakır'), ('Keskin'), ('Altıparmak'), ('Ersoy'), ('Uysal'), 
('Soysal'), ('Güzel'), ('Çakmak'), ('Tanış'), ('Çolak'), 
('Baysal'), ('İpek'), ('Poyraz'), ('Tunca'), ('Akdemir'), 
('Tosun'), ('Turgut'), ('Erden'), ('Bayraktar'), ('Telli'), 
('Güngör'), ('Durmuş'), ('Kurtuluş');

DECLARE @BOOKTYPES TABLE (FavoriteBookType NVARCHAR(50));
INSERT INTO @BOOKTYPES VALUES
('Roman'), ('Bilim Kurgu'), ('Fantastik'), ('Korku'), ('Gizem'), 
('Tarih'), ('Biyografi'), ('Kişisel Gelişim'), ('Şiir'), 
('Deneme'), ('Çocuk Kitapları'), ('Din'), 
('Ders Kitapları'), ('Aksiyon'), ('Macera'), 
('Aşk'), ('Edebiyat'), ('Psikoloji'), ('Sosyal Bilimler'), 
('Felsefe'), ('Anı'), ('Hikaye'), ('Biyografi'), ('Gezi');

DECLARE @STARTDATE DATE='2010-01-01'
DECLARE @ENDDATE DATE='2024-10-01'
DECLARE @TOTALDATE INT=DATEDIFF(DAY, @STARTDATE, @ENDDATE)

DECLARE @RANDOMNAME NVARCHAR(50);
DECLARE @RANDOMSURNAME NVARCHAR(50);

WHILE @I <= 100000
BEGIN
-- Rastgele oluşturulan isim ve soyisimler ile kullanıcı adı ve e mail adresleri oluşturulur.
  SELECT TOP 1 @RANDOMNAME=FirstNames FROM @NAME ORDER BY NEWID();
  SELECT TOP 1 @RANDOMSURNAME=Surnames FROM @SURNAME ORDER BY NEWID();

  SET @USERNAME = UPPER(LEFT(@RANDOMNAME, 1)) + LOWER(SUBSTRING(@RANDOMNAME, 2, LEN(@RANDOMNAME))) 
              + ' ' + 
              UPPER(LEFT(@RANDOMSURNAME, 1)) + LOWER(SUBSTRING(@RANDOMSURNAME, 2, LEN(@RANDOMSURNAME)));

  SET @EMAIL=LOWER(@RANDOMNAME)+'_'+LOWER(@RANDOMSURNAME)+
               CASE 
                 WHEN RAND() < 0.33 THEN '@hotmail.com' 
                 WHEN RAND() < 0.66 THEN '@gmail.com' 
                 ELSE '@outlook.com' 
               END;;

-- 10-70 aralığında kullanıcılara restgele bir yaş ataması gerçekleştirilir.
  SET @AGE=ROUND(RAND()*(70-10)+10, 0);

-- 0-100 aralığında kullanıcılara rastgele yıllık kitap okuma hedefi atanır.(okunacak kitap sayısı)
  SET @ANNUALREADINGTARGET=ROUND(RAND()*100, 0) + 1;

  SELECT TOP 1 @FAVORİTEBOOKTYPE=FavoriteBookType from @BOOKTYPES ORDER BY NEWID();

  SET @REGISTRATIONDATE=DATEADD(DAY, ROUND(RAND()*@TOTALDATE, 0), @STARTDATE)

  INSERT INTO Users(UserName, Email, Age, AnnualReadingTarget, FavoriteBookType, RegistrationDate)
  VALUES(@USERNAME, @EMAIL, @AGE, @ANNUALREADINGTARGET, @FAVORİTEBOOKTYPE, @REGISTRATIONDATE)

  SET @I=@I+1;
END

SELECT COUNT(*) FROM Users

SELECT * FROM Users

/* Kitaplar tablosu için; */
DECLARE @J INT = 1;
DECLARE @BOOKNAME NVARCHAR(100);
DECLARE @AUTHORNAME NVARCHAR(100);
DECLARE @BOOKTYPE NVARCHAR(50);
DECLARE @YEAROFPUBLICATION INT;
DECLARE @NUMBEROFPAGES INT;
DECLARE @WRITINGLANGUAGE NVARCHAR(20);

DECLARE @BOOKS TABLE (BookName NVARCHAR(100));
INSERT INTO @BOOKS VALUES
('Harry Potter ve Sırlar Odası'), ('Yüzüklerin Efendisi: Yüzük Kardeşliği'), 
('Taht Oyunları'), ('Da Vinci Şifresi'), ('Alacakaranlık'), 
('Ateş ve Kan'), ('Rüzgar Gibi Geçti'), ('Baba'), 
('Bir Cinayetin Anatomisi'), ('Sherlock Holmes: Kızıl Dosya'), 
('Peter Pan'), ('Alice Harikalar Diyarında'), ('Narnia Günlükleri'), 
('Mürebbiye'), ('Açlık Oyunları'), ('Yalnızız'), 
('Serenad'), ('İçimizdeki Şeytan'), ('Çalıkuşu'), 
('Olasılıksız'), ('Kinyas ve Kayra'), ('Kürk Mantolu Madonna'), 
('Puslu Kıtalar Atlası'), ('Tutunamayanlar'), ('Bir Gün Tek Başına'), 
('Aşk-ı Memnu'), ('Yabancı'), ('Sokratesin Savunması'), 
('Fareler ve İnsanlar'), ('Simyacı'), ('Beyaz Kale'), 
('Masumiyet Müzesi'), ('Sıfır Noktasındaki Kadın'), ('Senden Önce Ben'), 
('Kayıp Kız'), ('Koku'), ('Dune'), 
('Metro 2033'), ('Gece Yarısı Kütüphanesi'), ('İnce Memed'), 
('Serenad'), ('Şeker Portakalı'), ('Yüzyıllık Yalnızlık'), 
('Hayvan Çiftliği'), ('1984'), ('Savaş ve Barış'), 
('Uğultulu Tepeler'), ('İki Şehrin Hikayesi'), ('Don Kişot'), 
('Suç ve Ceza'), ('Anna Karenina'), ('Monte Cristo Kontu'), 
('Frankenstein'), ('Drakula'), ('Oliver Twist'), ('Büyük Umutlar'), 
('Gurur ve Önyargı'), ('Kırmızı ve Siyah'), ('Moby Dick'), 
('Denizler Altında Yirmi Bin Fersah'), ('Robinson Crusoe'), 
('Hobbit'), ('Bülbülü Öldürmek'), 
('Yeraltından Notlar'), ('Küçük Prens'), ('Harry Potter ve Felsefe Taşı'), 
('Uçurtma Avcısı'), ('Mülksüzler'), ('Madame Bovary'), 
('Dönüşüm'), ('Körlük'), ('Karamazov Kardeşler'), 
('Bir Ömür Nasıl Yaşanır'), ('Sapiens: İnsan Türünün Kısa Tarihi'), 
('Vadideki Zambak'), ('Beyaz Zambaklar Ülkesinde'), 
('Cesur Yeni Dünya'), ('Sefiller'), ('Fahrenheit 451');

DECLARE @AUTHORS TABLE (AuthorName NVARCHAR(100));
INSERT INTO @AUTHORS VALUES
('Lev Tolstoy'), ('George Orwell'), ('Harper Lee'), ('Fyodor Dostoyevsky'), 
('Gabriel Garcia Marquez'), ('J.K. Rowling'), ('Ursula K. Le Guin'), 
('J.R.R. Tolkien'), ('Victor Hugo'), ('Franz Kafka'), 
('Jane Austen'), ('Charles Dickens'), ('Albert Camus'), 
('Mark Twain'), ('John Steinbeck'), ('Ernest Hemingway'), 
('Franz Kafka'), ('Paulo Coelho'), ('Antoine de Saint-Exupéry'), 
('James Joyce'), ('Aldous Huxley'), ('Stephen King'), 
('Miguel de Cervantes'), ('Jules Verne'), ('Herman Melville'), 
('Fyodor Dostoyevsky'), ('H.G. Wells'), ('Orhan Pamuk'), 
('Sabahattin Ali'), ('Elif Şafak'), ('Ahmet Hamdi Tanpınar'), 
('Yaşar Kemal'), ('Zülfü Livaneli'), ('Halide Edib Adıvar'), 
('Franz Kafka'), ('Dan Brown'), ('Khaled Hosseini'), 
('Jose Saramago'), ('Simone de Beauvoir'), ('Virginia Woolf'), 
('Haruki Murakami'), ('Isaac Asimov'), ('Arthur Conan Doyle'), 
('Dostoyevsky'), ('William Shakespeare'), ('Hermann Hesse'), 
('Umberto Eco'), ('Patrick Süskind'), ('Sylvia Plath'), 
('Albert Einstein'), ('Stephen Hawking'), ('Richard Dawkins'), 
('Yuval Noah Harari'), ('Michel Foucault'), ('Jean-Paul Sartre');

DECLARE @BOOKTYPES2 TABLE (BookType NVARCHAR(50));
INSERT INTO @BOOKTYPES2 VALUES
('Roman'), ('Bilim Kurgu'), ('Fantastik'), ('Korku'), ('Gizem'), 
('Tarih'), ('Biyografi'), ('Kişisel Gelişim'), ('Şiir'), 
('Deneme'), ('Çocuk Kitapları'), ('Din'), 
('Ders Kitapları'), ('Aksiyon'), ('Macera'), 
('Aşk'), ('Edebiyat'), ('Psikoloji'), ('Sosyal Bilimler'), 
('Felsefe'), ('Anı'), ('Hikaye'), ('Biyografi'), ('Gezi');

DECLARE @LANGUAGES TABLE (WritingLanguage NVARCHAR(20));
INSERT INTO @LANGUAGES VALUES
('Türkçe'), ('İngilizce'), ('Fransızca'), ('Almanca');


WHILE @J <= 100000
BEGIN
  SELECT TOP 1 @BOOKNAME = BookName FROM @BOOKS ORDER BY NEWID();
  SELECT TOP 1 @AUTHORNAME = AuthorName FROM @AUTHORS ORDER BY NEWID();
  SELECT TOP 1 @BOOKTYPE = BookType FROM @BOOKTYPES2 ORDER BY NEWID();

  SET @YEAROFPUBLICATION = ROUND(RAND()*(2024-2010)+2010, 0);
  SET @NUMBEROFPAGES = ROUND(RAND()*3000, 0) + 80;

  SELECT TOP 1 @WRITINGLANGUAGE = WritingLanguage FROM @LANGUAGES ORDER BY NEWID();

  INSERT INTO Books(BookName, AuthorName, BookType, YearOfPublication, NumberOfPages, WritingLanguage)
  VALUES (@BOOKNAME, @AUTHORNAME, @BOOKTYPE, @YEAROFPUBLICATION, @NUMBEROFPAGES, @WRITINGLANGUAGE)

  SET @J=@J+1;
END

SELECT COUNT(*) FROM Books

SELECT * FROM Books

/* Okuma oturumları tablosu için; */
DECLARE @K INT = 1;
DECLARE @USERID INT;
DECLARE @BOOKID INT;
DECLARE @SESSIONSTARTDATE DATE;
DECLARE @SESSIONENDDATE DATE;
DECLARE @NUMBEROFPAGESREAD INT;
DECLARE @SESSIONDURATION TIME;


WHILE @K <= 100000
BEGIN
  SET @USERID = ROUND(RAND()*5000, 0) + 1;
  SET @BOOKID = ROUND(RAND()*2000, 0) + 1;

  SET @SESSIONSTARTDATE = DATEADD(DAY, FLOOR(RAND() * DATEDIFF(DAY, '2010-01-01', '2024-10-01')), '2010-01-01');
  SET @SESSIONENDDATE = DATEADD(DAY, FLOOR(RAND() * DATEDIFF(DAY, @SESSIONSTARTDATE, '2024-10-01')), @SESSIONSTARTDATE);

  SET @NUMBEROFPAGESREAD = ROUND(RAND()*(15000-2000)+100, 0);
 
  DECLARE @DURATIONMINUTES INT = FLOOR(RAND() * (180 - 30 + 1)) + 30; -- 30 ile 180 dakika arasında rastgele değer atanır.
  SET @SESSIONDURATION = DATEADD(MINUTE, @DURATIONMINUTES, '00:00:00')  

  INSERT INTO ReadingSessions(UserID, BookID, SessionStartDate, SessionEndDate, NumberOfPagesRead, SessionDuration)
  VALUES (@USERID, @BOOKID, @SESSIONSTARTDATE, @SESSIONENDDATE, @NUMBEROFPAGESREAD, @SESSIONDURATION)

  SET @K=@K+1;
END

SELECT COUNT(*) FROM ReadingSessions

SELECT * FROM ReadingSessions

/* İstek listesi tablosu için; */
DECLARE @L INT = 1;
DECLARE @USERID INT;
DECLARE @BOOKID INT;
DECLARE @WISHADDEDDATE DATE;


WHILE @L <= 100000
BEGIN
  SET @USERID = ROUND(RAND()*5000, 0) + 1;
  SET @BOOKID = ROUND(RAND()*2000, 0) + 1;

  SET @WISHADDEDDATE = DATEADD(DAY, FLOOR(RAND() * DATEDIFF(DAY, '2010-01-01', '2024-10-01')), '2010-01-01');

  INSERT INTO WishList(UserID, BookID, WishAddedDate)
  VALUES(@USERID, @BOOKID, @WISHADDEDDATE)

  SET @L=@L+1;
END

SELECT COUNT(*) FROM WishList

SELECT * FROM WishList



/* Database'i silmek için;

USE master;
GO
ALTER DATABASE [BOOKSHELF] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE [BOOKSHELF];

*/





/* SORULAR */

-- En fazla kitap okuyan kullanıcıların listesi:
WITH KullaniciKitapSayisi AS (
  SELECT R.UserID, 
  COUNT(R.BookID) AS ToplamKitapSayisi
  FROM ReadingSessions R
  GROUP BY R.UserID
)

SELECT TOP 15 U.UserName, KS.ToplamKitapSayisi
FROM KullaniciKitapSayisi KS
JOIN Users U ON U.UserID = KS.UserID
ORDER BY KS.ToplamKitapSayisi DESC;

-- Belirli bir tarih aralığında (2024-07-26 VE 2024-09-09) istek listesine en fazla kitap ekleyen kullanıcıların listesi:
WITH ToplamIstekKitap AS(
  SELECT W.UserID, COUNT(BookID) AS ToplamKitapSayisi
  FROM WishList W
  WHERE W.WishAddedDate between '2024-07-26' and '2024-09-09'
  GROUP BY W.UserID
)

SELECT TOP 10 U.UserName, TIK.ToplamKitapSayisi
FROM ToplamIstekKitap TIK
JOIN Users U ON U.UserID = TIK.UserID
ORDER BY TIK.ToplamKitapSayisi DESC;

-- Her kullanıcı için okuma seanslarının ortalama süresi nedir?
WITH OrtalamaOkumaSeansi AS(
  SELECT R.UserID, AVG(DATEDIFF(MINUTE, '00:00:00', R.SessionDuration)) AS OrtalamaOkumaOturumSuresiDk
  FROM ReadingSessions R
  GROUP BY R.UserID
)

SELECT TOP 15 U.UserName, OOS.OrtalamaOkumaOturumSuresiDk
FROM OrtalamaOkumaSeansi OOS
JOIN Users U ON U.UserID = OOS.UserID
ORDER BY OOS.OrtalamaOkumaOturumSuresiDk DESC;





/* Stored Procedure Oluşturma: */
CREATE TABLE UserActivity(
  UserID INT FOREIGN KEY (UserID) REFERENCES Users(UserID),
  LastActiveDate DATE,
  ActivityStatus NVARCHAR(10)
)

INSERT INTO UserActivity
(UserID, LastActiveDate)
SELECT R.UserID, MAX(R.SessionEndDate)
FROM ReadingSessions R
GROUP BY R.UserID

SELECT * FROM UserActivity

/* Bir tablodaki sütunun özelliğini değiştirme:
ALTER TABLE UserActivity
ALTER COLUMN ActivityStatus NVARCHAR(15);
*/

CREATE PROCEDURE dbo.sp_UserActivityUpdate
AS
BEGIN
  UPDATE UA
  SET UA.ActivityStatus = 'Passive User'
  FROM UserActivity UA
  -- Son 30 gün içerisinde okuma seansı yapmamış kullanıcılar pasif kullanıcı olarak etiketlendirilir.
  WHERE UA.LastActiveDate <= DATEADD(DAY, -30, GETDATE());

  UPDATE UA
  SET UA.ActivityStatus = 'Active User'
  FROM UserActivity UA
  -- Son 7 gün içerisinde okuma seansılarında toplamda 60 dakika veya daha fazla okuma yapmış olan kullanıcılar aktif kullanıcı olarak etiketlendirilir.
  WHERE EXISTS (
    SELECT 1
	FROM ReadingSessions RS
	WHERE RS.UserID = UA.UserID 
	AND RS.SessionEndDate >= DATEADD(DAY, -7, GETDATE())
	GROUP BY RS.UserID
	HAVING SUM(DATEDIFF(MINUTE, CAST('00:00:00' AS TIME), RS.SessionDuration)) >= 60
  );
END;

/* NOT:
EXISTS: Belirli bir koşulu karşılayan kayıtların varlığını kontrol eder. En az bir kayıt varsa, ana sorgudaki kayıt güncellenir.
NOT EXISTS: Belirli bir koşulu karşılayan kayıtların yokluğunu kontrol eder. Hiçbir kayıt yoksa, ana sorgudaki kayıt güncellenir.
*/

/* Mevcut stored procedure'ü silmek için:
DROP PROCEDURE IF EXISTS dbo.sp_UserActivityUpdate;
*/

-- Oluşturmuş olduğumuz stored procedure'ü çalıştırmak için:
EXEC dbo.sp_UserActivityUpdate;

SELECT * FROM UserActivity





/* Trigger Oluşturma: */
-- Pasif olan kullanıcıların Log tablosuna atılması için trigger oluşturulur.

CREATE TABLE ActivityLog(
  LogID INT IDENTITY(1,1) PRIMARY KEY,
  UserID INT,
  ActivityStatus NVARCHAR(15),
  LogDate DATETIME
)

CREATE TRIGGER trg_LogPassiveUsers
ON UserActivity
FOR UPDATE, INSERT
AS
BEGIN
  INSERT INTO ActivityLog (UserID, ActivityStatus, LogDate)
  SELECT I.UserID, I.ActivityStatus, GETDATE()
  FROM Inserted I
  WHERE I.ActivityStatus = 'Passive User'
END;

SELECT * FROM ActivityLog




/* Index oluşturma: */

/* Clustered Index: */

CREATE CLUSTERED INDEX IX_UserActivity
ON UserActivity (LastActiveDate)

SELECT * FROM UserActivity

-- Diğer tabloların herbirinde primary key olarak ayarlanan ID sütunu olduğu ve her tabloda yalnızca bir tane clustered index olabileceği için diğer tablolar kullanılmamıştır.

/* Non-Clustered Index: */

CREATE NONCLUSTERED INDEX IX_SessionEndDate
ON ReadingSessions (SessionEndDate)

CREATE NONCLUSTERED INDEX IX_SessionDuration
ON ReadingSessions (SessionDuration)

-- Tek tabloda birden fazla non-clustered index olabileceği ve sorgulama yaparaken en sık kullanılan sütunlar oldukları için kullanılmıştır.





/* View oluşturma: */

-- Aktif ve Pasif Kullanıcıların Oranı:
CREATE VIEW vm_ActivityRate
AS
SELECT 
  COUNT(CASE WHEN UA.ActivityStatus = 'Active User' THEN 1 END) * 1.0 / COUNT(*) AS ActiveUserRate,
  COUNT(CASE WHEN UA.ActivityStatus = 'Passive User' THEN 1 END) * 1.0 / COUNT(*) AS PassiveUserRate
FROM UserActivity UA;

SELECT * FROM vm_ActivityRate

-- Kullanıcıların Ortalama Okuma Süreleri:
CREATE VIEW vm_WeeklyReading
AS 
SELECT 
  U.UserName,
  AVG(DATEDIFF(MINUTE, CAST('00:00:00' AS TIME), RS.SessionDuration)) AS ReadingDurationRateDk
FROM ReadingSessions RS
JOIN Users U ON U.UserID = RS.UserID
GROUP BY U.UserName;

SELECT * FROM vm_WeeklyReading