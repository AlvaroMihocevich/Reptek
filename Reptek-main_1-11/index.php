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

include 'modules/navbar.php';

// Verificar si el usuario está logueado
if (!isset($_SESSION['usuario'])) {
    // Si no hay sesión activa, redirigir a la página de login
    header("Location: login.php");
    exit();  // Asegurarse de que no se ejecute más código
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
<script>
        <?php if (isset($_SESSION['rol'])): ?>
            console.log("Rol del usuario: <?php echo $_SESSION['rol']; ?>");
        <?php endif; ?>
    </script>
    

</body>
</html>
