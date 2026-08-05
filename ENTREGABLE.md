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
1. Panel Principal

<img width="495" height="507" alt="image" src="https://github.com/user-attachments/assets/82f1340c-8636-4ee8-b015-de9efff169ba" />

Al ejecutar la aplicación, se mostrará la ventana principal que confirma la conexión a Azure SQL Database. Desde aquí, el usuario puede navegar a cuatro módulos principales divididos en Consultas y Acciones.

2. Módulo de Consultas 

<img width="742" height="407" alt="image" src="https://github.com/user-attachments/assets/10df18a5-406d-4db5-b79a-c1e511fa6801" />

Ver Menú de Productos:

Haga clic en el botón "Ver Menú de Productos".

Se abrirá una nueva ventana mostrando una tabla con el catálogo completo de productos disponibles, detallando su ID, Nombre, Precio y si se encuentran activos.

Ver Registro de Pedidos:

Haga clic en el botón "🛵 Ver Registro de Pedidos".

El sistema desplegará el historial completo de órdenes generadas, mostrando el ID del pedido, el nombre del cliente asociado, la fecha/hora de creación, el monto total a pagar y el estado actual del envío.

3. Módulo de Gestión 

<img width="496" height="427" alt="image" src="https://github.com/user-attachments/assets/79556316-21d7-4851-a3b1-9cc85caf2677" />

Administrar Productos:

Haga clic en el botón "Administrar Productos (CRUD)".

Se abrirá un formulario. Para registrar un nuevo plato al menú, llene los campos solicitados: ID Producto (ej. PR005), Nombre del Producto, Precio (ej. 5.50) y Estado Activo (S/N), y presione el botón verde "Añadir".

Para Actualizar el precio o nombre de un producto existente, ingrese el ID del producto que desea modificar, coloque los nuevos valores en las casillas correspondientes y presione el botón azul "Actualizar".

Para Eliminar un producto del catálogo, basta con ingresar su ID en la primera casilla y presionar el botón rojo "Eliminar".

4. Módulo de Asignación

<img width="395" height="177" alt="image" src="https://github.com/user-attachments/assets/d5dd8c21-1761-4e28-b004-17d938525799" />

Asignar Productos a Pedido:

Haga clic en el botón "🔗 Asignar Productos a Pedido".

Esta interfaz gestiona el detalle de cada orden. Para agregar un ítem, ingrese un ID de Pedido válido (previamente creado por un cliente) y un ID de Producto que exista en el catálogo.

Defina la Cantidad a comprar y presione el botón verde "Añadir al Pedido". El sistema calculará automáticamente el subtotal multiplicando el precio del producto por la cantidad ingresada y guardará el registro en la base de datos.

<img width="310" height="180" alt="image" src="https://github.com/user-attachments/assets/2b287509-e66c-4f19-b3c8-86cddd65d801" />

Si el cliente desea retirar un ítem de su orden, ingrese el ID del Pedido y el ID del Producto correspondiente, y presione el botón rojo "Quitar del Pedido".
---

## 🎥 Video Explicativo

En el siguiente video detallamos el trabajo realizado por cada uno de los integrantes del equipo.

🔗 **[Enlace al video de YouTube / Google Drive aquí]**

---

## 🚀 Puntos Extras Implementados

* ✅ **Control de Versiones:** Uso activo de GitHub para trabajo colaborativo. Se implementó un repositorio remoto donde todos los miembros del equipo realizaron commits integrando el código fuente en Python, el script SQL y la documentación, demostrando el manejo del historial de versiones.
* ✅ **Máquina Virtual / Azure:** [Si usaron Azure o máquina virtual local como pedía la rúbrica, expliquen brevemente aquí cómo lo ejecutaron o pongan capturas].
rama-B
Revisión de base de datos terminada por integrante B.
Reporte finalizado por el integrante A.
main
