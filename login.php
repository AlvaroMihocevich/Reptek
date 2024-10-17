<?php
// Iniciar sesión
session_start();
// Verificar si el usuario ya ha iniciado sesión
if (isset($_SESSION['usuario'])) {
    // Redirigir a probando.php si la sesión está activa
    header("Location: probando.php");
    exit(); // Detener el script para evitar que se ejecute el resto
}

// Configuración de la conexión
$servername = "localhost";
$username = "root";         // Cambia si tienes otro nombre de usuario en MySQL
$password = "";             // Cambia si tienes contraseña en MySQL
$dbname = "grupouniversitar_reptek";  

// Crear la conexión
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar la conexión
if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}

// Inicializamos las variables de mensaje de error y usuario
$error_msg = "";

// Verificar si el formulario fue enviado
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_POST['usuario']) && isset($_POST['contrasena'])) {
        $usuario = $_POST['usuario'];
        $contrasena = $_POST['contrasena'];

        // Llamar a la rutina "LoginUsuario" desde MySQL
        $sql = "CALL LoginUsuario(?, ?)";

        // Preparar la consulta
        if ($stmt = $conn->prepare($sql)) {
            $stmt->bind_param("ss", $usuario, $contrasena);  // Enlazar parámetros
            $stmt->execute();
            $result = $stmt->get_result();

            if ($result->num_rows > 0) {
                $row = $result->fetch_assoc();
                $resultado_login = $row['resultado'];

                // Verificar si el login fue exitoso
                if ($resultado_login === 'Login exitoso') {
                    // Guardar la sesión del usuario
                    $_SESSION['usuario'] = $usuario;

                    // Redirigir a la página de inicio "probando.php"
                    header("Location: probando.php");
                    exit();  // Asegurarse de que no se ejecute más código
                } else {
                    // Mostrar el mensaje de error devuelto por la rutina
                    $error_msg = $resultado_login;
                }
            } else {
                $error_msg = "Error en la respuesta de la rutina.";
            }

            // Cerrar la declaración
            $stmt->close();
        } else {
            $error_msg = "Error al preparar la declaración: " . $conn->error;
        }
    } else {
        $error_msg = "Por favor, ingrese ambos campos.";
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
    <title>Login</title>
    <style>
        .error {
            color: red;
        }
    </style>
</head>
<body>

    <h1>Iniciar sesión</h1>

    <!-- Mostrar mensaje de error si existe -->
    <?php if (!empty($error_msg)): ?>
        <p class="error"><?php echo $error_msg; ?></p>
    <?php endif; ?>

    <!-- Formulario de login -->
    <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
        <label for="usuario">Usuario (Correo):</label>
        <input type="text" id="usuario" name="usuario" required>
        <br><br>
        <label for="contrasena">Contraseña:</label>
        <input type="password" id="contrasena" name="contrasena" required>
        <br><br>
        <button type="submit">Iniciar sesión</button>
    </form>

</body>
</html>
