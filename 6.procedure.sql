-- 	хранимые процедуры / триггеры;
USE katalog_m;

-- создадим процедуру которая поможет, выбрать подкатегорию товаров например все Телефоны, или все Мониторы
-- это часто встречаеться на практике при поиска подходящей модели для покупки

DROP PROCEDURE IF EXISTS get_product_from_Subproduct;

delimiter $$
CREATE PROCEDURE get_product_from_Subproduct (IN c CHAR(3))

BEGIN
	SELECT 
	product.product_name ,
	subcategory_name ,
	brand.brand_name,  
	model.price
FROM 
	product JOIN model 
	ON product.model_id=model.id
	JOIN brand ON model.brand_id=brand.id
	JOIN subcategory ON product.subcategory_id=subcategory.id 
	WHERE subcategory.id=c
	order BY price ;
END $$

delimiter ;

CALL get_product_from_Subproduct(1);
CALL get_product_from_Subproduct(2);