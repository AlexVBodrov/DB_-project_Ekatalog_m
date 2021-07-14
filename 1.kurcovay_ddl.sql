-- 1.	Составить общее текстовое описание БД и решаемых ею задач;
/* 
Для курсовой работы я выбрал аналог E-каталога  ( https://www.e-katalog.ru),
и от себя добавлю туда возможность купить товар сразу через сервис: что то на подобие  маркетплейс.
E-Katalog — многофункциональный сервис поиска товаров в интернет-магазинах с удобными каталогами,
фильтрами, поиском, возможность сравнения характеристик, цен, многих параметров товара.
Есть так же каталог статей, обзоры, советы покупателям.
А на странице каждой модели товара есть подробная информация, которая поможет принять решение:
описание, технические характеристики, фото и видео, полезные ссылки и отзывы.

*/

-- 2.	минимальное количество таблиц - 10;
-- 3.	скрипты создания структуры БД (с первичными ключами, индексами, внешними ключами);


CREATE DATABASE katalog_m;
USE katalog_m;


-- Категории  товаров

CREATE TABLE category(
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  category_name VARCHAR (255) unique
  );
 

 INSERT INTO category VALUES (DEFAULT, 'Гаджеты');
 INSERT INTO category VALUES (DEFAULT, 'Компьютеры');
 INSERT INTO category VALUES (DEFAULT, 'Офис и канцелярия');
 INSERT INTO category VALUES (DEFAULT, 'TV');
 INSERT INTO category VALUES (DEFAULT, 'Аудио');
 INSERT INTO category VALUES (DEFAULT, 'Бытовая техника');
 INSERT INTO category VALUES (DEFAULT, 'Климат');
 INSERT INTO category VALUES (DEFAULT, 'Дом');
 INSERT INTO category VALUES (DEFAULT, 'Детские товары');
 INSERT INTO category VALUES (DEFAULT, 'Авто');
 INSERT INTO category VALUES (DEFAULT, 'Инструмент');
 INSERT INTO category VALUES (DEFAULT, 'Туризм');
 INSERT INTO category VALUES (DEFAULT, 'Спорт');
 INSERT INTO category VALUES (DEFAULT, 'Аксесуары');
 INSERT INTO category VALUES (DEFAULT, 'Фото');

 -- подкатегория

CREATE TABLE subcategory (
  id BIGINT UNSIGNED AUTO_INCREMENT  PRIMARY KEY,
  subcategory_name VARCHAR (255) UNIQUE,
  category_id BIGINT UNSIGNED NOT NULL ,
  CONSTRAINT fk_subcategory_category FOREIGN KEY (category_id) REFERENCES category(id),
  index subcategory_name_idx(subcategory_name)
);

INSERT INTO subcategory VALUES (DEFAULT, 'Телефоны', 1);
INSERT INTO subcategory VALUES (DEFAULT, 'Флешкарты', 1);
INSERT INTO subcategory VALUES (DEFAULT, 'Чехлы', 1);
INSERT INTO subcategory VALUES (DEFAULT, 'Powerbank', 1);
INSERT INTO subcategory VALUES (DEFAULT, 'Зарядки', 1);
INSERT INTO subcategory VALUES (DEFAULT, 'Наушники', 1);
INSERT INTO subcategory VALUES (DEFAULT, 'Квадрокоптеры', 1);
INSERT INTO subcategory VALUES (DEFAULT, 'Смарт Часы', 1);


INSERT INTO subcategory VALUES (DEFAULT, 'Ноутбуки', 2);
INSERT INTO subcategory VALUES (DEFAULT, 'Планшетыы', 2);
INSERT INTO subcategory VALUES (DEFAULT, 'ПК', 2);
INSERT INTO subcategory VALUES (DEFAULT, 'Мониторы', 2);
INSERT INTO subcategory VALUES (DEFAULT, 'Комплектующие', 2);
INSERT INTO subcategory VALUES (DEFAULT, 'Приставки', 2);
INSERT INTO subcategory VALUES (DEFAULT, 'Сетевое оборудование', 2);
INSERT INTO subcategory VALUES (DEFAULT, 'Манипуляторы', 2);


-- бранды производители

CREATE TABLE brand (
  id BIGINT UNSIGNED AUTO_INCREMENT  PRIMARY KEY,
  brand_name VARCHAR (255) UNIQUE NOT NULL,
  description_brand VARCHAR  (255),
  index brand_name_idx(brand_name)
);

INSERT INTO brand VALUES (DEFAULT, 'Aplle', ' неотъемлемая часть успеха бренда — это культовая личность Стив Джобс, который буквально создал новую религию и заставил весь мир мечтать о  гаджетах');

INSERT INTO brand VALUES (DEFAULT, 'Samsung', ' Южнокорейская компания один из крупнейших концернов в мире. Говоря о продуктах мы подразумеваем соотношение цены и качества');

-- продавцы

CREATE TABLE dealer (
  id BIGINT UNSIGNED AUTO_INCREMENT  PRIMARY KEY,
  dealer_name VARCHAR (255) UNIQUE NOT NULL,
  description_dealer VARCHAR (255)
);

INSERT INTO dealer VALUES (DEFAULT, 'М.Видео', ' Какоето описание' );
INSERT INTO dealer VALUES (DEFAULT, 'Ситилинк', ' Какоето описание' );
INSERT INTO dealer VALUES (DEFAULT, 'DNS', ' Какоето описание' );

-- модель товара


CREATE TABLE model (
  id BIGINT UNSIGNED AUTO_INCREMENT  PRIMARY KEY,
  model_name VARCHAR (255) UNIQUE NOT NULL,
  description_model TEXT (255),
  brand_id BIGINT UNSIGNED NOT NULL,
  CONSTRAINT fk_model_brand FOREIGN KEY (brand_id) REFERENCES brand(id),
  dealer_id BIGINT UNSIGNED NOT NULL,
  CONSTRAINT fk_model_dealer FOREIGN KEY (dealer_id) REFERENCES dealer(id),
  characteristics VARCHAR (255) COMMENT 'JSON формат', -- все характеристики, всех товаров в JSON формате
  price int (255) UNSIGNED NOT NULL
);

INSERT INTO model VALUES (DEFAULT, 'Samsung Galaxy A51',
'Хороший процессор, пользоватся можно, android, фото снимает норм', 2 , 1, 
'{"Samsung Galaxy A51 64 ГБ":[{"Цвет":"Black", "Дисплей":"6.5 2400x1080 Super AMOLED, 
"Операционная система":"Android 10", "Основная камера":"48 МП"},{"Емкость аккумулятора":"4000 mAч"}]}',
15000
);


-- товар

CREATE TABLE product (
  id BIGINT UNSIGNED AUTO_INCREMENT  PRIMARY KEY,
  subcategory_id BIGINT UNSIGNED NOT NULL,
  CONSTRAINT fk_product_subcategory FOREIGN KEY (subcategory_id) REFERENCES subcategory(id),
  product_name VARCHAR (255) UNIQUE NOT NULL,
  model_id BIGINT UNSIGNED NOT NULL,
  CONSTRAINT fk_product_model FOREIGN KEY (model_id) REFERENCES model(id)
  );

 INSERT INTO product VALUES (DEFAULT, 1, 'Мобильный телефон Samsung Galaxy A51', 1);
 

-- фото  товаров

CREATE TABLE photos_product (
  id BIGINT UNSIGNED AUTO_INCREMENT  PRIMARY KEY,
  url_photos VARCHAR (255) NOT NULL,
  product_id BIGINT UNSIGNED NOT NULL,
  CONSTRAINT fk_photos_product FOREIGN KEY (product_id) REFERENCES product(id)
);

 INSERT INTO photos_product VALUES (DEFAULT, 'photos_products/some_photo_1', 1);
 INSERT INTO photos_product VALUES (DEFAULT, 'photos_products/some_photo_2', 1);

-- видео обзоры на товар

CREATE TABLE videos_product (
  id BIGINT UNSIGNED AUTO_INCREMENT  PRIMARY KEY,
  url_videos VARCHAR (255) NOT NULL,
  product_id BIGINT UNSIGNED NOT NULL,
  CONSTRAINT fk_videos_product FOREIGN KEY (product_id) REFERENCES product(id)  
);

 INSERT INTO videos_product VALUES (DEFAULT, 'videos_product/some_video_1', 1);
 INSERT INTO videos_product VALUES (DEFAULT, 'videos_product/some_video_2', 1);

-- пользователи

CREATE TABLE users (
  id BIGINT UNSIGNED AUTO_INCREMENT  PRIMARY KEY,
  nikname VARCHAR (255) UNIQUE NOT NULL,
  avatar VARCHAR (255) COMMENT 'url photo avatar',
  phone VARCHAR (11) UNIQUE NOT NULL,
  e_mail VARCHAR (255) UNIQUE NOT NULL,
  about VARCHAR (255),
  birthday DATE , 
  gender ENUM('f', 'm') ,
  password_hash CHAR(65) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users VALUES (DEfault,'Alex_007','users/avatar_1.jpeg','+18(2)09345','gutmann.edgar@example.com',
'some text about user','1983-02-25','m','a2feacb9c82095c23b48d3c492f133e39ff1ab1d','2018-06-13 13:40:26');

-- отзывы

CREATE TABLE reviews (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  review_text TEXT NOT NULL,
  url_photos_review VARCHAR (255),
  product_id BIGINT UNSIGNED NOT NULL,
  CONSTRAINT fk_review_product FOREIGN KEY (product_id) REFERENCES product(id) ,
  user_id BIGINT UNSIGNED NOT NULL,
  CONSTRAINT fk_review_user FOREIGN KEY (user_id) REFERENCES users(id) 
);




 INSERT INTO reviews VALUES (DEFAULT, 'some text review', 'videos_product/some_video_2', 1, 1);

-- корзина

CREATE TABLE carts (
  id BIGINT UNSIGNED AUTO_INCREMENT  PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  CONSTRAINT fk_carts_users FOREIGN KEY (user_id) REFERENCES users(id) 
);

-- заказы

CREATE TABLE orders (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
  carts_id BIGINT UNSIGNED NOT NULL,
  CONSTRAINT fk_orders_carts FOREIGN KEY (carts_id) REFERENCES carts(id) ,
  product_id BIGINT UNSIGNED NOT NULL,
  CONSTRAINT fk_orders_product FOREIGN KEY (product_id) REFERENCES product(id) 
);

