-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 17-10-2024 a las 11:23:54
-- Versión del servidor: 10.5.26-MariaDB
-- Versión de PHP: 8.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `grupouniversitar_REPTEK`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`grupouniversitar`@`localhost` PROCEDURE `Agregar Cliente` (IN `Nom` VARCHAR(20), IN `Ape` VARCHAR(20), IN `mail` VARCHAR(30), IN `Tel` VARCHAR(20))   BEGIN 

    INSERT INTO Clientes (Nombre, Apellido, Mail, Telefono) 

    VALUES (Nom,Ape,mail,Tel); 

END$$

CREATE DEFINER=`grupouniversitar`@`localhost` PROCEDURE `Agregar Repuesto` (IN `Nom` VARCHAR(20), IN `Pre` INT(20), IN `Des` VARCHAR(512), IN `Sto` INT(10))   BEGIN 

    INSERT INTO Repuestos (Nombre, Precio, Descripcion, Stock) 

    VALUES (Nom,Pre,Des,Sto); 

END$$

CREATE DEFINER=`grupouniversitar`@`localhost` PROCEDURE `Agregar Tecnicos` (IN `Nom` VARCHAR(20), IN `Ape` VARCHAR(20), IN `mail` VARCHAR(30), IN `Tel` VARCHAR(10))   BEGIN 

    INSERT INTO Tecnicos (Nombre, Apellido, Mail, Telefono) 

    VALUES (Nom,Ape,mail,Tel); 

END$$

CREATE DEFINER=`grupouniversitar`@`localhost` PROCEDURE `Agregar Trabajo` (IN `p_NumOT` INT, IN `p_Fecha_ingreso` DATE, IN `p_Fecha_egreso` DATE, IN `p_Cliente_id` INT, IN `p_Precio` FLOAT, IN `p_Descripcion_tecnico` VARCHAR(256), IN `p_Descripcion_cliente` VARCHAR(256), IN `p_Usuario_id` INT, IN `p_Tecnico_id` INT, IN `p_Estado_id` INT)   BEGIN
    INSERT INTO Trabajos (NumOT, Fecha_ingreso, Fecha_egreso, Cliente_id, Precio, Descripcion_tecnico, Descripcion_cliente, Usuario_id, Tecnico_id, Estado_id)
    VALUES (p_NumOT, p_Fecha_ingreso, p_Fecha_egreso, p_Cliente_id, p_Precio, p_Descripcion_tecnico, p_Descripcion_cliente, p_Usuario_id, p_Tecnico_id, p_Estado_id);
END$$

CREATE DEFINER=`grupouniversitar`@`localhost` PROCEDURE `Agregar Usuario` (IN `nombre` VARCHAR(20), IN `apellido` VARCHAR(20), IN `mail` VARCHAR(30), IN `contrasenia` VARCHAR(30), IN `telefono` VARCHAR(20))   BEGIN 

    INSERT INTO Usuarios (Nombre, Apellido, Mail, Contraseña, Telefono) 

    VALUES (nombre, apellido, mail, contrasenia, telefono); 

END$$

CREATE DEFINER=`grupouniversitar`@`localhost` PROCEDURE `CambiarContrasena` (IN `p_mail` VARCHAR(30), IN `p_telefono` VARCHAR(20), IN `p_nueva_contrasena` VARCHAR(30))   BEGIN
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
        SET Contraseña = p_nueva_contrasena
        WHERE Mail = p_mail
        AND Telefono = p_telefono;

        SELECT 'Contraseña actualizada exitosamente' AS resultado;
    ELSE
        SELECT 'Correo o teléfono incorrectos' AS resultado;
    END IF;
END$$

CREATE DEFINER=`grupouniversitar`@`localhost` PROCEDURE `Listar Cliente por Apellido` (IN `Ape` VARCHAR(20))   SELECT * FROM `Clientes` WHERE Apellido=Ape$$

CREATE DEFINER=`grupouniversitar`@`localhost` PROCEDURE `Listar Cliente Por Nombre` (IN `Nomb` VARCHAR(20))   SELECT * FROM `Clientes` WHERE Nombre=Nomb$$

CREATE DEFINER=`grupouniversitar`@`localhost` PROCEDURE `Listar Clientes` ()   SELECT * FROM `Clientes`$$

CREATE DEFINER=`grupouniversitar`@`localhost` PROCEDURE `Listar Nombre por Apellido` (IN `Ape` VARCHAR(20))   SELECT * FROM `Tecnicos` WHERE Apellido=Ape$$

CREATE DEFINER=`grupouniversitar`@`localhost` PROCEDURE `Listar Repuesto por Nombre` (IN `Nom` VARCHAR(20))   SELECT * FROM Repuestos WHERE Nombre=Nom$$

CREATE DEFINER=`grupouniversitar`@`localhost` PROCEDURE `Listar Repuestos` ()   SELECT * FROM `Repuestos`$$

CREATE DEFINER=`grupouniversitar`@`localhost` PROCEDURE `Listar Tecinco por Apellido` (IN `Ape` VARCHAR(20))   SELECT * FROM Tecnicos WHERE Apellido=Ape$$

CREATE DEFINER=`grupouniversitar`@`localhost` PROCEDURE `Listar tecnico por Nombre` (IN `Nomb` VARCHAR(20))   SELECT * FROM `Tecnicos` WHERE Nombre=Nomb$$

CREATE DEFINER=`grupouniversitar`@`localhost` PROCEDURE `Listar Tecnicos` ()   SELECT * FROM Tecnicos$$

CREATE DEFINER=`grupouniversitar`@`localhost` PROCEDURE `Listar Trabajos` ()   SELECT NumOT, Fecha_ingreso, Cliente_id, Estado_id, Tecnico_id FROM Trabajos$$

CREATE DEFINER=`grupouniversitar`@`localhost` PROCEDURE `Listar trabajos por Cliente (id)` (IN `clien` INT)   SELECT * FROM Trabajos WHERE Cliente_id=clien$$

CREATE DEFINER=`grupouniversitar`@`localhost` PROCEDURE `Listar trabajos por Estado (id)` (IN `est` INT(11))   SELECT * FROM `Trabajos` WHERE Estado_id=est$$

CREATE DEFINER=`grupouniversitar`@`localhost` PROCEDURE `Listar Trabajos por NumOT` (IN `num` INT)   SELECT * FROM Trabajos WHERE NumOT=num$$

CREATE DEFINER=`grupouniversitar`@`localhost` PROCEDURE `Listar trabajos Por rango de fecha de egreso` (IN `egr1` DATE, IN `egr2` DATE)   SELECT * 
FROM Trabajos
WHERE Fecha_egreso BETWEEN egr1 AND egr2$$

CREATE DEFINER=`grupouniversitar`@`localhost` PROCEDURE `Listar Trabajos Por Rango de fecha de ingreso` (IN `ing1` DATE, IN `ing2` DATE)   SELECT * 
FROM Trabajos
WHERE Fecha_ingreso BETWEEN ing1 AND ing2$$

CREATE DEFINER=`grupouniversitar`@`localhost` PROCEDURE `Listar Trabajos por Tecnico (id)` (IN `tec` INT)   SELECT * FROM Trabajos WHERE Tecnico_id=tec$$

CREATE DEFINER=`grupouniversitar`@`localhost` PROCEDURE `Listar Usuario por Apellido` (IN `Ape` VARCHAR(20))   SELECT Nombre, Apellido, Mail, Telefono FROM Usuarios WHERE Apellido=Ape$$

CREATE DEFINER=`grupouniversitar`@`localhost` PROCEDURE `Listar usuarios` ()   SELECT id, Nombre, Apellido, Mail, Telefono 
FROM Usuarios$$

CREATE DEFINER=`grupouniversitar`@`localhost` PROCEDURE `Listar Usuarios por Nombre` (IN `Nom` VARCHAR(20))   SELECT Nombre, Apellido, Mail, Telefono FROM Usuarios WHERE Nombre=Nom$$

CREATE DEFINER=`grupouniversitar`@`localhost` PROCEDURE `LoginUsuario` (IN `p_mail` VARCHAR(30), IN `p_contrasena` VARCHAR(30))   BEGIN
    DECLARE usuario_valido INT;

    -- Verificar si existe un usuario con las credenciales dadas
    SELECT COUNT(*)
    INTO usuario_valido
    FROM Usuarios
    WHERE Mail = p_mail
    AND Contrasena = p_contrasena;

    -- Si el usuario es válido, devolver un mensaje de éxito
    IF usuario_valido = 1 THEN
        SELECT 'Login exitoso' AS resultado;
    ELSE
        SELECT 'Correo o contraseña incorrectos' AS resultado;
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Clientes`
--

CREATE TABLE `Clientes` (
  `id` int(10) NOT NULL,
  `Nombre` varchar(20) NOT NULL,
  `Apellido` varchar(20) NOT NULL,
  `Mail` varchar(30) NOT NULL,
  `Telefono` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `Clientes`
--

INSERT INTO `Clientes` (`id`, `Nombre`, `Apellido`, `Mail`, `Telefono`) VALUES
(3, 'San', 'Intili', 'Santi@gmail.com', '2147483647'),
(4, 'Mati', 'sai', 'matisai@gmail.com', '351713043');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Estados`
--

CREATE TABLE `Estados` (
  `id` int(10) NOT NULL,
  `Nombre` varchar(20) CHARACTER SET utf16 COLLATE utf16_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `Estados`
--

INSERT INTO `Estados` (`id`, `Nombre`) VALUES
(1, 'En espera'),
(2, 'Realizado'),
(3, 'Cancelado'),
(4, 'En proceso');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Recursos`
--

CREATE TABLE `Recursos` (
  `id` int(10) NOT NULL,
  `trabajo_id` int(10) NOT NULL,
  `repuesto_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Repuestos`
--

CREATE TABLE `Repuestos` (
  `id` int(10) NOT NULL,
  `Nombre` varchar(20) NOT NULL,
  `Precio` int(20) NOT NULL,
  `Descripcion` varchar(512) NOT NULL,
  `Stock` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `Repuestos`
--

INSERT INTO `Repuestos` (`id`, `Nombre`, `Precio`, `Descripcion`, `Stock`) VALUES
(1, 'Intel i5', 100000, 'Intel i 5 generacion 13', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Tecnicos`
--

CREATE TABLE `Tecnicos` (
  `id` int(10) NOT NULL,
  `Nombre` varchar(20) NOT NULL,
  `Apellido` varchar(20) NOT NULL,
  `Mail` varchar(30) NOT NULL,
  `Telefono` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `Tecnicos`
--

INSERT INTO `Tecnicos` (`id`, `Nombre`, `Apellido`, `Mail`, `Telefono`) VALUES
(1, 'Alfon', 'Purro', 'alfpurr@gmail.com', '351366247');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Trabajos`
--

CREATE TABLE `Trabajos` (
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
-- Volcado de datos para la tabla `Trabajos`
--

INSERT INTO `Trabajos` (`id`, `NumOT`, `Fecha_ingreso`, `Fecha_egreso`, `Cliente_id`, `Precio`, `Descripcion_tecnico`, `Descripcion_cliente`, `Usuario_id`, `Tecnico_id`, `Estado_id`) VALUES
(1, 1, '2024-09-10', '2024-09-18', 3, 5000, 'Rompio placa video', 'No prende', 5, 1, 2),
(8, 2, '2024-07-03', '2024-08-01', 3, 15000, 'Cambio completo de procesador y pasta termica', 'No prende', 5, 1, 1),
(9, 5, '0000-00-00', '0000-00-00', 3, 50000, 'Rompio todo', 'No nada', 5, 1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Usuarios`
--

CREATE TABLE `Usuarios` (
  `id` int(10) NOT NULL,
  `Nombre` varchar(20) NOT NULL,
  `Apellido` varchar(20) NOT NULL,
  `Mail` varchar(30) NOT NULL,
  `Contrasena` varchar(30) NOT NULL,
  `Telefono` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `Usuarios`
--

INSERT INTO `Usuarios` (`id`, `Nombre`, `Apellido`, `Mail`, `Contrasena`, `Telefono`) VALUES
(5, 'Admin', '1', 'admin@reptek.com', 'alvarito845', '.');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `Clientes`
--
ALTER TABLE `Clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `Estados`
--
ALTER TABLE `Estados`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `Recursos`
--
ALTER TABLE `Recursos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trabajo_id` (`trabajo_id`,`repuesto_id`),
  ADD KEY `repuesto_id` (`repuesto_id`);

--
-- Indices de la tabla `Repuestos`
--
ALTER TABLE `Repuestos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `Tecnicos`
--
ALTER TABLE `Tecnicos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `Trabajos`
--
ALTER TABLE `Trabajos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Cliente_id` (`Cliente_id`),
  ADD KEY `Tecnico_id` (`Tecnico_id`,`Estado_id`),
  ADD KEY `Estado_id` (`Estado_id`),
  ADD KEY `Usuario_id` (`Usuario_id`),
  ADD KEY `NumOT` (`NumOT`);

--
-- Indices de la tabla `Usuarios`
--
ALTER TABLE `Usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `Clientes`
--
ALTER TABLE `Clientes`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `Estados`
--
ALTER TABLE `Estados`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `Recursos`
--
ALTER TABLE `Recursos`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Repuestos`
--
ALTER TABLE `Repuestos`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `Tecnicos`
--
ALTER TABLE `Tecnicos`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `Trabajos`
--
ALTER TABLE `Trabajos`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `Usuarios`
--
ALTER TABLE `Usuarios`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `Recursos`
--
ALTER TABLE `Recursos`
  ADD CONSTRAINT `Recursos_ibfk_1` FOREIGN KEY (`trabajo_id`) REFERENCES `Trabajos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `Recursos_ibfk_2` FOREIGN KEY (`repuesto_id`) REFERENCES `Repuestos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `Trabajos`
--
ALTER TABLE `Trabajos`
  ADD CONSTRAINT `Trabajos_ibfk_1` FOREIGN KEY (`Cliente_id`) REFERENCES `Clientes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `Trabajos_ibfk_2` FOREIGN KEY (`Tecnico_id`) REFERENCES `Tecnicos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `Trabajos_ibfk_3` FOREIGN KEY (`Estado_id`) REFERENCES `Estados` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `Trabajos_ibfk_4` FOREIGN KEY (`Usuario_id`) REFERENCES `Usuarios` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
