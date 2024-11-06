<?php
session_start();
// Configuración de la conexión
$servername = "localhost";  
$username = "root";         
$password = "";             
$dbname = "reptek";  

// Crear la conexión
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar la conexión
if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}

include '../modules/navbar.php';

// Verificar si el usuario está logueado
if (!isset($_SESSION['usuario'])) {
    // Si no hay sesión activa, redirigir a la página de login
    header("Location: login.php");
    exit();  // Asegurarse de que no se ejecute más código
}

$nombre_cliente = "";  // Inicializamos la variable para mostrar el resultado
$error_msg = "";  // Para almacenar posibles errores

// Verificar si el formulario fue enviado y el campo 'nombre' fue rellenado
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_POST['nombre']) && !empty($_POST['nombre'])) {
        $nombre_ingresado = $_POST['nombre'];  // Recibir el nombre ingresado en el formulario

        // Llamar a la rutina "ListarClientePorNombre" desde MySQL
        $sql = "CALL ListarClientePorNombre(?)";  // Llamada a la rutina

        // Preparar la consulta
        if ($stmt = $conn->prepare($sql)) {
            $stmt->bind_param("s", $nombre_ingresado);  // Enlazar el parámetro 'Nomb'
            $stmt->execute();
            $result = $stmt->get_result();

            // Verificar si se encontraron resultados
            if ($result->num_rows > 0) {
                $row = $result->fetch_assoc();
                $nombre_cliente = $row["Nombre"];
            } else {
                $nombre_cliente = "No se encontró ningún cliente con ese nombre.";
            }

            // Cerrar la declaración
            $stmt->close();
        } else {
            $error_msg = "Error al preparar la declaración: " . $conn->error;
        }
    } else {
        $error_msg = "Por favor ingrese un nombre.";
    }
}

// Cerrar la conexión
$conn->close();
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reptek</title>
    <style>
        .cliente {
            color: red;
            font-weight: bold;
        }
        .error {
            color: red;
        }
    </style>
</head>
<body>

    <h1>Buscar Cliente</h1>

    <!-- Mostrar errores, si existen -->
    <?php if (!empty($error_msg)): ?>
        <p class="error"><?php echo $error_msg; ?></p>
    <?php endif; ?>

    <!-- Formulario para ingresar el nombre del cliente -->
    <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
        <label for="nombre">Nombre del cliente:</label>
        <input type="text" id="nombre" name="nombre" required>
        <button type="submit">Buscar</button>
    </form>

    <!-- Mostrar el resultado de la búsqueda -->
    <?php if (!empty($nombre_cliente)): ?>
        <p class="cliente"><?php echo $nombre_cliente; ?></p>
    <?php endif; ?>

</body>
</html>
