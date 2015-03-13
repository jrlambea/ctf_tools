SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

CREATE TABLE IF NOT EXISTS `cookieVault` (
  `id` int(11) NOT NULL COMMENT 'Identificador de la cookie.',
  `date` datetime NOT NULL COMMENT 'Fecha de la recolección.',
  `url` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'URL de la cookie.',
  `data` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'Data de la cookie',
  `passwd_sha1` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'Clave de encriptación hasheada.'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabla de la tool cookieVault';
