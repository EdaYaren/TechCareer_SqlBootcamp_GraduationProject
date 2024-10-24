# 📚 Kitaplık Yönetim Sistemi 

Bu proje, kişisel kitaplık verilerinizi yönetmek için geliştirilmiş bir **SQL** tabanlı kitaplık yönetim sistemidir. Proje; kitapların, kullanıcıların ve okuma sürelerinin takibini sağlar. Ayrıca veri manipülasyonu ve kullanıcıların okuma alışkanlıklarını izlemek için **stored procedure** ve **trigger** kullanımı içerir.

## 🚀 Özellikler 

- 📖 **Kitap Ekleme:** Yeni kitaplar eklenebilir ve bu kitaplar için gerekli tüm bilgiler depolanabilir.
- 👤 **Kullanıcı Yönetimi:** Kullanıcıların sisteme eklenmesi ve güncellenmesi işlemleri gerçekleştirilebilir.
- ⏱️ **Okuma Takibi:** Kullanıcıların haftalık okuma sürelerini takip edebilir ve toplam okuma süreleri hesaplanabilir.
- 🌟 **İstek Listesi:** Kullanıcılar okumak istedikleri kitapları kaydedilebilir ve takip edilebilir.
- 🔄 **Etkinlik Günlüğü:** Kullanıcıların etkinlikleri kaydedilir, böylece okuma alışkanlıkları analiz edilebilir.
- 📝 **SQL Stored Procedures & Triggers:** Veri tabanı işlemlerini otomatikleştirmek ve verimliliği artırmak için SQL stored procedures ve trigger'lar kullanılmıştır.

## 📊 Tablolar 

Projede kullanılan temel tablolar ve bu tablolardaki verilerin açıklamaları aşağıda yer almaktadır:

### 1. `Users` Tablosu
Kullanıcı bilgilerini depolayan tablodur.

| Sütun Adı            | Veri Tipi | Açıklama                                                        |
|----------------------|-----------|-----------------------------------------------------------------|
| `UserID`             | INT       | Her kullanıcının benzersiz ID'si (Primary Key)                |
| `UserName`           | NVARCHAR  | Kullanıcının adı ve soyadı                                      |
| `Email`              | NVARCHAR  | Kullanıcının e-posta adresi                                     |
| `Age`                | INT       | Kullanıcının yaşı                                              |
| `AnnualReadingTarget` | INT       | Kullanıcının yıllık okuma hedefi                               |
| `FavoriteBookType`   | NVARCHAR  | Kullanıcının en sevdiği kitap türü                              |
| `RegistrationDate`   | DATE      | Kullanıcının sisteme kayıt tarihi 

### 2. `Books` Tablosu
Kitap bilgilerini saklayan tablodur.

| Sütun Adı      | Veri Tipi | Açıklama                       |
|----------------|-----------|--------------------------------|
| `BookID`       | INT       | Her kitabın benzersiz ID'si (Primary Key) |
| `BookName`        | NVARCHAR  | Kitabın adı                    |
| `AuthorName`       | NVARCHAR  | Kitabın yazarı                 |
| `YearOfPublication` | INT    | Kitabın yayınlandığı yıl       |
| `NumberOfPages`    | INT       | Kitabın toplam sayfa sayısı    |
| `BookType`     | NVARCHAR  | Kitabın kategorisi             |
| `WritingLanguage`     | NVARCHAR  | Kitabın yazıldığı dil             |

### 3. `ReadingSessions` Tablosu
Kullanıcıların okuma oturumlarını depolayan tablodur.

| Sütun Adı           | Veri Tipi | Açıklama                                                         |
|---------------------|-----------|------------------------------------------------------------------|
| `SessionID`         | INT       | Her okuma oturumunun benzersiz ID'si (Primary Key)             |
| `UserID`            | INT       | Oturumun ait olduğu kullanıcının ID'si (Foreign Key)           |
| `BookID`            | INT       | Oturumda okunan kitabın ID'si (Foreign Key)                    |
| `SessionStartDate`  | DATE      | Okuma oturumunun başlangıç tarihi                               |
| `SessionEndDate`    | DATE      | Okuma oturumunun bitiş tarihi                                   |
| `NumberOfPagesRead` | INT       | Okunan sayfa sayısı                                             |
| `SessionDuration`    | TIME      | Oturum boyunca okunan süre 


### 4. `WishList` Tablosu
Kullanıcıların istek listelerini depolayan tablodur.

| Sütun Adı         | Veri Tipi | Açıklama                                                        |
|-------------------|-----------|-----------------------------------------------------------------|
| `WishID`          | INT       | Her istek listesinin benzersiz ID'si (Primary Key)            |
| `UserID`          | INT       | İsteğin ait olduğu kullanıcının ID'si (Foreign Key)           |
| `BookID`          | INT       | İstenilen kitabın ID'si (Foreign Key)                          |
| `WishAddedDate`   | DATE      | Kitabın istek listesine eklendiği tarih                        |


### 5. `UserActivity` Tablosu
Kullanıcıların etkinlik durumlarını ve son aktif tarihlerini depolayan tablodur.

| Sütun Adı         | Veri Tipi | Açıklama                                                        |
|-------------------|-----------|-----------------------------------------------------------------|
| `UserID`          | INT       | Kullanıcının ID'si (Foreign Key)                               |
| `LastActiveDate`  | DATE      | Kullanıcının en son aktif olduğu tarih                          |
| `ActivityStatus`   | NVARCHAR  | Kullanıcının etkinlik durumu (örn. "Aktif", "Pasif")          |

### 6. `ActivityLog` Tablosu
Kullanıcı etkinliklerini ve tarihlerini kaydeden tablodur.

| Sütun Adı         | Veri Tipi | Açıklama                                                        |
|-------------------|-----------|-----------------------------------------------------------------|
| `LogID`           | INT       | Her kaydın benzersiz ID'si (Primary Key)                       |
| `UserID`          | INT       | Kullanıcının ID'si (Foreign Key)                               |
| `ActivityStatus`   | NVARCHAR  | Kullanıcının etkinlik durumu (örn. "Aktif", "Pasif")          |
| `LogDate`         | DATETIME  | Etkinliğin gerçekleştiği tarih ve saat                         |

## 📂 Proje Dosyaları

Projeye ait klasörde, **veritabanına ait bir backup dosyası** ve veri setinin oluşturulması için yazılan **SQL sorgularını içeren bir query dosyası** yer almaktadır. Bu dosyalar, projeyi kurmak ve veri tabanını kullanıma hazır hale getirmek için kullanılabilir.

**Not:** Bu projedeki veriler **rastgele** üretilmiştir.
