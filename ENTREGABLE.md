# Proyecto Endomilio - Delivery

Este repositorio contiene la implementación del proyecto de Sistemas de Bases de Datos, el cual incluye las operaciones CRUD para las tablas principales y las tablas generadas por relaciones de muchos a muchos.

## 👥 Integrantes del Equipo

* **Integrante 1 :** [Guerrero Bajaña Joan Alberto] - [Implementacíon del CRUD Y manual de usuario]
* **Integrante 2 :** [Jeremy Santiago Ambi Tapia] - [Documentación y README]
* **Integrante 3 :** [Franco Suarez Teddy Saul] - [Script de la Base de Datos]
* **Integrante 4 :** [Chavez Giler Galo Sebastian] - [Script de la Base de Datos]

---

## 📂 Entregables del Proyecto

### 1. Código Fuente
El código fuente de la aplicación (`app_endomilio.py`) y el script de la base de datos con los registros (`script_BD.sql`) se encuentran en la raíz de este repositorio.

### 2. Esquema de la Base de Datos
El proyecto cuenta con el siguiente esquema relacional estructurado para manejar las operaciones del delivery:

* **Tabla CLIENTE:** Almacena la información de los usuarios que realizan compras (Cédula/ID, Nombre, Teléfono y Dirección de entrega).
* **Tabla PRODUCTO:** Funciona como el catálogo del menú (ID del producto, Nombre, Precio y si está Activo).
* **Tabla PEDIDO:** Registra las órdenes generales generadas por los clientes (Incluye el Cliente, la Fecha/Hora, el Monto Total y el Estado del pedido, como "En camino" o "Entregado").
* **Tabla DETALLE_PEDIDO (Relación Muchos a Muchos):** Es la tabla que rompe la relación entre Pedidos y Productos. Detalla qué productos específicos y en qué cantidades van dentro de un pedido, calculando su subtotal.

### 3. Manual de Usuario (Nuevas Interfaces)
La aplicación cuenta con interfaces gráficas que permiten realizar operaciones CRUD (Crear, Leer, Actualizar y Eliminar) sobre la base de datos de Endomilio.

1. **Gestión de Clientes y Productos (Tablas Principales):**
   * **Añadir:** Permite registrar nuevos clientes con sus datos de contacto o agregar nuevos platos al catálogo de productos.
   * **Consultar:** Muestra la lista de clientes registrados y el menú de productos disponibles.
   * **Editar:** Permite actualizar la dirección de un cliente o cambiar el precio/estado de un producto.
   * **Eliminar:** Borra registros de clientes o productos (siempre y cuando no tengan pedidos asociados).

2. **Gestión de Pedidos (Relación Muchos a Muchos):**
   * **Crear Pedido:** Al generar una nueva orden, el sistema permite seleccionar el Cliente y luego ir añadiendo múltiples Productos al `DETALLE_PEDIDO`, calculando el subtotal por cantidad y el monto total final.
   * **Consultar y Actualizar:** Se pueden visualizar los pedidos históricos y actualizar su estado (por ejemplo, pasar de "En camino" a "Entregado").

---

## 🎥 Video Explicativo

En el siguiente video detallamos el trabajo realizado por cada uno de los integrantes del equipo (Duración máxima: 10 minutos).

🔗 **[Enlace al video de YouTube / Google Drive aquí]**

---

## 🚀 Puntos Extras Implementados

* ✅ **Control de Versiones:** Uso activo de GitHub para trabajo colaborativo.
* ✅ **Máquina Virtual / Azure:** [Si usaron Azure o máquina virtual local como pedía la rúbrica, expliquen brevemente aquí cómo lo ejecutaron o pongan capturas].
