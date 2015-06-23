-- phpMyAdmin SQL Dump
-- version 4.0.10.7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 23, 2015 at 05:20 AM
-- Server version: 5.5.42-cll
-- PHP Version: 5.4.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `jordon`
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

INSERT INTO `jordon_language` (`id`, `iso_3166_1`, `iso_639`, `friendly_name`, `native_name`, `active`) VALUES
(1, 'en-us', 'en', 'English (U.S.)', 'English', '1'),
(2, 'de-de', 'de', 'German', 'Deutsch', '1');

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

INSERT INTO `jordon_privacy_type` (`id`, `name`, `active`) VALUES
(1, 'public', '1'),
(2, 'private', '1'),
(3, 'unlisted', '1');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;

--
-- Dumping data for table `jordon_project`
--

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=31 ;

--
-- Dumping data for table `jordon_project_activity`
--

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;

--
-- Dumping data for table `jordon_project_category`
--


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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;

--
-- Dumping data for table `jordon_project_category_rel`
--

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;

--
-- Dumping data for table `jordon_project_issue`
--

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;

--
-- Dumping data for table `jordon_project_issue_activity`
--

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

INSERT INTO `jordon_project_issue_priority` (`id`, `name`, `severity`) VALUES
(1, 'blocker', 100),
(2, 'critical', 95),
(3, 'minor', 5),
(4, 'major', 50),
(5, 'trivial', 0),
(6, 'normal', 20),
(7, 'low', 10),
(8, 'urgent', 90),
(9, 'very_low', 1),
(10, 'high', 85);

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

INSERT INTO `jordon_project_issue_rel_type` (`id`, `title`) VALUES
(3, 'blocked_by'),
(2, 'blocks'),
(1, 'depends_on'),
(6, 'raised_by'),
(5, 'raises'),
(4, 'related'),
(7, 'subtask');

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

INSERT INTO `jordon_project_issue_resolution` (`id`, `name`) VALUES
(8, 'cannot_reproduce'),
(6, 'invalid'),
(7, 'not_bug'),
(4, 'rejected'),
(2, 'resolved'),
(1, 'unresolved'),
(5, 'wont_fix');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;

--
-- Dumping data for table `jordon_project_issue_revision`
--

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

INSERT INTO `jordon_project_issue_state` (`id`, `name`, `sort_order`) VALUES
(1, 'open', 1),
(2, 'closed', 2);

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

INSERT INTO `jordon_project_issue_status` (`id`, `name`) VALUES
(3, 'assigned'),
(8, 'cannot_reproduce'),
(12, 'confirmed'),
(9, 'fixed'),
(11, 'in_progress'),
(6, 'invalid'),
(7, 'not_bug'),
(4, 'rejected'),
(13, 'reopened'),
(10, 'resolved'),
(2, 'unassigned'),
(1, 'unconfirmed'),
(5, 'wont_fix');

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

INSERT INTO `jordon_project_issue_type` (`id`, `name`, `active`) VALUES
(1, 'feature_request', '1'),
(2, 'bug', '1'),
(3, 'support_request', '1'),
(4, 'improvement', '1'),
(5, 'third_party', '1'),
(6, 'task', '1'),
(7, 'subtask', '1'),
(8, 'story', '0'),
(9, 'epic', '0');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `jordon_project_permission`
--

INSERT INTO `jordon_project_permission` (`id`, `project_id`, `target_uuid`, `permission_id`) VALUES
(1, 1, '5FDCDE5E-55DA-471F-B638-A8C27B10225F', 3);

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

INSERT INTO `jordon_project_permission_type` (`id`, `name`) VALUES
(3, 'can_comment'),
(2, 'can_edit'),
(1, 'can_view');

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

INSERT INTO `jordon_project_role` (`id`, `uuid`, `title`, `description`, `date_added`) VALUES
(1, '60a4581e-6749-4646-8b78-5918f3f6a3a1', 'project_lead', 'Project Lead', 1406262374);

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

INSERT INTO `jordon_project_version` (`id`, `project_id`, `name`, `version`, `description`, `summary`, `release_notes`, `privacy`, `date_released`, `date_created`) VALUES
(1, 1, 'MVP', 'MVP', NULL, NULL, NULL, 1, 1406636233, 1406636233),
(2, 2, '1.0', '1.0', NULL, NULL, NULL, 1, NULL, 1432302932);

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

INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES
(1, 'site_name', 'Jordon', NULL, 'global', 'text', 'Site Name', NULL, '1'),
(2, 'site_default_preloader_image_path', '__BASEURL__/images/preloader/486.gif', NULL, 'global', 'text', NULL, NULL, '1'),
(3, 'site_default_landing_page', 'projects', NULL, 'global', 'text', 'Local URL to redirect to after login, do not include the scheme, i.e. http://', NULL, '1'),
(4, 'site_allow_template_change', '1', '0,1', 'global', 'radio', 'Allow Template Change', NULL, '1'),
(5, 'site_default_template', 'yeti', NULL, 'global', 'text', NULL, NULL, '1'),
(6, 'site_default_max_upload_size', '1073741824', NULL, 'upload', 'text', 'Max upload size in bytes', 'in bytes', '1'),
(7, 'site_allowed_file_types', '*', NULL, 'upload', 'text', 'File types allowed for upload. Separate entries with commas. Use * to allow all.', NULL, '1'),
(8, 'site_default_avatar_url', '__BASEURL__/images/profiles/anonymousUser.jpg', NULL, 'user', 'text', 'Full URL of the default user avatar', NULL, '1'),
(9, 'site_default_language', 'en-us', NULL, 'global', 'text', NULL, NULL, '1'),
(10, 'site_guest_max_recipients', '3', NULL, 'upload', 'text', NULL, NULL, '1'),
(11, 'site_guest_max_queue_size', '5', NULL, 'upload', 'text', NULL, NULL, '1'),
(12, 'site_guest_max_file_size', '2', NULL, 'upload', 'text', NULL, 'in MB', '1'),
(13, 'site_guest_total_file_size', '10', NULL, 'upload', 'text', NULL, 'in MB', '1'),
(14, 'site_allow_language_change', '1', '0,1', 'global', 'radio', 'Allow Language Change', NULL, '1'),
(15, 'site_guest_upload_retention', '168', NULL, 'upload', 'text', NULL, 'in hours', '1'),
(16, 'site_moderate_new_users', '1', '0,1', 'user', 'radio', NULL, NULL, '1'),
(17, 'site_require_email_confirm', '1', '0,1', 'user', 'radio', 'Require e-mail confirmation for new user registrations', NULL, '1'),
(18, 'site_email_address', 'projects@jordonblitz.com', NULL, 'global', 'text', NULL, NULL, '1'),
(19, 'site_upload_dir', 'data/uploads', NULL, 'upload', 'text', 'Relative path of the local file upload directory', NULL, '1'),
(20, 'site_upload_dir_users', 'data/uploads/users', NULL, 'upload', 'text', 'Relative path of the local file upload directory for end-users', NULL, '1'),
(22, 'site_token_min_length', '8', NULL, 'upload', 'text', 'Tokens match users to available files', NULL, '1'),
(23, 'site_token_max_length', '15', NULL, 'upload', 'text', 'Tokens match users to available files', NULL, '1'),
(24, 'site_local_theme_url_root', 'css/jquery-ui/themes', NULL, 'global', 'text', 'Theme root relative to the site. Do not include host or scheme.', 'relative to the site root', '1'),
(25, 'site_default_admin_preloader_image_path', 'images/preloader/477-black-124x128.gif', NULL, 'admin', 'text', 'Local URL of the preloader image for the site admin UI. Do not include the protocol scheme.', NULL, '1'),
(26, 'site_default_landing_page_after_login', 'projects', NULL, 'global', 'text', NULL, NULL, '1'),
(52, 'site_use_blockui', '1', '1,0', 'global', 'radio', NULL, NULL, '1'),
(53, 'site_moderate_uploads', '0', '0,1', 'global', 'radio', NULL, NULL, '1'),
(64, 'site_url', 'http://dev.vevoclone.com', NULL, 'global', 'text', NULL, 'including scheme', '1'),
(77, 'site_facebook_app_id', '324640691020497', NULL, 'global', 'text', NULL, NULL, '1'),
(78, 'site_twitter_api_key', 'KS0tMXGV1jBPHcr9B2NsxplmU', NULL, 'social', 'text', NULL, NULL, '1'),
(79, 'site_twitter_api_secret', '4SaA3aauMozDQqJIbEZIiwmJTYj1hBmaF6Ql0PILnBFHi604By', NULL, 'social', 'text', NULL, NULL, '1'),
(80, 'site_allow_social_login', '0', '0,1', 'social', 'text', NULL, NULL, '1'),
(81, 'site_yahoo_consumer_key', 'dj0yJmk9RlBPU09OTXZxY3hPJmQ9WVdrOVZuVkRWWGRHTXpZbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD04Mg--', NULL, 'social', 'text', NULL, NULL, '1'),
(82, 'site_yahoo_consumer_secret', 'e15419d9ab06e7cd727a252c16f03877e68cc7eb', NULL, 'social', 'text', NULL, NULL, '1'),
(83, 'site_yahoo_app_id', 'VuCUwF36', NULL, 'social', 'text', NULL, NULL, '1'),
(84, 'site_yahoo_domain', 'dev.vevoclone.com', NULL, 'social', 'text', NULL, NULL, '1'),
(85, 'site_windows_live_client_id', '000000004811FC1F', NULL, 'social', 'text', NULL, NULL, '1'),
(86, 'site_windows_live_client_secret', '2YIn7AR1kyqSliK5GVh-V6X3U6Bhn6pF', NULL, 'social', 'text', NULL, NULL, '1'),
(87, 'site_cookie_expiration_date', '2147483647', NULL, 'global', 'text', NULL, NULL, '1'),
(89, 'site_guest_usergroup_id', '1', NULL, 'user', 'select', NULL, NULL, '1'),
(90, 'site_issue_comment_fetch_limit', '20', NULL, 'global', 'text', NULL, NULL, '1'),
(91, 'site_default_issue_state', '1', NULL, 'global', 'text', NULL, NULL, '1'),
(92, 'site_default_issue_status', '1', NULL, 'global', 'text', NULL, NULL, '1'),
(93, 'site_default_issue_resolution', '1', NULL, 'global', 'text', NULL, NULL, '1'),
(94, 'site_issue_recent_fetch_limit', '15', NULL, 'global', 'text', NULL, NULL, '1'),
(95, 'site_issue_chart_type', 'areaspline', 'area,areaspline', 'global', 'select', NULL, NULL, '1'),
(96, 'site_issue_chart_tooltip_date_format', '%A, %B %d, %Y', NULL, 'global', 'text', NULL, NULL, '1'),
(97, 'site_project_recent_activity_cutoff', '2592000', NULL, 'global', 'text', NULL, NULL, '1'),
(98, 'site_issue_chat_xaxis_date_format', '%B %d', NULL, 'global', 'text', NULL, NULL, '1'),
(99, 'site_date_format', 'l, F, d, Y / h:i:s A P', NULL, 'global', 'text', NULL, NULL, '1'),
(100, 'site_issue_edit_style', 'inline', 'inline,popup', 'global', 'text', NULL, NULL, '1'),
(101, 'site_issue_resolution_id', '2', NULL, 'global', 'select', NULL, NULL, '1'),
(102, 'site_cookie_path', '/', NULL, 'global', 'text', NULL, NULL, '1'),
(103, 'site_cookie_timeout', '622080000', NULL, 'global', 'text', NULL, NULL, '1'),
(104, 'site_loading_placeholder_small', '<img src="__BASEURL__/images/preloader/small-black.png" border="0">', NULL, 'global', 'text', NULL, NULL, '1'),
(105, 'site_comment_fetch_limit', '10', NULL, 'global', 'text', NULL, NULL, '1'),
(106, 'site_issue_status_unassigned_id', '2', NULL, 'global', 'text', NULL, NULL, '1'),
(107, 'site_issue_status_assigned_id', '3', NULL, 'global', 'text', NULL, NULL, '1'),
(108, 'site_issue_chart_xaxis_date_format', NULL, NULL, 'global', 'text', NULL, NULL, '1');

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

INSERT INTO `jordon_site_permission` (`id`, `permission_name`, `permission_type`, `comment`) VALUES
(1, 'can_view_site', 'site', NULL),
(2, 'can_upload', 'upload', NULL),
(3, 'can_admin_site', 'admin', NULL),
(4, 'can_view_debug_messages', 'admin', NULL),
(5, 'can_view_user_profiles', 'site', NULL),
(6, 'can_edit_own_profile', 'user', NULL),
(7, 'can_change_own_password', 'user', NULL),
(8, 'can_delete_own_account', 'user', NULL),
(9, 'can_admin_site_phrases', 'admin', NULL),
(10, 'can_admin_users', 'admin', NULL),
(11, 'can_admin_files', 'admin', 'Can Administer Uploaded Files (Admin)'),
(12, 'can_view_system_dashboard', 'site', NULL),
(13, 'can_view_project_list', 'user', NULL),
(14, 'can_comment_on_issues', 'user', NULL),
(15, 'can_delete_issue_comments', 'admin', NULL),
(16, 'can_view_issue_comments', 'user', NULL),
(17, 'can_view_issues', 'user', NULL),
(18, 'can_create_issues', 'user', NULL),
(19, 'can_edit_issues', 'admin', NULL),
(20, 'can_delete_issues', 'admin', NULL),
(21, 'can_use_firephp', 'admin', NULL),
(22, 'can_assign_issues', 'admin', NULL),
(23, 'issue_can_change_reporter', 'admin', NULL),
(24, 'project_can_view_activity_stream', 'user', NULL),
(25, 'email_can_view', 'user', NULL);

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

INSERT INTO `jordon_site_phrase` (`id`, `language_id`, `name`, `text`) VALUES
(1, 1, 'language', 'Language'),
(2, 2, 'language', 'Sprache'),
(5, 1, 'upload', 'Upload'),
(6, 2, 'upload', 'Hochladen'),
(7, 1, 'add_files', 'Add Files'),
(8, 2, 'add_files', 'Dateien hinzuf'),
(9, 1, 'to', 'To'),
(10, 2, 'to', 'An'),
(13, 1, 'from', 'From'),
(14, 2, 'from', 'Von'),
(15, 1, 'your_email', 'Your e-mail'),
(16, 2, 'your_email', 'Ihre E-Mail'),
(17, 1, 'your_friend_email', 'Your friend''s e-mail'),
(18, 2, 'your_friend_email', 'Email des Freundes'),
(19, 1, 'message', 'Message'),
(20, 2, 'message', 'Nachricht'),
(21, 1, 'transfer', 'Transfer'),
(22, 2, 'transfer', ''),
(23, 1, 'file_upload_success', 'YEAH! Your files were successfully uploaded!'),
(24, 2, 'file_upload_success', 'Ja! Ihre Dateien wurden erfolgreich hochgeladen!'),
(25, 1, 'http_error_404_text', 'The document that you have requested does not exist'),
(26, 2, 'http_error_404_text', 'Das Dokument, das Sie angefordert haben existiert nicht'),
(27, 1, 'site_default_admin_preloader_image_path', 'Preloader Image Path (URL)'),
(28, 1, 'site_allow_language_change', 'Allow Language Change'),
(29, 1, 'site_allow_template_change', 'Allow Template Change'),
(30, 1, 'site_allowed_file_types', 'Allowed File Types'),
(31, 1, 'site_archive_prefix', 'Archive Prefix'),
(32, 1, 'site_default_avatar_url', 'Default Avatar URL'),
(33, 1, 'admin', 'Admin'),
(34, 1, 'global', 'Global'),
(35, 1, 'site_default_landing_page', 'Default Landing Page (After Login)'),
(36, 1, 'site_default_language', 'Default Site Language'),
(37, 1, 'site_default_max_upload_size', 'Max Upload Size'),
(38, 1, 'site_default_preloader_image_path', 'Site Preloader Image'),
(39, 1, 'site_default_template', 'Default Site Template'),
(40, 1, 'site_email_address', 'Site e-mail Address'),
(41, 1, 'site_guest_max_file_size', 'Max File Size for Guests'),
(42, 1, 'site_guest_max_queue_size', 'Queue Size Limit for Guests'),
(43, 1, 'site_guest_max_recipients', 'Max Number of Recipients for Guests'),
(44, 1, 'site_guest_total_file_size', 'Total Queue Size for Guests'),
(45, 1, 'site_guest_upload_retention', 'Guest Upload Retention'),
(46, 1, 'site_local_theme_url_root', 'Relative URL path of themes'),
(47, 1, 'site_moderate_new_users', 'Moderate New Users'),
(48, 1, 'site_name', 'Site Name'),
(49, 1, 'user', 'User'),
(50, 1, 'site_require_email_confirm', 'Require e-mail Confirmation after User Registration'),
(51, 1, 'site_upload_dir_users', 'Path of upload directory for end-users'),
(52, 1, 'site_upload_dir', 'Path of upload directory '),
(53, 1, 'site_token_max_length', 'Max Token Length'),
(54, 1, 'site_token_min_length', 'Minimum token length'),
(55, 1, 'site_settings', 'Site Settings'),
(56, 2, 'site_settings', 'Site-Einstellungen'),
(57, 2, 'user', 'Benutzer'),
(58, 2, 'settings', 'Einstellungen'),
(59, 2, 'site', 'Webseite'),
(60, 2, 'phrases', 'S'),
(61, 2, 'users', 'Benutzer'),
(62, 2, 'all', 'alle'),
(63, 2, 'logoff', 'Abmelden'),
(64, 2, 'account_settings', 'Konto-Einstellungen'),
(65, 2, 'files', 'Dateien'),
(66, 1, 'template_color', 'Template Color'),
(67, 2, 'template_color', 'Schablone Farbe'),
(68, 1, 'save_changes', 'Save Changes'),
(69, 1, 'cancel', 'Cancel'),
(70, 2, 'save_changes', ''),
(71, 2, 'cancel', 'Abbrechen'),
(72, 2, 'site_phrases', 'Website-S'),
(73, 1, 'site_phrases', 'Site Phrases'),
(74, 1, 'logoff', 'Logout'),
(75, 1, 'uploaded_files', 'Uploaded Files'),
(76, 2, 'uploaded_files', 'Hochgeladene Dateien'),
(77, 1, 'orphaned_files', 'Orphaned Files'),
(78, 2, 'orphaned_files', 'Verwaiste Dateien'),
(79, 1, 'login', 'Login'),
(80, 2, 'login', 'Anmelden'),
(81, 1, 'forgotten_password', 'Forgotten Password'),
(82, 2, 'forgotten_password', 'Passwort vergessen'),
(83, 1, 'error', 'Error'),
(84, 1, 'login_username_does_not_exist', 'Authentication Failure'),
(85, 1, 'authentication_failure', 'Authentication Failure'),
(86, 1, 'logout', 'Logout'),
(87, 2, 'logout', 'Abmelden'),
(88, 1, 'help', 'Help'),
(89, 2, 'help', 'Hilfe'),
(92, 1, 'themes', 'Themes'),
(93, 2, 'themes', 'Thema'),
(94, 1, 'password', 'Password'),
(95, 2, 'password', 'Kennwort'),
(96, 1, 'email', 'e-mail'),
(97, 2, 'email', 'Email'),
(98, 1, 'to_top', 'Top'),
(99, 2, 'to_top', 'Nach oben'),
(100, 1, 'all_rights_reserved', 'All Rights Reserved'),
(101, 2, 'all_rights_reserved', 'Alle Rechte vorbehalten'),
(102, 1, 'copyright', 'Copyright'),
(103, 2, 'copyright', 'Copyright'),
(104, 1, 'dashboards', 'Dashboards'),
(105, 2, 'dashboards', 'Armaturenbrett'),
(106, 1, 'search', 'Search'),
(107, 2, 'search', 'Suche'),
(108, 1, 'system_dashboard', 'System Dashboard'),
(109, 2, 'system_dashboard', 'System-Armaturenbrett'),
(110, 1, 'about', 'About'),
(111, 2, 'about', ''),
(112, 1, 'issues', 'Issues'),
(113, 1, 'search_issues', 'Search Issues'),
(114, 1, 'projects', 'Projects'),
(115, 1, 'view_all_projects', 'View All Projects'),
(116, 1, 'uncategorized', 'Uncategorized'),
(117, 1, 'all_projects', 'All Projects'),
(118, 1, 'permission_error', 'Permission Error'),
(119, 1, 'permission_error_explantation', 'Your user account does not have permission to access this resource.'),
(120, 2, 'projects', 'Projekte'),
(121, 2, 'view_all_projects', 'Alle Projekte'),
(123, 2, 'issues', 'Themen'),
(124, 2, 'search_issues', 'Suche Themen'),
(125, 1, 'title', 'Title'),
(126, 1, 'priority', 'Priority'),
(127, 1, 'date_created', 'Date Created'),
(128, 1, 'last_updated', 'Last Updated'),
(129, 1, 'summary', 'Summary'),
(130, 1, 'status', 'Status'),
(131, 1, 'percentage', 'Percentage'),
(132, 1, 'trivial', 'Trivial'),
(133, 1, 'unconfirmed', 'Unconfirmed'),
(134, 1, 'unassigned', 'Unassigned'),
(135, 1, 'assigned', 'Assigned'),
(136, 1, 'rejected', 'Rejected'),
(137, 1, 'wont_fix', 'Won''t Fix'),
(138, 1, 'invalid', 'Invalid'),
(139, 1, 'not_bug', 'Not a Bug'),
(140, 1, 'cannot_reproduce', 'Cannot Reproduce'),
(141, 1, 'resolved', 'Resolved'),
(142, 1, 'fixed', 'Fixed'),
(143, 1, 'no_data', 'No data'),
(144, 1, 'details', 'Details'),
(145, 1, 'people', 'People'),
(146, 1, 'feature_request', 'Feature Request'),
(147, 1, 'open', 'Open'),
(148, 1, 'dates', 'Dates'),
(149, 1, 'created', 'Created'),
(150, 1, 'last_comment', 'Last Comment'),
(151, 1, 'normal', 'Normal'),
(152, 1, 'resolution', 'Resolution'),
(153, 1, 'task', 'Task'),
(154, 1, 'blocker', 'Blocker'),
(155, 1, 'type', 'Type'),
(156, 1, 'assignee', 'Assignee'),
(157, 1, 'reporter', 'Reporter'),
(158, 1, 'never', 'Never'),
(159, 2, 'never', 'Niemals'),
(160, 1, 'description', 'Description'),
(162, 2, 'details', 'Beiwerk'),
(164, 2, 'resolution', 'Aufl'),
(165, 2, 'priority', 'Priorit'),
(166, 2, 'type', 'Typ'),
(167, 2, 'people', 'Leute'),
(169, 2, 'description', 'Beschreibung'),
(170, 2, 'assignee', 'Zugewiesen an'),
(172, 2, 'created', 'Erstellt'),
(173, 2, 'dates', 'Datum'),
(174, 2, 'last_updated', 'Zuletzt aktualisiert'),
(175, 2, 'last_comment', 'Letzter Kommentar'),
(176, 2, 'open', 'Offen'),
(177, 2, 'unconfirmed', 'Unbest'),
(178, 2, 'feature_request', 'Neues Feature'),
(179, 1, 'activity', 'Activity'),
(182, 1, 'all', 'All'),
(185, 1, 'comments', 'Comments'),
(186, 2, 'comments', 'Kommentare'),
(187, 1, 'issue_settings', 'Issue Settings'),
(188, 1, 'clean', 'Clean'),
(189, 1, 'modern', 'Modern'),
(190, 1, 'unresolved', 'Unresolved'),
(191, 1, 'state', 'State'),
(192, 1, 'moments_ago', 'moments ago'),
(194, 2, 'moments_ago', 'Jetzt Gleich'),
(195, 1, 'add_comment', 'Add Comment'),
(196, 1, 'unhandled_exception', 'Unhandled Exception'),
(197, 1, 'no_saved', 'Not Saved'),
(198, 1, 'guest', 'Guest'),
(199, 1, 'comment', 'Comment'),
(200, 1, 'prompt_comment_delete', 'Are you sure that you want to delete this comment?'),
(201, 2, 'prompt_comment_delete', 'Sind Sie sicher, dass Sie diesen Kommentar wirklich l'),
(202, 1, 'delete', 'Delete'),
(203, 2, 'delete', 'L'),
(204, 1, 'create_issue', 'Create Issue'),
(205, 1, 'create', 'Create'),
(206, 1, 'project', 'Project'),
(207, 2, 'project', 'Projekt'),
(208, 1, 'select_project', 'Select a Project'),
(209, 1, 'affected_version', 'Affected Version'),
(210, 1, 'privacy', 'Privacy'),
(211, 1, 'bug', 'Bug'),
(212, 1, 'support_request', 'Support Request'),
(213, 1, 'improvement', 'Improvement'),
(214, 1, 'third_party', 'Third Party'),
(215, 1, 'subtask', 'Subtask'),
(216, 1, 'critical', 'Critical'),
(217, 1, 'low', 'Low'),
(218, 1, 'major', 'Major'),
(219, 1, 'minor', 'Minor'),
(220, 1, 'urgent', 'Urgent'),
(221, 1, 'very_low', 'Very Low'),
(222, 1, 'high', 'High'),
(223, 1, 'public', 'Public'),
(224, 1, 'private', 'Private'),
(225, 1, 'unlisted', 'Unlisted'),
(226, 1, 'prompt_no_versions', 'This project does not have any versions'),
(227, 1, 'prompt_error', 'An error has occurred'),
(228, 2, 'state', 'Zustand'),
(229, 1, 'activity_stream', 'Activity Stream'),
(230, 1, 'no_recent_activity', 'No Recent Activity'),
(231, 1, 'issues_30day_summary', 'Issues:&nbsp;&nbsp;30 Day Summary'),
(232, 1, 'closed', 'Closed'),
(233, 1, 'prompt_issue_delete', 'Are you sure that you want delete this issue?'),
(234, 1, 'prompt_irreversible_action', 'This is a permanent, irreversible action'),
(235, 1, 'deleting_issue', 'Deleting Issue'),
(236, 1, 'edit', 'Edit'),
(237, 1, 'exception', 'Exception'),
(238, 1, 'error_project_not_found', 'Project not found'),
(239, 1, 'error_issue_not_found', 'Issue not found'),
(240, 1, 'in_progress', 'In Progress'),
(241, 1, 'reopened', 'Re-opened'),
(242, 1, 'issue_resolution', 'Issue Resolution'),
(243, 1, 'issue_status', 'Issue Status'),
(244, 1, 'issue_state', 'Issue State'),
(245, 1, 'issue_priority', 'Issue Priority'),
(246, 1, 'issue_type', 'Issue Type'),
(247, 1, 'issue_description', 'Issue Description'),
(248, 1, 'current_project', 'Current Project'),
(249, 1, 'not_specified', 'Not Specified'),
(251, 1, 'commented_on', 'commented on'),
(252, 1, 'key', 'Key'),
(253, 1, 'lead', 'Lead'),
(254, 1, 'category', 'Category'),
(255, 1, 'all_issues', 'All Issues'),
(256, 1, 'added_recently', 'Added Recently'),
(257, 1, 'resolved_recently', 'Resolved Recently'),
(258, 1, 'updated_recently', 'Updated Recently'),
(259, 1, 'unscheduled', 'Unscheduled'),
(260, 1, 'outstanding', 'Outstanding'),
(261, 1, 'recent', 'Recent'),
(262, 1, 'confirmed', 'Confirmed'),
(263, 1, 'no_permission', 'Your account does not have the required access level to perform this action'),
(267, 2, 'issues_30day_summary', 'Themen:&nbsp;&nbsp;30-Tage-Zusammenfassung'),
(269, 2, 'resolved', 'entschlossen'),
(270, 1, 'profile_not_found', 'Profile not found'),
(271, 1, 'last_active', 'Last Active'),
(272, 1, 'last_seen', 'Last Seen'),
(273, 1, 'assigned_issues', 'Assigned Issues'),
(274, 1, 'join_date', 'Join Date'),
(275, 1, 'last_login_date', 'Last Login Date'),
(276, 1, 'full_name', 'Full Name'),
(277, 1, 'no_issues', 'No Issues');

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

INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES
(1, 'bootstrap', 'cerulean', 'Cerulean', '1'),
(2, 'bootstrap', 'flatly', 'Flatly', '1'),
(4, 'bootstrap', 'slate', 'Slate', '1'),
(5, 'bootstrap', 'cosmo', 'Cosmo', '1'),
(6, 'bootstrap', 'darkly', 'Darkly', '1'),
(7, 'bootstrap', 'cyborg', 'Cyborg', '1'),
(8, 'bootstrap', 'journal', 'Journal', '1'),
(9, 'bootstrap', 'lumen', 'Lumen', '1'),
(11, 'bootstrap', 'bootstrap', 'Bootstrap', '1'),
(12, 'bootstrap', 'simplex', 'Simplex', '1'),
(13, 'bootstrap', 'spacelab', 'Spacelab', '1'),
(14, 'bootstrap', 'superhero', 'Superhero', '1'),
(15, 'bootstrap', 'united', 'United', '1'),
(16, 'bootstrap', 'bootstrap-with-theme', 'Bootstrap (w/ theme)', '1'),
(17, 'bootstrap', 'yeti', 'Yeti', '1');

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

INSERT INTO `jordon_user` (`id`, `uuid`, `email`, `username`, `display_name`, `first_name`, `last_name`, `password`, `avatar_url`, `url_slug`, `site_language`, `site_status`, `date_created`, `signup_ip`, `last_upload`, `last_active`, `last_login_date`, `last_ip`) VALUES
(1, '9e53acc0-e44f-11e3-ac10-0800200c9a66', 'admin@jordonblitz.com', 'admin@jordonblitz.com', 'Jordon Blitz', 'Jordon', 'Blitz', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', NULL, 'JordonBlitz', 1, 'auto_confirmed', 1383254334, NULL, NULL, 1435051757, 1435043391, NULL);

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

INSERT INTO `jordon_usergroup` (`id`, `uuid`, `name`, `title`, `comment`) VALUES
(0, '6DCD04ED-F6FB-4813-B34F-18A1D31E8E59', 'Banned', 'Banned', 'Banned Users'),
(1, '5FDCDE5E-55DA-471F-B638-A8C27B10225F', 'Guest', 'Unauthenticated', 'Guests'),
(2, '4B6737B1-C0EF-4E3D-81DB-8946B08695E5', 'User', 'Normal Users', 'Normal Users'),
(3, 'DD9B6BDB-5C77-45F9-A5CE-A3284C30B83B', 'Administrator', 'Site Administrators', 'Site Administrators'),
(4, 'E92B1F80-A7ED-4FDE-8F84-80C6AD7F18B9', 'Demo', 'Demo Users', 'Demo Users');

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

INSERT INTO `jordon_usergroup_member` (`id`, `user_id`, `usergroup_id`) VALUES
(1, 1, 3);

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

INSERT INTO `jordon_usergroup_permission` (`id`, `usergroup_id`, `permission_id`) VALUES
(24, 1, 1),
(22, 1, 12),
(23, 1, 13),
(25, 1, 17),
(16, 2, 1),
(13, 2, 2),
(12, 2, 5),
(40, 2, 12),
(39, 2, 13),
(1, 3, 1),
(2, 3, 2),
(3, 3, 3),
(4, 3, 4),
(9, 3, 5),
(10, 3, 6),
(11, 3, 7),
(18, 3, 9),
(19, 3, 10),
(20, 3, 11),
(21, 3, 12),
(26, 3, 13),
(29, 3, 14),
(30, 3, 15),
(28, 3, 16),
(27, 3, 17),
(31, 3, 18),
(33, 3, 19),
(32, 3, 20),
(34, 3, 21),
(35, 3, 22),
(36, 3, 23),
(37, 3, 24),
(38, 3, 25),
(14, 4, 1),
(15, 4, 2),
(17, 4, 5);

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