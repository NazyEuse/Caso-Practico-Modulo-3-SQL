--Pasos a seguir
/*a) Crear la base de datos con el archivo create_restaurant_db.sql

b) Explorar la tabla “menu_items” para conocer los productos del menú.*/
SELECT * FROM menu_items
	
/*1.- Realizar consultas para contestar las siguientes preguntas:

● Encontrar el número de artículos en el menú.*/

SELECT COUNT(*) AS numero_articulos FROM menu_items;

--● ¿Cuál es el artículo menos caro y el más caro en el menú?

-- Artículo menos caro
SELECT item_name, price FROM menu_items ORDER BY price ASC LIMIT 1; 
-- Artículo más caro
SELECT item_name, price FROM menu_items ORDER BY price DESC LIMIT 1;  

--● ¿Cuántos platos americanos hay en el menú?

SELECT COUNT(*) AS item_name FROM menu_items WHERE category = 'Americana';

--● ¿Cuál es el precio promedio de los platos?

SELECT AVG(price) AS price_promedio FROM menu_items;

--c) Explorar la tabla “order_details” para conocer los datos que han sido recolectados.

SELECT * FROM order_details

--1.- Realizar consultas para contestar las siguientes preguntas:

--● ¿Cuántos pedidos únicos se realizaron en total?

SELECT COUNT(DISTINCT order_id) AS order_details_id FROM order_details;

--● ¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?

SELECT order_id, COUNT(*) AS item_id
FROM order_details
GROUP BY order_id
ORDER BY COUNT (item_id) DESC
LIMIT 5;

--● ¿Cuándo se realizó el primer pedido y el último pedido?

SELECT MIN(order_date) AS order_id, MAX(order_date) AS order_details_id FROM order_details;

--● ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?

SELECT COUNT(DISTINCT order_id) AS order_date
FROM order_details
WHERE order_date BETWEEN '2023-01-01' AND '2023-01-05';

/*d) Usar ambas tablas para conocer la reacción de los clientes respecto al menú.
1.- Realizar un left join entre entre order_details y menu_items con el identificador
item_id(tabla order_details) y menu_item_id(tabla menu_items).*/

SELECT * 
FROM order_details AS o
	LEFT JOIN menu_items AS m
ON o.item_id=m.menu_item_id
    
/*e) Una vez que hayas explorado los datos en las tablas correspondientes y respondido las
preguntas planteadas, realiza un análisis adicional utilizando este join entre las tablas. El
objetivo es identificar 5 puntos clave que puedan ser de utilidad para los dueños del
restaurante en el lanzamiento de su nuevo menú. Para ello, crea tus propias consultas y
utiliza los resultados obtenidos para llegar a estas conclusiones.*/

--1.- Artículos Más Vendidos del Menú
SELECT COUNT(o.order_id),m.item_name
  FROM 
    order_details AS o
LEFT JOIN 
    menu_items AS m 
ON 
    o.item_id = m.menu_item_id
GROUP BY 
    m.item_name
ORDER BY 
   COUNT (o.order_id) DESC
LIMIT 5;

--2.- Ingreso Total Generado por Cada Tipo de Cocina
SELECT 
    m.tipo_cocina,
    SUM(o.cantidad * m.precio) AS total_ingreso
FROM 
    order_details AS o
LEFT JOIN 
    menu_items AS m 
ON 
    o.item_id = m.menu_item_id
GROUP BY 
    m.tipo_cocina
ORDER BY 
    total_ingreso DESC;

--3.- Días con Mayor Cantidad de Pedidos
SELECT 
    o.fecha_pedido,
    COUNT(DISTINCT o.pedido_id) AS total_pedidos
FROM 
    order_details AS o
LEFT JOIN 
    menu_items AS m 
ON 
    o.item_id = m.menu_item_id
GROUP BY 
    o.fecha_pedido
ORDER BY 
    total_pedidos DESC
LIMIT 5;

--4. Precio Promedio por Pedido

SELECT 
    o.pedido_id,
    AVG(m.precio * o.cantidad) AS precio_promedio
FROM 
    order_details AS o
LEFT JOIN 
    menu_items AS m 
ON 
    o.item_id = m.menu_item_id
GROUP BY 
    o.pedido_id;
--5. Popularidad de Tipos de Cocina Basado en la Cantidad de Artículos Pedidos
SELECT 
    m.tipo_cocina,
    SUM(o.cantidad) AS total_pedidos
FROM 
    order_details AS o
LEFT JOIN 
    menu_items AS m 
ON 
    o.item_id = m.menu_item_id
GROUP BY 
    m.tipo_cocina
ORDER BY 
    total_pedidos DESC;




