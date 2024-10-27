-- CREAR TABLAS
CREATE TABLE CLIENTE (
    cliente_id CHAR(5) NOT NULL,
    nombre VARCHAR2(25) NOT NULL,
    apellido VARCHAR2(25) NOT NULL,
    fecha_registro DATE NOT NULL,
    email VARCHAR2(50) NOT NULL,
    telefono NUMBER(9),
    CONSTRAINT pk_cliente PRIMARY KEY(cliente_id)
)

CREATE TABLE PRODUCTO (
    producto_id CHAR(5) NOT NULL,
    nombre_producto VARCHAR2(50) NOT NULL,
    categoria VARCHAR2(25) NOT NULL,
    precio NUMBER(8) NOT NULL,
    stock NUMBER(3) NOT NULL,
    CONSTRAINT pk_producto PRIMARY KEY(producto_id)
)

CREATE TABLE PERSONAL_VENTA (
    personal_id CHAR(5) NOT NULL,
    nombre VARCHAR2(25) NOT NULL,
    apellido VARCHAR(25) NOT NULL,
    email VARCHAR2(50) NOT NULL,
    telefono NUMBER(9) NOT NULL,
    CONSTRAINT pk_personal PRIMARY KEY(personal_id)
)

CREATE TABLE VENTA (
    venta_id CHAR(5) NOT NULL,
    cliente_id CHAR(5) NOT NULL,
    producto_id CHAR(5) NOT NULL,
    cantidad NUMBER(3) NOT NULL,
    fecha_venta DATE NOT NULL,
    total_venta NUMBER(7) NOT NULL,
    CONSTRAINT fk_cliente FOREIGN KEY(cliente_id) REFERENCES CLIENTE(cliente_id),
    CONSTRAINT fk_producto FOREIGN KEY(producto_id) REFERENCES PRODUCTO(producto_id)
)

-- INSERTAR DATOS
INSERT INTO CLIENTE (cliente_id, nombre, apellido, fecha_registro, email, telefono) VALUES 
('CLI01', 'Nicolas', 'Silva', TO_DATE('2024-05-12', 'YYYY-MM-DD'), 'nico@correo.cl', NULL );
INSERT INTO CLIENTE (cliente_id, nombre, apellido, fecha_registro, email, telefono) VALUES 
('CLI02', 'Javier', 'Araneda', TO_DATE('2024-10-24', 'YYYY-MM-DD'), 'javier@gmail.com', NULL );
INSERT INTO CLIENTE (cliente_id, nombre, apellido, fecha_registro, email, telefono) VALUES 
('CLI03', 'Valentina', 'Nappi', TO_DATE('2022-10-25', 'YYYY-MM-DD'), 'vale@nappi.com', 987654321 );
INSERT INTO CLIENTE (cliente_id, nombre, apellido, fecha_registro, email, telefono) VALUES 
('CLI04', 'Andres', 'Bilbao', TO_DATE('2020-12-17', 'YYYY-MM-DD'), 'mr_cochayuyo@gmail.com', 998877665 );
INSERT INTO CLIENTE (cliente_id, nombre, apellido, fecha_registro, email, telefono) VALUES 
('CLI05', 'Yerko', 'Cortes', TO_DATE('2021-04-09', 'YYYY-MM-DD'), 'run_with_yerko@trekking.cl', NULL );
INSERT INTO CLIENTE (cliente_id, nombre, apellido, fecha_registro, email, telefono) VALUES 
('CLI06', 'Maria', 'Reyes', TO_DATE('2024-10-05', 'YYYY-MM-DD'), 'mariareyes@mail.com', 223344556 );


INSERT INTO PRODUCTO (producto_id, nombre_producto, categoria, precio, stock) VALUES 
('PRO01', 'Impresora', 'Impresoras y Suministros', 45900, 37 );
INSERT INTO PRODUCTO (producto_id, nombre_producto, categoria, precio, stock) VALUES 
('PRO02', 'Notebook', 'Computadores y Tablets', 678990, 12 );
INSERT INTO PRODUCTO (producto_id, nombre_producto, categoria, precio, stock) VALUES 
('PRO03', 'Disco SSD', 'Almacenamiento', 77990, 5 );
INSERT INTO PRODUCTO (producto_id, nombre_producto, categoria, precio, stock) VALUES 
('PRO04', 'Mouse', 'Perifericos', 7500, 19 );
INSERT INTO PRODUCTO (producto_id, nombre_producto, categoria, precio, stock) VALUES 
('PRO05', 'Teclado Mecanico', 'Perifericos', 119990, 3 );


INSERT INTO PERSONAL_VENTA (personal_id, nombre, apellido, email, telefono) VALUES
('PVE01', 'Carlos', 'Fernandez', 'carlos.fernandez@ventas.cl', 912345678);
INSERT INTO PERSONAL_VENTA (personal_id, nombre, apellido, email, telefono) VALUES
('PVE02', 'Maria', 'Gonzalez', 'maria.gonzalez@ventas.cl', 923456789);
INSERT INTO PERSONAL_VENTA (personal_id, nombre, apellido, email, telefono) VALUES
('PVE03', 'Jose', 'Ramirez', 'jose.ramirez@ventas.cl', 934567890);
INSERT INTO PERSONAL_VENTA (personal_id, nombre, apellido, email, telefono) VALUES
('PVE04', 'Ana', 'Martinez', 'ana.martinez@ventas.cl', 945678901);
INSERT INTO PERSONAL_VENTA (personal_id, nombre, apellido, email, telefono) VALUES
('PVE05', 'Felipe', 'Torres', 'felipe.torres@ventas.cl', 956789012);


INSERT INTO VENTA (venta_id, cliente_id, producto_id, cantidad, fecha_venta, total_venta) VALUES
('VEN01', 'CLI01', 'PRO02', 1, TO_DATE('2024-10-10', 'YYYY-MM-DD'), 678990);
INSERT INTO VENTA (venta_id, cliente_id, producto_id, cantidad, fecha_venta, total_venta) VALUES
('VEN02', 'CLI02', 'PRO04', 2, TO_DATE('2024-10-12', 'YYYY-MM-DD'), 15000);
INSERT INTO VENTA (venta_id, cliente_id, producto_id, cantidad, fecha_venta, total_venta) VALUES
('VEN03', 'CLI03', 'PRO03', 1, TO_DATE('2023-09-15', 'YYYY-MM-DD'), 77990);
INSERT INTO VENTA (venta_id, cliente_id, producto_id, cantidad, fecha_venta, total_venta) VALUES
('VEN04', 'CLI04', 'PRO01', 3, TO_DATE('2023-11-20', 'YYYY-MM-DD'), 137700);
INSERT INTO VENTA (venta_id, cliente_id, producto_id, cantidad, fecha_venta, total_venta) VALUES
('VEN05', 'CLI05', 'PRO05', 1, TO_DATE('2024-01-05', 'YYYY-MM-DD'), 119990);


-- CONSULTAS

-- Obtener la lista de clientes registrados en el último mes, 
-- mostrando su nombre completo y fecha de registro. 
-- Ordenar la lista por fecha de registro en orden descendente
SELECT  nombre || ' ' || apellido AS Nombre_Completo, fecha_registro AS Registro 
FROM CLIENTE
WHERE EXTRACT(YEAR FROM fecha_registro) = EXTRACT(YEAR FROM SYSDATE)
    AND EXTRACT(MONTH FROM fecha_registro) = EXTRACT(MONTH FROM SYSDATE)
ORDER BY fecha_registro DESC;


-- Calcular el incremento del 15% del precio de todos los productos cuyo nombre
-- termine en A y que tengan más de 10 unidades en stock. 
-- Considera el resultado del incremento con 1 decimal. 
-- Ordenar el listado por el incremento de forma ascendente
SELECT nombre_producto, stock, precio, ROUND(precio * 1.15, 1) AS Precio_Incremento 
FROM PRODUCTO
WHERE nombre_producto LIKE('%a') OR nombre_producto LIKE '%A'
    AND stock > 10
ORDER BY Precio_Incremento ASC;


-- Obtener la lista del personal de ventas registrado en la base de datos, 
-- mostrando su nombre completo, correo electrónico y creando una contraseña por defecto que cumpla los
-- siguientes requisitos:
-- 4 primeras letras del nombre
-- Cantidad de caracteres de su email
-- 3 últimas letras del apellido
--Ordenar la lista por apellido de forma descendente y por nombre de forma ascendente
SELECT nombre || ' ' || apellido AS Nombre_Completo, email, 
    SUBSTR(nombre,1,4) || LENGTH(email) || SUBSTR(apellido, -3) AS Contraseña 
FROM PERSONAL_VENTA
ORDER BY apellido DESC, nombre ASC;
