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
-- Asumiendo que tu tabla se llama DETALLE_PEDIDO
INSERT INTO DETALLE_PEDIDO (Id_Pedido, Id_Producto, Cantidad, Subtotal) VALUES 
('PD-0001', 'PR001', 1, 5.50),
('PD-0001', 'PR003', 1, 1.50),
('PD-0002', 'PR002', 1, 6.00);


-- 2. INSERCION DE DATOS DE TESTEO
INSERT INTO CLIENTE VALUES 
('0912345671', 'Carlos Mendoza', '0991234561', 'Urdesa Central, Calle 1'),
('0912345672', 'Ana Torres', '0991234562', 'Ceibos Norte, Mz 4');

INSERT INTO PRODUCTO VALUES 
('P0001', 'Combo 10 Alitas BBQ', 12.50, 'S'),
('P0002', 'Hamburguesa Clasica', 6.50, 'S');

INSERT INTO PEDIDO VALUES 
('PED-000001', '0912345671', '2026-07-15 19:00:00', 12.50, 'Entregado'),
('PED-000002', '0912345672', '2026-07-15 19:10:00', 6.50, 'En camino');

INSERT INTO DETALLE_PEDIDO VALUES 
('PED-000001', 'P0001', 1, 12.50),
('PED-000002', 'P0002', 1, 6.50);
