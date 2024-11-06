<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
// Obtener el directorio base de forma dinámica
$baseDir = dirname(__DIR__);
$baseUrl = '/reptek-main'; // Cambia a '/' en producción

function url($path) {
    global $baseUrl;
    return $baseUrl . $path;
}

// Obtener el rol del usuario de la sesión
$rol = isset($_SESSION['rol']) ? $_SESSION['rol'] : null;
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="<?php echo url('/index.php'); ?>">Reptek</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" href="<?php echo url('/index.php'); ?>">Inicio</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo url('/pages/buscarClientes.php'); ?>">Buscar cliente</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo url('/pagina2.php'); ?>">Página 2</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<?php echo url('/pagina3.php'); ?>">Página 3</a>
                    </li>
                    <?php if ($rol == 1): ?>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Soy admin</a>
                        </li>
                    <?php elseif ($rol == 2): ?>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Soy operario</a>
                        </li>
                    <?php endif; ?>
                </ul>
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-person-circle"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                            <li><a class="dropdown-item" href="<?php echo url('/pages/cambioContrasena.php'); ?>">Perfil</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="<?php echo url('/logout.php'); ?>">Cerrar sesión</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
