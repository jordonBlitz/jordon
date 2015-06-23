-- phpMyAdmin SQL Dump
-- version 4.1.8
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 25, 2014 at 06:06 PM
-- Server version: 5.5.37-cll
-- PHP Version: 5.4.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `cloneui_jbdemo`
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=31 ;

--
-- Dumping data for table `jordon_project`
--

INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(1, 'JB', 'Jordon', 'Jordon &mdash; Project Management Software \r\nEnterprise level Project Management at a fraction of the cost', '<i class="fa fa-life-ring"></i>', 'http://jordonblitz.com', 1, 'public', '1', 1406191109);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(2, 'WLC', 'White Label Chat', NULL, '<i class="fa fa-comments"></i>', 'http://chat.whitelabelready.com', 1, 'public', '1', 1406294527);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(3, 'WLCI', 'White Label Check-in', 'A clone of Untappd', '<i class="fa fa-tags"></i>', NULL, 1, 'private', '1', 1406309599);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(4, 'CURAETO', 'Curaeto', 'A clone of VEVO', '<i class="fa fa-heart-o"></i>', 'http://curaeto.com', 1, 'public', '1', 1406310297);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(5, 'IGC', 'IG Clone', 'An Instagram clone', '<i class="fa fa-camera-retro"></i>', 'http://igclone.com', 1, 'public', '1', 1406592752);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(6, 'WLMP', 'White Label Marketplace', NULL, '<i class="fa fa-shopping-cart"></i>', 'http://whitelabelmp.com', 1, 'public', '1', 1406939481);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(7, 'EA', 'Expert Answers', 'Expert Answers', NULL, 'http://amalance.com', 1, 'private', '1', 1407115416);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(8, 'FF', 'FamilyFirst', 'Social Networking for Familes', NULL, NULL, 1, 'private', '1', 1407115493);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(9, 'WLHM', 'HeyMan', 'Twitter clone', NULL, NULL, 1, 'private', '1', 1407115552);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(10, 'HOWYOU', 'HowYou', 'WhatsApp clone', '<i class="fa fa-comment-o"></i>', 'http://howyouapp.com', 1, 'public', '1', 1407115623);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(11, 'WTC', 'WT Clone', 'Private file sharing', '<i class="fa fa-cloud-upload"></i>', 'http://wtclone.com', 1, 'public', '1', 1407115682);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(12, 'VE', 'Videnc', 'Video encoding service', '<i class="fa fa-bolt"></i>', 'http://videnc.com', 1, 'public', '1', 1407115770);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(13, 'DU', 'DesktopUpload', 'Desktop Upload', '<i class="fa fa-desktop"></i>', 'http://desktopupload.com', 1, 'public', '1', 1407115804);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(14, 'JAAZON', 'JAAZON', 'A YouTube clone', '<i class="fa fa-film"></i>', NULL, 1, 'public', '1', 1407115879);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(15, 'POF', 'OpenFace', 'Decentralized Social Networking', '<i class="fa fa-smile-o"></i>', 'http://projectopenface.com', 1, 'public', '1', 1407115950);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(16, 'UWC', 'UW Clone', 'A clone of Upworthy', '<i class="fa fa-thumbs-o-up"></i>', 'http://uwclone.com', 1, 'public', '1', 1407116002);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(17, 'SC', 'SponsorCode', 'Code bounty site', '<i class="fa fa-bank"></i>', 'http://sponsorcode.org', 1, 'public', '1', 1407116036);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(18, 'DM', 'Dynamic Media', NULL, NULL, NULL, 1, 'private', '1', 1407116071);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(19, 'YC', 'Yammer Clone', NULL, NULL, NULL, 1, 'private', '1', 1407116109);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(20, 'WLQA', 'White Label QA', 'White Label Question & Answer site', '<i class="fa fa-question-circle"></i>', 'http://whitelabelqa.com', 1, 'public', '1', 1407116170);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(21, 'OAUTH', 'OAuth Server', 'OAuth server &mdash; PHP', NULL, NULL, 1, 'public', '1', 1407116220);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(22, 'CS', 'Clouded Sounds', 'Audio sharing', '<i class="fa fa-music"></i>', 'http://cloudedsounds.com', 1, 'public', '1', 1407116258);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(23, 'HASHREP', 'HashRep', NULL, NULL, NULL, 1, 'private', '1', 1407116322);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(24, 'FILEREP', 'FileRep', NULL, NULL, NULL, 1, 'private', '1', 1407116356);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(25, 'HIRIGO', 'Hirigo', NULL, NULL, NULL, 1, 'private', '1', 1407116385);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(26, 'DISLIKE', 'DislikeApp', NULL, '<i class="fa fa-thumbs-o-down"></i>', NULL, 1, 'private', '1', 1407116417);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(27, 'CODEREVIEW', 'Code Review', NULL, NULL, NULL, 1, 'public', '1', 1407116447);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(28, 'HOSTILEIP', 'HostileIP', NULL, NULL, NULL, 1, 'private', '1', 1407116476);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(29, 'PHPNETWORK', 'The PHP Network', 'Social Networking for PHP Developers', NULL, NULL, 1, 'private', '1', 1407116518);
INSERT INTO `jordon_project` (`id`, `key`, `title`, `description`, `branding`, `url`, `lead`, `privacy`, `active`, `date_created`) VALUES(30, 'AUTHANY', 'AuthAny', 'Federated / Social Login', '<i class="fa fa-paper-plane-o"></i>', 'http://authany.com', 1, 'public', '1', 1407116577);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=80 ;

--
-- Dumping data for table `jordon_project_activity`
--

INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(1, 1, '98ea3e52-c6f6-45b2-a972-60540d4c3ac1', NULL, 'open', 'issue', 1, '127.0.0.1', 1406963996);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(2, 1, '98ea3e52-c6f6-45b2-a972-60540d4c3ac1', NULL, 'closed', 'issue', 1, '127.0.0.1', 1406964529);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(3, 1, '98ea3e52-c6f6-45b2-a972-60540d4c3ac1', NULL, 'assigned', 'issue', 1, '127.0.0.1', 1406967320);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(4, 1, '98ea3e52-c6f6-45b2-a972-60540d4c3ac1', NULL, 'fixed', 'issue', 1, '127.0.0.1', 1406967378);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(5, 1, '98ea3e52-c6f6-45b2-a972-60540d4c3ac1', NULL, 'resolved', 'issue', 1, '127.0.0.1', 1406967408);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(6, 1, '28f60129-35f4-409a-a2d8-68db149c312a', NULL, 'comment', 'issue', 1, '127.0.0.1', 1406969561);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(7, 1, '4cada0bb-09fe-4246-8cdd-ea6403f4c3aa', NULL, 'comment', 'issue', 1, '127.0.0.1', 1406969996);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(8, 1, '79f16d53-02ef-4727-acbf-35c5a107164d', NULL, 'create', 'issue', 1, '127.0.0.1', 1406970794);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(9, 1, NULL, NULL, 'delete', 'issue', 1, '127.0.0.1', 1406970794);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(10, 1, NULL, NULL, 'delete', 'issue', 1, '127.0.0.1', 1406971151);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(11, 1, '7aee1310-ad31-4a56-a860-203cf0ac7920', NULL, 'comment', 'issue', 1, '', 1407038911);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(12, 1, '25aacc47-2897-4860-9097-ffabdc465325', NULL, 'comment', 'issue', 1, '192.168.2.102', 1407039019);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(13, 1, '689ef549-83ce-4471-a84f-b2fc54713572', NULL, 'closed', 'issue', 1, '192.168.2.102', 1407048322);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(14, 1, '689ef549-83ce-4471-a84f-b2fc54713572', NULL, 'open', 'issue', 1, '192.168.2.102', 1407048344);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(15, 1, '689ef549-83ce-4471-a84f-b2fc54713572', NULL, 'confirmed', 'issue', 1, '192.168.2.102', 1407048698);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(16, 1, '', NULL, 'comment', 'issue', 1, '192.168.2.102', 1407050069);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(17, 1, '689ef549-83ce-4471-a84f-b2fc54713572', NULL, 'comment', 'issue', 1, '192.168.2.102', 1407050306);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(18, 1, '689ef549-83ce-4471-a84f-b2fc54713572', NULL, 'comment', 'issue', 1, '192.168.2.102', 1407050486);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(19, 1, '689ef549-83ce-4471-a84f-b2fc54713572', NULL, 'comment', 'issue', 1, '192.168.2.102', 1407050508);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(20, 1, '689ef549-83ce-4471-a84f-b2fc54713572', NULL, 'comment', 'issue', 1, '192.168.2.102', 1407051409);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(21, 1, '689ef549-83ce-4471-a84f-b2fc54713572', NULL, 'comment', 'issue', 1, '192.168.2.102', 1407052934);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(22, 1, '689ef549-83ce-4471-a84f-b2fc54713572', NULL, 'comment', 'issue', 1, '192.168.2.102', 1407053165);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(23, 1, '689ef549-83ce-4471-a84f-b2fc54713572', NULL, 'comment', 'issue', 1, '192.168.2.102', 1407053261);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(24, 1, '689ef549-83ce-4471-a84f-b2fc54713572', NULL, 'comment', 'issue', 1, '192.168.2.102', 1407053449);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(25, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', NULL, 'confirmed', 'issue', 1, '192.168.2.102', 1407062859);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(26, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', NULL, 'assigned', 'issue', 1, '192.168.2.102', 1407062906);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(27, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', NULL, 'confirmed', 'issue', 1, '192.168.2.102', 1407062917);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(28, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', NULL, 'assigned', 'issue', 1, '192.168.2.102', 1407062928);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(29, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', NULL, 'confirmed', 'issue', 1, '192.168.2.102', 1407062950);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(30, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', NULL, 'assigned', 'issue', 1, '192.168.2.102', 1407062975);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(31, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', NULL, 'confirmed', 'issue', 1, '192.168.2.102', 1407062997);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(32, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', NULL, 'assigned', 'issue', 1, '192.168.2.102', 1407063021);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(33, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', NULL, 'confirmed', 'issue', 1, '192.168.2.102', 1407063200);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(34, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', NULL, 'assigned', 'issue', 1, '192.168.2.102', 1407063300);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(35, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', NULL, 'confirmed', 'issue', 1, '192.168.2.102', 1407063349);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(36, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', NULL, 'invalid', 'issue', 1, '192.168.2.102', 1407077644);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(37, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', NULL, 'unresolved', 'issue', 1, '192.168.2.102', 1407077680);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(38, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', NULL, 'assigned', 'issue', 1, '192.168.2.102', 1407079243);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(39, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', NULL, 'confirmed', 'issue', 1, '192.168.2.102', 1407079354);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(40, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', NULL, 'assigned', 'issue', 1, '192.168.2.102', 1407079383);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(41, 1, '', NULL, 'create', 'issue', 1, '192.168.2.102', 1407092346);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(42, 1, '', NULL, 'create', 'issue', 1, '192.168.2.102', 1407093348);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(43, 1, 'ef7d17e9-36b1-43c0-b51b-fade69b3d867', NULL, 'confirmed', 'issue', 1, '192.168.2.102', 1407093368);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(44, 1, '', NULL, 'create', 'issue', 1, '192.168.2.102', 1407093846);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(45, 1, NULL, NULL, 'delete', 'issue', 1, '192.168.2.102', 1407093905);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(46, 1, NULL, NULL, 'delete', 'issue', 1, '192.168.2.102', 1407094220);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(47, 1, '689ef549-83ce-4471-a84f-b2fc54713572', NULL, 'create', 'issue', 1, '192.168.2.102', 1407104474);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(48, 1, '030f9303-ae49-4e26-bd1c-91f2e5e06dc2', 'db13e271-007b-4a4d-8673-cd16e7680f25', 'comment', 'issue', 1, '192.168.2.102', 1407104735);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(49, 1, '030f9303-ae49-4e26-bd1c-91f2e5e06dc2', NULL, 'create', 'issue', 1, '192.168.2.102', 1407105247);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(50, 1, '26eb3ff3-2565-4642-8656-68f9c10f3a92', NULL, 'create', 'issue', 1, '192.168.2.102', 1407106385);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(51, 1, 'e25e6826-54bd-4b24-a0db-d0c4e4ba2dc9', NULL, 'create', 'issue', 1, '192.168.2.102', 1407106476);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(52, 1, '5c7bfde3-ba18-4898-8fdd-2f12fed6a1ea', NULL, 'create', 'issue', 1, '192.168.2.102', 1407106528);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(53, 1, '5c7bfde3-ba18-4898-8fdd-2f12fed6a1ea', '36266a0c-c562-4979-8d98-c4aeec5ec858', 'invalid', 'issue', 1, '192.168.2.102', 1407107844);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(54, 1, '5c7bfde3-ba18-4898-8fdd-2f12fed6a1ea', '68ad12f3-e955-448c-9df5-1b7c75e63888', 'comment', 'issue', 1, '192.168.2.102', 1407108023);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(55, 1, '5c7bfde3-ba18-4898-8fdd-2f12fed6a1ea', NULL, 'delete', 'issue', 1, '192.168.2.102', 1407108289);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(56, 1, 'e25e6826-54bd-4b24-a0db-d0c4e4ba2dc9', NULL, 'delete', 'issue', 1, '192.168.2.102', 1407108866);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(57, 1, '26eb3ff3-2565-4642-8656-68f9c10f3a92', NULL, 'delete', 'issue', 1, '192.168.2.102', 1407108996);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(58, 1, '17f4988f-d422-406f-9b7d-014e9fcdf322', NULL, 'delete', 'issue', 1, '192.168.2.102', 1407109090);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(59, 1, '030f9303-ae49-4e26-bd1c-91f2e5e06dc2', NULL, 'delete', 'issue', 1, '192.168.2.102', 1407109183);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(60, 1, '689ef549-83ce-4471-a84f-b2fc54713572', 'd0c34559-5654-4119-a200-7b29eda6ea00', 'assigned', 'issue', 1, '192.168.2.102', 1407110464);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(61, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', '35e18f2d-9fb1-42e1-af67-d4a8d1e979a1', 'in_progress', 'issue', 1, '192.168.2.102', 1407131387);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(62, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 'b0ab98a2-d876-4fb9-9c41-d00bbd8b0bee', 'in_progress', 'issue', 1, '192.168.233.1', 1407301232);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(63, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', '759c4384-ca36-47aa-8bf6-e9a67902e326', 'in_progress', 'issue', 1, '192.168.233.1', 1407376124);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(64, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', '2066740c-f466-4f96-8607-9f258073e1ca', 'in_progress', 'issue', 1, '192.168.233.1', 1407376490);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(65, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 'd7da6fca-8179-4376-917c-2a2309183d09', 'in_progress', 'issue', 1, '192.168.233.1', 1407376682);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(66, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', '434be798-8bad-40da-b951-a693959d3f20', 'in_progress', 'issue', 1, '192.168.233.1', 1407376729);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(67, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 'a70974fe-98a0-490e-b157-eb68e50cd8f9', 'invalid', 'issue', 1, '192.168.233.1', 1407376928);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(68, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', '578c5637-c976-455d-bf84-e6d29decc695', 'in_progress', 'issue', 1, '192.168.233.1', 1407377011);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(69, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', '550f3e18-171b-4767-8a7c-3b6a3ccd0249', 'in_progress', 'issue', 1, '192.168.233.1', 1407377208);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(70, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 'f7dbcb3c-889b-4062-9848-7a2d020da6e4', 'in_progress', 'issue', 1, '192.168.233.1', 1407377526);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(71, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 'ddcf0032-86c8-46a7-a248-d146f4609edb', 'in_progress', 'issue', 1, '192.168.233.1', 1407377807);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(72, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 'ab4ff219-7ca8-42b0-8a1c-38f45c33aee4', 'invalid', 'issue', 1, '192.168.233.1', 1407378481);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(73, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 'b786c4d7-74a6-4236-ab86-5041800020f6', 'in_progress', 'issue', 1, '192.168.233.1', 1407378504);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(74, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 'e61fa50d-0ac9-446e-8b93-11d18059d562', 'comment', 'issue', 1, '192.168.233.1', 1407379994);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(75, 1, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', '1d37537e-2e59-46e7-a2c5-4b1623751da8', 'comment', 'issue', 1, '192.168.233.1', 1407917455);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(76, 1, '689ef549-83ce-4471-a84f-b2fc54713572', 'b86fa87e-5359-4b9a-8bf6-cd21da94624e', 'invalid', 'issue', 1, '192.168.233.1', 1407918615);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(77, 1, '689ef549-83ce-4471-a84f-b2fc54713572', 'b1de2923-3ce6-4daf-bd2e-f31b14ce02b2', 'comment', 'issue', 1, '192.168.233.1', 1407918625);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(78, 1, '689ef549-83ce-4471-a84f-b2fc54713572', '076494e5-4ced-478f-81b2-b185d93be1b8', 'assigned', 'issue', 1, '192.168.233.1', 1407952987);
INSERT INTO `jordon_project_activity` (`id`, `project_id`, `parent_uuid`, `action_uuid`, `action`, `target`, `by`, `ip`, `date`) VALUES(79, 1, 'c973214b-30cd-41c1-9244-9640a23a9309', NULL, 'create', 'issue', 1, '93.220.230.190', 1410430991);

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

INSERT INTO `jordon_project_category` (`id`, `title`, `description`, `sort_order`, `date_created`) VALUES(1, 'BizLogic Products', NULL, NULL, 1406259128);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=18 ;

--
-- Dumping data for table `jordon_project_category_rel`
--

INSERT INTO `jordon_project_category_rel` (`id`, `project_id`, `category_id`) VALUES(1, 1, 1);
INSERT INTO `jordon_project_category_rel` (`id`, `project_id`, `category_id`) VALUES(2, 2, 1);
INSERT INTO `jordon_project_category_rel` (`id`, `project_id`, `category_id`) VALUES(3, 3, 1);
INSERT INTO `jordon_project_category_rel` (`id`, `project_id`, `category_id`) VALUES(4, 4, 1);
INSERT INTO `jordon_project_category_rel` (`id`, `project_id`, `category_id`) VALUES(5, 30, 1);
INSERT INTO `jordon_project_category_rel` (`id`, `project_id`, `category_id`) VALUES(6, 11, 1);
INSERT INTO `jordon_project_category_rel` (`id`, `project_id`, `category_id`) VALUES(7, 5, 1);
INSERT INTO `jordon_project_category_rel` (`id`, `project_id`, `category_id`) VALUES(8, 10, 1);
INSERT INTO `jordon_project_category_rel` (`id`, `project_id`, `category_id`) VALUES(9, 16, 1);
INSERT INTO `jordon_project_category_rel` (`id`, `project_id`, `category_id`) VALUES(10, 6, 1);
INSERT INTO `jordon_project_category_rel` (`id`, `project_id`, `category_id`) VALUES(11, 13, 1);
INSERT INTO `jordon_project_category_rel` (`id`, `project_id`, `category_id`) VALUES(12, 22, 1);
INSERT INTO `jordon_project_category_rel` (`id`, `project_id`, `category_id`) VALUES(13, 12, 1);
INSERT INTO `jordon_project_category_rel` (`id`, `project_id`, `category_id`) VALUES(14, 20, 1);
INSERT INTO `jordon_project_category_rel` (`id`, `project_id`, `category_id`) VALUES(15, 15, 1);
INSERT INTO `jordon_project_category_rel` (`id`, `project_id`, `category_id`) VALUES(16, 7, 1);
INSERT INTO `jordon_project_category_rel` (`id`, `project_id`, `category_id`) VALUES(17, 17, 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=27 ;

--
-- Dumping data for table `jordon_project_issue`
--

INSERT INTO `jordon_project_issue` (`id`, `uuid`, `project_id`, `project_issue_id`, `revision_uuid`, `date_last_comment`, `date_created`, `date_resolved`, `date_updated`) VALUES(1, 'd6e164d0-14d6-11e4-8c21-0800200c9a66', 1, 1, 'a082613b-1b1f-11e4-9bc3-000c29eb70ec', 1407053261, 1406387514, NULL, 1407050306);
INSERT INTO `jordon_project_issue` (`id`, `uuid`, `project_id`, `project_issue_id`, `revision_uuid`, `date_last_comment`, `date_created`, `date_resolved`, `date_updated`) VALUES(2, 'f6c7fdfc-38de-4f58-aca2-68dedfa112db', 1, 2, 'a082b689-1b1f-11e4-9bc3-000c29eb70ec', NULL, 1406642981, NULL, 1407050306);
INSERT INTO `jordon_project_issue` (`id`, `uuid`, `project_id`, `project_issue_id`, `revision_uuid`, `date_last_comment`, `date_created`, `date_resolved`, `date_updated`) VALUES(4, 'a4951bab-c013-45aa-88a7-5232cf8548f2', 1, 3, 'a08345a0-1b1f-11e4-9bc3-000c29eb70ec', NULL, 1406643402, NULL, 1407050306);
INSERT INTO `jordon_project_issue` (`id`, `uuid`, `project_id`, `project_issue_id`, `revision_uuid`, `date_last_comment`, `date_created`, `date_resolved`, `date_updated`) VALUES(8, 'f085126d-4b7a-4855-ba37-6b632aa147d3', 1, 4, 'a083e048-1b1f-11e4-9bc3-000c29eb70ec', NULL, 1406776236, NULL, 1407050306);
INSERT INTO `jordon_project_issue` (`id`, `uuid`, `project_id`, `project_issue_id`, `revision_uuid`, `date_last_comment`, `date_created`, `date_resolved`, `date_updated`) VALUES(9, 'd48b0adf-3cee-4fdb-b25c-0d2a566e8ee8', 1, 5, 'a084590c-1b1f-11e4-9bc3-000c29eb70ec', NULL, 1406776294, NULL, 1407050306);
INSERT INTO `jordon_project_issue` (`id`, `uuid`, `project_id`, `project_issue_id`, `revision_uuid`, `date_last_comment`, `date_created`, `date_resolved`, `date_updated`) VALUES(10, 'd869d8e2-df78-43f3-a33d-a3567b2e18b2', 1, 6, 'a0846059-1b1f-11e4-9bc3-000c29eb70ec', NULL, 1406776487, NULL, 1407050306);
INSERT INTO `jordon_project_issue` (`id`, `uuid`, `project_id`, `project_issue_id`, `revision_uuid`, `date_last_comment`, `date_created`, `date_resolved`, `date_updated`) VALUES(11, 'daad9ccc-f01c-47fb-b8d4-08e6d7cb01a0', 1, 7, 'a085db45-1b1f-11e4-9bc3-000c29eb70ec', NULL, 1406776517, NULL, 1407050306);
INSERT INTO `jordon_project_issue` (`id`, `uuid`, `project_id`, `project_issue_id`, `revision_uuid`, `date_last_comment`, `date_created`, `date_resolved`, `date_updated`) VALUES(12, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 1, 8, 'b786c4d7-74a6-4236-ab86-5041800020f6', 1407917455, 1406776557, NULL, 1407378504);
INSERT INTO `jordon_project_issue` (`id`, `uuid`, `project_id`, `project_issue_id`, `revision_uuid`, `date_last_comment`, `date_created`, `date_resolved`, `date_updated`) VALUES(22, '98ea3e52-c6f6-45b2-a972-60540d4c3ac1', 1, 9, 'a085eab9-1b1f-11e4-9bc3-000c29eb70ec', NULL, 1406776598, 1406967408, 1406967408);
INSERT INTO `jordon_project_issue` (`id`, `uuid`, `project_id`, `project_issue_id`, `revision_uuid`, `date_last_comment`, `date_created`, `date_resolved`, `date_updated`) VALUES(23, '79f16d53-02ef-4727-acbf-35c5a107164d', 1, 10, 'a085f1a2-1b1f-11e4-9bc3-000c29eb70ec', NULL, 1406815179, NULL, NULL);
INSERT INTO `jordon_project_issue` (`id`, `uuid`, `project_id`, `project_issue_id`, `revision_uuid`, `date_last_comment`, `date_created`, `date_resolved`, `date_updated`) VALUES(24, 'c4fa92ae-f740-49e4-ac67-4d3bd8b951a1', 1, 11, 'a085f3ed-1b1f-11e4-9bc3-000c29eb70ec', NULL, 1406853195, NULL, NULL);
INSERT INTO `jordon_project_issue` (`id`, `uuid`, `project_id`, `project_issue_id`, `revision_uuid`, `date_last_comment`, `date_created`, `date_resolved`, `date_updated`) VALUES(25, '689ef549-83ce-4471-a84f-b2fc54713572', 1, 12, '076494e5-4ced-478f-81b2-b185d93be1b8', 1407918625, 1406970529, NULL, 1407952987);
INSERT INTO `jordon_project_issue` (`id`, `uuid`, `project_id`, `project_issue_id`, `revision_uuid`, `date_last_comment`, `date_created`, `date_resolved`, `date_updated`) VALUES(26, 'c973214b-30cd-41c1-9244-9640a23a9309', 1, 30, 'e62a261e-2909-4d96-968b-07a3c4a94e35', NULL, 1410430991, NULL, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=32 ;

--
-- Dumping data for table `jordon_project_issue_activity`
--

INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(1, '030f9303-ae49-4e26-bd1c-91f2e5e06dc2', 'db13e271-007b-4a4d-8673-cd16e7680f25', 'comment', 1, '192.168.2.102', 1407104735);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(2, '26eb3ff3-2565-4642-8656-68f9c10f3a92', NULL, 'create', 1, '192.168.2.102', 1407106385);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(3, 'e25e6826-54bd-4b24-a0db-d0c4e4ba2dc9', NULL, 'create', 1, '192.168.2.102', 1407106476);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(4, '5c7bfde3-ba18-4898-8fdd-2f12fed6a1ea', NULL, 'create', 1, '192.168.2.102', 1407106528);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(5, '5c7bfde3-ba18-4898-8fdd-2f12fed6a1ea', '36266a0c-c562-4979-8d98-c4aeec5ec858', 'invalid', 1, '192.168.2.102', 1407107844);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(6, '5c7bfde3-ba18-4898-8fdd-2f12fed6a1ea', '68ad12f3-e955-448c-9df5-1b7c75e63888', 'comment', 1, '192.168.2.102', 1407108023);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(7, '5c7bfde3-ba18-4898-8fdd-2f12fed6a1ea', NULL, 'delete', 1, '192.168.2.102', 1407108289);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(8, 'e25e6826-54bd-4b24-a0db-d0c4e4ba2dc9', NULL, 'delete', 1, '192.168.2.102', 1407108866);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(9, '26eb3ff3-2565-4642-8656-68f9c10f3a92', NULL, 'delete', 1, '192.168.2.102', 1407108996);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(10, '17f4988f-d422-406f-9b7d-014e9fcdf322', NULL, 'delete', 1, '192.168.2.102', 1407109090);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(11, '030f9303-ae49-4e26-bd1c-91f2e5e06dc2', NULL, 'delete', 1, '192.168.2.102', 1407109183);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(12, '689ef549-83ce-4471-a84f-b2fc54713572', 'd0c34559-5654-4119-a200-7b29eda6ea00', 'assigned', 1, '192.168.2.102', 1407110464);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(13, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', '35e18f2d-9fb1-42e1-af67-d4a8d1e979a1', 'in_progress', 1, '192.168.2.102', 1407131387);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(14, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 'b0ab98a2-d876-4fb9-9c41-d00bbd8b0bee', 'in_progress', 1, '192.168.233.1', 1407301232);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(15, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', '759c4384-ca36-47aa-8bf6-e9a67902e326', 'in_progress', 1, '192.168.233.1', 1407376124);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(16, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', '2066740c-f466-4f96-8607-9f258073e1ca', 'in_progress', 1, '192.168.233.1', 1407376490);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(17, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 'd7da6fca-8179-4376-917c-2a2309183d09', 'in_progress', 1, '192.168.233.1', 1407376682);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(18, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', '434be798-8bad-40da-b951-a693959d3f20', 'in_progress', 1, '192.168.233.1', 1407376729);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(19, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 'a70974fe-98a0-490e-b157-eb68e50cd8f9', 'invalid', 1, '192.168.233.1', 1407376928);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(20, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', '578c5637-c976-455d-bf84-e6d29decc695', 'in_progress', 1, '192.168.233.1', 1407377011);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(21, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', '550f3e18-171b-4767-8a7c-3b6a3ccd0249', 'in_progress', 1, '192.168.233.1', 1407377208);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(22, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 'f7dbcb3c-889b-4062-9848-7a2d020da6e4', 'in_progress', 1, '192.168.233.1', 1407377526);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(23, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 'ddcf0032-86c8-46a7-a248-d146f4609edb', 'in_progress', 1, '192.168.233.1', 1407377807);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(24, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 'ab4ff219-7ca8-42b0-8a1c-38f45c33aee4', 'invalid', 1, '192.168.233.1', 1407378481);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(25, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 'b786c4d7-74a6-4236-ab86-5041800020f6', 'in_progress', 1, '192.168.233.1', 1407378504);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(26, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 'e61fa50d-0ac9-446e-8b93-11d18059d562', 'comment', 1, '192.168.233.1', 1407379994);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(27, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', '1d37537e-2e59-46e7-a2c5-4b1623751da8', 'comment', 1, '192.168.233.1', 1407917455);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(28, '689ef549-83ce-4471-a84f-b2fc54713572', 'b86fa87e-5359-4b9a-8bf6-cd21da94624e', 'invalid', 1, '192.168.233.1', 1407918615);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(29, '689ef549-83ce-4471-a84f-b2fc54713572', 'b1de2923-3ce6-4daf-bd2e-f31b14ce02b2', 'comment', 1, '192.168.233.1', 1407918625);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(30, '689ef549-83ce-4471-a84f-b2fc54713572', '076494e5-4ced-478f-81b2-b185d93be1b8', 'assigned', 1, '192.168.233.1', 1407952987);
INSERT INTO `jordon_project_issue_activity` (`id`, `issue_uuid`, `action_uuid`, `action`, `by`, `ip`, `date`) VALUES(31, 'c973214b-30cd-41c1-9244-9640a23a9309', NULL, 'create', 1, '93.220.230.190', 1410430991);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=15 ;

--
-- Dumping data for table `jordon_project_issue_comment`
--

INSERT INTO `jordon_project_issue_comment` (`id`, `uuid`, `issue_id`, `reply_to`, `author_id`, `comment`, `ip`, `date`) VALUES(11, '32BEA041-EE93-4cbc-8110-DB70C3662E7A', 8, NULL, 1, 'Working...', '192.168.2.102', 1406823632);
INSERT INTO `jordon_project_issue_comment` (`id`, `uuid`, `issue_id`, `reply_to`, `author_id`, `comment`, `ip`, `date`) VALUES(14, 'b1de2923-3ce6-4daf-bd2e-f31b14ce02b2', 25, NULL, 1, 'I just started working on this right now.', '192.168.233.1', 1407918625);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=111 ;

--
-- Dumping data for table `jordon_project_issue_revision`
--

INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(1, 'd6e164d0-14d6-11e4-8c21-0800200c9a66', 1, 'a082613b-1b1f-11e4-9bc3-000c29eb70ec', NULL, 1, 1, 'Create Issues', 'A feature to create issues', NULL, 1, 1, 1, 1, 1, 9, 2, 2, NULL, NULL, 1406387514, 1406748185, 1406738767, 1406748185, '127.0.0.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(2, 'f6c7fdfc-38de-4f58-aca2-68dedfa112db', 1, 'a082b689-1b1f-11e4-9bc3-000c29eb70ec', NULL, 1, 2, 'Edit Issues', 'Need feature to edit issues', 1, 1, 1, 1, 1, 1, 9, 2, 2, NULL, NULL, 1406642981, 1406776015, 1406776015, 1406642981, '127.0.0.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(4, 'a4951bab-c013-45aa-88a7-5232cf8548f2', 1, 'a08345a0-1b1f-11e4-9bc3-000c29eb70ec', NULL, 1, 3, 'Delete Issues', 'Need feature to delete issues', 1, 1, 1, NULL, 1, 1, 9, 2, 2, NULL, NULL, 1406643402, 1406756500, 1406756500, 1406756500, '127.0.0.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(8, 'f085126d-4b7a-4855-ba37-6b632aa147d3', 1, 'a083e048-1b1f-11e4-9bc3-000c29eb70ec', NULL, 1, 4, 'Edit Assignee & Reporter', 'Need feature to edit the Assignee & Reporter of an Issue', 1, 1, 1, 1, 1, 1, 9, 2, 2, 1406823632, NULL, 1406776236, 1406851525, 1406851525, 1406851525, '127.0.0.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(9, 'd48b0adf-3cee-4fdb-b25c-0d2a566e8ee8', 1, 'a084590c-1b1f-11e4-9bc3-000c29eb70ec', NULL, 1, 5, 'Affected Version Does Not Display in Issue View', 'Affected Version Does Not Display in Issue View', 1, 2, 1, NULL, 10, 1, 9, 2, 2, NULL, NULL, 1406776294, 1406820554, 1406820554, 1406820554, '127.0.0.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(10, 'd869d8e2-df78-43f3-a33d-a3567b2e18b2', 1, 'a0846059-1b1f-11e4-9bc3-000c29eb70ec', NULL, 1, 6, 'Ensure Bootstrap is Current Version', 'Ensure Bootstrap is Current Version', 1, 6, 1, NULL, 10, 1, 9, 2, 2, NULL, NULL, 1406776487, 1406820722, 1406820722, 1406820722, '127.0.0.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(11, 'daad9ccc-f01c-47fb-b8d4-08e6d7cb01a0', 1, 'a085db45-1b1f-11e4-9bc3-000c29eb70ec', NULL, 1, 7, 'Search', 'Search', 1, 1, 1, NULL, 10, 1, 1, 1, 1, NULL, NULL, 1406776517, NULL, NULL, 1406776517, '127.0.0.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(12, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 1, 'a085e459-1b1f-11e4-9bc3-000c29eb70ec', NULL, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, NULL, 1, 1, 1, 1, 1, NULL, NULL, 1406776557, NULL, NULL, 1406776557, '127.0.0.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(13, '98ea3e52-c6f6-45b2-a972-60540d4c3ac1', 1, 'a085eab9-1b1f-11e4-9bc3-000c29eb70ec', NULL, 1, 9, 'Activity Stream on Project View', 'Activity Stream on Project View', 1, 1, 1, NULL, 10, 1, 9, 2, 2, 1406969996, NULL, 1406776598, 1406967408, 1406967408, 1406967408, '127.0.0.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(14, '79f16d53-02ef-4727-acbf-35c5a107164d', 1, 'a085f1a2-1b1f-11e4-9bc3-000c29eb70ec', NULL, 1, 10, 'In-line Editing of Comments', 'In-line Editing of Comments', 1, 1, 1, NULL, 7, 1, 1, 1, 1, NULL, NULL, 1406815179, NULL, NULL, 1406815179, '127.0.0.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(15, 'c4fa92ae-f740-49e4-ac67-4d3bd8b951a1', 1, 'a085f3ed-1b1f-11e4-9bc3-000c29eb70ec', NULL, 1, 11, 'Time Tracking', 'Feature to log work hours', 1, 1, 1, NULL, 6, 1, 1, 1, 1, NULL, NULL, 1406853195, NULL, NULL, 1406853195, '127.0.0.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(16, '689ef549-83ce-4471-a84f-b2fc54713572', 1, 'a085f60c-1b1f-11e4-9bc3-000c29eb70ec', NULL, 1, 12, 'Admin UI', 'Admin UI', 1, 1, 1, NULL, 1, 1, 1, 1, 1, NULL, NULL, 1406970529, NULL, NULL, 1406970529, '127.0.0.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(21, '689ef549-83ce-4471-a84f-b2fc54713572', 2, 'a085f826-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 12, 'Admin UI', 'Admin UI', 1, 6, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1406970529, 1407045623, 1407045623, 1406970529, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(26, '689ef549-83ce-4471-a84f-b2fc54713572', 3, 'a085fa4e-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 12, 'Admin UI', 'Admin UI', 1, 6, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1406970529, 1407046712, 1407046712, 1406970529, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(27, '689ef549-83ce-4471-a84f-b2fc54713572', 4, 'a085fe6e-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 12, 'Admin UI', 'Admin UI', 1, 2, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1406970529, 1407046794, 1407046794, 1406970529, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(28, '689ef549-83ce-4471-a84f-b2fc54713572', 5, 'a08600a2-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 12, 'Admin UI', 'Admin UI', 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1406970529, 1407047459, NULL, 1406970529, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(29, '689ef549-83ce-4471-a84f-b2fc54713572', 6, 'a08602be-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 12, 'Admin UI', 'Admin UI', 1, 1, 1, 0, 3, 1, 1, 1, 1, 0, 0, 1406970529, 1407047735, 0, 1406970529, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(30, '689ef549-83ce-4471-a84f-b2fc54713572', 7, 'a08604df-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 12, 'Admin UI', 'Admin UI', 1, 1, 1, 0, 2, 1, 1, 1, 1, 0, 0, 1406970529, 1407048237, 1407048237, 1406970529, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(31, '689ef549-83ce-4471-a84f-b2fc54713572', 8, 'a0860b73-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 12, 'Admin UI', 'Admin UI', 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1406970529, 1407048256, 0, 1406970529, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(32, '689ef549-83ce-4471-a84f-b2fc54713572', 9, 'a08691ff-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 12, 'Admin UI', 'Admin UI', 1, 1, 1, 0, 1, 1, 1, 2, 1, 0, 0, 1406970529, 1407048322, 1407048322, 1406970529, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(33, '689ef549-83ce-4471-a84f-b2fc54713572', 10, 'a086985b-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 12, 'Admin UI', 'Admin UI', 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1406970529, 1407048344, 0, 1406970529, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(34, '689ef549-83ce-4471-a84f-b2fc54713572', 11, 'a0869bcc-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 12, 'Admin UI', 'Admin UI', 1, 1, 1, 0, 1, 1, 12, 1, 1, 0, 0, 1406970529, 1407048698, 0, 1406970529, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(35, 'c4fa92ae-f740-49e4-ac67-4d3bd8b951a1', 2, 'a0869d32-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 11, 'Time Tracking', 'Feature to log work hours', 1, 1, 1, 0, 6, 1, 1, 1, 1, 0, 0, 1406853195, 1407050069, 0, 1406853195, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(36, 'c4fa92ae-f740-49e4-ac67-4d3bd8b951a1', 3, 'a0869f39-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 11, 'Time Tracking', 'Feature to log work hours', 1, 1, 1, 0, 6, 1, 1, 1, 1, 0, 0, 1406853195, 1407050306, 0, 1406853195, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(37, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 2, 'a086a15e-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 0, 1, 1, 12, 1, 1, 0, 0, 1406776557, 1407062859, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(38, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 3, 'a086a4b0-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 0, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407062906, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(39, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 4, 'a086a6e4-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 0, 1, 1, 12, 1, 1, 0, 0, 1406776557, 1407062917, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(40, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 5, 'a086a907-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 0, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407062928, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(41, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 6, 'a086c36d-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 0, 1, 1, 12, 1, 1, 0, 0, 1406776557, 1407062950, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(42, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 7, 'a086f149-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 0, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407062975, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(43, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 8, 'a086f74e-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 0, 1, 1, 12, 1, 1, 0, 0, 1406776557, 1407062997, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(44, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 9, 'a086f8d5-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 0, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407063021, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(45, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 10, 'a086fb72-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 0, 1, 1, 12, 1, 1, 0, 0, 1406776557, 1407063200, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(46, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 11, 'a086fde7-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 0, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407063300, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(47, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 12, 'a0870012-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 0, 1, 1, 12, 1, 1, 0, 0, 1406776557, 1407063349, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(48, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 13, 'a0870371-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 4, 1, 0, 1, 1, 12, 1, 1, 0, 0, 1406776557, 1407075511, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(49, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 14, 'a08706da-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 0, 1, 1, 12, 1, 1, 0, 0, 1406776557, 1407075588, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(50, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 15, 'a087091c-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 0, 1, 1, 12, 1, 6, 0, 0, 1406776557, 1407077644, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(51, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 16, 'a08724c6-1b1f-11e4-9bc3-000c29eb70ec', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 0, 1, 1, 12, 1, 1, 0, 0, 1406776557, 1407077680, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(52, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 17, '8ccbcb64-f597-46d2-94ba-2c284a44d154', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 0, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407079243, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(53, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 18, 'd491704e-a3e9-4866-a0b9-3f83f94081c2', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 0, 1, 1, 12, 1, 1, 0, 0, 1406776557, 1407079354, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(54, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 19, 'a44bdd51-cb10-45c5-8785-ea95b62cace5', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 0, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407079383, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(55, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 20, '12ca2b5d-8b67-4c0c-bd0e-235091bc8589', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 4, 1, 0, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407079850, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(56, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 21, '37ff7776-9ec4-4f71-9beb-fe9e537ea8f7', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 0, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407079868, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(57, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 22, 'a99a8120-df7a-445b-b337-8a62b5be490f', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407081797, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(58, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 23, 'cd057f9a-d3bf-4532-a988-527b7510fe93', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, -1, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407081903, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(59, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 24, '678e5c79-d246-424d-bd94-1fab66e8a5e0', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407083200, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(60, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 25, '3758b5a7-76f4-42a3-9394-dc64b220fe89', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, -1, 1, 1, 2, 1, 1, 0, 0, 1406776557, 1407083352, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(61, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 26, '37de6368-185b-4cdf-a235-b3ec46f184cc', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 1, 1, 1, 2, 1, 1, 0, 0, 1406776557, 1407083701, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(62, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 27, '1f6f5ec4-348e-439a-a6f1-cc6223ab9c49', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, -1, 1, 1, 2, 1, 1, 0, 0, 1406776557, 1407083774, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(63, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 28, 'cd8636cf-6b00-4c15-8b18-782398d7e598', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407083789, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(64, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 29, '9dbd5131-67e4-4d5f-8d6b-36f0e2a57705', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, -1, 1, 1, 2, 1, 1, 0, 0, 1406776557, 1407086030, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(65, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 30, 'ae2cec69-7711-4bdf-8745-e79d741665f2', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407086490, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(66, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 31, '3cf29ec9-81d5-4e77-acdf-d9f965606c1e', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, -1, 1, 1, 2, 1, 1, 0, 0, 1406776557, 1407086816, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(67, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 32, '01e46404-ae7b-4039-a01d-8c11f3a79536', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407086908, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(68, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 33, 'a3ba7a3e-7b12-4846-bf9f-f038dec1fb98', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, -1, 1, 1, 2, 1, 1, 0, 0, 1406776557, 1407086937, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(69, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 34, '3b4b937c-3f57-4fc1-aa11-f16f1b05529b', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, NULL, 1, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407086969, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(70, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 35, '17b5bcd8-d87f-405d-b367-2ba9c979019a', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407088065, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(71, '92e30a5c-fc38-4375-919a-ee993c08a783', 1, '63230627-3d52-4ca2-a2d4-78a8f47aa950', 1, 1, 13, 'testing issue creation', 'testing issue creation', 1, 2, 1, NULL, 5, 1, 1, 1, 1, NULL, NULL, 1407091661, NULL, NULL, 0, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(73, '61170d8c-1b04-48d2-9d97-3915c6e26d9f', 1, 'c811fe10-ecce-46fc-8a8d-3beebb8b1f4b', 1, 1, 14, 'dfdfd', 'dfdfd', 1, 4, 1, NULL, 5, 1, 1, 1, 1, NULL, NULL, 1407092086, NULL, NULL, 0, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(74, '5306bee1-dd53-4813-803f-52989ddf71af', 1, 'f1e10970-2d3c-4d72-bea7-a3b6b7d834c9', 1, 1, 15, 'dfdfd', 'dfdfd', 1, 4, 1, NULL, 5, 1, 1, 1, 1, NULL, NULL, 1407092149, NULL, NULL, 0, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(75, '6f8f6f65-0031-4581-bf2f-cf28235a1e85', 1, '8360cace-cf69-48de-ba93-5152f0996c81', 1, 1, 16, 'dfdfd', 'dfdfd', 1, 4, 1, NULL, 5, 1, 1, 1, 1, NULL, NULL, 1407092171, NULL, NULL, 0, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(77, '1b05407f-e953-4de8-8b2a-c3f7737ab654', 1, 'a7b7a9f8-13c7-4e04-9d1f-8b6880b94907', 1, 1, 17, 'test', 'test', 1, 1, 1, NULL, 9, 2, 1, 1, 1, NULL, NULL, 1407092248, NULL, NULL, 0, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(78, '4c7ef393-ed0f-400a-8855-73f8ba82355e', 1, 'fba40a52-e4bc-4c8a-85bf-37c64e2254c8', 1, 1, 18, 'ddfdf', 'array_intersect', 1, 1, 1, NULL, 9, 2, 1, 1, 1, NULL, NULL, 1407092346, NULL, NULL, 0, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(79, 'fcf932f7-c01c-445d-b85f-e9be1aa37de7', 1, '0374ca7c-96a6-4776-a900-9f37ea65d969', 1, 1, 19, 'test', 'test', 1, 2, 1, NULL, 9, 1, 1, 1, 1, NULL, NULL, 1407092410, NULL, NULL, 0, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(80, '84982c18-18ac-45bf-ba80-debb1831a493', 1, 'df9eb1b6-2829-4272-9029-135656f0a05c', 1, 1, 20, 'ddfdarray_intersect_key', 'array_intersect_key', 1, 1, 1, NULL, 9, 1, 1, 1, 1, NULL, NULL, 1407092532, NULL, NULL, 0, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(81, '822aa9de-f575-4842-a647-00842f980704', 1, '01fc907b-8f1e-4237-be6a-6ad59cda33d3', 1, 1, 21, 'test', 'test', 1, 1, 1, NULL, 5, 2, 1, 1, 1, NULL, NULL, 1407092763, NULL, NULL, 0, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(82, '3b0cf26d-65cb-4bc0-93e9-961c70c5abed', 1, 'b4d5d1bc-1562-4c42-898b-3c76de83e61f', 1, 1, 22, 'teset', 'teset', 1, 2, 1, NULL, 5, 2, 1, 1, 1, NULL, NULL, 1407093139, NULL, NULL, 0, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(83, 'ef7d17e9-36b1-43c0-b51b-fade69b3d867', 1, 'c98b70a4-35e1-47f3-8a94-c59636c8ef21', 1, 1, 23, 'mic check', 'mic check', 1, 3, 1, NULL, 5, 1, 1, 1, 1, NULL, NULL, 1407093348, NULL, NULL, 0, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(84, 'ef7d17e9-36b1-43c0-b51b-fade69b3d867', 2, '45052885-2a6c-4d8b-8d4b-06e622ddd2a9', 1, 1, 23, 'mic check', 'mic check', 1, 3, 1, 0, 5, 1, 12, 1, 1, 0, 0, 1407093348, 1407093368, 0, 0, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(85, '1902aab7-3884-4b43-94d3-d860875018f1', 1, 'a55a1aa9-b151-46bc-a235-c79d14732f6b', 1, 1, 24, 'test', 'test', 1, 2, 1, NULL, 5, 1, 1, 1, 1, NULL, NULL, 1407093846, NULL, NULL, 0, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(86, '030f9303-ae49-4e26-bd1c-91f2e5e06dc2', 1, '78cfed45-4b8a-4706-83c8-583203e00df3', 1, 1, 25, 'testing activity log', 'testing activity log', 1, 1, 1, NULL, 5, 1, 1, 1, 1, NULL, NULL, 1407104474, NULL, NULL, 0, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(87, '17f4988f-d422-406f-9b7d-014e9fcdf322', 1, 'f8d9d510-bb1a-450a-8c68-e40d2a0901f6', 1, 1, 26, 'testing activity log entry', 'testing activity log entry', 1, 1, 1, NULL, 9, 1, 1, 1, 1, NULL, NULL, 1407105248, NULL, NULL, 0, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(88, '26eb3ff3-2565-4642-8656-68f9c10f3a92', 1, '88049020-6588-4dd1-9f0b-77536a2ee2d8', 1, 1, 27, 'testing...', 'testing...', 1, 1, 1, NULL, 7, 1, 1, 1, 1, NULL, NULL, 1407106385, NULL, NULL, 0, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(89, 'e25e6826-54bd-4b24-a0db-d0c4e4ba2dc9', 1, '7c9002ff-df3e-40b1-b3e5-373835449e9c', 1, 1, 28, 'testing again...', 'testing...', 1, 1, 1, NULL, 7, 1, 1, 1, 1, NULL, NULL, 1407106476, NULL, NULL, 0, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(90, '5c7bfde3-ba18-4898-8fdd-2f12fed6a1ea', 1, '281798d0-12b2-451c-9178-f8c1608bad11', 1, 1, 29, 'am I testing', 'am I testing', 1, 2, 1, NULL, 5, 1, 1, 1, 1, NULL, NULL, 1407106528, NULL, NULL, 0, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(91, '5c7bfde3-ba18-4898-8fdd-2f12fed6a1ea', 2, '36266a0c-c562-4979-8d98-c4aeec5ec858', 1, 1, 29, 'am I testing', 'am I testing', 1, 2, 1, 0, 5, 1, 6, 1, 1, 0, 0, 1407106528, 1407107844, 0, 0, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(92, '689ef549-83ce-4471-a84f-b2fc54713572', 12, 'd0c34559-5654-4119-a200-7b29eda6ea00', 1, 1, 12, 'Admin UI', 'Admin UI', 1, 1, 1, 0, 1, 1, 3, 1, 1, 0, 0, 1406970529, 1407110465, 0, 1406970529, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(93, '689ef549-83ce-4471-a84f-b2fc54713572', 13, '5a9796f3-2f89-45df-88ef-5fa993741f3a', 1, 1, 12, 'Admin UI', 'Admin UI', 1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 0, 1406970529, 1407110481, 0, 1406970529, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(94, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 36, '35e18f2d-9fb1-42e1-af67-d4a8d1e979a1', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407131387, 0, 1406776557, '192.168.2.102');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(95, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 37, 'b0ab98a2-d876-4fb9-9c41-d00bbd8b0bee', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407301232, 0, 1406776557, '192.168.233.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(96, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 38, '759c4384-ca36-47aa-8bf6-e9a67902e326', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407376124, 0, 1406776557, '192.168.233.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(97, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 39, '2066740c-f466-4f96-8607-9f258073e1ca', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407376490, 0, 1406776557, '192.168.233.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(98, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 40, 'd7da6fca-8179-4376-917c-2a2309183d09', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407376682, 0, 1406776557, '192.168.233.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(99, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 41, '434be798-8bad-40da-b951-a693959d3f20', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407376729, 0, 1406776557, '192.168.233.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(100, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 42, 'a70974fe-98a0-490e-b157-eb68e50cd8f9', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407376928, 0, 1406776557, '192.168.233.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(101, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 43, '578c5637-c976-455d-bf84-e6d29decc695', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407377011, 0, 1406776557, '192.168.233.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(102, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 44, '550f3e18-171b-4767-8a7c-3b6a3ccd0249', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407377208, 0, 1406776557, '192.168.233.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(103, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 45, 'f7dbcb3c-889b-4062-9848-7a2d020da6e4', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 0, 1406776557, 1407377526, 0, 1406776557, '192.168.233.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(104, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 46, 'ddcf0032-86c8-46a7-a248-d146f4609edb', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 1, 1, 1, 11, 1, 1, 0, 0, 1406776557, 1407377807, 0, 1406776557, '192.168.233.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(105, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 47, 'ab4ff219-7ca8-42b0-8a1c-38f45c33aee4', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 1, 1, 1, 6, 1, 1, 0, 0, 1406776557, 1407378481, 0, 0, '192.168.233.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(106, 'c3279f8b-4cda-4d17-b639-fd10bbee37f7', 48, 'b786c4d7-74a6-4236-ab86-5041800020f6', 1, 1, 8, 'User Profiles', 'User Profiles', 1, 1, 1, 1, 1, 1, 11, 1, 1, 0, 0, 1406776557, 1407378504, 0, 0, '192.168.233.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(107, '689ef549-83ce-4471-a84f-b2fc54713572', 14, 'b86fa87e-5359-4b9a-8bf6-cd21da94624e', 1, 1, 12, 'Admin UI', 'Admin UI', 1, 1, 1, 1, 1, 1, 6, 1, 1, 0, 0, 1406970529, 1407918615, 0, 0, '192.168.233.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(108, '689ef549-83ce-4471-a84f-b2fc54713572', 15, '0d946e83-dba8-4ff5-a025-495516bb7af7', 1, 1, 12, 'Admin UI', 'Admin UI', 1, 1, 1, -1, 1, 1, 6, 1, 1, 0, 0, 1406970529, 1407918683, 0, 0, '192.168.233.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(109, '689ef549-83ce-4471-a84f-b2fc54713572', 16, '076494e5-4ced-478f-81b2-b185d93be1b8', 1, 1, 12, 'Admin UI', 'Admin UI', 1, 1, 1, -1, 1, 1, 3, 1, 1, 0, 0, 1406970529, 1407952987, 0, 0, '192.168.233.1');
INSERT INTO `jordon_project_issue_revision` (`id`, `uuid`, `revision`, `revision_uuid`, `revised_by`, `project_id`, `project_issue_id`, `title`, `description`, `affected_version`, `type`, `reporter`, `assignee`, `priority`, `privacy`, `status`, `state`, `resolution`, `date_last_comment`, `date_released`, `date_created`, `date_updated`, `date_resolved`, `date_revision`, `ip`) VALUES(110, 'c973214b-30cd-41c1-9244-9640a23a9309', 1, 'e62a261e-2909-4d96-968b-07a3c4a94e35', 1, 1, 30, 'Test', 'This is a test issue', 1, 6, 1, NULL, 5, 1, 1, 1, 1, NULL, NULL, 1410430991, NULL, NULL, 0, '93.220.230.190');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `jordon_project_permission`
--

INSERT INTO `jordon_project_permission` (`id`, `project_id`, `target_uuid`, `permission_id`) VALUES(1, 1, '5FDCDE5E-55DA-471F-B638-A8C27B10225F', 3);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `jordon_project_version`
--

INSERT INTO `jordon_project_version` (`id`, `project_id`, `name`, `version`, `description`, `summary`, `release_notes`, `privacy`, `date_released`, `date_created`) VALUES(1, 1, 'MVP', 'MVP', NULL, NULL, NULL, 1, 1406636233, 1406636233);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=108 ;

--
-- Dumping data for table `jordon_site_config`
--

INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(1, 'site_name', 'BizLogic Jordan', NULL, 'global', 'text', 'Site Name', NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(2, 'site_default_preloader_image_path', '__BASEURL__/images/preloader/486.gif', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(3, 'site_default_landing_page', '', NULL, 'global', 'text', 'Local URL to redirect to after login, do not include the scheme, i.e. http://', NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(4, 'site_allow_template_change', '1', '0,1', 'global', 'radio', 'Allow Template Change', NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(5, 'site_default_template', 'paintstrap-sleeping-cat-moon2', NULL, 'global', 'text', NULL, NULL, '1');
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
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(18, 'site_email_address', 'admin@wtclone.com', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(19, 'site_upload_dir', 'data/uploads', NULL, 'upload', 'text', 'Relative path of the local file upload directory', NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(20, 'site_upload_dir_users', 'data/uploads/users', NULL, 'upload', 'text', 'Relative path of the local file upload directory for end-users', NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(22, 'site_token_min_length', '8', NULL, 'upload', 'text', 'Tokens match users to available files', NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(23, 'site_token_max_length', '15', NULL, 'upload', 'text', 'Tokens match users to available files', NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(24, 'site_local_theme_url_root', 'css/jquery-ui/themes', NULL, 'global', 'text', 'Theme root relative to the site. Do not include host or scheme.', 'relative to the site root', '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(25, 'site_default_admin_preloader_image_path', 'images/preloader/477-black-124x128.gif', NULL, 'admin', 'text', 'Local URL of the preloader image for the site admin UI. Do not include the protocol scheme.', NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(26, 'site_default_landing_page_after_login', '', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(52, 'site_use_blockui', '1', '1,0', 'global', 'radio', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(53, 'site_moderate_uploads', '0', '0,1', 'global', 'radio', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(64, 'site_url', 'http://dev.vevoclone.com', NULL, 'global', 'text', NULL, 'including scheme', '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(77, 'site_facebook_app_id', '324640691020497', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(78, 'site_twitter_api_key', 'KS0tMXGV1jBPHcr9B2NsxplmU', NULL, 'social', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(79, 'site_twitter_api_secret', '4SaA3aauMozDQqJIbEZIiwmJTYj1hBmaF6Ql0PILnBFHi604By', NULL, 'social', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(80, 'site_allow_social_login', '1', '0,1', 'social', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(81, 'site_yahoo_consumer_key', 'dj0yJmk9RlBPU09OTXZxY3hPJmQ9WVdrOVZuVkRWWGRHTXpZbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD04Mg--', NULL, 'social', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(82, 'site_yahoo_consumer_secret', 'e15419d9ab06e7cd727a252c16f03877e68cc7eb', NULL, 'social', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(83, 'site_yahoo_app_id', 'VuCUwF36', NULL, 'social', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(84, 'site_yahoo_domain', 'dev.vevoclone.com', NULL, 'social', 'text', NULL, NULL, '1');
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
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(98, 'site_issue_chart_xaxis_date_format', '%B %d', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(99, 'site_date_format', 'l, F, d, Y / h:i:s A P', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(100, 'site_issue_edit_style', 'inline', 'inline,popup', 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(101, 'site_issue_resolution_id', '2', NULL, 'global', 'select', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(102, 'site_cookie_path', '/', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(103, 'site_cookie_timeout', '622080000', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(104, 'site_loading_placeholder_small', '<img src="__BASEURL__/images/preloader/small-black.png" border="0">', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(105, 'site_comment_fetch_limit', '10', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(106, 'site_issue_status_unassigned_id', '2', NULL, 'global', 'text', NULL, NULL, '1');
INSERT INTO `jordon_site_config` (`id`, `name`, `value`, `possible_values`, `category`, `ui_type`, `hint`, `comment`, `editable`) VALUES(107, 'site_issue_status_assigned_id', '3', NULL, 'global', 'text', NULL, NULL, '1');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=277 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=104 ;

--
-- Dumping data for table `jordon_site_theme`
--

INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(1, 'bootstrap', 'cerulean', 'Cerulean', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(2, 'bootstrap', 'flatly', 'Flatly', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(3, 'bootstrap', 'amelia', 'Amelia', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(4, 'bootstrap', 'slate', 'Slate', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(5, 'bootstrap', 'cosmo', 'Cosmo', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(6, 'bootstrap', 'darkly', 'Darkly', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(7, 'bootstrap', 'cyborg', 'Cyborg', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(8, 'bootstrap', 'journal', 'Journal', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(9, 'bootstrap', 'lumen', 'Lumen', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(10, 'bootstrap', 'readable', 'Readable', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(11, 'bootstrap', 'bootstrap', 'Bootstrap', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(12, 'bootstrap', 'simplex', 'Simplex', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(13, 'bootstrap', 'spacelab', 'Spacelab', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(14, 'bootstrap', 'superhero', 'Superhero', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(15, 'bootstrap', 'united', 'United', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(16, 'bootstrap', 'bootstrap-with-theme', 'Bootstrap (w/ theme)', '0');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(17, 'bootstrap', 'yeti', 'Yeti', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(18, 'bootstrap', 'pastel', 'Pastel', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(19, 'bootstrap', 'autumn-dawn', 'Autumn Dawn', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(20, 'bootstrap', 'candy-box', 'Candy Box', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(21, 'bootstrap', 'black-classic', 'Black Classic', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(22, 'bootstrap', 'dark-orange', 'Dark Orange', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(23, 'bootstrap', 'dron', 'DRON', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(24, 'bootstrap', 'white-green', 'White Green', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(25, 'bootstrap', 'white-dark-blue', 'White Dark Blue', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(26, 'bootstrap', 'flat-ui', 'Flat UI', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(27, 'bootstrap', 'sys-dream', 'Sys Dream', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(28, 'bootstrap', 'lavish-mineral-hues', 'Lavish Mineral Hues', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(29, 'bootstrap', 'faceboot', 'Faceboot', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(30, 'bootstrap', 'solid', 'Solid', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(31, 'bootstrap', 'dark-admin', 'Dark Admin', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(32, 'bootstrap', 'paintstrap-capture', 'Paintstrap Capture', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(33, 'bootstrap', 'paintstrap-bluesky', 'Paintstrap Blue Sky', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(34, 'bootstrap', 'blueprint', 'Blueprint', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(35, 'bootstrap', 'black-classic-alt', 'Black Classic (Alt)', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(36, 'bootstrap', 'white-flatty', 'White Flatty', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(37, 'bootstrap', 'mnml-brown', 'Mnml Brown', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(38, 'bootstrap', 'flat-brown', 'Flat Brown', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(39, 'bootstrap', 'flat-white', 'Flat White', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(40, 'bootstrap', 'dark-flat', 'Dark Flat', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(41, 'bootstrap', 'cool-blue', 'Cool Blue', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(42, 'bootstrap', 'black-white', 'Black White', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(43, 'bootstrap', 'black-blue', 'Black Blue', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(44, 'bootstrap', 'classic-gray', 'Classic Gray', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(45, 'bootstrap', 'lavish-grass', 'Lavish Grass', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(46, 'bootstrap', 'lavish-sliced', 'Lavish Sliced', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(47, 'bootstrap', 'lavish-spring', 'Lavish Spring', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(48, 'bootstrap', 'lavish-sea', 'Lavish Sea', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(49, 'bootstrap', 'lavish-cockatoo', 'Lavish Cockatoo', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(50, 'bootstrap', 'lavish-creature', 'Lavish Creature', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(51, 'bootstrap', 'lavish-floating', 'Lavish Floating', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(52, 'bootstrap', 'lavish-penciled', 'Lavish Penciled', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(53, 'bootstrap', 'paintstrap-bloggy-gradient-blues', 'Paintstrap Bloggy Gradient Blues', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(54, 'bootstrap', 'paintstrap-aqua-boogie', 'Paintstrap Aqua Boogie', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(55, 'bootstrap', 'paintstrap-this-green', 'Paintstrap This Green', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(56, 'bootstrap', 'paintstrap-the-bizness', 'Paintstrap The Bizness', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(57, 'bootstrap', 'paintstrap-classic-business', 'Paintstrap Classic Business', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(58, 'bootstrap', 'paintstrap-marine-classic', 'Paintstrap Marine Classic', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(59, 'bootstrap', 'paintstrap-grandes-vinos', 'Paintstrap Grandes Vinos', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(60, 'bootstrap', 'paintstrap-sea', 'Paintstrap Sea', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(61, 'bootstrap', 'paintstrap-war', 'Paintstrap War', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(62, 'bootstrap', 'paintstrap-corporate-blues', 'Paintstrap Corporate Blues', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(63, 'bootstrap', 'paintstrap-beach-bums', 'Paintstrap Beach Bums', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(64, 'bootstrap', 'paintstrap-moxy', 'Paintstrap Moxy', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(65, 'bootstrap', 'paintstrap-sleeping-cat-moon2', 'Paintstrap Sleeping Cat Moon 2', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(66, 'bootstrap', 'paintstrap-beer', 'Paintstrap Beer', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(67, 'bootstrap', 'paintstrap-crenshaw', 'Paintstrap Crenshaw', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(68, 'bootstrap', 'paintstrap-kul-swag', 'Paintstrap Kul Swag', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(69, 'bootstrap', 'paintstrap-berkshire-hathaway', 'Paintstrap Berkshire Hathaway', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(70, 'bootstrap', 'paintstrap-reluctant-vampire', 'Paintstrap Reluctant Vampire', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(71, 'bootstrap', 'paintstrap-fotolia', 'Paintstrap Fotolia', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(72, 'bootstrap', 'paintstrap-vintage-rl', 'Paintstrap Vintage RL', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(73, 'bootstrap', 'paintstrap-second', 'Paintstrap Second', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(74, 'bootstrap', 'paintstrap-neutral-blue', 'Paintstrap Neutral Blue', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(75, 'bootstrap', 'paintstrap-newspaper', 'Paintstrap Newspaper', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(76, 'bootstrap', 'paintstrap-kul-moj', 'Paintstrap Kul Mój', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(77, 'bootstrap', 'paintstrap-sharon', 'Paintstrap Sharon', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(78, 'bootstrap', 'paintstrap-bubba-gump', 'Paintstrap Bubba Gump', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(79, 'bootstrap', 'paintstrap-happy-clean', 'Paintstrap Happy Clean', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(80, 'bootstrap', 'paintstrap-sean-don', 'Paintstrap Sean Don', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(81, 'bootstrap', 'paintstrap-american-psycho', 'Paintstrap American Psycho', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(82, 'bootstrap', 'paintstrap-purple-rain', 'Paintstrap Purple Rain', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(83, 'bootstrap', 'paintstrap-migo', 'Paintstrap Migo', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(84, 'bootstrap', 'paintstrap-gdb', 'Paintstrap GDB', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(85, 'bootstrap', 'paintstrap-hogwarts', 'Paintstrap Hogwarts', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(86, 'bootstrap', 'paintstrap-swaggyp', 'Paintstrap SwaggyP', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(87, 'bootstrap', 'paintstrap-threadless', 'Paintstrap Threadless', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(88, 'bootstrap', 'paintstrap-kent-state', 'Paintstrap Kent State', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(89, 'bootstrap', 'paintstrap-strictly-business', 'Paintstrap Strictly Business', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(90, 'bootstrap', 'paintstrap-neighbor', 'Paintstrap Neighbor', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(91, 'bootstrap', 'paintstrap-oma', 'Paintstrap Oma', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(92, 'bootstrap', 'paintstrap-business-magnate', 'Paintstrap Business Magnate', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(93, 'bootstrap', 'paintstrap-barney', 'Paintstrap Barney', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(94, 'bootstrap', 'paintstrap-terrific', 'Paintstrap Terrific', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(95, 'bootstrap', 'paintstrap-slauson', 'Paintstrap Slauson', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(96, 'bootstrap', 'paintstrap-onley', 'Paintstrap Onley', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(97, 'bootstrap', 'paintstrap-uofo', 'Paintstrap UofO', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(98, 'bootstrap', 'paintstrap-dirtydog', 'Paintstrap Dirty Dog', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(99, 'bootstrap', 'paintstrap-citrus', 'Paintstrap Citrus', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(100, 'bootstrap', 'paintstrap-redwine', 'Paintstrap Red Wine', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(101, 'bootstrap', 'paintstrap-suit-n-tie', 'Paintstrap Suit & Tie', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(102, 'bootstrap', 'paintstrap-lois-lane', 'Paintstrap Lois Lane', '1');
INSERT INTO `jordon_site_theme` (`id`, `type`, `name`, `display_name`, `active`) VALUES(103, 'bootstrap', 'paintstrap-miami', 'Paintstrap Miami', '1');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `jordon_user`
--

INSERT INTO `jordon_user` (`id`, `uuid`, `email`, `username`, `display_name`, `first_name`, `last_name`, `password`, `avatar_url`, `url_slug`, `site_language`, `site_status`, `date_created`, `signup_ip`, `last_upload`, `last_active`, `last_login_date`, `last_ip`) VALUES(1, '9e53acc0-e44f-11e3-ac10-0800200c9a66', 'jordon@marquisknox.com', 'MarQuis', 'MarQuis Knox', 'MarQuis', 'Knox', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', NULL, 'MarQuisKnox', 1, 'auto_confirmed', 1383254334, NULL, NULL, 1411688425, 1411519173, '93.228.77.76');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=39 ;

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

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
