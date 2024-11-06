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
    header("Location: login.php");
    exit();
}

// Parámetros de búsqueda opcionales
$numOT = $_GET['NumOT'] ?? null;
$fechaIngreso = $_GET['Fecha_ingreso'] ?? null;
$fechaEgreso = $_GET['Fecha_egreso'] ?? null;
$descTecnico = $_GET['Descripcion_tecnico'] ?? null;
$descCliente = $_GET['Descripcion_cliente'] ?? null;
$estadoId = $_GET['Estado_id'] ?? null;
$tecnicoId = $_GET['Tecnico_id'] ?? null;

// Ejecutar la rutina de búsqueda
$sql = "CALL BuscarTrabajos(?, ?, ?, ?, ?, ?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("sssssss", $numOT, $fechaIngreso, $fechaEgreso, $descTecnico, $descCliente, $estadoId, $tecnicoId);
$stmt->execute();
$result = $stmt->get_result();

// Ejecutar crear trabajo

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["crearTrabajo"])) {
    $numOT = $_POST['NumOT'];
    $fechaIngreso = $_POST['Fecha_ingreso'];
    $fechaEgreso = $_POST['Fecha_egreso'];
    $clienteId = $_POST['Cliente_id'];
    $precio = $_POST['Precio'];
    $descripcionTecnico = $_POST['Descripcion_tecnico'];
    $descripcionCliente = $_POST['Descripcion_cliente'];
    $usuarioId = $_POST['Usuario_id'];
    $tecnicoId = $_POST['Tecnico_id'];
    $estadoId = $_POST['Estado_id'];

    // Llamar a la rutina almacenada para agregar un trabajo
    $sql = "CALL AgregarTrabajo(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("isssisiiii", $numOT, $fechaIngreso, $fechaEgreso, $clienteId, $precio, $descripcionTecnico, $descripcionCliente, $usuarioId, $tecnicoId, $estadoId);
    $stmt->execute();
    $stmt->close();
    header("Location: index.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reptek - Lista de Trabajos</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
    <div class="container mt-5">
        <div class="text-right mb-3">
            <!-- Botón de búsqueda con ícono de lupa -->
            <button class="btn btn-primary" data-toggle="modal" data-target="#searchModal">
                <i class="fas fa-search"></i> Buscar
            </button>
        </div>
        <!-- Botón de crear trabajo -->
        <button class="btn btn-success" data-toggle="modal" data-target="#createModal">
                <i class="fas fa-plus"></i> Crear Trabajo
            </button>

        <h2 class="text-center">Lista de Trabajos</h2>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Número de OT</th>
                    <th>Fecha de Ingreso</th>
                    <th>Fecha de Egreso</th>
                    <th>Descripción del Técnico</th>
                    <th>Descripción del Cliente</th>
                    <th>ID de Estado</th>
                    <th>ID de Técnico</th>
                </tr>
            </thead>
            <tbody>
                <?php if ($result && $result->num_rows > 0): ?>
                    <?php while($row = $result->fetch_assoc()): ?>
                        <tr>
                            <td><?php echo $row['NumOT']; ?></td>
                            <td><?php echo $row['Fecha_ingreso']; ?></td>
                            <td><?php echo $row['Fecha_egreso']; ?></td>
                            <td><?php echo $row['Descripcion_tecnico']; ?></td>
                            <td><?php echo $row['Descripcion_cliente']; ?></td>
                            <td><?php echo $row['Estado_id']; ?></td>
                            <td><?php echo $row['Tecnico_id']; ?></td>
                        </tr>
                    <?php endwhile; ?>
                <?php else: ?>
                    <tr>
                        <td colspan="7" class="text-center">No hay trabajos registrados.</td>
                    </tr>
                <?php endif; ?>
            </tbody>
        </table>
    </div>

    <!-- Modal de búsqueda -->
    <div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="searchModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="index.php" method="GET">
                    <div class="modal-header">
                        <h5 class="modal-title" id="searchModalLabel">Buscar Trabajos</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="NumOT">Número de OT</label>
                            <input type="text" class="form-control" name="NumOT" id="NumOT">
                        </div>
                        <div class="form-group">
                            <label for="Fecha_ingreso">Fecha de Ingreso</label>
                            <input type="date" class="form-control" name="Fecha_ingreso" id="Fecha_ingreso">
                        </div>
                        <div class="form-group">
                            <label for="Fecha_egreso">Fecha de Egreso</label>
                            <input type="date" class="form-control" name="Fecha_egreso" id="Fecha_egreso">
                        </div>
                        <div class="form-group">
                            <label for="Descripcion_tecnico">Descripción del Técnico</label>
                            <input type="text" class="form-control" name="Descripcion_tecnico" id="Descripcion_tecnico">
                        </div>
                        <div class="form-group">
                            <label for="Descripcion_cliente">Descripción del Cliente</label>
                            <input type="text" class="form-control" name="Descripcion_cliente" id="Descripcion_cliente">
                        </div>
                        <div class="form-group">
                            <label for="Estado_id">ID de Estado</label>
                            <input type="text" class="form-control" name="Estado_id" id="Estado_id">
                        </div>
                        <div class="form-group">
                            <label for="Tecnico_id">ID de Técnico</label>
                            <input type="text" class="form-control" name="Tecnico_id" id="Tecnico_id">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Buscar</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- Modal para crear un trabajo -->
    <div class="modal fade" id="createModal" tabindex="-1" aria-labelledby="createModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="index.php" method="POST">
                        <div class="modal-header">
                            <h5 class="modal-title" id="createModalLabel">Crear Nuevo Trabajo</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="NumOT">Número de OT</label>
                                <input type="text" class="form-control" name="NumOT" id="NumOT" required>
                            </div>
                            <div class="form-group">
                                <label for="Fecha_ingreso">Fecha de Ingreso</label>
                                <input type="date" class="form-control" name="Fecha_ingreso" id="Fecha_ingreso" required>
                            </div>
                            <div class="form-group">
                                <label for="Fecha_egreso">Fecha de Egreso</label>
                                <input type="date" class="form-control" name="Fecha_egreso" id="Fecha_egreso">
                            </div>
                            <div class="form-group">
                                <label for="Cliente_id">ID del Cliente</label>
                                <input type="number" class="form-control" name="Cliente_id" id="Cliente_id" required>
                            </div>
                            <div class="form-group">
                                <label for="Precio">Precio</label>
                                <input type="number" step="0.01" class="form-control" name="Precio" id="Precio" required>
                            </div>
                            <div class="form-group">
                                <label for="Descripcion_tecnico">Descripción del Técnico</label>
                                <input type="text" class="form-control" name="Descripcion_tecnico" id="Descripcion_tecnico">
                            </div>
                            <div class="form-group">
                                <label for="Descripcion_cliente">Descripción del Cliente</label>
                                <input type="text" class="form-control" name="Descripcion_cliente" id="Descripcion_cliente">
                            </div>
                            <div class="form-group">
                                <label for="Usuario_id">ID del Usuario</label>
                                <input type="number" class="form-control" name="Usuario_id" id="Usuario_id" required>
                            </div>
                            <div class="form-group">
                                <label for="Tecnico_id">ID del Técnico</label>
                                <input type="number" class="form-control" name="Tecnico_id" id="Tecnico_id" required>
                            </div>
                            <div class="form-group">
                                <label for="Estado_id">ID de Estado</label>
                                <input type="number" class="form-control" name="Estado_id" id="Estado_id" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" name="crearTrabajo" class="btn btn-success">Guardar Trabajo</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<?php
// Cerrar la conexión
$stmt->close();
$conn->close();
?>
