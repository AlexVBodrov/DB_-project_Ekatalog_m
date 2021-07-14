-- для примера UPDATE Изменим несколько брандов на реальные

UPDATE brand
    SET brand_name='SONY',
        description_brand='Fill the world with emotion, through the power of creativity and technology'
    where id=3;
UPDATE brand
    SET brand_name='Nokia',
     description_brand='Будучи глобальной социально-ответственной компанией, мы стремимся оказывать положительное влияние на общество, предлагая инновационные продукты и услуги'
    where id=4;
UPDATE brand
    SET brand_name='Xiaomi',
    description_brand=' вся наша операционная деятельность имеет нулевой баланс выбросов углерода.'
    where id=5;

