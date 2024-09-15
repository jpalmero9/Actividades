-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Sep 15, 2024 at 05:00 AM
-- Server version: 8.2.0
-- PHP Version: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `activities`
--

-- --------------------------------------------------------

--
-- Table structure for table `activities_day`
--

DROP TABLE IF EXISTS `activities_day`;
CREATE TABLE IF NOT EXISTS `activities_day` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_user` int UNSIGNED NOT NULL,
  `name_task` varchar(500) NOT NULL,
  `activitie_date` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_task` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `activities_day`
--

INSERT INTO `activities_day` (`id`, `id_user`, `name_task`, `activitie_date`) VALUES
(1, 1, 'Crear repositorio GitHub', '2024-09-14 00:00:00.000000'),
(3, 1, 'Desarrollo Dashboard', '2024-09-14 00:00:00.000000'),
(4, 1, 'Codificar Validaciones Básicas', '2024-09-14 00:00:00.000000'),
(5, 2, 'Revisión de Proyectos y procesos a desarrollar', '2024-09-13 00:00:00.000000'),
(6, 2, 'Creación de nuevos usuarios', '2024-09-14 00:00:00.000000'),
(7, 2, 'Actividad de pruebas para revisar funcionamiento', '2024-09-11 00:00:00.000000'),
(8, 3, 'Preparación del plan de actividades rev 1 Rev 2', '2024-09-14 00:00:00.000000'),
(9, 3, 'Revisión de Objetivos alcanzados', '2024-09-14 00:00:00.000000'),
(11, 1, 'Nueva actividad Rev 1', '2024-09-11 00:00:00.000000'),
(12, 2, 'Actividad de prueba Rev 1', '2024-09-14 00:00:00.000000'),
(13, 2, 'Revisión de casos de Soporte a los usuarios', '2024-09-12 00:00:00.000000');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name_user` varchar(50) NOT NULL,
  `name` varchar(80) NOT NULL,
  `password` varchar(1000) NOT NULL,
  `email` varchar(100) NOT NULL,
  `creation_date` datetime NOT NULL DEFAULT (now(6)),
  PRIMARY KEY (`id`),
  UNIQUE KEY `nameuser` (`name_user`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name_user`, `name`, `password`, `email`, `creation_date`) VALUES
(1, 'jpalmero9', 'Jose Gregorio Palmero', 'scrypt:32768:8:1$5c7gXL722JoEzSuR$5c23debc080e4d8e4941810ff086f23b869ac79b2fbb9a021f0eab1995d170edcfa0f617f5351da468e0c7a64487adda742ce3092dfc9c71958d7f94b8110bfd', 'jpalmero9@gmail.com', '2024-09-14 00:00:00'),
(2, 'admin', 'Super Administrador', 'scrypt:32768:8:1$aACUSfUQw3mKZNQN$88132ca63f656b87588996662faa6d4771a3246173424f7ed898dcf9ac2f0a5fe341af103e4af9218037c3288a7b9b34898c2fcf4082af68d4dfb443bd000d0a', 'jpalmero9@gmail.com', '2024-09-14 00:00:00'),
(3, 'jperez', 'Juan Perez', 'scrypt:32768:8:1$9YQ1emBsZB5ELGVS$4edf6f3e6a83948d9d199be862a56a33052398c54ed20dce4ab07f9c19254cff1cb063cf87719dea5bbe98ae0ce614e640b15a3c072a308c980aa74e68d72d58', 'jperez@demo.com', '2024-09-14 00:00:00'),
(4, 'demo', 'Usuario Demostración', 'scrypt:32768:8:1$XFnWIm2IkI7pmnIB$2c40d409a77a06e5e386a7fd9e3ee86154ba0984dae278753767142fad671947fc4201f6989e3e56596880163094173329a8e5bf4ace697a012bdb1605976ad0', 'usuariodemo@demo.com', '2024-09-14 00:00:00'),
(5, 'demo2', 'Usuario Demostración 2', 'scrypt:32768:8:1$ThsKeIvDKIP8FMTa$49508fbaa2f9807f716572407ffb1b5f1149660a326c2d16ba295e748a9fa1cfd01198ab56a69f90e61b0babc6ea0b2a10a4e87f0f5b80b13d3decb3a3d7d74f', 'usuariodemo2@demo.com', '2024-09-14 00:00:00');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activities_day`
--
ALTER TABLE `activities_day`
  ADD CONSTRAINT `user_task` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
