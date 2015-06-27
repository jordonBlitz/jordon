-- phpMyAdmin SQL Dump
-- version 4.0.10.7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 27, 2015 at 02:36 AM
-- Server version: 5.5.42-cll
-- PHP Version: 5.4.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `bizlogic_jordon_demo`
--

-- --------------------------------------------------------

--
-- Table structure for table `jordon_banned`
--

CREATE TABLE IF NOT EXISTS `jordon_banned` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('email','ip','username') COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `comment` text COLLATE utf8_unicode_ci,
  `date_added` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `date_added` (`date_added`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `jordon_language`
--

CREATE TABLE IF NOT EXISTS `jordon_language` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `iso_3166_1` varchar(5) COLLATE utf8_unicode_ci NOT NULL COMMENT 'http://en.wikipedia.org/wiki/ISO_3166-1',
  `iso_639` varchar(2) COLLATE utf8_unicode_ci NOT NULL COMMENT 'locale',
  `friendly_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `native_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `active` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `active` (`active`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `jordon_language`
--

INSERT INTO `jordon_language` (`id`, `iso_3166_1`, `iso_639`, `friendly_name`, `native_name`, `active`) VALUES(1, 'en-us', 'en', 'English (U.S.)', 'English', '1');
INSERT INTO `jordon_language` (`id`, `iso_3166_1`, `iso_639`, `friendly_name`, `native_name`, `active`) VALUES(2, 'de-de', 'de', 'German', 'Deutsch', '1');

-- --------------------------------------------------------

--
-- Table structure for table `jordon_metadata`
--

CREATE TABLE IF NOT EXISTS `jordon_metadata` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `object_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_created` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid_key_value` (`object_uuid`,`key`,`value`),
  KEY `key` (`key`),
  KEY `value` (`value`),
  KEY `object_uuid` (`object_uuid`),
  KEY `date_created` (`date_created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `jordon_privacy_type`
--

CREATE TABLE IF NOT EXISTS `jordon_privacy_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `active` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '1' COMMENT '0 - 100',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `active` (`active`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `jordon_privacy_type`
--

INSERT INTO `jordon_privacy_type` (`id`, `name`, `active`) VALUES(1, 'public', '1');
INSERT INTO `jordon_privacy_type` (`id`, `name`, `active`) VALUES(2, 'private', '1');
INSERT INTO `jordon_privacy_type` (`id`, `name`, `active`) VALUES(3, 'unlisted', '1');

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project`
--

CREATE TABLE IF NOT EXISTS `jordon_project` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `branding` text COLLATE utf8_unicode_ci,
  `url` text COLLATE utf8_unicode_ci,
  `lead` bigint(20) unsigned DEFAULT NULL,
  `privacy` enum('public','private','unlisted') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'public',
  `active` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '1',
  `date_created` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `date_created` (`date_created`),
  KEY `key` (`key`),
  KEY `lead` (`lead`),
  KEY `privacy` (`privacy`),
  KEY `active` (`active`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `jordon_project`
--

INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(1, 'BWT', 'Bewerbungstool', 'Bewerbungstool', '<i class="fa fa-briefcase"></i>', 'http://pac.pmhdev.com', 1, 'public', '1', 1427484146);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(2, 'REPORTING', 'Reporting Tool', 'Reporting Tool', '<i class="fa fa-area-chart"></i>', 'http://reports.pmgd.info', 1, 'public', '1', 1432194219);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(3, 'COMPRESSION', 'PDF Compression', 'PDF Compression', '<i class="fa fa-file-pdf-o"></i>', NULL, 1, 'public', '1', 1432194739);

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_activity`
--

CREATE TABLE IF NOT EXISTS `jordon_project_activity` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned DEFAULT NULL,
  `parent_uuid` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'UUID of item that action was performed on',
  `action_uuid` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'UUID of action item',
  `action` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `target` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `by` bigint(20) DEFAULT NULL,
  `ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `date` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `issue_id` (`project_id`),
  KEY `date` (`date`),
  KEY `changed_by` (`by`),
  KEY `action` (`action`),
  KEY `parent_uuid` (`parent_uuid`),
  KEY `type` (`target`),
  KEY `ip` (`ip`),
  KEY `action_uuid` (`action_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_category`
--

CREATE TABLE IF NOT EXISTS `jordon_project_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `sort_order` int(10) unsigned DEFAULT NULL,
  `date_created` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `date_created` (`date_created`),
  KEY `description` (`description`),
  KEY `sort_order` (`sort_order`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `jordon_project_category`
--

INSERT INTO `jordon_project_category` (`id`, `title`, `description`, `sort_order`, `date_created`) VALUES(1, 'Product Media Holding', NULL, NULL, 1406259128);

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_category_rel`
--

CREATE TABLE IF NOT EXISTS `jordon_project_category_rel` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL,
  `category_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`project_id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_issue`
--

CREATE TABLE IF NOT EXISTS `jordon_project_issue` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `project_id` bigint(20) unsigned NOT NULL,
  `project_issue_id` bigint(20) unsigned NOT NULL,
  `revision_uuid` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_last_comment` int(10) unsigned DEFAULT NULL,
  `date_created` int(10) unsigned NOT NULL,
  `date_resolved` int(10) unsigned DEFAULT NULL,
  `date_updated` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `project_id_project_issue_id` (`project_id`,`project_issue_id`),
  UNIQUE KEY `revision_uuid` (`revision_uuid`),
  KEY `project_id` (`project_id`),
  KEY `project_issue_id` (`project_issue_id`),
  KEY `date_created` (`date_created`),
  KEY `date_last_comment` (`date_last_comment`),
  KEY `date_resolved` (`date_resolved`),
  KEY `date_updated` (`date_updated`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_issue_activity`
--

CREATE TABLE IF NOT EXISTS `jordon_project_issue_activity` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `issue_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `action_uuid` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `action` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `by` bigint(20) unsigned DEFAULT NULL,
  `ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `date` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `date` (`date`),
  KEY `action` (`action`),
  KEY `ip` (`ip`),
  KEY `by` (`by`),
  KEY `action_uuid` (`action_uuid`),
  KEY `issue_uuid` (`issue_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_issue_attachment`
--

CREATE TABLE IF NOT EXISTS `jordon_project_issue_attachment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `message_id` bigint(20) unsigned DEFAULT NULL,
  `issue_id` bigint(20) unsigned NOT NULL,
  `uploader_id` bigint(20) unsigned NOT NULL,
  `date_added` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `date_added` (`date_added`),
  KEY `message_id` (`message_id`),
  KEY `issue_id` (`issue_id`),
  KEY `uploader_id` (`uploader_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_issue_comment`
--

CREATE TABLE IF NOT EXISTS `jordon_project_issue_comment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `issue_id` bigint(20) unsigned NOT NULL,
  `reply_to` bigint(20) unsigned DEFAULT NULL,
  `author_id` bigint(20) unsigned DEFAULT NULL,
  `comment` text COLLATE utf8_unicode_ci,
  `ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `issue_id` (`issue_id`),
  KEY `posted_by` (`author_id`),
  KEY `date` (`date`),
  KEY `reply_to` (`reply_to`),
  KEY `ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_issue_comment_history`
--

CREATE TABLE IF NOT EXISTS `jordon_project_issue_comment_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `issue_id` bigint(20) unsigned NOT NULL,
  `changed_by` bigint(20) unsigned NOT NULL,
  `source` text COLLATE utf8_unicode_ci,
  `edit` text COLLATE utf8_unicode_ci NOT NULL,
  `date` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `issue_id` (`issue_id`),
  KEY `date` (`date`),
  KEY `changed_by` (`changed_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_issue_component`
--

CREATE TABLE IF NOT EXISTS `jordon_project_issue_component` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `issue_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_created` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `title` (`title`),
  KEY `date_created` (`date_created`),
  KEY `issue_id` (`issue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_issue_component_version`
--

CREATE TABLE IF NOT EXISTS `jordon_project_issue_component_version` (
  `id` bigint(20) unsigned NOT NULL,
  `component_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_released` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `component_id` (`component_id`),
  KEY `date_released` (`date_released`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_issue_priority`
--

CREATE TABLE IF NOT EXISTS `jordon_project_issue_priority` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `severity` int(11) DEFAULT NULL COMMENT '0 - 100',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `severity` (`severity`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=11 ;

--
-- Dumping data for table `jordon_project_issue_priority`
--

INSERT INTO `jordon_project_issue_priority` (`id`, `name`, `severity`) VALUES(1, 'blocker', 100);
INSERT INTO `jordon_project_issue_priority` (`id`, `name`, `severity`) VALUES(2, 'critical', 95);
INSERT INTO `jordon_project_issue_priority` (`id`, `name`, `severity`) VALUES(3, 'minor', 5);
INSERT INTO `jordon_project_issue_priority` (`id`, `name`, `severity`) VALUES(4, 'major', 50);
INSERT INTO `jordon_project_issue_priority` (`id`, `name`, `severity`) VALUES(5, 'trivial', 0);
INSERT INTO `jordon_project_issue_priority` (`id`, `name`, `severity`) VALUES(6, 'normal', 20);
INSERT INTO `jordon_project_issue_priority` (`id`, `name`, `severity`) VALUES(7, 'low', 10);
INSERT INTO `jordon_project_issue_priority` (`id`, `name`, `severity`) VALUES(8, 'urgent', 90);
INSERT INTO `jordon_project_issue_priority` (`id`, `name`, `severity`) VALUES(9, 'very_low', 1);
INSERT INTO `jordon_project_issue_priority` (`id`, `name`, `severity`) VALUES(10, 'high', 85);

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_issue_rel`
--

CREATE TABLE IF NOT EXISTS `jordon_project_issue_rel` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `issue_id` bigint(20) unsigned NOT NULL,
  `related_issue_id` bigint(20) unsigned NOT NULL,
  `relation` int(10) unsigned NOT NULL,
  `date` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `issue_voter_id` (`issue_id`,`related_issue_id`),
  UNIQUE KEY `name` (`relation`),
  KEY `date_created` (`date`),
  KEY `issue_id` (`issue_id`),
  KEY `voter_id` (`related_issue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_issue_rel_type`
--

CREATE TABLE IF NOT EXISTS `jordon_project_issue_rel_type` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `issue_voter_id` (`title`),
  KEY `issue_id` (`title`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=8 ;

--
-- Dumping data for table `jordon_project_issue_rel_type`
--

INSERT INTO `jordon_project_issue_rel_type` (`id`, `title`) VALUES(3, 'blocked_by');
INSERT INTO `jordon_project_issue_rel_type` (`id`, `title`) VALUES(2, 'blocks');
INSERT INTO `jordon_project_issue_rel_type` (`id`, `title`) VALUES(1, 'depends_on');
INSERT INTO `jordon_project_issue_rel_type` (`id`, `title`) VALUES(6, 'raised_by');
INSERT INTO `jordon_project_issue_rel_type` (`id`, `title`) VALUES(5, 'raises');
INSERT INTO `jordon_project_issue_rel_type` (`id`, `title`) VALUES(4, 'related');
INSERT INTO `jordon_project_issue_rel_type` (`id`, `title`) VALUES(7, 'subtask');

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_issue_resolution`
--

CREATE TABLE IF NOT EXISTS `jordon_project_issue_resolution` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

--
-- Dumping data for table `jordon_project_issue_resolution`
--

INSERT INTO `jordon_project_issue_resolution` (`id`, `name`) VALUES(8, 'cannot_reproduce');
INSERT INTO `jordon_project_issue_resolution` (`id`, `name`) VALUES(6, 'invalid');
INSERT INTO `jordon_project_issue_resolution` (`id`, `name`) VALUES(7, 'not_bug');
INSERT INTO `jordon_project_issue_resolution` (`id`, `name`) VALUES(4, 'rejected');
INSERT INTO `jordon_project_issue_resolution` (`id`, `name`) VALUES(2, 'resolved');
INSERT INTO `jordon_project_issue_resolution` (`id`, `name`) VALUES(1, 'unresolved');
INSERT INTO `jordon_project_issue_resolution` (`id`, `name`) VALUES(5, 'wont_fix');

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_issue_revision`
--

CREATE TABLE IF NOT EXISTS `jordon_project_issue_revision` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `revision` bigint(20) unsigned DEFAULT NULL,
  `revision_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `revised_by` bigint(20) unsigned DEFAULT NULL,
  `project_id` bigint(20) unsigned NOT NULL,
  `project_issue_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `affected_version` bigint(20) unsigned DEFAULT NULL,
  `type` bigint(20) unsigned DEFAULT NULL,
  `reporter` bigint(20) unsigned DEFAULT NULL,
  `assignee` bigint(20) DEFAULT NULL,
  `priority` bigint(20) unsigned DEFAULT NULL,
  `privacy` int(11) unsigned DEFAULT NULL,
  `status` bigint(20) unsigned DEFAULT NULL,
  `state` bigint(20) unsigned DEFAULT NULL,
  `resolution` bigint(20) unsigned DEFAULT NULL,
  `date_last_comment` int(10) unsigned DEFAULT NULL,
  `date_released` int(10) unsigned DEFAULT NULL,
  `date_created` int(10) unsigned NOT NULL,
  `date_updated` int(10) unsigned DEFAULT NULL,
  `date_resolved` int(10) unsigned DEFAULT NULL,
  `date_revision` int(10) unsigned NOT NULL,
  `ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `revision_uuid` (`revision_uuid`),
  UNIQUE KEY `uuid_version_pair` (`uuid`,`revision`),
  UNIQUE KEY `project_id_project_issue_id_revision` (`project_id`,`project_issue_id`,`revision`),
  KEY `date_created` (`date_created`),
  KEY `name` (`title`),
  KEY `date_released` (`date_released`),
  KEY `project_id` (`project_id`),
  KEY `state` (`state`),
  KEY `date_updated` (`date_updated`),
  KEY `date_resolved` (`date_resolved`),
  KEY `date_last_comment` (`date_last_comment`),
  KEY `privacy` (`privacy`),
  KEY `affected_version` (`affected_version`),
  KEY `assignee` (`assignee`),
  KEY `priority` (`priority`),
  KEY `status` (`status`),
  KEY `type` (`type`),
  KEY `project_issue_id` (`project_issue_id`),
  KEY `resolution` (`resolution`),
  KEY `reporter` (`reporter`),
  KEY `version` (`revision`),
  KEY `date_revision` (`date_revision`),
  KEY `revised_by` (`revised_by`),
  KEY `ip` (`ip`),
  KEY `project_id_2` (`project_id`,`project_issue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_issue_state`
--

CREATE TABLE IF NOT EXISTS `jordon_project_issue_state` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sort_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `sort_order` (`sort_order`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `jordon_project_issue_state`
--

INSERT INTO `jordon_project_issue_state` (`id`, `name`, `sort_order`) VALUES(1, 'open', 1);
INSERT INTO `jordon_project_issue_state` (`id`, `name`, `sort_order`) VALUES(2, 'closed', 2);

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_issue_status`
--

CREATE TABLE IF NOT EXISTS `jordon_project_issue_status` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=14 ;

--
-- Dumping data for table `jordon_project_issue_status`
--

INSERT INTO `jordon_project_issue_status` (`id`, `name`) VALUES(3, 'assigned');
INSERT INTO `jordon_project_issue_status` (`id`, `name`) VALUES(8, 'cannot_reproduce');
INSERT INTO `jordon_project_issue_status` (`id`, `name`) VALUES(12, 'confirmed');
INSERT INTO `jordon_project_issue_status` (`id`, `name`) VALUES(9, 'fixed');
INSERT INTO `jordon_project_issue_status` (`id`, `name`) VALUES(11, 'in_progress');
INSERT INTO `jordon_project_issue_status` (`id`, `name`) VALUES(6, 'invalid');
INSERT INTO `jordon_project_issue_status` (`id`, `name`) VALUES(7, 'not_bug');
INSERT INTO `jordon_project_issue_status` (`id`, `name`) VALUES(4, 'rejected');
INSERT INTO `jordon_project_issue_status` (`id`, `name`) VALUES(13, 'reopened');
INSERT INTO `jordon_project_issue_status` (`id`, `name`) VALUES(10, 'resolved');
INSERT INTO `jordon_project_issue_status` (`id`, `name`) VALUES(2, 'unassigned');
INSERT INTO `jordon_project_issue_status` (`id`, `name`) VALUES(1, 'unconfirmed');
INSERT INTO `jordon_project_issue_status` (`id`, `name`) VALUES(5, 'wont_fix');

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_issue_subcomponent`
--

CREATE TABLE IF NOT EXISTS `jordon_project_issue_subcomponent` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `component_id` bigint(20) unsigned NOT NULL,
  `issue_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `title` (`issue_id`),
  KEY `issue_id` (`component_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_issue_time_tracking`
--

CREATE TABLE IF NOT EXISTS `jordon_project_issue_time_tracking` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `issue_id` bigint(20) unsigned NOT NULL,
  `type` enum('estimate','actual') COLLATE utf8_unicode_ci NOT NULL,
  `time` int(10) unsigned NOT NULL COMMENT 'in minutes',
  `date` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `date` (`date`),
  KEY `issue_id` (`issue_id`),
  KEY `type` (`type`),
  KEY `time` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_issue_type`
--

CREATE TABLE IF NOT EXISTS `jordon_project_issue_type` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `active` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `active` (`active`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10 ;

--
-- Dumping data for table `jordon_project_issue_type`
--

INSERT INTO `jordon_project_issue_type` (`id`, `name`, `active`) VALUES(1, 'feature_request', '1');
INSERT INTO `jordon_project_issue_type` (`id`, `name`, `active`) VALUES(2, 'bug', '1');
INSERT INTO `jordon_project_issue_type` (`id`, `name`, `active`) VALUES(3, 'support_request', '1');
INSERT INTO `jordon_project_issue_type` (`id`, `name`, `active`) VALUES(4, 'improvement', '1');
INSERT INTO `jordon_project_issue_type` (`id`, `name`, `active`) VALUES(5, 'third_party', '1');
INSERT INTO `jordon_project_issue_type` (`id`, `name`, `active`) VALUES(6, 'task', '1');
INSERT INTO `jordon_project_issue_type` (`id`, `name`, `active`) VALUES(7, 'subtask', '1');
INSERT INTO `jordon_project_issue_type` (`id`, `name`, `active`) VALUES(8, 'story', '0');
INSERT INTO `jordon_project_issue_type` (`id`, `name`, `active`) VALUES(9, 'epic', '0');

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_issue_vote`
--

CREATE TABLE IF NOT EXISTS `jordon_project_issue_vote` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `issue_id` bigint(20) unsigned NOT NULL,
  `voter_id` bigint(20) unsigned NOT NULL,
  `type` enum('for','against','abstain') COLLATE utf8_unicode_ci DEFAULT 'for',
  `date` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `issue_voter_id` (`issue_id`,`voter_id`),
  UNIQUE KEY `name` (`type`),
  KEY `date_created` (`date`),
  KEY `issue_id` (`issue_id`),
  KEY `voter_id` (`voter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_issue_watch`
--

CREATE TABLE IF NOT EXISTS `jordon_project_issue_watch` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `issue_id` bigint(20) unsigned NOT NULL,
  `watcher_id` bigint(20) unsigned NOT NULL,
  `type` enum('email','feed') COLLATE utf8_unicode_ci DEFAULT 'email',
  `date` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `issue_voter_id` (`issue_id`,`watcher_id`),
  UNIQUE KEY `name` (`type`),
  KEY `date_created` (`date`),
  KEY `issue_id` (`issue_id`),
  KEY `voter_id` (`watcher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_permission`
--

CREATE TABLE IF NOT EXISTS `jordon_project_permission` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL,
  `target_uuid` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'User or Usergroup UUID',
  `permission_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroup_perm_project` (`target_uuid`,`permission_id`,`project_id`),
  KEY `permission_id` (`permission_id`),
  KEY `project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_permission_type`
--

CREATE TABLE IF NOT EXISTS `jordon_project_permission_type` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `role` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `jordon_project_permission_type`
--

INSERT INTO `jordon_project_permission_type` (`id`, `name`) VALUES(3, 'can_comment');
INSERT INTO `jordon_project_permission_type` (`id`, `name`) VALUES(2, 'can_edit');
INSERT INTO `jordon_project_permission_type` (`id`, `name`) VALUES(1, 'can_view');

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_role`
--

CREATE TABLE IF NOT EXISTS `jordon_project_role` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8 NOT NULL,
  `description` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `date_added` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `date_created` (`date_added`),
  KEY `description` (`description`),
  KEY `user_id` (`uuid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `jordon_project_role`
--

INSERT INTO `jordon_project_role` (`id`, `uuid`, `title`, `description`, `date_added`) VALUES(1, '60a4581e-6749-4646-8b78-5918f3f6a3a1', 'project_lead', 'Project Lead', 1406262374);

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_role_assignment`
--

CREATE TABLE IF NOT EXISTS `jordon_project_role_assignment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) unsigned NOT NULL,
  `target_uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `date_assigned` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroup_id_and_permissions_id` (`role_id`,`target_uuid`),
  KEY `permission_id` (`target_uuid`),
  KEY `date_assigned` (`date_assigned`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `jordon_project_version`
--

CREATE TABLE IF NOT EXISTS `jordon_project_version` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `version` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `summary` text COLLATE utf8_unicode_ci,
  `release_notes` text COLLATE utf8_unicode_ci,
  `privacy` int(10) unsigned DEFAULT NULL,
  `date_released` int(10) unsigned DEFAULT NULL,
  `date_created` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id_version` (`project_id`,`version`),
  KEY `date_created` (`date_created`),
  KEY `name` (`name`),
  KEY `date_released` (`date_released`),
  KEY `project_id` (`project_id`),
  KEY `version` (`version`),
  KEY `privacy` (`privacy`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `jordon_project_version`
--

INSERT INTO `jordon_project_version` (`id`, `project_id`, `name`, `version`, `description`, `summary`, `release_notes`, `privacy`, `date_released`, `date_created`) VALUES(1, 1, 'MVP', 'MVP', NULL, NULL, NULL, 1, 1406636233, 1406636233);
INSERT INTO `jordon_project_version` (`id`, `project_id`, `name`, `version`, `description`, `summary`, `release_notes`, `privacy`, `date_released`, `date_created`) VALUES(2, 2, '1.0', '1.0', NULL, NULL, NULL, 1, NULL, 1432302932);

-- --------------------------------------------------------

--
-- Table structure for table `jordon_site_config`
--

CREATE TABLE IF NOT EXISTS `jordon_site_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `possible_values` text COLLATE utf8_unicode_ci,
  `category` enum('admin','global','social','upload','user') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'global',
  `ui_type` enum('radio','select','text','textarea') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'text',
  `hint` text COLLATE utf8_unicode_ci COMMENT 'hint to present in the UI',
  `comment` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `editable` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `category` (`category`),
  KEY `comment` (`comment`),
  KEY `value` (`value`),
  KEY `editable` (`editable`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=109 ;

--
-- Dumping data for table `jordon_site_config`
--

INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(1, 'site_name', 'Jordon', NULL, 'global', 'text', 'Site Name', NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(2, 'site_default_preloader_image_path', '__BASEURL__/images/preloader/486.gif', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(3, 'site_default_landing_page', 'projects', NULL, 'global', 'text', 'Local URL to redirect to after login, do not include the scheme, i.e. http://', NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(4, 'site_allow_template_change', '1', '0,1', 'global', 'radio', 'Allow Template Change', NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(5, 'site_default_template', 'yeti', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(6, 'site_default_max_upload_size', '1073741824', NULL, 'upload', 'text', 'Max upload size in bytes', 'in bytes', '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(7, 'site_allowed_file_types', '*', NULL, 'upload', 'text', 'File types allowed for upload. Separate entries with commas. Use * to allow all.', NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(8, 'site_default_avatar_url', '__BASEURL__/images/profiles/anonymousUser.jpg', NULL, 'user', 'text', 'Full URL of the default user avatar', NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(9, 'site_default_language', 'en-us', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(10, 'site_guest_max_recipients', '3', NULL, 'upload', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(11, 'site_guest_max_queue_size', '5', NULL, 'upload', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(12, 'site_guest_max_file_size', '2', NULL, 'upload', 'text', NULL, 'in MB', '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(13, 'site_guest_total_file_size', '10', NULL, 'upload', 'text', NULL, 'in MB', '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(14, 'site_allow_language_change', '1', '0,1', 'global', 'radio', 'Allow Language Change', NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(15, 'site_guest_upload_retention', '168', NULL, 'upload', 'text', NULL, 'in hours', '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(16, 'site_moderate_new_users', '1', '0,1', 'user', 'radio', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(17, 'site_require_email_confirm', '1', '0,1', 'user', 'radio', 'Require e-mail confirmation for new user registrations', NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(18, 'site_email_address', 'admin@jordonblitz.com', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(19, 'site_upload_dir', 'data/uploads', NULL, 'upload', 'text', 'Relative path of the local file upload directory', NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(20, 'site_upload_dir_users', 'data/uploads/users', NULL, 'upload', 'text', 'Relative path of the local file upload directory for end-users', NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(22, 'site_token_min_length', '8', NULL, 'upload', 'text', 'Tokens match users to available files', NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(23, 'site_token_max_length', '15', NULL, 'upload', 'text', 'Tokens match users to available files', NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(24, 'site_local_theme_url_root', 'css/jquery-ui/themes', NULL, 'global', 'text', 'Theme root relative to the site. Do not include host or scheme.', 'relative to the site root', '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(25, 'site_default_admin_preloader_image_path', 'images/preloader/477-black-124x128.gif', NULL, 'admin', 'text', 'Local URL of the preloader image for the site admin UI. Do not include the protocol scheme.', NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(26, 'site_default_landing_page_after_login', 'projects', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(52, 'site_use_blockui', '1', '1,0', 'global', 'radio', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(53, 'site_moderate_uploads', '0', '0,1', 'global', 'radio', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(64, 'site_url', 'http://demo.jordonblitz.com', NULL, 'global', 'text', NULL, 'including scheme', '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(77, 'site_facebook_app_id', '324640691020497', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(78, 'site_twitter_api_key', 'KS0tMXGV1jBPHcr9B2NsxplmU', NULL, 'social', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(79, 'site_twitter_api_secret', '4SaA3aauMozDQqJIbEZIiwmJTYj1hBmaF6Ql0PILnBFHi604By', NULL, 'social', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(80, 'site_allow_social_login', '0', '0,1', 'social', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(81, 'site_yahoo_consumer_key', 'dj0yJmk9RlBPU09OTXZxY3hPJmQ9WVdrOVZuVkRWWGRHTXpZbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD04Mg--', NULL, 'social', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(82, 'site_yahoo_consumer_secret', 'e15419d9ab06e7cd727a252c16f03877e68cc7eb', NULL, 'social', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(83, 'site_yahoo_app_id', 'VuCUwF36', NULL, 'social', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(84, 'site_yahoo_domain', '', NULL, 'social', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(85, 'site_windows_live_client_id', '000000004811FC1F', NULL, 'social', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(86, 'site_windows_live_client_secret', '2YIn7AR1kyqSliK5GVh-V6X3U6Bhn6pF', NULL, 'social', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(87, 'site_cookie_expiration_date', '2147483647', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(89, 'site_guest_usergroup_id', '1', NULL, 'user', 'select', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(90, 'site_issue_comment_fetch_limit', '20', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(91, 'site_default_issue_state', '1', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(92, 'site_default_issue_status', '1', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(93, 'site_default_issue_resolution', '1', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(94, 'site_issue_recent_fetch_limit', '15', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(95, 'site_issue_chart_type', 'areaspline', 'area,areaspline', 'global', 'select', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(96, 'site_issue_chart_tooltip_date_format', '%A, %B %d, %Y', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(97, 'site_project_recent_activity_cutoff', '2592000', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(98, 'site_issue_chat_xaxis_date_format', '%B %d', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(99, 'site_date_format', 'l, F, d, Y / h:i:s A P', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(100, 'site_issue_edit_style', 'inline', 'inline,popup', 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(101, 'site_issue_resolution_id', '2', NULL, 'global', 'select', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(102, 'site_cookie_path', '/', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(103, 'site_cookie_timeout', '622080000', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(104, 'site_loading_placeholder_small', '<img src="__BASEURL__/images/preloader/small-black.png" border="0">', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(105, 'site_comment_fetch_limit', '10', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(106, 'site_issue_status_unassigned_id', '2', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(107, 'site_issue_status_assigned_id', '3', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(108, 'site_issue_chart_xaxis_date_format', NULL, NULL, 'global', 'text', NULL, NULL, '1');

-- --------------------------------------------------------

--
-- Table structure for table `jordon_site_permission`
--

CREATE TABLE IF NOT EXISTS `jordon_site_permission` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `permission_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `permission_type` enum('admin','site','upload','user') COLLATE utf8_unicode_ci DEFAULT 'site',
  `comment` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permission_name` (`permission_name`,`permission_type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=26 ;

--
-- Dumping data for table `jordon_site_permission`
--

INSERT INTO `jordon_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(1, 'can_view_site', 'site', NULL);
INSERT INTO `jordon_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(2, 'can_upload', 'upload', NULL);
INSERT INTO `jordon_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(3, 'can_admin_site', 'admin', NULL);
INSERT INTO `jordon_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(4, 'can_view_debug_messages', 'admin', NULL);
INSERT INTO `jordon_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(5, 'can_view_user_profiles', 'site', NULL);
INSERT INTO `jordon_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(6, 'can_edit_own_profile', 'user', NULL);
INSERT INTO `jordon_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(7, 'can_change_own_password', 'user', NULL);
INSERT INTO `jordon_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(8, 'can_delete_own_account', 'user', NULL);
INSERT INTO `jordon_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(9, 'can_admin_site_phrases', 'admin', NULL);
INSERT INTO `jordon_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(10, 'can_admin_users', 'admin', NULL);
INSERT INTO `jordon_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(11, 'can_admin_files', 'admin', 'Can Administer Uploaded Files (Admin)');
INSERT INTO `jordon_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(12, 'can_view_system_dashboard', 'site', NULL);
INSERT INTO `jordon_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(13, 'can_view_project_list', 'user', NULL);
INSERT INTO `jordon_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(14, 'can_comment_on_issues', 'user', NULL);
INSERT INTO `jordon_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(15, 'can_delete_issue_comments', 'admin', NULL);
INSERT INTO `jordon_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(16, 'can_view_issue_comments', 'user', NULL);
INSERT INTO `jordon_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(17, 'can_view_issues', 'user', NULL);
INSERT INTO `jordon_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(18, 'can_create_issues', 'user', NULL);
INSERT INTO `jordon_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(19, 'can_edit_issues', 'admin', NULL);
INSERT INTO `jordon_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(20, 'can_delete_issues', 'admin', NULL);
INSERT INTO `jordon_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(21, 'can_use_firephp', 'admin', NULL);
INSERT INTO `jordon_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(22, 'can_assign_issues', 'admin', NULL);
INSERT INTO `jordon_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(23, 'issue_can_change_reporter', 'admin', NULL);
INSERT INTO `jordon_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(24, 'project_can_view_activity_stream', 'user', NULL);
INSERT INTO `jordon_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES(25, 'email_can_view', 'user', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `jordon_site_phrase`
--

CREATE TABLE IF NOT EXISTS `jordon_site_phrase` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `text` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `language_id_2` (`language_id`,`name`),
  KEY `language_id` (`language_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=278 ;

--
-- Dumping data for table `jordon_site_phrase`
--

INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(1, 1, 'language', 'Language');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(2, 2, 'language', 'Sprache');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(5, 1, 'upload', 'Upload');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(6, 2, 'upload', 'Hochladen');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(7, 1, 'add_files', 'Add Files');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(8, 2, 'add_files', 'Dateien hinzuf');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(9, 1, 'to', 'To');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(10, 2, 'to', 'An');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(13, 1, 'from', 'From');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(14, 2, 'from', 'Von');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(15, 1, 'your_email', 'Your e-mail');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(16, 2, 'your_email', 'Ihre E-Mail');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(17, 1, 'your_friend_email', 'Your friend''s e-mail');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(18, 2, 'your_friend_email', 'Email des Freundes');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(19, 1, 'message', 'Message');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(20, 2, 'message', 'Nachricht');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(21, 1, 'transfer', 'Transfer');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(22, 2, 'transfer', '');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(23, 1, 'file_upload_success', 'YEAH! Your files were successfully uploaded!');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(24, 2, 'file_upload_success', 'Ja! Ihre Dateien wurden erfolgreich hochgeladen!');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(25, 1, 'http_error_404_text', 'The document that you have requested does not exist');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(26, 2, 'http_error_404_text', 'Das Dokument, das Sie angefordert haben existiert nicht');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(27, 1, 'site_default_admin_preloader_image_path', 'Preloader Image Path (URL)');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(28, 1, 'site_allow_language_change', 'Allow Language Change');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(29, 1, 'site_allow_template_change', 'Allow Template Change');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(30, 1, 'site_allowed_file_types', 'Allowed File Types');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(31, 1, 'site_archive_prefix', 'Archive Prefix');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(32, 1, 'site_default_avatar_url', 'Default Avatar URL');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(33, 1, 'admin', 'Admin');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(34, 1, 'global', 'Global');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(35, 1, 'site_default_landing_page', 'Default Landing Page (After Login)');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(36, 1, 'site_default_language', 'Default Site Language');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(37, 1, 'site_default_max_upload_size', 'Max Upload Size');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(38, 1, 'site_default_preloader_image_path', 'Site Preloader Image');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(39, 1, 'site_default_template', 'Default Site Template');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(40, 1, 'site_email_address', 'Site e-mail Address');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(41, 1, 'site_guest_max_file_size', 'Max File Size for Guests');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(42, 1, 'site_guest_max_queue_size', 'Queue Size Limit for Guests');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(43, 1, 'site_guest_max_recipients', 'Max Number of Recipients for Guests');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(44, 1, 'site_guest_total_file_size', 'Total Queue Size for Guests');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(45, 1, 'site_guest_upload_retention', 'Guest Upload Retention');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(46, 1, 'site_local_theme_url_root', 'Relative URL path of themes');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(47, 1, 'site_moderate_new_users', 'Moderate New Users');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(48, 1, 'site_name', 'Site Name');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(49, 1, 'user', 'User');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(50, 1, 'site_require_email_confirm', 'Require e-mail Confirmation after User Registration');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(51, 1, 'site_upload_dir_users', 'Path of upload directory for end-users');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(52, 1, 'site_upload_dir', 'Path of upload directory ');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(53, 1, 'site_token_max_length', 'Max Token Length');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(54, 1, 'site_token_min_length', 'Minimum token length');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(55, 1, 'site_settings', 'Site Settings');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(56, 2, 'site_settings', 'Site-Einstellungen');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(57, 2, 'user', 'Benutzer');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(58, 2, 'settings', 'Einstellungen');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(59, 2, 'site', 'Webseite');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(60, 2, 'phrases', 'S');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(61, 2, 'users', 'Benutzer');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(62, 2, 'all', 'alle');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(63, 2, 'logoff', 'Abmelden');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(64, 2, 'account_settings', 'Konto-Einstellungen');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(65, 2, 'files', 'Dateien');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(66, 1, 'template_color', 'Template Color');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(67, 2, 'template_color', 'Schablone Farbe');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(68, 1, 'save_changes', 'Save Changes');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(69, 1, 'cancel', 'Cancel');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(70, 2, 'save_changes', '');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(71, 2, 'cancel', 'Abbrechen');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(72, 2, 'site_phrases', 'Website-S');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(73, 1, 'site_phrases', 'Site Phrases');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(74, 1, 'logoff', 'Logout');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(75, 1, 'uploaded_files', 'Uploaded Files');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(76, 2, 'uploaded_files', 'Hochgeladene Dateien');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(77, 1, 'orphaned_files', 'Orphaned Files');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(78, 2, 'orphaned_files', 'Verwaiste Dateien');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(79, 1, 'login', 'Login');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(80, 2, 'login', 'Anmelden');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(81, 1, 'forgotten_password', 'Forgotten Password');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(82, 2, 'forgotten_password', 'Passwort vergessen');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(83, 1, 'error', 'Error');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(84, 1, 'login_username_does_not_exist', 'Authentication Failure');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(85, 1, 'authentication_failure', 'Authentication Failure');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(86, 1, 'logout', 'Logout');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(87, 2, 'logout', 'Abmelden');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(88, 1, 'help', 'Help');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(89, 2, 'help', 'Hilfe');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(92, 1, 'themes', 'Themes');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(93, 2, 'themes', 'Thema');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(94, 1, 'password', 'Password');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(95, 2, 'password', 'Kennwort');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(96, 1, 'email', 'e-mail');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(97, 2, 'email', 'Email');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(98, 1, 'to_top', 'Top');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(99, 2, 'to_top', 'Nach oben');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(100, 1, 'all_rights_reserved', 'All Rights Reserved');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(101, 2, 'all_rights_reserved', 'Alle Rechte vorbehalten');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(102, 1, 'copyright', 'Copyright');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(103, 2, 'copyright', 'Copyright');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(104, 1, 'dashboards', 'Dashboards');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(105, 2, 'dashboards', 'Armaturenbrett');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(106, 1, 'search', 'Search');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(107, 2, 'search', 'Suche');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(108, 1, 'system_dashboard', 'System Dashboard');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(109, 2, 'system_dashboard', 'System-Armaturenbrett');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(110, 1, 'about', 'About');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(111, 2, 'about', '');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(112, 1, 'issues', 'Issues');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(113, 1, 'search_issues', 'Search Issues');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(114, 1, 'projects', 'Projects');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(115, 1, 'view_all_projects', 'View All Projects');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(116, 1, 'uncategorized', 'Uncategorized');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(117, 1, 'all_projects', 'All Projects');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(118, 1, 'permission_error', 'Permission Error');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(119, 1, 'permission_error_explantation', 'Your user account does not have permission to access this resource.');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(120, 2, 'projects', 'Projekte');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(121, 2, 'view_all_projects', 'Alle Projekte');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(123, 2, 'issues', 'Themen');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(124, 2, 'search_issues', 'Suche Themen');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(125, 1, 'title', 'Title');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(126, 1, 'priority', 'Priority');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(127, 1, 'date_created', 'Date Created');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(128, 1, 'last_updated', 'Last Updated');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(129, 1, 'summary', 'Summary');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(130, 1, 'status', 'Status');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(131, 1, 'percentage', 'Percentage');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(132, 1, 'trivial', 'Trivial');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(133, 1, 'unconfirmed', 'Unconfirmed');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(134, 1, 'unassigned', 'Unassigned');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(135, 1, 'assigned', 'Assigned');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(136, 1, 'rejected', 'Rejected');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(137, 1, 'wont_fix', 'Won''t Fix');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(138, 1, 'invalid', 'Invalid');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(139, 1, 'not_bug', 'Not a Bug');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(140, 1, 'cannot_reproduce', 'Cannot Reproduce');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(141, 1, 'resolved', 'Resolved');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(142, 1, 'fixed', 'Fixed');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(143, 1, 'no_data', 'No data');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(144, 1, 'details', 'Details');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(145, 1, 'people', 'People');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(146, 1, 'feature_request', 'Feature Request');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(147, 1, 'open', 'Open');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(148, 1, 'dates', 'Dates');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(149, 1, 'created', 'Created');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(150, 1, 'last_comment', 'Last Comment');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(151, 1, 'normal', 'Normal');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(152, 1, 'resolution', 'Resolution');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(153, 1, 'task', 'Task');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(154, 1, 'blocker', 'Blocker');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(155, 1, 'type', 'Type');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(156, 1, 'assignee', 'Assignee');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(157, 1, 'reporter', 'Reporter');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(158, 1, 'never', 'Never');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(159, 2, 'never', 'Niemals');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(160, 1, 'description', 'Description');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(162, 2, 'details', 'Beiwerk');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(164, 2, 'resolution', 'Aufl');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(165, 2, 'priority', 'Priorit');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(166, 2, 'type', 'Typ');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(167, 2, 'people', 'Leute');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(169, 2, 'description', 'Beschreibung');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(170, 2, 'assignee', 'Zugewiesen an');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(172, 2, 'created', 'Erstellt');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(173, 2, 'dates', 'Datum');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(174, 2, 'last_updated', 'Zuletzt aktualisiert');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(175, 2, 'last_comment', 'Letzter Kommentar');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(176, 2, 'open', 'Offen');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(177, 2, 'unconfirmed', 'Unbest');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(178, 2, 'feature_request', 'Neues Feature');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(179, 1, 'activity', 'Activity');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(182, 1, 'all', 'All');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(185, 1, 'comments', 'Comments');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(186, 2, 'comments', 'Kommentare');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(187, 1, 'issue_settings', 'Issue Settings');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(188, 1, 'clean', 'Clean');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(189, 1, 'modern', 'Modern');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(190, 1, 'unresolved', 'Unresolved');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(191, 1, 'state', 'State');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(192, 1, 'moments_ago', 'moments ago');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(194, 2, 'moments_ago', 'Jetzt Gleich');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(195, 1, 'add_comment', 'Add Comment');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(196, 1, 'unhandled_exception', 'Unhandled Exception');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(197, 1, 'no_saved', 'Not Saved');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(198, 1, 'guest', 'Guest');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(199, 1, 'comment', 'Comment');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(200, 1, 'prompt_comment_delete', 'Are you sure that you want to delete this comment?');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(201, 2, 'prompt_comment_delete', 'Sind Sie sicher, dass Sie diesen Kommentar wirklich l');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(202, 1, 'delete', 'Delete');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(203, 2, 'delete', 'L');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(204, 1, 'create_issue', 'Create Issue');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(205, 1, 'create', 'Create');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(206, 1, 'project', 'Project');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(207, 2, 'project', 'Projekt');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(208, 1, 'select_project', 'Select a Project');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(209, 1, 'affected_version', 'Affected Version');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(210, 1, 'privacy', 'Privacy');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(211, 1, 'bug', 'Bug');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(212, 1, 'support_request', 'Support Request');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(213, 1, 'improvement', 'Improvement');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(214, 1, 'third_party', 'Third Party');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(215, 1, 'subtask', 'Subtask');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(216, 1, 'critical', 'Critical');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(217, 1, 'low', 'Low');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(218, 1, 'major', 'Major');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(219, 1, 'minor', 'Minor');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(220, 1, 'urgent', 'Urgent');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(221, 1, 'very_low', 'Very Low');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(222, 1, 'high', 'High');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(223, 1, 'public', 'Public');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(224, 1, 'private', 'Private');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(225, 1, 'unlisted', 'Unlisted');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(226, 1, 'prompt_no_versions', 'This project does not have any versions');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(227, 1, 'prompt_error', 'An error has occurred');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(228, 2, 'state', 'Zustand');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(229, 1, 'activity_stream', 'Activity Stream');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(230, 1, 'no_recent_activity', 'No Recent Activity');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(231, 1, 'issues_30day_summary', 'Issues:&nbsp;&nbsp;30 Day Summary');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(232, 1, 'closed', 'Closed');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(233, 1, 'prompt_issue_delete', 'Are you sure that you want delete this issue?');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(234, 1, 'prompt_irreversible_action', 'This is a permanent, irreversible action');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(235, 1, 'deleting_issue', 'Deleting Issue');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(236, 1, 'edit', 'Edit');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(237, 1, 'exception', 'Exception');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(238, 1, 'error_project_not_found', 'Project not found');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(239, 1, 'error_issue_not_found', 'Issue not found');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(240, 1, 'in_progress', 'In Progress');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(241, 1, 'reopened', 'Re-opened');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(242, 1, 'issue_resolution', 'Issue Resolution');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(243, 1, 'issue_status', 'Issue Status');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(244, 1, 'issue_state', 'Issue State');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(245, 1, 'issue_priority', 'Issue Priority');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(246, 1, 'issue_type', 'Issue Type');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(247, 1, 'issue_description', 'Issue Description');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(248, 1, 'current_project', 'Current Project');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(249, 1, 'not_specified', 'Not Specified');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(251, 1, 'commented_on', 'commented on');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(252, 1, 'key', 'Key');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(253, 1, 'lead', 'Lead');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(254, 1, 'category', 'Category');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(255, 1, 'all_issues', 'All Issues');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(256, 1, 'added_recently', 'Added Recently');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(257, 1, 'resolved_recently', 'Resolved Recently');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(258, 1, 'updated_recently', 'Updated Recently');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(259, 1, 'unscheduled', 'Unscheduled');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(260, 1, 'outstanding', 'Outstanding');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(261, 1, 'recent', 'Recent');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(262, 1, 'confirmed', 'Confirmed');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(263, 1, 'no_permission', 'Your account does not have the required access level to perform this action');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(267, 2, 'issues_30day_summary', 'Themen:&nbsp;&nbsp;30-Tage-Zusammenfassung');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(269, 2, 'resolved', 'entschlossen');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(270, 1, 'profile_not_found', 'Profile not found');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(271, 1, 'last_active', 'Last Active');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(272, 1, 'last_seen', 'Last Seen');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(273, 1, 'assigned_issues', 'Assigned Issues');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(274, 1, 'join_date', 'Join Date');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(275, 1, 'last_login_date', 'Last Login Date');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(276, 1, 'full_name', 'Full Name');
INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES(277, 1, 'no_issues', 'No Issues');

-- --------------------------------------------------------

--
-- Table structure for table `jordon_site_theme`
--

CREATE TABLE IF NOT EXISTS `jordon_site_theme` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('custom','bootstrap','jquery-ui') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'custom',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `display_name` (`display_name`),
  KEY `active` (`active`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=18 ;

--
-- Dumping data for table `jordon_site_theme`
--

INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(1, 'bootstrap', 'cerulean', 'Cerulean', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(2, 'bootstrap', 'flatly', 'Flatly', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(4, 'bootstrap', 'slate', 'Slate', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(5, 'bootstrap', 'cosmo', 'Cosmo', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(6, 'bootstrap', 'darkly', 'Darkly', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(7, 'bootstrap', 'cyborg', 'Cyborg', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(8, 'bootstrap', 'journal', 'Journal', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(9, 'bootstrap', 'lumen', 'Lumen', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(11, 'bootstrap', 'bootstrap', 'Bootstrap', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(12, 'bootstrap', 'simplex', 'Simplex', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(13, 'bootstrap', 'spacelab', 'Spacelab', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(14, 'bootstrap', 'superhero', 'Superhero', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(15, 'bootstrap', 'united', 'United', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(16, 'bootstrap', 'bootstrap-with-theme', 'Bootstrap (w/ theme)', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(17, 'bootstrap', 'yeti', 'Yeti', '1');

-- --------------------------------------------------------

--
-- Table structure for table `jordon_tag`
--

CREATE TABLE IF NOT EXISTS `jordon_tag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_created` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `date_created` (`date_created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `jordon_user`
--

CREATE TABLE IF NOT EXISTS `jordon_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `email` text COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `display_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `avatar_url` text COLLATE utf8_unicode_ci,
  `url_slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `site_language` bigint(20) unsigned DEFAULT NULL,
  `site_status` enum('banned','pending','confirmed','auto_confirmed','unconfirmed') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'unconfirmed',
  `date_created` int(10) unsigned NOT NULL,
  `signup_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_upload` int(10) unsigned DEFAULT NULL,
  `last_active` int(10) unsigned DEFAULT NULL,
  `last_login_date` int(10) unsigned DEFAULT NULL,
  `last_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `url_slug` (`url_slug`),
  KEY `site_language` (`site_language`),
  KEY `signup_ip` (`signup_ip`),
  KEY `last_ip` (`last_ip`),
  KEY `last_login_date` (`last_login_date`),
  KEY `password` (`password`),
  KEY `username` (`username`),
  KEY `username_password` (`username`,`password`),
  KEY `date_created` (`date_created`),
  KEY `last_upload` (`last_upload`),
  KEY `last_active` (`last_active`),
  KEY `display_name` (`display_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `jordon_user`
--

INSERT INTO `jordon_user` (`id`, `uuid`, `email`, `username`, `display_name`, `first_name`, `last_name`, `password`, `avatar_url`, `url_slug`, `site_language`, `site_status`, `date_created`, `signup_ip`, `last_upload`, `last_active`, `last_login_date`, `last_ip`) VALUES(1, '9e53acc0-e44f-11e3-ac10-0800200c9a66', 'admin@jordonblitz.com', 'admin@jordonblitz.com', 'Site Admin', 'Site', 'Admin', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', NULL, 'site-admin', 1, 'auto_confirmed', 1383254334, NULL, NULL, 1435061316, 1435043391, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `jordon_usergroup`
--

CREATE TABLE IF NOT EXISTS `jordon_usergroup` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `jordon_usergroup`
--

INSERT INTO `jordon_usergroup` (`id`, `uuid`, `name`, `title`, `comment`) VALUES(0, '6DCD04ED-F6FB-4813-B34F-18A1D31E8E59', 'Banned', 'Banned', 'Banned Users');
INSERT INTO `jordon_usergroup` (`id`, `uuid`, `name`, `title`, `comment`) VALUES(1, '5FDCDE5E-55DA-471F-B638-A8C27B10225F', 'Guest', 'Unauthenticated', 'Guests');
INSERT INTO `jordon_usergroup` (`id`, `uuid`, `name`, `title`, `comment`) VALUES(2, '4B6737B1-C0EF-4E3D-81DB-8946B08695E5', 'User', 'Normal Users', 'Normal Users');
INSERT INTO `jordon_usergroup` (`id`, `uuid`, `name`, `title`, `comment`) VALUES(3, 'DD9B6BDB-5C77-45F9-A5CE-A3284C30B83B', 'Administrator', 'Site Administrators', 'Site Administrators');
INSERT INTO `jordon_usergroup` (`id`, `uuid`, `name`, `title`, `comment`) VALUES(4, 'E92B1F80-A7ED-4FDE-8F84-80C6AD7F18B9', 'Demo', 'Demo Users', 'Demo Users');

-- --------------------------------------------------------

--
-- Table structure for table `jordon_usergroup_member`
--

CREATE TABLE IF NOT EXISTS `jordon_usergroup_member` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `usergroup_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_and_usergroup_id` (`user_id`,`usergroup_id`),
  KEY `user_id` (`user_id`),
  KEY `usergroup_id` (`usergroup_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `jordon_usergroup_member`
--

INSERT INTO `jordon_usergroup_member` (`id`, `user_id`, `usergroup_id`) VALUES(1, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `jordon_usergroup_permission`
--

CREATE TABLE IF NOT EXISTS `jordon_usergroup_permission` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `usergroup_id` bigint(20) unsigned NOT NULL,
  `permission_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroup_id_and_permissions_id` (`usergroup_id`,`permission_id`),
  KEY `permission_id` (`permission_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=41 ;

--
-- Dumping data for table `jordon_usergroup_permission`
--

INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(24, 1, 1);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(22, 1, 12);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(23, 1, 13);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(25, 1, 17);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(16, 2, 1);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(13, 2, 2);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(12, 2, 5);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(40, 2, 12);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(39, 2, 13);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(1, 3, 1);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(2, 3, 2);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(3, 3, 3);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(4, 3, 4);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(9, 3, 5);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(10, 3, 6);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(11, 3, 7);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(18, 3, 9);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(19, 3, 10);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(20, 3, 11);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(21, 3, 12);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(26, 3, 13);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(29, 3, 14);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(30, 3, 15);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(28, 3, 16);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(27, 3, 17);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(31, 3, 18);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(33, 3, 19);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(32, 3, 20);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(34, 3, 21);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(35, 3, 22);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(36, 3, 23);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(37, 3, 24);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(38, 3, 25);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(14, 4, 1);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(15, 4, 2);
INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES(17, 4, 5);

-- --------------------------------------------------------

--
-- Table structure for table `jordon_user_confirm`
--

CREATE TABLE IF NOT EXISTS `jordon_user_confirm` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `jordon_vendor`
--

CREATE TABLE IF NOT EXISTS `jordon_vendor` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `url` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `jordon_project`
--
ALTER TABLE `jordon_project`
  ADD CONSTRAINT `jordon_project_ibfk_1` FOREIGN KEY (`lead`) REFERENCES `jordon_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `jordon_project_activity`
--
ALTER TABLE `jordon_project_activity`
  ADD CONSTRAINT `jordon_project_activity_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `jordon_project` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `jordon_project_category_rel`
--
ALTER TABLE `jordon_project_category_rel`
  ADD CONSTRAINT `jordon_project_category_rel_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `jordon_project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `jordon_project_category_rel_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `jordon_project_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `jordon_project_issue`
--
ALTER TABLE `jordon_project_issue`
  ADD CONSTRAINT `jordon_project_issue_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `jordon_project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `jordon_project_issue_ibfk_4` FOREIGN KEY (`revision_uuid`) REFERENCES `jordon_project_issue_revision` (`revision_uuid`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `jordon_project_issue_activity`
--
ALTER TABLE `jordon_project_issue_activity`
  ADD CONSTRAINT `jordon_project_issue_activity_ibfk_1` FOREIGN KEY (`by`) REFERENCES `jordon_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `jordon_project_issue_comment`
--
ALTER TABLE `jordon_project_issue_comment`
  ADD CONSTRAINT `jordon_project_issue_comment_ibfk_1` FOREIGN KEY (`issue_id`) REFERENCES `jordon_project_issue` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `jordon_project_issue_comment_ibfk_3` FOREIGN KEY (`author_id`) REFERENCES `jordon_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `jordon_project_issue_comment_ibfk_4` FOREIGN KEY (`reply_to`) REFERENCES `jordon_project_issue_comment` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `jordon_project_permission`
--
ALTER TABLE `jordon_project_permission`
  ADD CONSTRAINT `jordon_project_permission_ibfk_1` FOREIGN KEY (`permission_id`) REFERENCES `jordon_project_permission_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `jordon_project_permission_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `jordon_project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `jordon_project_role_assignment`
--
ALTER TABLE `jordon_project_role_assignment`
  ADD CONSTRAINT `jordon_project_role_assignment_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `jordon_project_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `jordon_project_version`
--
ALTER TABLE `jordon_project_version`
  ADD CONSTRAINT `jordon_project_version_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `jordon_project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `jordon_project_version_ibfk_2` FOREIGN KEY (`privacy`) REFERENCES `jordon_privacy_type` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `jordon_site_phrase`
--
ALTER TABLE `jordon_site_phrase`
  ADD CONSTRAINT `jordon_site_phrase_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `jordon_language` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `jordon_user`
--
ALTER TABLE `jordon_user`
  ADD CONSTRAINT `jordon_user_ibfk_1` FOREIGN KEY (`site_language`) REFERENCES `jordon_language` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `jordon_usergroup_member`
--
ALTER TABLE `jordon_usergroup_member`
  ADD CONSTRAINT `jordon_usergroup_member_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `jordon_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `jordon_usergroup_member_ibfk_2` FOREIGN KEY (`usergroup_id`) REFERENCES `jordon_usergroup` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `jordon_usergroup_permission`
--
ALTER TABLE `jordon_usergroup_permission`
  ADD CONSTRAINT `jordon_usergroup_permission_ibfk_1` FOREIGN KEY (`usergroup_id`) REFERENCES `jordon_usergroup` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `jordon_usergroup_permission_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `jordon_site_permission` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `jordon_user_confirm`
--
ALTER TABLE `jordon_user_confirm`
  ADD CONSTRAINT `jordon_user_confirm_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `jordon_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
