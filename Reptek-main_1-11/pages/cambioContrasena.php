<?php
// Iniciar sesión
session_start();

// Configuración de la conexión
$servername = "localhost";
$username = "root";         // Cambia si tienes otro nombre de usuario en MySQL
$password = "";             // Cambia si tienes contraseña en MySQL
$dbname = "reptek";  

// Crear la conexión
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar la conexión
if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}

include '../modules/navbar.php';
// Inicializar mensaje de error o éxito
$msg = "";

// Verificar si el formulario fue enviado
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Recoger los valores del formulario
    $mail = $_POST['mail'];
    $telefono = $_POST['telefono'];
    $nuevaContrasena = $_POST['nuevaContrasena'];

    // Llamar a la rutina "CambiarContrasena" desde MySQL
    $sql = "CALL CambiarContrasena(?, ?, ?)";

    // Preparar la consulta
    if ($stmt = $conn->prepare($sql)) {
        // Enlazar parámetros
        $stmt->bind_param("sss", $mail, $telefono, $nuevaContrasena);

        // Ejecutar la consulta
        if ($stmt->execute()) {
            // Obtener el resultado de la rutina
            $result = $stmt->get_result();
            if ($result->num_rows > 0) {
                $row = $result->fetch_assoc();
                $msg = $row['resultado']; // Mostrar el resultado devuelto por la rutina
                // Redirigir a la página de inicio de sesión si la contraseña se cambió con éxito
                if ($msg == "Contraseña actualizada exitosamente") {
                    // Asegurarse de que no se ha enviado contenido HTML antes de la redirección
                    header("Location: login.php");
                    exit();
                }
            } else {
                $msg = "Error en los parámetros ingresados.";
            }
        } else {
            $msg = "Error al ejecutar la consulta: " . $stmt->error;
        }

        // Cerrar la declaración
        $stmt->close();
    } else {
        $msg = "Error al preparar la consulta: " . $conn->error;
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
    <title>Cambiar Contraseña</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background-color: #fff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
        }
        h1 {
            margin-bottom: 20px;
        }
        .msg {
            color: red;
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            background-color: #007BFF;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Cambiar Contraseña</h1>
        <!-- Mostrar mensaje de éxito o error -->
        <?php if (!empty($msg)): ?>
            <p class="msg"><?php echo $msg; ?></p>
        <?php endif; ?>
        <!-- Formulario para cambiar la contraseña -->
        <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
            <label for="mail">Correo:</label>
            <input type="text" id="mail" name="mail" required>
            <label for="telefono">Teléfono:</label>
            <input type="text" id="telefono" name="telefono" required>
            <label for="nuevaContrasena">Nueva Contraseña:</label>
            <input type="password" id="nuevaContrasena" name="nuevaContrasena" required>
            <button type="submit">Actualizar Contraseña</button>
        </form>
    </div>

</body>
</html>
