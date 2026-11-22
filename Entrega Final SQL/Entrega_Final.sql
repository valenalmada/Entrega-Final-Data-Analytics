CREATE DATABASE Entrega_Final;

USE Entrega_Final;

SELECT * FROM ventas;
SELECT * FROM productos;
SELECT * FROM metodos_pago;
SELECT * FROM clientes;
SELECT * FROM categorias;

ALTER TABLE ventas
ADD CONSTRAINT FK_Ventas_Clientes
FOREIGN KEY (ID_Cliente)
REFERENCES clientes(ID_Cliente);

ALTER TABLE ventas
ADD CONSTRAINT FK_Ventas_Productos
FOREIGN KEY (ID_Producto)
REFERENCES productos(ID_Producto);

ALTER TABLE ventas
ADD CONSTRAINT FK_Ventas_MetodosPago
FOREIGN KEY (ID_Metodo)
REFERENCES metodos_pago(ID_Metodo);

ALTER TABLE productos
ADD CONSTRAINT FK_Productos_Categorias
FOREIGN KEY (ID_Categoria)
REFERENCES categorias(ID_Categoria);

SELECT
    c.Nombre AS Nombre_Cliente,
    v.Fecha AS Fecha_Compra,
    (v.Cantidad * p.Precio_Unitario) AS Total_Venta
FROM ventas v
INNER JOIN clientes c
    ON v.ID_Cliente = c.ID_Cliente
INNER JOIN productos p
    ON v.ID_Producto = p.ID_Producto
WHERE v.Fecha >= (
    SELECT DATEADD(DAY, -30, MAX(Fecha))
    FROM ventas
)
ORDER BY v.Fecha DESC;