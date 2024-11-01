-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-11-2024 a las 22:18:04
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `reptek`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AgregarCliente` (IN `Nom` VARCHAR(20), IN `Ape` VARCHAR(20), IN `mail` VARCHAR(30), IN `Tel` VARCHAR(20))   BEGIN 
    INSERT INTO Clientes (Nombre, Apellido, Mail, Telefono) 
    VALUES (Nom,Ape,mail,Tel); 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AgregarRepuesto` (IN `Nom` VARCHAR(20), IN `Pre` INT(20), IN `Des` VARCHAR(512), IN `Sto` INT(10))   BEGIN 
    INSERT INTO Repuestos (Nombre, Precio, Descripcion, Stock) 
    VALUES (Nom,Pre,Des,Sto); 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AgregarTecnicos` (IN `Nom` VARCHAR(20), IN `Ape` VARCHAR(20), IN `mail` VARCHAR(30), IN `Tel` VARCHAR(10))   BEGIN 
    INSERT INTO Tecnicos (Nombre, Apellido, Mail, Telefono) 
    VALUES (Nom,Ape,mail,Tel); 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AgregarTrabajo` (IN `p_NumOT` INT, IN `p_FechaIngreso` DATE, IN `p_FechaEgreso` DATE, IN `p_ClienteId` INT, IN `p_Precio` FLOAT, IN `p_DescripcionTecnico` VARCHAR(256), IN `p_DescripcionCliente` VARCHAR(256), IN `p_UsuarioId` INT, IN `p_TecnicoId` INT, IN `p_EstadoId` INT)   BEGIN
    INSERT INTO Trabajos (NumOT, Fecha_ingreso, Fecha_egreso, Cliente_id, Precio, Descripcion_tecnico, Descripcion_cliente, Usuario_id, Tecnico_id, Estado_id)
    VALUES (p_NumOT, p_FechaIngreso, p_FechaEgreso, p_ClienteId, p_Precio, p_DescripcionTecnico, p_DescripcionCliente, p_UsuarioId, p_TecnicoId, p_EstadoId);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AgregarUsuario` (IN `nombre` VARCHAR(20), IN `apellido` VARCHAR(20), IN `mail` VARCHAR(30), IN `contrasenia` VARCHAR(30), IN `telefono` VARCHAR(20))   BEGIN 
    INSERT INTO Usuarios (Nombre, Apellido, Mail, Contrasena, Telefono) 
    VALUES (nombre, apellido, mail, contrasenia, telefono); 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CambiarContrasena` (IN `p_mail` VARCHAR(30), IN `p_telefono` VARCHAR(20), IN `p_nuevaContrasena` VARCHAR(30))   BEGIN
    DECLARE usuario_valido INT;

    -- Verificar si existe un usuario con el correo y teléfono proporcionados
    SELECT COUNT(*)
    INTO usuario_valido
    FROM Usuarios
    WHERE Mail = p_mail
    AND Telefono = p_telefono;

    -- Si el usuario es válido, actualizamos la contraseña
    IF usuario_valido = 1 THEN
        UPDATE Usuarios
        SET Contrasena = p_nuevaContrasena
        WHERE Mail = p_mail
        AND Telefono = p_telefono;

        SELECT 'Contraseña actualizada exitosamente' AS resultado;
    ELSE
        SELECT 'Correo o teléfono incorrectos' AS resultado;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarClientePorApellido` (IN `Ape` VARCHAR(20))   SELECT * FROM `Clientes` WHERE Apellido=Ape$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarClientePorNombre` (IN `Nomb` VARCHAR(20))   SELECT * FROM `Clientes` WHERE Nombre=Nomb$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarClientes` ()   SELECT * FROM `Clientes`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarNombrePorApellido` (IN `Ape` VARCHAR(20))   SELECT * FROM `Tecnicos` WHERE Apellido=Ape$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarRepuestoPorNombre` (IN `Nom` VARCHAR(20))   SELECT * FROM Repuestos WHERE Nombre=Nom$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarRepuestos` ()   SELECT * FROM `Repuestos`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarTecnicoPorApellido` (IN `Ape` VARCHAR(20))   SELECT * FROM Tecnicos WHERE Apellido=Ape$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarTecnicoPorNombre` (IN `Nomb` VARCHAR(20))   SELECT * FROM `Tecnicos` WHERE Nombre=Nomb$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarTecnicos` ()   SELECT * FROM Tecnicos$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarTrabajos` ()   SELECT NumOT, Fecha_ingreso, Cliente_id, Estado_id, Tecnico_id FROM Trabajos$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarTrabajosPorClienteId` (IN `clien` INT)   SELECT * FROM Trabajos WHERE Cliente_id=clien$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarTrabajosPorEstadoId` (IN `est` INT(11))   SELECT * FROM `Trabajos` WHERE Estado_id=est$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarTrabajosPorNumOT` (IN `num` INT)   SELECT * FROM Trabajos WHERE NumOT=num$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarTrabajosPorRangoDeFechaEgreso` (IN `egr1` DATE, IN `egr2` DATE)   SELECT * 
FROM Trabajos
WHERE Fecha_egreso BETWEEN egr1 AND egr2$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarTrabajosPorRangoDeFechaIngreso` (IN `ing1` DATE, IN `ing2` DATE)   SELECT * 
FROM Trabajos
WHERE Fecha_ingreso BETWEEN ing1 AND ing2$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarTrabajosPorTecnicoId` (IN `tec` INT)   SELECT * FROM Trabajos WHERE Tecnico_id=tec$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarUsuarioPorApellido` (IN `Ape` VARCHAR(20))   SELECT Nombre, Apellido, Mail, Telefono FROM Usuarios WHERE Apellido=Ape$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarUsuarios` ()   SELECT id, Nombre, Apellido, Mail, Telefono 
FROM Usuarios$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarUsuariosPorNombre` (IN `Nom` VARCHAR(20))   SELECT Nombre, Apellido, Mail, Telefono FROM Usuarios WHERE Nombre=Nom$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LoginUsuario` (IN `p_mail` VARCHAR(30), IN `p_contrasena` VARCHAR(30))   BEGIN
    DECLARE usuario_valido INT;
    DECLARE usuario_rol INT;

    -- Verificar si existe un usuario con las credenciales dadas
    SELECT COUNT(*), Rol
    INTO usuario_valido, usuario_rol
    FROM Usuarios
    WHERE Mail = p_mail
    AND Contrasena = p_contrasena;

    -- Si el usuario es válido, devolver un mensaje de éxito y el rol
    IF usuario_valido = 1 THEN
        SELECT 'Login exitoso' AS resultado, usuario_rol AS Rol;
    ELSE
        SELECT 'Correo o contraseña incorrectos' AS resultado, NULL AS Rol;
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` int(10) NOT NULL,
  `Nombre` varchar(20) NOT NULL,
  `Apellido` varchar(20) NOT NULL,
  `Mail` varchar(30) NOT NULL,
  `Telefono` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `Nombre`, `Apellido`, `Mail`, `Telefono`) VALUES
(3, 'San', 'Intili', 'Santi@gmail.com', '2147483647'),
(4, 'Mati', 'sai', 'matisai@gmail.com', '351713043');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados`
--

CREATE TABLE `estados` (
  `id` int(10) NOT NULL,
  `Nombre` varchar(20) CHARACTER SET utf16 COLLATE utf16_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `estados`
--

INSERT INTO `estados` (`id`, `Nombre`) VALUES
(1, 'En espera'),
(2, 'Realizado'),
(3, 'Cancelado'),
(4, 'En proceso');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recursos`
--

CREATE TABLE `recursos` (
  `id` int(10) NOT NULL,
  `trabajo_id` int(10) NOT NULL,
  `repuesto_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `repuestos`
--

CREATE TABLE `repuestos` (
  `id` int(10) NOT NULL,
  `Nombre` varchar(20) NOT NULL,
  `Precio` int(20) NOT NULL,
  `Descripcion` varchar(512) NOT NULL,
  `Stock` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `repuestos`
--

INSERT INTO `repuestos` (`id`, `Nombre`, `Precio`, `Descripcion`, `Stock`) VALUES
(1, 'Intel i5', 100000, 'Intel i 5 generacion 13', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tecnicos`
--

CREATE TABLE `tecnicos` (
  `id` int(10) NOT NULL,
  `Nombre` varchar(20) NOT NULL,
  `Apellido` varchar(20) NOT NULL,
  `Mail` varchar(30) NOT NULL,
  `Telefono` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `tecnicos`
--

INSERT INTO `tecnicos` (`id`, `Nombre`, `Apellido`, `Mail`, `Telefono`) VALUES
(1, 'Alfon', 'Purro', 'alfpurr@gmail.com', '351366247');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trabajos`
--

CREATE TABLE `trabajos` (
  `id` int(10) NOT NULL,
  `NumOT` int(10) NOT NULL,
  `Fecha_ingreso` date NOT NULL,
  `Fecha_egreso` date NOT NULL,
  `Cliente_id` int(10) NOT NULL,
  `Precio` float NOT NULL,
  `Descripcion_tecnico` varchar(256) NOT NULL,
  `Descripcion_cliente` varchar(256) NOT NULL,
  `Usuario_id` int(10) NOT NULL,
  `Tecnico_id` int(10) NOT NULL,
  `Estado_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `trabajos`
--

INSERT INTO `trabajos` (`id`, `NumOT`, `Fecha_ingreso`, `Fecha_egreso`, `Cliente_id`, `Precio`, `Descripcion_tecnico`, `Descripcion_cliente`, `Usuario_id`, `Tecnico_id`, `Estado_id`) VALUES
(1, 1, '2024-09-10', '2024-09-18', 3, 5000, 'Rompio placa video', 'No prende', 5, 1, 2),
(8, 2, '2024-07-03', '2024-08-01', 3, 15000, 'Cambio completo de procesador y pasta termica', 'No prende', 5, 1, 1),
(9, 5, '0000-00-00', '0000-00-00', 3, 50000, 'Rompio todo', 'No nada', 5, 1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(10) NOT NULL,
  `Nombre` varchar(20) NOT NULL,
  `Apellido` varchar(20) NOT NULL,
  `Mail` varchar(30) NOT NULL,
  `Contrasena` varchar(30) NOT NULL,
  `Telefono` varchar(20) NOT NULL,
  `Rol` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `Nombre`, `Apellido`, `Mail`, `Contrasena`, `Telefono`, `Rol`) VALUES
(5, 'Admin', '1', 'admin@reptek.com', 'alvarito845', '.', 1),
(6, 'Santiago', 'Intili', 'sintili@gmail.com', '1234', '3517322150', 2);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `estados`
--
ALTER TABLE `estados`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `recursos`
--
ALTER TABLE `recursos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trabajo_id` (`trabajo_id`,`repuesto_id`),
  ADD KEY `repuesto_id` (`repuesto_id`);

--
-- Indices de la tabla `repuestos`
--
ALTER TABLE `repuestos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tecnicos`
--
ALTER TABLE `tecnicos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `trabajos`
--
ALTER TABLE `trabajos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Cliente_id` (`Cliente_id`),
  ADD KEY `Tecnico_id` (`Tecnico_id`,`Estado_id`),
  ADD KEY `Estado_id` (`Estado_id`),
  ADD KEY `Usuario_id` (`Usuario_id`),
  ADD KEY `NumOT` (`NumOT`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `estados`
--
ALTER TABLE `estados`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `recursos`
--
ALTER TABLE `recursos`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `repuestos`
--
ALTER TABLE `repuestos`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tecnicos`
--
ALTER TABLE `tecnicos`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `trabajos`
--
ALTER TABLE `trabajos`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `recursos`
--
ALTER TABLE `recursos`
  ADD CONSTRAINT `Recursos_ibfk_1` FOREIGN KEY (`trabajo_id`) REFERENCES `trabajos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `Recursos_ibfk_2` FOREIGN KEY (`repuesto_id`) REFERENCES `repuestos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `trabajos`
--
ALTER TABLE `trabajos`
  ADD CONSTRAINT `Trabajos_ibfk_1` FOREIGN KEY (`Cliente_id`) REFERENCES `clientes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `Trabajos_ibfk_2` FOREIGN KEY (`Tecnico_id`) REFERENCES `tecnicos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `Trabajos_ibfk_3` FOREIGN KEY (`Estado_id`) REFERENCES `estados` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `Trabajos_ibfk_4` FOREIGN KEY (`Usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
