-- 1. CREACION DE LAS TABLAS
CREATE TABLE CLIENTE (
    Id_Cliente CHAR(10) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Telefono CHAR(10) NOT NULL,
    Direccion_Entrega VARCHAR(100) NOT NULL
);

CREATE TABLE PRODUCTO (
    Id_Producto CHAR(5) PRIMARY KEY,
    Nombre_Producto VARCHAR(50) NOT NULL,
    Precio DECIMAL(6,2) NOT NULL,
    Estado_Activo CHAR(1) NOT NULL
);

CREATE TABLE PEDIDO (
    Id_Pedido CHAR(10) PRIMARY KEY,
    Id_Cliente CHAR(10) NOT NULL,
    Fecha_Hora_Creacion DATETIME NOT NULL,
    Monto_Total DECIMAL(6,2) NOT NULL,
    Estado VARCHAR(20) NOT NULL,
    FOREIGN KEY (Id_Cliente) REFERENCES CLIENTE(Id_Cliente)
);

CREATE TABLE DETALLE_PEDIDO (
    Id_Pedido CHAR(10) NOT NULL,
    Id_Producto CHAR(5) NOT NULL,
    Cantidad INT NOT NULL,
    Subtotal DECIMAL(6,2) NOT NULL,
    PRIMARY KEY (Id_Pedido, Id_Producto),
    FOREIGN KEY (Id_Pedido) REFERENCES PEDIDO(Id_Pedido),
    FOREIGN KEY (Id_Producto) REFERENCES PRODUCTO(Id_Producto)
);


-- 2. INSERCIÓN DE DATOS INICIALES


-- Insertar Clientes
INSERT INTO CLIENTE (Id_Cliente, Nombre, Telefono, Direccion_Entrega) VALUES 
('0912345678', 'Carlos Zambrano', '0991112233', 'Sauces 8, Guayaquil'),
('0987654321', 'Andrea Gomez', '0982223344', 'Samanes 2, Guayaquil');

-- Insertar Productos
INSERT INTO PRODUCTO (Id_Producto, Nombre_Producto, Precio, Estado_Activo) VALUES 
('PR001', 'Combo Hamburguesa', 5.50, '1'),
('PR002', 'Alitas BBQ (6 uds)', 6.00, '1'),
('PR003', 'Gaseosa 1L', 1.50, '1');

-- Insertar Pedidos
INSERT INTO PEDIDO (Id_Pedido, Id_Cliente, Fecha_Hora_Creacion, Monto_Total, Estado) VALUES 
('PD-0001', '0912345678', '2026-08-04 19:30:00', 7.00, 'Entregado'),
('PD-0002', '0987654321', '2026-08-04 20:00:00', 6.00, 'En camino');

-- Insertar Detalles del Pedido (Relación Muchos a Muchos)
INSERT INTO DETALLE_PEDIDO (Id_Pedido, Id_Producto, Cantidad, Subtotal) VALUES 
('PD-0001', 'PR001', 1, 5.50),
('PD-0001', 'PR003', 1, 1.50),
('PD-0002', 'PR002', 1, 6.00);

-- AVANCE #03

CREATE PROCEDURE sp_InsertarProducto @Id_Producto CHAR(5), @Nombre_Producto VARCHAR(50), @Precio DECIMAL(6,2), @Estado_Activo CHAR(1) AS
BEGIN BEGIN TRY BEGIN TRANSACTION; IF @Precio <= 0 BEGIN THROW 50001, 'Error: El precio del producto debe ser mayor a 0.', 1; END
INSERT INTO PRODUCTO (Id_Producto, Nombre_Producto, Precio, Estado_Activo) VALUES (@Id_Producto, @Nombre_Producto, @Precio, @Estado_Activo);
COMMIT TRANSACTION; END TRY BEGIN CATCH IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; THROW; END CATCH END;
GO

CREATE PROCEDURE sp_ActualizarProducto @Id_Producto CHAR(5), @Nombre_Producto VARCHAR(50), @Precio DECIMAL(6,2), @Estado_Activo CHAR(1) AS
BEGIN BEGIN TRY BEGIN TRANSACTION; IF @Precio <= 0 BEGIN THROW 50002, 'Error: El precio debe ser mayor a 0.', 1; END
UPDATE PRODUCTO SET Nombre_Producto = @Nombre_Producto, Precio = @Precio, Estado_Activo = @Estado_Activo WHERE Id_Producto = @Id_Producto;
COMMIT TRANSACTION; END TRY BEGIN CATCH IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; THROW; END CATCH END;
GO

CREATE PROCEDURE sp_EliminarProducto @Id_Producto CHAR(5) AS
BEGIN BEGIN TRY BEGIN TRANSACTION; IF NOT EXISTS (SELECT 1 FROM PRODUCTO WHERE Id_Producto = @Id_Producto) BEGIN THROW 50003, 'Error: No existe.', 1; END
DELETE FROM PRODUCTO WHERE Id_Producto = @Id_Producto; COMMIT TRANSACTION; END TRY BEGIN CATCH IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; THROW; END CATCH END;
GO


-- Triggers

CREATE TABLE AUDITORIA_PRECIOS (Id_Auditoria INT IDENTITY(1,1) PRIMARY KEY, Id_Producto CHAR(5), Precio_Viejo DECIMAL(6,2), Precio_Nuevo DECIMAL(6,2), Fecha_Cambio DATETIME DEFAULT GETDATE());
GO

CREATE TRIGGER trg_ValidarPedidoEntregado ON DETALLE_PEDIDO INSTEAD OF INSERT AS
BEGIN IF EXISTS (SELECT 1 FROM inserted i JOIN PEDIDO p ON i.Id_Pedido = p.Id_Pedido WHERE p.Estado = 'Entregado') BEGIN THROW 50004, 'Error: Pedido ya entregado.', 1; END
ELSE BEGIN INSERT INTO DETALLE_PEDIDO (Id_Pedido, Id_Producto, Cantidad, Subtotal) SELECT Id_Pedido, Id_Producto, Cantidad, Subtotal FROM inserted; END END;
GO

CREATE TRIGGER trg_AuditoriaPrecio ON PRODUCTO AFTER UPDATE AS
BEGIN IF UPDATE(Precio) BEGIN INSERT INTO AUDITORIA_PRECIOS (Id_Producto, Precio_Viejo, Precio_Nuevo)
SELECT i.Id_Producto, d.Precio, i.Precio FROM inserted i JOIN deleted d ON i.Id_Producto = d.Id_Producto WHERE i.Precio <> d.Precio; END END;
GO

-- AVANCE 03: REPORTES (VISTAS)

CREATE VIEW vw_ReporteVentasPorCliente AS SELECT c.Id_Cliente, c.Nombre AS Cliente, COUNT(DISTINCT p.Id_Pedido) AS Total_Pedidos, SUM(dp.Cantidad) AS Articulos_Comprados, SUM(dp.Subtotal) AS Dinero_Gastado FROM CLIENTE c JOIN PEDIDO p ON c.Id_Cliente = p.Id_Cliente JOIN DETALLE_PEDIDO dp ON p.Id_Pedido = dp.Id_Pedido GROUP BY c.Id_Cliente, c.Nombre;
GO
CREATE VIEW vw_ReporteProductosMasVendidos AS SELECT pr.Id_Producto, pr.Nombre_Producto, COUNT(DISTINCT p.Id_Pedido) AS Apariciones, SUM(dp.Cantidad) AS Unidades_Vendidas, SUM(dp.Subtotal) AS Ingresos FROM PRODUCTO pr JOIN DETALLE_PEDIDO dp ON pr.Id_Producto = dp.Id_Producto JOIN PEDIDO p ON dp.Id_Pedido = p.Id_Pedido GROUP BY pr.Id_Producto, pr.Nombre_Producto;
GO
CREATE VIEW vw_ReporteHistorialDetallado AS SELECT p.Id_Pedido, p.Fecha_Hora_Creacion, c.Nombre AS Cliente, pr.Nombre_Producto AS Item, dp.Cantidad, dp.Subtotal, p.Estado FROM PEDIDO p JOIN CLIENTE c ON p.Id_Cliente = c.Id_Cliente JOIN DETALLE_PEDIDO dp ON p.Id_Pedido = dp.Id_Pedido JOIN PRODUCTO pr ON dp.Id_Producto = pr.Id_Producto;
GO
CREATE VIEW vw_ReporteIngresosPorEstado AS SELECT p.Estado, COUNT(DISTINCT p.Id_Pedido) AS Cantidad_Pedidos, COUNT(DISTINCT c.Id_Cliente) AS Clientes_Atendidos, SUM(dp.Cantidad) AS Productos_Movidos, SUM(dp.Subtotal) AS Dinero_Recaudado FROM PEDIDO p JOIN CLIENTE c ON p.Id_Cliente = c.Id_Cliente JOIN DETALLE_PEDIDO dp ON p.Id_Pedido = dp.Id_Pedido GROUP BY p.Estado;
GO


-- AVANCE 03: ÍNDICES

CREATE NONCLUSTERED INDEX idx_Cliente_Nombre ON CLIENTE (Nombre);
CREATE NONCLUSTERED INDEX idx_Pedido_IdCliente ON PEDIDO (Id_Cliente);
CREATE NONCLUSTERED INDEX idx_Pedido_Estado ON PEDIDO (Estado);
CREATE NONCLUSTERED INDEX idx_Detalle_IdProducto ON DETALLE_PEDIDO (Id_Producto);
CREATE NONCLUSTERED INDEX idx_Pedido_FechaCreacion ON PEDIDO (Fecha_Hora_Creacion);
GO

