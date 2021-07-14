-- примеры простых SELECT;

SELECT * FROM brand;
SELECT MIN(price),MAX(price) FROM model;
SELECT * FROM subcategory WHERe id='4';
SELECT COUNT(*) FROM product;

-- пример составной , вложенные таблицы SELECT;
SELECT 
(SELECT subcategory_name FROM subcategory WHERE id=1) as Category,
product_name as product,
(SELECT model_name FROM model WHERE id='1') as model
FROM product WHERE subcategory_id='1';

-- пример JOIN , order BY

SELECT product.product_name,
    subcategory.subcategory_name    
    FROM subcategory   JOIN product ON  product.subcategory_id=subcategory.id
    Order BY subcategory.subcategory_name;