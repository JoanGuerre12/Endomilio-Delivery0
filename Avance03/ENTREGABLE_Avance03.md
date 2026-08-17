# 📋 Documentación - Avance 03 (Endomilio Delivery)

##  1. Lógica de Base de Datos
*Procedimientos Almacenados (SPs) implementados para el CRUD:*
* Se crearon sp_InsertarProducto, sp_ActualizarProducto y sp_EliminarProducto con validaciones (ej. el precio debe ser > 0 usando THROW) y control de transacciones (COMMIT/ROLLBACK). El código de Python fue modificado para usar estos SPs en lugar de consultas SQL directas.

*Triggers implementados:*
* trg_ValidarPedidoEntregado (INSTEAD OF INSERT): Bloquea la alteración de órdenes que ya tienen el estado "Entregado" para proteger la integridad del negocio.
* trg_AuditoriaPrecio (AFTER UPDATE): Vigila la tabla Producto y guarda un historial automático en una tabla anexa si un precio es modificado.

* Markdown
##  2. Analítica y Optimización
*Reportes y Vistas creadas (Mínimo 3 tablas unidas):*
* vw_ReporteVentasPorCliente: Analiza a los mejores clientes (une Cliente, Pedido, Detalle).
* vw_ReporteProductosMasVendidos: Identifica el rendimiento del menú (une Producto, Detalle, Pedido).
* vw_ReporteHistorialDetallado: Sábana completa de operaciones (une Pedido, Cliente, Detalle, Producto).
* vw_ReporteIngresosPorEstado: Finanzas separadas por pedidos entregados o en camino.

*Índices añadidos y su justificación:*
1. idx_Cliente_Nombre: Acelera búsquedas de operadores por nombre exacto de cliente.
2. idx_Pedido_IdCliente: Optimiza los JOINs para ver el historial específico de un comprador.
3. idx_Pedido_Estado: Mejora la velocidad de los filtros operativos (ej. filtrar solo "En camino").
4. idx_Detalle_IdProducto: Agiliza los cálculos matemáticos agrupados sobre el rendimiento del menú.
5. idx_Pedido_FechaCreacion: Indexa la fecha para que auditorías mensuales eviten escanear toda la tabla.
## 🔐 3. Seguridad
**Control de Accesos (Usuarios y Permisos):**

| Usuario | Permiso 1 | Permiso 2 | Justificación |
| :--- | :--- | :--- | :--- |
| **User_Gerente** | `EXECUTE` en `sp_InsertarProducto` | `SELECT` en `vw_ReporteVentasPorCliente` | Agrega platos y ve ventas generales. |
| **User_Cajero** | `EXECUTE` en `sp_ActualizarProducto` | `SELECT` en `vw_ReporteHistorialDetallado` | Corrige precios y revisa historial. |
| **User_Atencion** | `SELECT` en `CLIENTE` | `SELECT` en `vw_ReporteProductosMasVendidos` | Revisa clientes y platos populares. |
| **User_Analista** | `SELECT` en `vw_ReporteIngresosPorEstado`| `SELECT` en `vw_ReporteVentasPorCliente` | Función 100% analítica con vistas. |
| **User_Auditor** | `SELECT` en `AUDITORIA_PRECIOS` | `SELECT` en `vw_ReporteIngresosPorEstado` | Audita historial de precios y estados. |

## 📱 4. Manual de Usuario

## 1. Interfaz Principal
Al ejecutar el sistema, el operador tiene acceso a un formulario centralizado para la gestión del catálogo de productos.
<img width="493" height="432" alt="image" src="https://github.com/user-attachments/assets/6df1df90-7684-4334-9fd9-6e051df4f83d" />

## 2. Registro de Nuevos Productos
Para añadir un ítem al menú, el usuario debe completar los campos obligatorios. El sistema se comunica con `sp_InsertarProducto` para guardar el registro.
<img width="375" height="183" alt="image" src="https://github.com/user-attachments/assets/e3c4e301-8540-4037-b7a3-1027b843235a" />
* **Actualización:** El operador puede modificar precios o nombres ingresando el ID del producto y los nuevos datos, ejecutando `sp_ActualizarProducto`.
* **Eliminación:** Solo se requiere el ID del producto para retirarlo del sistema mediante `sp_EliminarProducto`.

## 3. Validaciones y Seguridad del Sistema
La base de datos protege la integridad del negocio bloqueando errores de capa de usuario. Si un operador intenta ingresar un producto con precio cero o negativo, el sistema detiene la transacción y muestra una alerta visual.
<img width="492" height="433" alt="image" src="https://github.com/user-attachments/assets/3308283a-62b3-46a8-8004-14de3afb287f" />
<img width="510" height="208" alt="image" src="https://github.com/user-attachments/assets/2f96f32c-0c54-454c-960a-956513847433" />



