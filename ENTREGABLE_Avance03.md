# 📋 Documentación - Avance 03 (Endomilio Delivery)

## 🛠️ 1. Lógica de Base de Datos
*Procedimientos Almacenados (SPs) implementados para el CRUD:*
* Se crearon sp_InsertarProducto, sp_ActualizarProducto y sp_EliminarProducto con validaciones (ej. el precio debe ser > 0 usando THROW) y control de transacciones (COMMIT/ROLLBACK). El código de Python fue modificado para usar estos SPs en lugar de consultas SQL directas.

*Triggers implementados:*
* trg_ValidarPedidoEntregado (INSTEAD OF INSERT): Bloquea la alteración de órdenes que ya tienen el estado "Entregado" para proteger la integridad del negocio.
* trg_AuditoriaPrecio (AFTER UPDATE): Vigila la tabla Producto y guarda un historial automático en una tabla anexa si un precio es modificado.
