-- представления (минимум 2);

-- из 1-ой таблицы
CREATE VIEW price_model_view AS
SELECT model_name, price
FROM model
WHERE price BETWEEN '2000' and  '6000';

-- получаем

SELECT * FROM price_model_view;

-- из нескольких таблиц

CREATE VIEW product_view AS
SELECT product.id, 
	product.product_name ,
	subcategory_name ,
	brand.brand_name,  
	model.price
FROM 
	product JOIN model 
	ON product.model_id=model.id
	JOIN brand ON model.brand_id=brand.id
	JOIN subcategory ON product.subcategory_id=subcategory.id 
	order BY subcategory_name ;

-- как результат
SELECT * FROM product_view;