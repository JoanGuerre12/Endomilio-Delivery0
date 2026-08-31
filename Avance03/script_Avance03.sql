-- 1. CREACION DE LAS TABLAS
CREATE TABLE CLIENTE (
    Id_Cliente CHAR(10) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Telefono CHAR(10) NOT NULL,
    Direccion_Entrega VARCHAR(100) NOT NULL
);

CREATE TABLE REPARTIDOR (
    Id_Repartidor CHAR(5) PRIMARY KEY,
    Nombre_Repartidor VARCHAR(50) NOT NULL,
    Medio_Transporte VARCHAR(20) NOT NULL,
    Numero_Placa VARCHAR(15)
);

CREATE TABLE CALIFICACION (
    Id_Calificacion CHAR(10) PRIMARY KEY,
    Id_Pedido CHAR(10) NOT NULL,
    Id_Cliente CHAR(10) NOT NULL,
    Puntuacion INT NOT NULL,
    Comentario VARCHAR(100) NULL,
    FOREIGN KEY (Id_Pedido) REFERENCES PEDIDO(Id_Pedido),
    FOREIGN KEY (Id_Cliente) REFERENCES CLIENTE(Id_Cliente)
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

CREATE TABLE PAGO (
    Id_Pago CHAR(10) PRIMARY KEY,
    Id_Pedido CHAR(10) NOT NULL,
    Id_Cliente CHAR(10) NOT NULL,
    Monto DECIMAL(6,2) NOT NULL,
    Metodo_Pago VARCHAR(20) NOT NULL,
    Comprobante VARCHAR(50) NOT NULL,
    FOREIGN KEY (Id_Pedido) REFERENCES PEDIDO(Id_Pedido),
    FOREIGN KEY (Id_Cliente) REFERENCES CLIENTE(Id_Cliente)
-- 2. INSERCIÓN DE DATOS INICIALES


-- Insertar Clientes
-- Inserción de Registros: Tabla CLIENTE
INSERT INTO CLIENTE VALUES 
('0912345671', 'Carlos Mendoza', '0991234561', 'Urdesa Central, Calle 1'),
('0912345672', 'Ana Torres', '0991234562', 'Ceibos Norte, Mz 4'),
('0912345673', 'Luis Silva', '0991234563', 'Alborada 12ava Etapa'),
('0912345674', 'Maria Gomez', '0991234564', 'Garzota 2, Mz 15'),
('0912345675', 'Jorge Ruiz', '0991234565', 'Samanes 4, Villa 10'),
('0912345676', 'Elena Castro', '0991234566', 'Vía a la Costa, Km 10'),
('0912345677', 'Pedro Vera', '0991234567', 'Sauces 8, Mz 20'),
('0912345678', 'Lucia Ortiz', '0991234568', 'Puerto Santa Ana, Edificio 3'),
('0912345679', 'Andres Lopez', '0991234569', 'Sur, Barrio del Seguro'),
('0912345670', 'Diana Mora', '0991234560', 'Mucho Lote 2, Etapa 1');

-- Inserción de Registros: Tabla REPARTIDOR
INSERT INTO REPARTIDOR VALUES 
('R0001', 'Juan Perez', 'Moto', 'GBA-1234'),
('R0002', 'Miguel Santos', 'Moto', 'GBC-5678'),
('R0003', 'Jose Reyes', 'Bicicleta', NULL),
('R0004', 'David Macias', 'Moto', 'GBE-9012'),
('R0005', 'Kevin Leon', 'Auto', 'GSY-3456'),
('R0006', 'Bryan Cruz', 'Moto', 'GBZ-7890'),
('R0007', 'Victor Peña', 'Bicicleta', NULL),
('R0008', 'Alex Velez', 'Moto', 'GBL-1122'),
('R0009', 'Daniel Franco', 'Auto', 'GSP-3344'),
('R0010', 'Oscar Solis', 'Moto', 'GBM-5566');

-- Inserción de Registros: Tabla PRODUCTO
INSERT INTO PRODUCTO VALUES 
('P0001', 'Combo 10 Alitas BBQ', 12.50, 'S'),
('P0002', 'Combo 15 Alitas Buffalo', 16.00, 'S'),
('P0003', 'Hamburguesa Clásica', 6.50, 'S'),
('P0004', 'Hamburguesa Doble', 8.50, 'S'),
('P0005', 'Papas Fritas Medianas', 2.50, 'S'),
('P0006', 'Papas Fritas Grandes', 3.50, 'S'),
('P0007', 'Gaseosa 1 Litro', 2.00, 'S'),
('P0008', 'Limonada Frapeada', 3.00, 'S'),
('P0009', 'Combo Familiar (30 Alitas)', 28.00, 'S'),
('P0010', 'Helado de Vainilla', 2.50, 'N');

-- Inserción de Registros: Tabla PEDIDO
INSERT INTO PEDIDO VALUES 
('PED-000001', '0912345671', 'R0001', '2026-07-15 19:00:00', '2026-07-15 19:45:00', 12.50, 'Entregado', 'Urdesa Central, Calle 1', NULL, NULL, NULL),
('PED-000002', '0912345672', 'R0002', '2026-07-15 19:10:00', '2026-07-15 19:50:00', 16.00, 'Entregado', 'Ceibos Norte, Mz 4', NULL, NULL, NULL),
('PED-000003', '0912345673', NULL, '2026-07-15 20:00:00', NULL, 8.50, 'Cancelado', 'Alborada 12ava Etapa', 'Cliente no respondio', NULL, NULL),
('PED-000004', '0912345674', 'R0004', '2026-07-16 18:30:00', '2026-07-16 19:10:00', 30.50, 'Entregado', 'Garzota 2, Mz 15', NULL, 'DESC-2.5', 2.50),
('PED-000005', '0912345675', 'R0005', '2026-07-16 19:00:00', '2026-07-16 19:30:00', 6.50, 'Entregado', 'Samanes 4, Villa 10', NULL, NULL, NULL),
('PED-000006', '0912345676', 'R0006', '2026-07-17 20:15:00', '2026-07-17 21:00:00', 14.50, 'Entregado', 'Vía a la Costa, Km 10', NULL, NULL, NULL),
('PED-000007', '0912345677', 'R0007', '2026-07-18 12:00:00', '2026-07-18 12:40:00', 9.00, 'Entregado', 'Sauces 8, Mz 20', NULL, NULL, NULL),
('PED-000008', '0912345678', NULL, '2026-07-18 19:00:00', NULL, 28.00, 'Pendiente', 'Puerto Santa Ana', NULL, NULL, NULL),
('PED-000009', '0912345679', 'R0009', '2026-07-18 19:05:00', NULL, 12.50, 'En camino', 'Sur, Barrio del Seguro', NULL, NULL, NULL),
('PED-000010', '0912345670', 'R0010', '2026-07-18 19:10:00', '2026-07-18 19:55:00', 21.00, 'Entregado', 'Mucho Lote 2, Etapa 1', NULL, 'PROMO-5', 5.00);

-- Inserción de Registros: Tabla DETALLE_PEDIDO
INSERT INTO DETALLE_PEDIDO VALUES 
('PED-000001', 'P0001', 1, 12.50),
('PED-000002', 'P0002', 1, 16.00),
('PED-000003', 'P0004', 1, 8.50),
('PED-000004', 'P0009', 1, 28.00),
('PED-000004', 'P0005', 1, 2.50),
('PED-000005', 'P0003', 1, 6.50),
('PED-000006', 'P0001', 1, 12.50),
('PED-000006', 'P0007', 1, 2.00),
('PED-000007', 'P0003', 1, 6.50),
('PED-000007', 'P0005', 1, 2.50);

-- Inserción de Registros: Tabla PAGO
INSERT INTO PAGO VALUES 
('PAG-000001', 'PED-000001', '0912345671', 12.50, 'Transferencia', 'REF-998877'),
('PAG-000002', 'PED-000002', '0912345672', 16.00, 'Tarjeta', 'VOU-123456'),
('PAG-000003', 'PED-000004', '0912345674', 28.00, 'Efectivo', 'REC-001'),
('PAG-000004', 'PED-000005', '0912345675', 6.50, 'Transferencia', 'REF-998878'),
('PAG-000005', 'PED-000006', '0912345676', 14.50, 'Tarjeta', 'VOU-123457'),
('PAG-000006', 'PED-000007', '0912345677', 9.00, 'Efectivo', 'REC-002'),
('PAG-000007', 'PED-000008', '0912345678', 28.00, 'Transferencia', 'REF-998879'),
('PAG-000008', 'PED-000009', '0912345679', 12.50, 'Tarjeta', 'VOU-123458'),
('PAG-000009', 'PED-000010', '0912345670', 16.00, 'Tarjeta', 'VOU-123459'),
('PAG-000010', 'PED-000004', '0912345674', 2.50, 'Efectivo', 'REC-003');

-- Inserción de Registros: Tabla CALIFICACION
INSERT INTO CALIFICACION VALUES 
('CAL-000001', 'PED-000001', '0912345671', 5, 'Excelente servicio y rapidos'),
('CAL-000002', 'PED-000002', '0912345672', 4, 'Todo bien pero falto servilletas'),
('CAL-000003', 'PED-000004', '0912345674', 5, 'Las mejores alitas'),
('CAL-000004', 'PED-000005', '0912345675', 5, 'Buena hamburguesa'),
('CAL-000005', 'PED-000006', '0912345676', 3, 'Llego un poco frio'),
('CAL-000006', 'PED-000007', '0912345677', 5, 'Muy amables'),
('CAL-000007', 'PED-000010', '0912345670', 4, 'Buena promo'),
('CAL-000008', 'PED-000001', '0912345671', 5, 'Volvere a pedir'),
('CAL-000009', 'PED-000002', '0912345672', 5, 'Recomendado'),
('CAL-000010', 'PED-000004', '0912345674', 5, '10/10');

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
-- ====================================================
-- AVANCE 03: USUARIOS Y PERMISOS
-- ====================================================
CREATE USER User_Gerente WITH PASSWORD = 'PasswordSeguro2026*';
CREATE USER User_Cajero WITH PASSWORD = 'PasswordSeguro2026*';
CREATE USER User_Atencion WITH PASSWORD = 'PasswordSeguro2026*';
CREATE USER User_Analista WITH PASSWORD = 'PasswordSeguro2026*';
CREATE USER User_Auditor WITH PASSWORD = 'PasswordSeguro2026*';
GO
GRANT EXECUTE ON OBJECT::sp_InsertarProducto TO User_Gerente;
GRANT SELECT ON OBJECT::vw_ReporteVentasPorCliente TO User_Gerente;
GRANT EXECUTE ON OBJECT::sp_ActualizarProducto TO User_Cajero;
GRANT SELECT ON OBJECT::vw_ReporteHistorialDetallado TO User_Cajero;
GRANT SELECT ON OBJECT::CLIENTE TO User_Atencion;
GRANT SELECT ON OBJECT::vw_ReporteProductosMasVendidos TO User_Atencion;
GRANT SELECT ON OBJECT::vw_ReporteIngresosPorEstado TO User_Analista;
GRANT SELECT ON OBJECT::vw_ReporteVentasPorCliente TO User_Analista;
GRANT SELECT ON OBJECT::AUDITORIA_PRECIOS TO User_Auditor;
GRANT SELECT ON OBJECT::vw_ReporteIngresosPorEstado TO User_Auditor;
GO
