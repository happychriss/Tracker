-- phpMyAdmin SQL Dump
-- version 3.3.2deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Erstellungszeit: 26. November 2010 um 23:01
-- Server Version: 5.1.41
-- PHP-Version: 5.3.2-1ubuntu4.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Datenbank: `Estimator_development`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `baselines`
--

CREATE TABLE IF NOT EXISTS `baselines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) DEFAULT NULL,
  `estimator_id` int(11) NOT NULL,
  `state` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment` text COLLATE utf8_unicode_ci,
  `pm_comment` text COLLATE utf8_unicode_ci,
  `estimation_date` datetime DEFAULT NULL,
  `eac_hours` int(11) DEFAULT '0',
  `variance` float DEFAULT NULL,
  `pm_eac_amount` int(11) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=13 ;

--
-- Daten für Tabelle `baselines`
--

INSERT INTO `baselines` (`id`, `task_id`, `estimator_id`, `state`, `comment`, `pm_comment`, `estimation_date`, `eac_hours`, `variance`, `pm_eac_amount`, `created_at`, `updated_at`) VALUES
(1, 1, 3, 'requested', NULL, 'asdf', NULL, 0, 0, 0, '2010-05-26 18:43:11', '2010-05-26 18:43:15'),
(2, 2, 4, 'final', NULL, 'Design should be based on client specification of March 05 (version 1.1)', '2010-05-25 22:00:00', 41, 11.3889, 0, '2010-05-26 20:46:31', '2010-05-26 21:06:39'),
(3, 3, 4, 'estimated', NULL, '', '2010-05-25 22:00:00', 66, 55.5556, 0, '2010-05-26 20:58:58', '2010-05-26 20:59:21'),
(4, 2, 4, 'final', NULL, '', '2010-09-29 22:00:00', 41, 11.3889, 0, '2010-05-26 21:06:38', '2010-11-10 21:46:52'),
(5, 6, 8, 'estimated', NULL, 'Do the estimate', '2010-09-28 22:00:00', 42, 0, 0, '2010-09-29 20:24:35', '2010-09-29 20:30:19'),
(6, 7, 9, 'estimated', NULL, '', '2010-09-28 22:00:00', 11, 0, 0, '2010-09-29 21:09:25', '2010-09-29 21:10:04'),
(8, 10, 4, 'estimated', NULL, '', '2010-11-03 23:00:00', 35, 2.27778, 0, '2010-11-04 21:30:56', '2010-11-04 21:32:19'),
(9, 11, 4, 'estimated', NULL, 'Please incl. all stakeholders in testing.', '2010-11-07 23:00:00', 74, 76.3889, 0, '2010-11-08 20:41:10', '2010-11-08 20:42:08'),
(10, 12, 10, 'estimated', NULL, '', '2010-11-09 23:00:00', 13, 0, 0, '2010-11-10 21:33:32', '2010-11-10 21:34:06'),
(11, 13, 10, 'estimated', NULL, 'adfs', '2010-11-09 23:00:00', 17, 0, 0, '2010-11-10 21:42:30', '2010-11-10 21:42:58'),
(12, 2, 4, 'requested', NULL, '', NULL, 41, 11.3889, 0, '2010-11-10 21:46:49', '2010-11-10 21:46:52');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `budget_groups`
--

CREATE TABLE IF NOT EXISTS `budget_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Daten für Tabelle `budget_groups`
--

INSERT INTO `budget_groups` (`id`, `group_name`) VALUES
(1, 'Costtype'),
(2, 'Department'),
(3, 'Team');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `budget_types`
--

CREATE TABLE IF NOT EXISTS `budget_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `budget_group_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

--
-- Daten für Tabelle `budget_types`
--

INSERT INTO `budget_types` (`id`, `budget_group_id`, `name`, `created_at`, `updated_at`) VALUES
(1, 1, 'External', '2010-05-25 20:32:09', '2010-05-25 20:32:09'),
(2, 1, 'Internal', '2010-05-25 20:32:09', '2010-05-25 20:32:09'),
(3, 1, 'Offshore', '2010-05-25 20:32:09', '2010-05-25 20:32:09'),
(4, 2, 'Design', '2010-05-25 20:32:09', '2010-05-25 20:32:09'),
(5, 2, 'Backend', '2010-05-25 20:32:09', '2010-05-25 20:32:09'),
(6, 2, 'Test', '2010-05-25 20:32:09', '2010-05-25 20:32:09'),
(7, 3, 'Onsite', '2010-05-25 20:32:09', '2010-05-25 20:32:09'),
(8, 3, 'Offshore', '2010-05-25 20:32:09', '2010-05-25 20:32:09');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `budget_types_ressources`
--

CREATE TABLE IF NOT EXISTS `budget_types_ressources` (
  `ressource_id` int(11) NOT NULL,
  `budget_type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Daten für Tabelle `budget_types_ressources`
--

INSERT INTO `budget_types_ressources` (`ressource_id`, `budget_type_id`) VALUES
(1, 1),
(1, 4),
(1, 7),
(2, 1),
(2, 4),
(2, 7),
(3, 1),
(3, 4),
(3, 7),
(4, 1),
(4, 4),
(4, 7),
(5, 1),
(5, 4),
(5, 7),
(6, 1),
(6, 4),
(6, 7),
(7, 1),
(7, 4),
(7, 7),
(8, 1),
(8, 4),
(8, 7),
(9, 1),
(9, 4),
(9, 7),
(10, 1),
(10, 6),
(10, 8),
(11, 1),
(11, 4),
(11, 7),
(12, 3),
(12, 4),
(12, 7);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `estimations`
--

CREATE TABLE IF NOT EXISTS `estimations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) DEFAULT NULL,
  `estimator_id` int(11) NOT NULL,
  `baseline_id` int(11) DEFAULT NULL,
  `etc_hours` int(11) DEFAULT '0',
  `etc_amount` int(11) DEFAULT '0',
  `state` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment` text COLLATE utf8_unicode_ci,
  `estimation_date` date DEFAULT NULL,
  `pm_comment` text COLLATE utf8_unicode_ci,
  `eac_hours` int(11) DEFAULT '0',
  `variance` float DEFAULT NULL,
  `pm_eac_amount` int(11) DEFAULT '0',
  `actual_hours` int(11) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=18 ;

--
-- Daten für Tabelle `estimations`
--

INSERT INTO `estimations` (`id`, `task_id`, `estimator_id`, `baseline_id`, `etc_hours`, `etc_amount`, `state`, `comment`, `estimation_date`, `pm_comment`, `eac_hours`, `variance`, `pm_eac_amount`, `actual_hours`, `created_at`, `updated_at`) VALUES
(2, 3, 4, 3, 0, 0, 'final', '', '2010-05-26', '', 45, 22.2222, 0, 20, '2010-05-26 21:00:05', '2010-11-08 20:36:53'),
(5, 2, 4, 2, 0, 0, 'closed', NULL, NULL, '', 0, 0, 0, 0, '2010-05-26 21:06:28', '2010-05-26 21:06:39'),
(6, 6, 8, 5, 0, 0, 'estimated', '', '2010-09-29', '', 51, 0, 0, 16, '2010-09-29 21:06:00', '2010-09-29 21:07:26'),
(7, 7, 9, 6, 0, 0, 'estimated', '', '2010-09-29', '', 6, 0, 0, 0, '2010-09-29 21:14:23', '2010-09-29 21:14:53'),
(9, 2, 4, 4, 0, 0, 'final', '', '2010-11-04', '', 51, 3.23611, 0, 40, '2010-11-04 21:32:38', '2010-11-10 21:46:52'),
(10, 10, 4, 8, 0, 0, 'final', '', '2010-11-04', '', 42, 0.805556, 0, 30, '2010-11-04 21:33:36', '2010-11-04 21:39:46'),
(11, 10, 4, 8, 0, 0, 'estimated', '', '2010-11-04', '', 33, 0.111111, 0, 0, '2010-11-04 21:39:46', '2010-11-04 21:39:57'),
(12, 3, 4, 3, 0, 0, 'estimated', '', '2010-11-08', '', 30, 0, 0, 10, '2010-11-08 20:36:52', '2010-11-08 20:37:24'),
(13, 11, 4, 9, 0, 0, 'final', '', '2010-11-08', '', 80, 72.5694, 0, 20, '2010-11-08 20:42:22', '2010-11-08 20:44:15'),
(14, 11, 4, 9, 0, 0, 'final', '', '2010-11-20', '', 79, 37.8472, 0, 18, '2010-11-08 20:44:15', '2010-11-08 20:54:19'),
(17, 11, 4, 9, 0, 0, 'estimated', '', '2010-12-20', '', 83, 34.7222, 0, 10, '2010-11-08 21:01:17', '2010-11-08 21:01:40');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `invitations`
--

CREATE TABLE IF NOT EXISTS `invitations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_id` int(11) DEFAULT NULL,
  `recipient_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sent_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `accepted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Daten für Tabelle `invitations`
--

INSERT INTO `invitations` (`id`, `sender_id`, `recipient_email`, `token`, `sent_at`, `created_at`, `updated_at`, `accepted_at`) VALUES
(1, 4, 'worker@pmsfriensuper.com', '8869e9c31ee984b7b417ac69ece3dc2322781782', '2010-05-26 20:29:20', '2010-05-26 20:29:20', '2010-05-26 20:29:23', '2010-05-26 20:29:23');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `organizations`
--

CREATE TABLE IF NOT EXISTS `organizations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

--
-- Daten für Tabelle `organizations`
--

INSERT INTO `organizations` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'MASTER', '2010-05-25 20:32:09', '2010-05-25 20:32:09'),
(2, 'TestOrg', '2010-05-26 18:25:08', '2010-05-26 18:25:08'),
(3, 'Bluxx', '2010-05-26 20:27:28', '2010-05-26 20:27:28'),
(4, 'asdfasdfadfs', '2010-09-26 21:01:42', '2010-09-26 21:01:42'),
(5, 'adsfasdf', '2010-09-29 19:42:06', '2010-09-29 19:42:06'),
(6, 'sdfasdfadfs', '2010-09-29 20:10:16', '2010-09-29 20:10:16'),
(7, 'asdfasdf', '2010-09-29 21:08:18', '2010-09-29 21:08:18'),
(8, 'asdfads', '2010-11-10 20:34:10', '2010-11-10 20:34:10');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `projects`
--

CREATE TABLE IF NOT EXISTS `projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pm_id` int(11) DEFAULT NULL,
  `organization_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=11 ;

--
-- Daten für Tabelle `projects`
--

INSERT INTO `projects` (`id`, `name`, `description`, `pm_id`, `organization_id`, `created_at`, `updated_at`) VALUES
(1, 'Testproject', 'asdfasdfasdf', 3, 2, '2010-05-26 18:40:20', '2010-05-26 18:40:20'),
(2, 'BuzzPhone', 'WebPad GPS Phone', 4, 3, '2010-05-26 20:29:57', '2010-05-26 20:29:57'),
(3, 'super2', '', 4, 3, '2010-09-24 21:13:35', '2010-09-24 21:13:35'),
(4, 'adfss', '', 4, 3, '2010-09-24 21:41:43', '2010-09-24 21:41:43'),
(5, 'Test', 'Better', 6, 4, '2010-09-26 21:24:44', '2010-09-26 21:24:44'),
(6, 'adfsdf', '', 4, 3, '2010-09-29 20:05:46', '2010-09-29 20:05:46'),
(7, 'Test Project', 'adasdafs', 8, 6, '2010-09-29 20:10:36', '2010-09-29 20:10:36'),
(8, 'adsfadsf', 'asdfas', 9, 7, '2010-09-29 21:08:25', '2010-09-29 21:08:25'),
(9, 'weqr', '', 4, 3, '2010-09-29 21:21:33', '2010-09-29 21:21:33'),
(10, 'Super Project', '', 10, 8, '2010-11-10 20:34:30', '2010-11-10 20:34:30');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `reports`
--

CREATE TABLE IF NOT EXISTS `reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Daten für Tabelle `reports`
--

INSERT INTO `reports` (`id`, `name`, `project_id`, `created_at`, `updated_at`) VALUES
(2, 'Overall Budget', 2, '2010-11-04 21:42:12', '2010-11-04 21:42:12');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `report_lines`
--

CREATE TABLE IF NOT EXISTS `report_lines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_id` int(11) DEFAULT NULL,
  `budget_group_id` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Daten für Tabelle `report_lines`
--

INSERT INTO `report_lines` (`id`, `report_id`, `budget_group_id`, `position`) VALUES
(2, 2, 3, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ressources`
--

CREATE TABLE IF NOT EXISTS `ressources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cost` decimal(11,2) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=13 ;

--
-- Daten für Tabelle `ressources`
--

INSERT INTO `ressources` (`id`, `cost`, `created_at`, `updated_at`, `name`, `project_id`) VALUES
(1, '50.00', '2010-05-26 18:40:50', '2010-05-26 18:40:50', 'Java Developer', 1),
(2, '80.00', '2010-05-26 20:30:28', '2010-05-26 20:30:28', 'Java Developer', 2),
(3, '34.00', '2010-09-24 21:23:42', '2010-09-24 21:23:42', 'adsfasdf', 3),
(4, '10.00', '2010-09-26 21:29:53', '2010-09-26 21:29:53', 'Java Developer', 5),
(5, '20.00', '2010-09-29 20:08:25', '2010-09-29 20:08:25', 'Super Hugo', 6),
(6, '90.00', '2010-09-29 20:11:41', '2010-09-29 20:11:41', 'Java Developer', 7),
(7, '200.00', '2010-09-29 20:12:06', '2010-09-29 20:12:06', 'Senior Tester', 7),
(8, '3.00', '2010-09-29 21:08:31', '2010-09-29 21:08:31', 'qf', 8),
(9, '3453.00', '2010-09-29 21:21:55', '2010-09-29 21:21:55', 'adsfsd', 9),
(10, '40.00', '2010-11-08 20:39:51', '2010-11-08 20:39:51', 'Tester', 2),
(11, '90.00', '2010-11-10 20:39:31', '2010-11-10 20:39:31', 'Java', 10),
(12, '90.00', '2010-11-10 20:39:43', '2010-11-10 20:39:43', 'Tester', 10);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `schema_migrations`
--

CREATE TABLE IF NOT EXISTS `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Daten für Tabelle `schema_migrations`
--

INSERT INTO `schema_migrations` (`version`) VALUES
('20100103201013'),
('20100103201214'),
('20100129224006'),
('20100129224613'),
('20100131205314'),
('20100203220957'),
('20100310220301'),
('20100428200451'),
('20100502201601'),
('20100515181521'),
('20100515181555'),
('20100516172726');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `sessions`
--

CREATE TABLE IF NOT EXISTS `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_sessions_on_session_id` (`session_id`),
  KEY `index_sessions_on_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Daten für Tabelle `sessions`
--


-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tasks`
--

CREATE TABLE IF NOT EXISTS `tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `start` date DEFAULT NULL,
  `stop` date DEFAULT NULL,
  `estimation_type` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pm_contingency` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ressource_id` int(11) DEFAULT NULL,
  `baseline_id` int(11) DEFAULT NULL,
  `estimation_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=16 ;

--
-- Daten für Tabelle `tasks`
--

INSERT INTO `tasks` (`id`, `name`, `description`, `status`, `start`, `stop`, `estimation_type`, `pm_contingency`, `project_id`, `created_at`, `updated_at`, `ressource_id`, `baseline_id`, `estimation_id`) VALUES
(1, 'Testtask', 'asdf', NULL, '2010-05-09', '2010-05-28', 'pert', 'normal', 1, '2010-05-26 18:41:18', '2010-05-26 18:41:18', 1, NULL, NULL),
(2, 'GUI Design', 'Design GUI for Dialer', NULL, '2010-05-17', '2010-05-31', 'pert', 'sigma_3', 2, '2010-05-26 20:32:28', '2010-11-10 21:46:52', 2, 4, NULL),
(3, 'Backend Implementation', '', NULL, '2010-05-23', '2010-05-31', 'pert', 'sigma_3', 2, '2010-05-26 20:58:36', '2010-11-08 20:37:24', 2, 3, 12),
(4, 'Super', 'asdasdf', NULL, '2010-09-19', '2010-09-30', 'pert', 'normal', 3, '2010-09-26 20:05:06', '2010-09-26 20:05:06', 3, NULL, NULL),
(5, 'Build', 'asdfasd', NULL, '2010-09-12', '2010-09-30', 'pert', 'normal', 5, '2010-09-26 21:30:17', '2010-09-26 21:30:17', 4, NULL, NULL),
(6, 'Frontend Delayed', 'asfasd', NULL, '2010-09-12', '2010-09-30', 'pert', 'normal', 7, '2010-09-29 20:13:01', '2010-09-29 21:07:26', 6, 5, 6),
(7, 'dfasdf', 'asdfasdf', NULL, '2010-09-05', '2010-09-15', 'pert', 'normal', 8, '2010-09-29 21:08:47', '2010-09-29 21:14:53', 8, 6, 7),
(8, 'asdfasd', '', NULL, NULL, NULL, 'pert', 'normal', 9, '2010-09-30 19:50:43', '2010-09-30 19:50:43', 9, NULL, NULL),
(10, 'Payment Module', 'Interface to Payment Module', NULL, '2010-11-01', '2010-11-12', 'pert', 'sigma_3', 2, '2010-11-04 21:30:18', '2010-11-04 21:39:57', 2, 8, 11),
(11, 'User Acceptance Testing', '', NULL, '2010-11-01', '2010-11-26', 'pert', 'sigma_3', 2, '2010-11-08 20:40:14', '2010-11-08 21:01:40', 10, 9, 17),
(12, 'Main Core', 'asdfasdf', NULL, '2010-11-10', '2010-11-24', 'pert', 'normal', 10, '2010-11-10 20:40:07', '2010-11-10 21:34:06', 11, 10, NULL),
(13, 'Super', 'asdfas', NULL, '2010-11-01', '2010-11-18', 'pert', 'normal', 10, '2010-11-10 21:42:15', '2010-11-10 21:42:58', 11, 11, NULL),
(14, 'Super', '', NULL, '2010-11-23', '2010-11-27', 'pert', 'normal', 2, '2010-11-25 21:06:16', '2010-11-25 21:06:16', 2, NULL, NULL),
(15, 'asdfasdf', '', NULL, '2010-11-08', '2010-11-27', 'pert', 'normal', 6, '2010-11-25 21:46:16', '2010-11-25 21:46:16', 5, NULL, NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `crypted_password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password_salt` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `persistence_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `perishable_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_pm` tinyint(1) NOT NULL DEFAULT '0',
  `invitation_id` int(11) DEFAULT NULL,
  `invitation_limit` int(11) DEFAULT '10',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=11 ;

--
-- Daten für Tabelle `users`
--

INSERT INTO `users` (`id`, `organization_id`, `username`, `is_admin`, `email`, `crypted_password`, `password_salt`, `persistence_token`, `perishable_token`, `created_at`, `updated_at`, `is_pm`, `invitation_id`, `invitation_limit`) VALUES
(1, 1, 'admin', 1, 'admin@yrr.de', '542d98af0c0d3c88d16708938168ee6ab1691c1b6fefa30d427e7a971faaddbc4f8f643b5192b32827652222ca8d07ddf60752b5a3ca7a37a4ccb6d2c74856fc', 'kw1D3bnifjnpuxhygxWg', 'cabbb1889864d015e2d935834bec66261362cce331a471f0b1bc0de405ce2b76ec5008d0938040b14930e047e7bb8c69b0d2a42ae17527cbd22234e53e6b9ebf', 'k_rdhEsvBVyvvTOaHIuU', '2010-05-25 20:32:09', '2010-11-04 21:24:23', 0, NULL, 5),
(2, 1, 'testuser', 0, 'asdf.asdf@adsfasdfasdf.de', '8bfd2a1e55d1a7324a0591e70a038eaf27e047d766562d69efab61aacc2e7a0a8a6fb2d9092879523ae80de29596161d285fd26934bedc0ceab602efe58135c4', 'TNDSmTntEQxlPUQGIDPA', '72663193dbd4e4cfb5c3ca9ee4bd77195625b2c0f30b43a27c52332a18d5c4a1a4dc6fe5a1a8c5a6d8e4a31e0ee7b1046ee68845c30fc1046adb2d02153f5099', 'yl-4g39cEbXW9bA7ypuh', '2010-05-25 20:32:56', '2010-05-25 20:32:56', 1, NULL, 5),
(3, 2, 'cneuhaus', 0, 'neuhaus.info@googlemail.com', 'ddc755d74f7df90e68b275a257c21d08113fe634408dbeb774929a3e37918eeb8d358eca4691e60daf09dcb8d3d12f36a2454900c596490f02c487638063d20a', 'XJ9Od-A5603Y1bViHpb8', '74adbd76028d00ed86aa68dcfadd0ede2590cc9399d59083f47ffe3c8172aa89aae4b1443923c01d3cccba6d209781570bfc7b0e31e779d5e86e976ccd99371e', 'Sxqob_mACXEK5OCyolj8', '2010-05-26 18:25:31', '2010-05-26 20:18:14', 1, NULL, 5),
(4, 3, 'pm1', 0, 'pmsfriend_pm1@project.com', '309afd1a8e28a2826ac5ea1484a21670fd87da4c7835a8aa2121a5bd1d3bf33e5ab1edb0aa4e091b72b15bdbdb4efa0d1ff0b1d5d9c71ef662b7acbedf42c0a9', '7onu3J36HQ4gF-WPfNCi', 'aad138dfaff103953bde00bcfdf2a2ace9cbb81921e157fb6b68120c45e3d4b0506d03fd7b716af4525aba9b813d519c23c02fd384adf874b6f6beb32b57555d', 'q9TbznThjw7uooih9DLK', '2010-05-26 20:27:28', '2010-11-25 20:35:26', 1, NULL, 4),
(5, 3, 'joe', 0, 'worker@pmsfriensuper.com', '80fff20035a0c44dce33faf3c56ed0f6448491f303ca3d09652294a2490152a10d65524ab5fb8ecfac022256e2b182827647c4ae928c2f46799cfff0e814b4be', 'LMnnJS3JGlzEGpUc_OIi', '15c3c2e405a13444641606ddcb7856af5f55568c9c78f97d15588d5273a5ca5904c6c6c80722a1c506ed4db5a052a29da596d2807984ca9bced713e2d9525afa', 'oUSzOHUbA0l_PJB29nK2', '2010-05-26 20:33:33', '2010-11-04 21:30:57', 0, 1, 5),
(6, 4, 'pm4', 0, 'asdfasdf@asddd.de', 'ec963ccdb34256c7b709697a50dde492681fa3f2f7410bf6f00de7f2b2bb08ae83298540885256b967e9426b8e4c6efe006a32121fc1be8502eebc067ec76ef9', 'bDWMT0pWQEPPgwI3CwNl', 'c749d16926a16306aba93353f7ceb627b134b6a7dbe8c7865eb45bd3264f32aaf7cea88eb6d3b08ca8d7aedcc792d7e7f18edd122f16bad7fe5593825387c919', 'M7_zk51g2kYIMRHgokaB', '2010-09-26 21:01:42', '2010-09-26 21:04:53', 1, NULL, 5),
(7, 5, 'asdfasd', 0, 'asdfasdf@asddddd.de', '7b845024bffb00ceecfa4a255e2f619494971a7b122e71c368b5cdf8471f2e050d5d27eb2c147622e2d6c6bd1f14b0637975a392e27a94f9ec2c5f6209078c35', 'RY5m0COVd2a4f5EK6zUN', 'aff528b2979d24414dd77e9b9be4f89da8fba566b0cacb2f764cc87b53d4dab55d583ee8954773e108acd141be0d8b9dacddce92d8fd118f1d56a0c342bbe8d5', 'rFDQwJHanHEKgIu6EhFT', '2010-09-29 19:42:06', '2010-09-29 19:42:06', 1, NULL, 5),
(8, 6, 'test_pm100', 0, 'asdfasdf@asdddddxxx.de', 'eae303c6bf8ead207ee5e81d2c352f9bf1f10332799106e03c96c999e552824f098acbdebb9a2584a84f06a861838d085d8588bc2b94b8e7117c7ee7f4d38642', 'EWBBhDCkuINi8Ln_1NAE', '559fd08498d8dc97965a6b333c78416f9379085e4531acc454af2925ea8cd0aa1278ff78344694e3987733cc513e958abb5b830d2fa14b1ee4d05736f4c2d60f', '3-cMR-UWzaToDc6WyTjO', '2010-09-29 20:10:16', '2010-09-29 21:06:01', 1, NULL, 5),
(9, 7, 'pm200', 0, 'asdfasdf@asdddddxxxx.de', 'e168535bf89f13adb855b97f2f3d3a4610812cab7c88a4fb77c7c9d6eb1e5756392e97d786e485fe836e91a0f3a3dfcfbf534de044603c12c98e460afec08c3f', 'jitunEsMD1WIccNRX9mR', '2f06a171d4da7ac41178fc97fc570d5e329bdd64e1e1172d3c4fc047840d52c12df2d5ffead01791019ce78b61c28c6707d58c7e3f02d4dc44e0e1adfe5f470e', 'HwuuV-cDbgkaRsdEnpGr', '2010-09-29 21:08:18', '2010-09-29 21:14:23', 1, NULL, 5),
(10, 8, 'pm99', 0, 'asdfasdf@asddsddd.de', 'b780ed4411f3ea828d8ddb02c8a07645575d0df0bd228e784b13c8e1a4d2a46946848216986eade65435bba6130c9372727f2c744dddc75e6cfa69a1cf0b3a57', '3Sd10a9UiJ40x9jWAq8O', '65dedf98ae4dd73c831559988ce2babba789b3683d43769b923cf6fd53daa0e59c9f89b2f10cd6de8bd737b615bd7798185306d2ac9bc7fa6de9bc93d8699a26', 'Tl-XhkQdj1mNOmRUCjgn', '2010-11-10 20:34:10', '2010-11-10 21:42:31', 1, NULL, 5);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `works`
--

CREATE TABLE IF NOT EXISTS `works` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `baseline_id` int(11) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `workhours` int(11) DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=39 ;

--
-- Daten für Tabelle `works`
--

INSERT INTO `works` (`id`, `baseline_id`, `start_date`, `duration`, `workhours`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, '2010-05-03', 7, 0, 'sdf', '2010-05-26 18:43:11', '2010-05-26 18:43:11'),
(2, 1, '2010-05-10', 7, 0, '', '2010-05-26 18:43:11', '2010-05-26 18:43:11'),
(3, 1, '2010-05-17', 7, 0, '', '2010-05-26 18:43:11', '2010-05-26 18:43:11'),
(4, 1, '2010-05-24', 7, 0, '', '2010-05-26 18:43:11', '2010-05-26 18:43:11'),
(5, 2, '2010-05-17', 7, 10, '', '2010-05-26 20:46:31', '2010-05-26 20:55:34'),
(6, 2, '2010-05-24', 7, 20, 'Vacation', '2010-05-26 20:46:31', '2010-05-26 20:55:34'),
(7, 2, '2010-05-31', 7, 11, '', '2010-05-26 20:46:31', '2010-05-26 20:55:34'),
(8, 3, '2010-05-17', 7, 20, '', '2010-05-26 20:58:58', '2010-05-26 20:59:21'),
(9, 3, '2010-05-24', 7, 20, '', '2010-05-26 20:58:58', '2010-05-26 20:59:21'),
(10, 3, '2010-05-31', 7, 26, '', '2010-05-26 20:58:58', '2010-05-26 20:59:21'),
(11, 4, '2010-05-17', 7, 20, '', '2010-05-26 21:06:38', '2010-09-30 20:18:12'),
(12, 4, '2010-05-24', 7, 21, 'Vacation', '2010-05-26 21:06:38', '2010-09-30 20:18:12'),
(13, 4, '2010-05-31', 7, 0, '', '2010-05-26 21:06:38', '2010-05-26 21:06:38'),
(14, 5, '2010-09-06', 7, 10, '', '2010-09-29 20:24:35', '2010-09-29 20:30:19'),
(15, 5, '2010-09-13', 7, 10, '', '2010-09-29 20:24:35', '2010-09-29 20:30:19'),
(16, 5, '2010-09-20', 7, 10, '', '2010-09-29 20:24:35', '2010-09-29 20:30:19'),
(17, 5, '2010-09-27', 7, 12, '', '2010-09-29 20:24:35', '2010-09-29 20:30:19'),
(18, 6, '2010-08-30', 7, 3, '', '2010-09-29 21:09:25', '2010-09-29 21:10:04'),
(19, 6, '2010-09-06', 7, 3, '', '2010-09-29 21:09:25', '2010-09-29 21:10:04'),
(20, 6, '2010-09-13', 7, 5, '', '2010-09-29 21:09:25', '2010-09-29 21:10:04'),
(24, 8, '2010-11-01', 7, 20, '', '2010-11-04 21:30:56', '2010-11-04 21:32:19'),
(25, 8, '2010-11-08', 7, 15, '', '2010-11-04 21:30:56', '2010-11-04 21:32:19'),
(26, 9, '2010-11-01', 7, 20, 'Design', '2010-11-08 20:41:10', '2010-11-08 20:42:08'),
(27, 9, '2010-11-08', 7, 20, 'Review', '2010-11-08 20:41:10', '2010-11-08 20:42:08'),
(28, 9, '2010-11-15', 7, 20, 'Perfom', '2010-11-08 20:41:10', '2010-11-08 20:42:08'),
(29, 9, '2010-11-22', 7, 14, 'Report', '2010-11-08 20:41:10', '2010-11-08 20:42:08'),
(30, 10, '2010-11-08', 7, 10, '', '2010-11-10 21:33:32', '2010-11-10 21:34:06'),
(31, 10, '2010-11-15', 7, 3, '', '2010-11-10 21:33:32', '2010-11-10 21:34:06'),
(32, 10, '2010-11-22', 7, 0, '', '2010-11-10 21:33:32', '2010-11-10 21:33:32'),
(33, 11, '2010-11-01', 7, 10, '', '2010-11-10 21:42:30', '2010-11-10 21:42:57'),
(34, 11, '2010-11-08', 7, 2, '', '2010-11-10 21:42:30', '2010-11-10 21:42:57'),
(35, 11, '2010-11-15', 7, 5, '', '2010-11-10 21:42:30', '2010-11-10 21:42:57'),
(36, 12, '2010-05-17', 7, 0, '', '2010-11-10 21:46:49', '2010-11-10 21:46:49'),
(37, 12, '2010-05-24', 7, 0, 'Vacation', '2010-11-10 21:46:49', '2010-11-10 21:46:49'),
(38, 12, '2010-05-31', 7, 10, '', '2010-11-10 21:46:49', '2010-11-10 21:46:49');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `work_actuals`
--

CREATE TABLE IF NOT EXISTS `work_actuals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) DEFAULT NULL,
  `estimation_id` int(11) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `workhours` int(11) DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=79 ;

--
-- Daten für Tabelle `work_actuals`
--

INSERT INTO `work_actuals` (`id`, `task_id`, `estimation_id`, `start_date`, `duration`, `workhours`, `description`, `created_at`, `updated_at`) VALUES
(3, 3, 2, '2010-05-17', 7, 10, '', '2010-05-26 21:00:05', '2010-05-26 21:00:20'),
(4, 3, 2, '2010-05-24', 7, 10, '', '2010-05-26 21:00:05', '2010-05-26 21:00:20'),
(7, 2, 5, '2010-05-17', 7, NULL, '', '2010-05-26 21:06:28', '2010-05-26 21:06:28'),
(8, 2, 5, '2010-05-24', 7, NULL, 'Vacation', '2010-05-26 21:06:28', '2010-05-26 21:06:28'),
(9, 6, 6, '2010-09-06', 7, 5, '', '2010-09-29 21:06:00', '2010-09-29 21:07:25'),
(10, 6, 6, '2010-09-13', 7, 5, '', '2010-09-29 21:06:00', '2010-09-29 21:07:25'),
(11, 6, 6, '2010-09-20', 7, 5, '', '2010-09-29 21:06:00', '2010-09-29 21:07:25'),
(12, 6, 6, '2010-09-27', 7, 1, '', '2010-09-29 21:06:00', '2010-09-29 21:07:25'),
(13, 7, 7, '2010-08-30', 7, NULL, '', '2010-09-29 21:14:23', '2010-09-29 21:14:23'),
(14, 7, 7, '2010-09-06', 7, NULL, '', '2010-09-29 21:14:23', '2010-09-29 21:14:23'),
(15, 7, 7, '2010-09-13', 7, NULL, '', '2010-09-29 21:14:23', '2010-09-29 21:14:23'),
(16, 7, 7, '2010-09-20', 7, NULL, '', '2010-09-29 21:14:23', '2010-09-29 21:14:23'),
(17, 7, 7, '2010-09-27', 7, NULL, '', '2010-09-29 21:14:23', '2010-09-29 21:14:23'),
(18, 2, 9, '2010-05-31', 7, 10, '', '2010-11-04 21:32:38', '2010-11-04 21:33:17'),
(19, 2, 9, '2010-06-07', 7, 10, '', '2010-11-04 21:32:38', '2010-11-04 21:33:17'),
(20, 2, 9, '2010-06-14', 7, 10, '', '2010-11-04 21:32:38', '2010-11-04 21:33:17'),
(21, 2, 9, '2010-06-21', 7, 10, '', '2010-11-04 21:32:38', '2010-11-04 21:33:17'),
(22, 2, 9, '2010-06-28', 7, NULL, '', '2010-11-04 21:32:38', '2010-11-04 21:32:38'),
(23, 2, 9, '2010-07-05', 7, NULL, '', '2010-11-04 21:32:38', '2010-11-04 21:32:38'),
(24, 2, 9, '2010-07-12', 7, NULL, '', '2010-11-04 21:32:38', '2010-11-04 21:32:38'),
(25, 2, 9, '2010-07-19', 7, NULL, '', '2010-11-04 21:32:38', '2010-11-04 21:32:38'),
(26, 2, 9, '2010-07-26', 7, NULL, '', '2010-11-04 21:32:38', '2010-11-04 21:32:38'),
(27, 2, 9, '2010-08-02', 7, NULL, '', '2010-11-04 21:32:38', '2010-11-04 21:32:38'),
(28, 2, 9, '2010-08-09', 7, NULL, '', '2010-11-04 21:32:38', '2010-11-04 21:32:38'),
(29, 2, 9, '2010-08-16', 7, NULL, '', '2010-11-04 21:32:38', '2010-11-04 21:32:38'),
(30, 2, 9, '2010-08-23', 7, NULL, '', '2010-11-04 21:32:38', '2010-11-04 21:32:38'),
(31, 2, 9, '2010-08-30', 7, NULL, '', '2010-11-04 21:32:38', '2010-11-04 21:32:38'),
(32, 2, 9, '2010-09-06', 7, NULL, '', '2010-11-04 21:32:38', '2010-11-04 21:32:38'),
(33, 2, 9, '2010-09-13', 7, NULL, '', '2010-11-04 21:32:38', '2010-11-04 21:32:38'),
(34, 2, 9, '2010-09-20', 7, NULL, '', '2010-11-04 21:32:38', '2010-11-04 21:32:38'),
(35, 2, 9, '2010-09-27', 7, NULL, '', '2010-11-04 21:32:38', '2010-11-04 21:32:38'),
(36, 2, 9, '2010-10-04', 7, NULL, '', '2010-11-04 21:32:38', '2010-11-04 21:32:38'),
(37, 2, 9, '2010-10-11', 7, NULL, '', '2010-11-04 21:32:38', '2010-11-04 21:32:38'),
(38, 2, 9, '2010-10-18', 7, NULL, '', '2010-11-04 21:32:38', '2010-11-04 21:32:38'),
(39, 2, 9, '2010-10-25', 7, NULL, '', '2010-11-04 21:32:38', '2010-11-04 21:32:38'),
(40, 2, 9, '2010-11-01', 7, NULL, '', '2010-11-04 21:32:38', '2010-11-04 21:32:38'),
(41, 10, 10, '2010-11-01', 7, 30, '', '2010-11-04 21:33:36', '2010-11-04 21:39:11'),
(42, 3, 12, '2010-05-31', 7, 10, '', '2010-11-08 20:36:53', '2010-11-08 20:37:24'),
(43, 3, 12, '2010-06-07', 7, NULL, '', '2010-11-08 20:36:53', '2010-11-08 20:36:53'),
(44, 3, 12, '2010-06-14', 7, NULL, '', '2010-11-08 20:36:53', '2010-11-08 20:36:53'),
(45, 3, 12, '2010-06-21', 7, NULL, '', '2010-11-08 20:36:53', '2010-11-08 20:36:53'),
(46, 3, 12, '2010-06-28', 7, NULL, '', '2010-11-08 20:36:53', '2010-11-08 20:36:53'),
(47, 3, 12, '2010-07-05', 7, NULL, '', '2010-11-08 20:36:53', '2010-11-08 20:36:53'),
(48, 3, 12, '2010-07-12', 7, NULL, '', '2010-11-08 20:36:53', '2010-11-08 20:36:53'),
(49, 3, 12, '2010-07-19', 7, NULL, '', '2010-11-08 20:36:53', '2010-11-08 20:36:53'),
(50, 3, 12, '2010-07-26', 7, NULL, '', '2010-11-08 20:36:53', '2010-11-08 20:36:53'),
(51, 3, 12, '2010-08-02', 7, NULL, '', '2010-11-08 20:36:53', '2010-11-08 20:36:53'),
(52, 3, 12, '2010-08-09', 7, NULL, '', '2010-11-08 20:36:53', '2010-11-08 20:36:53'),
(53, 3, 12, '2010-08-16', 7, NULL, '', '2010-11-08 20:36:53', '2010-11-08 20:36:53'),
(54, 3, 12, '2010-08-23', 7, NULL, '', '2010-11-08 20:36:53', '2010-11-08 20:36:53'),
(55, 3, 12, '2010-08-30', 7, NULL, '', '2010-11-08 20:36:53', '2010-11-08 20:36:53'),
(56, 3, 12, '2010-09-06', 7, NULL, '', '2010-11-08 20:36:53', '2010-11-08 20:36:53'),
(57, 3, 12, '2010-09-13', 7, NULL, '', '2010-11-08 20:36:53', '2010-11-08 20:36:53'),
(58, 3, 12, '2010-09-20', 7, NULL, '', '2010-11-08 20:36:53', '2010-11-08 20:36:53'),
(59, 3, 12, '2010-09-27', 7, NULL, '', '2010-11-08 20:36:53', '2010-11-08 20:36:53'),
(60, 3, 12, '2010-10-04', 7, NULL, '', '2010-11-08 20:36:53', '2010-11-08 20:36:53'),
(61, 3, 12, '2010-10-11', 7, NULL, '', '2010-11-08 20:36:53', '2010-11-08 20:36:53'),
(62, 3, 12, '2010-10-18', 7, NULL, '', '2010-11-08 20:36:53', '2010-11-08 20:36:53'),
(63, 3, 12, '2010-10-25', 7, NULL, '', '2010-11-08 20:36:53', '2010-11-08 20:36:53'),
(64, 3, 12, '2010-11-01', 7, NULL, '', '2010-11-08 20:36:53', '2010-11-08 20:36:53'),
(65, 3, 12, '2010-11-08', 7, NULL, '', '2010-11-08 20:36:53', '2010-11-08 20:36:53'),
(66, 11, 13, '2010-11-01', 7, 10, 'Design', '2010-11-08 20:42:22', '2010-11-08 20:42:42'),
(67, 11, 13, '2010-11-08', 7, 10, 'Review', '2010-11-08 20:42:22', '2010-11-08 20:42:42'),
(68, 11, 14, '2010-11-15', 7, 18, 'Perfom', '2010-11-08 20:44:15', '2010-11-08 20:44:41'),
(74, 11, 17, '2010-11-22', 7, 10, 'Report', '2010-11-08 21:01:17', '2010-11-08 21:01:40'),
(75, 11, 17, '2010-11-29', 7, NULL, '', '2010-11-08 21:01:17', '2010-11-08 21:01:17'),
(76, 11, 17, '2010-12-06', 7, NULL, '', '2010-11-08 21:01:17', '2010-11-08 21:01:17'),
(77, 11, 17, '2010-12-13', 7, NULL, '', '2010-11-08 21:01:17', '2010-11-08 21:01:17'),
(78, 11, 17, '2010-12-20', 7, NULL, '', '2010-11-08 21:01:17', '2010-11-08 21:01:17');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `wps`
--

CREATE TABLE IF NOT EXISTS `wps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `baseline_id` int(11) DEFAULT NULL,
  `p_estimate` int(11) DEFAULT NULL,
  `m_estimate` int(11) DEFAULT NULL,
  `o_estimate` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=34 ;

--
-- Daten für Tabelle `wps`
--

INSERT INTO `wps` (`id`, `baseline_id`, `p_estimate`, `m_estimate`, `o_estimate`, `name`, `created_at`, `updated_at`) VALUES
(1, 1, 0, 0, 0, 'asdf', '2010-05-26 18:43:11', '2010-05-26 18:43:11'),
(2, 1, 0, 0, 0, 'asdf', '2010-05-26 18:43:11', '2010-05-26 18:43:11'),
(3, 2, 10, 5, 1, 'Client Demo', '2010-05-26 20:46:31', '2010-05-26 20:55:34'),
(4, 2, 20, 15, 10, 'GUI Implementation', '2010-05-26 20:46:31', '2010-05-26 20:55:34'),
(5, 2, 20, 7, 5, 'Test', '2010-05-26 20:46:31', '2010-05-26 20:55:34'),
(6, 2, 3, 2, 1, 'Design Guide', '2010-05-26 20:46:31', '2010-05-26 20:55:34'),
(7, 3, 30, 20, 10, 'Hardware', '2010-05-26 20:58:58', '2010-05-26 20:59:21'),
(8, 3, 50, 20, 10, 'Software', '2010-05-26 20:58:58', '2010-05-26 20:59:21'),
(9, 4, 10, 5, 1, 'Client Demo', '2010-05-26 21:06:38', '2010-05-26 21:06:38'),
(10, 4, 20, 15, 10, 'GUI Implementation', '2010-05-26 21:06:38', '2010-05-26 21:06:38'),
(11, 4, 20, 7, 5, 'Test', '2010-05-26 21:06:38', '2010-05-26 21:06:38'),
(12, 4, 3, 2, 1, 'Design Guide', '2010-05-26 21:06:38', '2010-05-26 21:06:38'),
(13, 5, 13, 12, 10, 'asfasd', '2010-09-29 20:24:35', '2010-09-29 20:30:19'),
(14, 5, 40, 30, 20, 'sadadfs', '2010-09-29 20:24:35', '2010-09-29 20:30:19'),
(15, 6, 11, 10, 5, 'asdf', '2010-09-29 21:09:25', '2010-09-29 21:10:04'),
(16, 6, 3, 2, 1, 'asdf', '2010-09-29 21:09:25', '2010-09-29 21:10:04'),
(20, 8, 12, 10, 5, 'Design Concept', '2010-11-04 21:30:56', '2010-11-04 21:32:19'),
(21, 8, 12, 11, 10, 'Implement Sandbox', '2010-11-04 21:30:56', '2010-11-04 21:32:19'),
(22, 8, 10, 7, 5, 'Test with vendor', '2010-11-04 21:30:56', '2010-11-04 21:32:19'),
(23, 8, 4, 2, 2, 'Test in Production', '2010-11-04 21:30:56', '2010-11-04 21:32:19'),
(24, 9, 10, 7, 5, 'Design Testcases', '2010-11-08 20:41:10', '2010-11-08 20:42:08'),
(25, 9, 20, 10, 5, 'Review Testcases with Users', '2010-11-08 20:41:10', '2010-11-08 20:42:08'),
(26, 9, 60, 20, 10, 'Perform Test', '2010-11-08 20:41:10', '2010-11-08 20:42:08'),
(27, 9, 5, 5, 5, 'Create Report', '2010-11-08 20:41:10', '2010-11-08 20:42:08'),
(28, 10, 20, 12, 10, 'sadf', '2010-11-10 21:33:32', '2010-11-10 21:34:06'),
(29, 11, 20, 19, 5, 'asdf', '2010-11-10 21:42:30', '2010-11-10 21:42:57'),
(30, 12, 10, 5, 1, 'Client Demo', '2010-11-10 21:46:49', '2010-11-10 21:46:49'),
(31, 12, 20, 15, 10, 'GUI Implementation', '2010-11-10 21:46:49', '2010-11-10 21:46:49'),
(32, 12, 20, 7, 5, 'Test', '2010-11-10 21:46:49', '2010-11-10 21:46:49'),
(33, 12, 3, 2, 1, 'Design Guide', '2010-11-10 21:46:49', '2010-11-10 21:46:49');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `wp_actuals`
--

CREATE TABLE IF NOT EXISTS `wp_actuals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wp_id` int(11) DEFAULT NULL,
  `estimation_id` int(11) DEFAULT NULL,
  `status` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=44 ;

--
-- Daten für Tabelle `wp_actuals`
--

INSERT INTO `wp_actuals` (`id`, `wp_id`, `estimation_id`, `status`, `created_at`, `updated_at`) VALUES
(5, 7, 2, 'closed', '2010-05-26 21:00:20', '2010-05-26 21:00:20'),
(6, 8, 2, 'ongoing', '2010-05-26 21:00:20', '2010-05-26 21:00:20'),
(7, 13, 6, 'ongoing', '2010-09-29 21:07:25', '2010-09-29 21:07:25'),
(8, 14, 6, 'open', '2010-09-29 21:07:25', '2010-09-29 21:07:25'),
(9, 15, 7, 'ongoing', '2010-09-29 21:14:53', '2010-09-29 21:14:53'),
(10, 16, 7, 'open', '2010-09-29 21:14:53', '2010-09-29 21:14:53'),
(14, 9, 9, 'closed', '2010-11-04 21:33:17', '2010-11-04 21:33:17'),
(15, 10, 9, 'closed', '2010-11-04 21:33:17', '2010-11-04 21:33:17'),
(16, 11, 9, 'ongoing', '2010-11-04 21:33:17', '2010-11-04 21:33:17'),
(17, 12, 9, 'open', '2010-11-04 21:33:17', '2010-11-04 21:33:17'),
(18, 20, 10, 'closed', '2010-11-04 21:39:11', '2010-11-04 21:39:11'),
(19, 21, 10, 'closed', '2010-11-04 21:39:11', '2010-11-04 21:39:11'),
(20, 22, 10, 'open', '2010-11-04 21:39:11', '2010-11-04 21:39:11'),
(21, 23, 10, 'open', '2010-11-04 21:39:11', '2010-11-04 21:39:11'),
(22, 20, 11, 'closed', '2010-11-04 21:39:57', '2010-11-04 21:39:57'),
(23, 21, 11, 'closed', '2010-11-04 21:39:57', '2010-11-04 21:39:57'),
(24, 22, 11, 'closed', '2010-11-04 21:39:57', '2010-11-04 21:39:57'),
(25, 23, 11, 'open', '2010-11-04 21:39:57', '2010-11-04 21:39:57'),
(26, 7, 12, 'closed', '2010-11-08 20:37:24', '2010-11-08 20:37:24'),
(27, 8, 12, 'closed', '2010-11-08 20:37:24', '2010-11-08 20:37:24'),
(28, 24, 13, 'closed', '2010-11-08 20:42:42', '2010-11-08 20:42:42'),
(29, 25, 13, 'ongoing', '2010-11-08 20:42:42', '2010-11-08 20:42:42'),
(30, 26, 13, 'open', '2010-11-08 20:42:42', '2010-11-08 20:42:42'),
(31, 27, 13, 'open', '2010-11-08 20:42:42', '2010-11-08 20:42:42'),
(32, 24, 14, 'closed', '2010-11-08 20:44:41', '2010-11-08 20:44:41'),
(33, 25, 14, 'ongoing', '2010-11-08 20:44:41', '2010-11-08 20:44:41'),
(34, 26, 14, 'ongoing', '2010-11-08 20:44:41', '2010-11-08 20:44:41'),
(35, 27, 14, 'open', '2010-11-08 20:44:41', '2010-11-08 20:44:41'),
(40, 24, 17, 'closed', '2010-11-08 21:01:40', '2010-11-08 21:01:40'),
(41, 25, 17, 'closed', '2010-11-08 21:01:40', '2010-11-08 21:01:40'),
(42, 26, 17, 'ongoing', '2010-11-08 21:01:40', '2010-11-08 21:01:40'),
(43, 27, 17, 'open', '2010-11-08 21:01:40', '2010-11-08 21:01:40');
