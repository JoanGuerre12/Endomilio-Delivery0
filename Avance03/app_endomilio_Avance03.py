import tkinter as tk
from tkinter import ttk, messagebox
import pyodbc

# ==========================================
# 1. CONFIGURACIÓN DE CONEXIÓN
# ==========================================
connection_string = (
    'Driver={ODBC Driver 18 for SQL Server};'
    'Server=tcp:server-endomilio-2026.database.windows.net,1433;'
    'Database=BD_Endomilio;'
    'Uid=admin_endomilio;'
    'Pwd=CorazonDoki12;'
    'Encrypt=yes;'
    'TrustServerCertificate=no;'
    'Connection Timeout=30;'
)


def ejecutar_consulta(query):
    try:
        conn = pyodbc.connect(connection_string, timeout=10)
        cursor = conn.cursor()
        cursor.execute(query)
        filas = cursor.fetchall()
        columnas = [column[0] for column in cursor.description]
        conn.close()
        return columnas, filas
    except Exception as e:
        messagebox.showerror("Error de Conexión", f"No se pudo conectar a Azure:\n{e}")
        return None, None


def ejecutar_accion(query, parametros):
    try:
        conexion = pyodbc.connect(connection_string)
        cursor = conexion.cursor()
        cursor.execute(query, parametros)
        conexion.commit()
        conexion.close()
        return True
    except Exception as e:
        messagebox.showerror("Error BD", f"Ocurrió un error:\n{e}")
        return False


def crear_tabla(ventana, columnas, filas):
    tree = ttk.Treeview(ventana, columns=columnas, show='headings')
    for col in columnas:
        tree.heading(col, text=col)
        tree.column(col, anchor="center")

    for fila in filas:
        tree.insert("", tk.END, values=list(fila))
    tree.pack(expand=True, fill='both', padx=20, pady=10)


# ==========================================
# 2. MÓDULOS DE LECTURA (R)
# ==========================================
def mostrar_pantalla_productos():
    ventana_prod = tk.Toplevel(root)
    ventana_prod.title("Menú de Productos - Endomilio")
    ventana_prod.geometry("600x300")
    tk.Label(ventana_prod, text="Catálogo de Productos Activos", font=("Arial", 14, "bold")).pack(pady=10)

    query = "SELECT Id_Producto, Nombre_Producto, Precio, Estado_Activo FROM PRODUCTO WHERE Estado_Activo = 'S'"
    columnas, filas = ejecutar_consulta(query)
    if columnas:
        crear_tabla(ventana_prod, columnas, filas)


def mostrar_pantalla_pedidos():
    ventana_pedidos = tk.Toplevel(root)
    ventana_pedidos.title("Estado de Pedidos - Endomilio")
    ventana_pedidos.geometry("850x350")
    tk.Label(ventana_pedidos, text="Monitor General de Pedidos", font=("Arial", 14, "bold")).pack(pady=10)

    query = """
            SELECT P.Id_Pedido, C.Nombre AS Cliente, P.Fecha_Hora_Creacion, P.Monto_Total, P.Estado
            FROM PEDIDO P
            JOIN CLIENTE C ON P.Id_Cliente = C.Id_Cliente
            """
    columnas, filas = ejecutar_consulta(query)

    if columnas and filas:
        tree = ttk.Treeview(ventana_pedidos, columns=columnas, show='headings')
        for col in columnas:
            tree.heading(col, text=col)
            tree.column(col, anchor="center", width=140)

        for fila in filas:
            tree.insert("", tk.END, values=list(fila))
        tree.pack(expand=True, fill='both', padx=20, pady=10)
    else:
        tk.Label(ventana_pedidos, text="No se encontraron registros de pedidos.", fg="gray").pack(pady=20)


def ver_detalle_pedido():
    ventana_ver = tk.Toplevel(root)
    ventana_ver.title("Ver Contenido del Pedido")
    ventana_ver.geometry("600x400")

    tk.Label(ventana_ver, text="Ingresa el ID del Pedido (Ej. PED-000009):", font=("Arial", 10, "bold")).pack(
        pady=(15, 5))
    txt_id_buscar = tk.Entry(ventana_ver)
    txt_id_buscar.pack()

    def buscar_detalle():
        id_ped = txt_id_buscar.get()
        query = f"""
            SELECT DP.Id_Pedido, P.Nombre_Producto, DP.Cantidad, P.Precio, DP.Subtotal
            FROM DETALLE_PEDIDO DP
            JOIN PRODUCTO P ON DP.Id_Producto = P.Id_Producto
            WHERE DP.Id_Pedido = '{id_ped}'
        """
        columnas, filas = ejecutar_consulta(query)
        if filas:
            crear_tabla(ventana_ver, columnas, filas)
        else:
            messagebox.showinfo("Información", "Este pedido está vacío o no existe.")

    tk.Button(ventana_ver, text="Buscar Productos", command=buscar_detalle, bg="lightblue").pack(pady=15)


# ==========================================
# 3. MÓDULOS TRANSACCIONALES (C, U, D)
# ==========================================
def abrir_crud_productos():
    ventana_prod = tk.Toplevel(root)
    ventana_prod.title("Gestión de Productos (CRUD)")
    ventana_prod.geometry("400x320")

    tk.Label(ventana_prod, text="ID Producto (Ej. P0011):").pack(pady=(10, 0))
    txt_id = tk.Entry(ventana_prod)
    txt_id.pack()

    tk.Label(ventana_prod, text="Nombre del Producto:").pack()
    txt_nombre = tk.Entry(ventana_prod)
    txt_nombre.pack()

    tk.Label(ventana_prod, text="Precio (Ej. 5.50):").pack()
    txt_precio = tk.Entry(ventana_prod)
    txt_precio.pack()

    tk.Label(ventana_prod, text="Estado Activo (S/N):").pack()
    txt_estado = tk.Entry(ventana_prod)
    txt_estado.pack()

    def insertar():
        query = "EXEC sp_InsertarProducto ?, ?, ?, ?"
        params = (txt_id.get(), txt_nombre.get(), float(txt_precio.get()), txt_estado.get())
        if ejecutar_accion(query, params):
            messagebox.showinfo("Éxito", "Producto añadido correctamente.")

    def actualizar():
        query = "EXEC sp_ActualizarProducto ?, ?, ?, ?"
        params = (txt_id.get(), txt_nombre.get(), float(txt_precio.get()), txt_estado.get())
        if ejecutar_accion(query, params):
            messagebox.showinfo("Éxito", "Producto actualizado correctamente.")

    def eliminar():
        query = "EXEC sp_EliminarProducto ?"
        params = (txt_id.get(),)
        if ejecutar_accion(query, params):
            messagebox.showinfo("Éxito", "Producto eliminado correctamente.")

    frame_botones = tk.Frame(ventana_prod)
    frame_botones.pack(pady=15)
    tk.Button(frame_botones, text="Añadir", command=insertar, bg="lightgreen").grid(row=0, column=0, padx=5)
    tk.Button(frame_botones, text="Actualizar", command=actualizar, bg="lightblue").grid(row=0, column=1, padx=5)
    tk.Button(frame_botones, text="Eliminar", command=eliminar, bg="salmon").grid(row=0, column=2, padx=5)


def abrir_crud_detalle():
    ventana_det = tk.Toplevel(root)
    ventana_det.title("Asignar Productos (Muchos a Muchos)")
    ventana_det.geometry("400x250")

    tk.Label(ventana_det, text="ID del Pedido (Debe existir, ej. PED-000001):").pack(pady=(10, 0))
    txt_id_pedido = tk.Entry(ventana_det)
    txt_id_pedido.pack()

    tk.Label(ventana_det, text="ID del Producto (Debe existir, ej. P0001):").pack()
    txt_id_producto_det = tk.Entry(ventana_det)
    txt_id_producto_det.pack()

    tk.Label(ventana_det, text="Cantidad a comprar:").pack()
    txt_cantidad = tk.Entry(ventana_det)
    txt_cantidad.pack()

    def insertar_detalle():
        try:
            conexion = pyodbc.connect(connection_string)
            cursor = conexion.cursor()

            # Validación de Reglas de Negocio (Ciclo de Vida)
            cursor.execute("SELECT Estado FROM PEDIDO WHERE Id_Pedido = ?", (txt_id_pedido.get(),))
            resultado_estado = cursor.fetchone()

            if not resultado_estado:
                messagebox.showwarning("Error", "El Pedido no existe en el sistema.")
                conexion.close()
                return

            estado_actual = resultado_estado[0]
            if estado_actual == 'Entregado' or estado_actual == 'Cancelado':
                messagebox.showerror("Operación Denegada",
                                     f"No se pueden asignar productos. Este pedido ya se encuentra {estado_actual}.")
                conexion.close()
                return

            # Obtención de precio y cálculo
            cursor.execute("SELECT Precio FROM PRODUCTO WHERE Id_Producto = ?", (txt_id_producto_det.get(),))
            resultado_precio = cursor.fetchone()

            if not resultado_precio:
                messagebox.showwarning("Error", "El Producto no existe en el catálogo.")
                conexion.close()
                return

            precio_unitario = float(resultado_precio[0])
            cantidad = int(txt_cantidad.get())
            subtotal = precio_unitario * cantidad

            # Inserción final
            query_insert = "INSERT INTO DETALLE_PEDIDO (Id_Pedido, Id_Producto, Cantidad, Subtotal) VALUES (?, ?, ?, ?)"
            cursor.execute(query_insert, (txt_id_pedido.get(), txt_id_producto_det.get(), cantidad, subtotal))
            conexion.commit()
            conexion.close()
            messagebox.showinfo("Éxito", f"Detalle agregado. Subtotal: ${subtotal:.2f}")

        except Exception as e:
            messagebox.showerror("Error", f"Fallo al agregar detalle:\n{e}")

    def eliminar_detalle():
        query = "DELETE FROM DETALLE_PEDIDO WHERE Id_Pedido = ? AND Id_Producto = ?"
        params = (txt_id_pedido.get(), txt_id_producto_det.get())
        if ejecutar_accion(query, params):
            messagebox.showinfo("Éxito", "Producto removido del pedido.")

    frame_bot_det = tk.Frame(ventana_det)
    frame_bot_det.pack(pady=15)
    tk.Button(frame_bot_det, text="Añadir al Pedido", command=insertar_detalle, bg="lightgreen").grid(row=0, column=0,
                                                                                                      padx=5)
    tk.Button(frame_bot_det, text="Quitar del Pedido", command=eliminar_detalle, bg="salmon").grid(row=0, column=1,
                                                                                                   padx=5)


# ==========================================
# 4. VENTANA PRINCIPAL (MENÚ)
# ==========================================
root = tk.Tk()
root.title("Sistema Gestor - Endomilio Delivery")
root.geometry("400x380")

tk.Label(root, text="Panel de Administración", font=("Arial", 16, "bold")).pack(pady=(20, 5))
tk.Label(root, text="Conectado a Azure SQL Database", fg="green").pack(pady=(0, 15))

btn_productos = tk.Button(root, text="📦 Ver Menú de Productos", command=mostrar_pantalla_productos, width=30, height=1)
btn_productos.pack(pady=5)

btn_pedidos = tk.Button(root, text="🛵 Ver Monitor de Pedidos", command=mostrar_pantalla_pedidos, width=30, height=1)
btn_pedidos.pack(pady=5)

btn_ver_det = tk.Button(root, text="🔎 Ver Contenido de un Pedido", command=ver_detalle_pedido, width=30, height=1)
btn_ver_det.pack(pady=5)

ttk.Separator(root, orient='horizontal').pack(fill='x', padx=50, pady=15)

btn_crud_prod = tk.Button(root, text="⚙️ Administrar Productos", command=abrir_crud_productos, width=30, height=1,
                          bg="#e0e0e0")
btn_crud_prod.pack(pady=5)

btn_crud_det = tk.Button(root, text="🔗 Asignar Productos a Pedido", command=abrir_crud_detalle, width=30, height=1,
                         bg="#e0e0e0")
btn_crud_det.pack(pady=5)

root.mainloop()

btn_crud_det = tk.Button(root, text="🔗 Asignar Productos a Pedido", command=abrir_crud_detalle, width=30, height=1, bg="#e0e0e0")
btn_crud_det.pack(pady=5)

root.mainloop()
