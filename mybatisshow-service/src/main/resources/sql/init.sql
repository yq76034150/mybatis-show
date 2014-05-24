# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.5.35)
# Database: tecc-ui
# Generation Time: 2014-05-02 13:21:13 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table ui_event
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ui_event`;

CREATE TABLE `ui_event` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `from` bigint(20) DEFAULT NULL COMMENT '事件操作发起方（可能是系统本身）',
  `to` bigint(20) DEFAULT NULL COMMENT '事件影响方',
  `eventType` int(11) DEFAULT NULL COMMENT '事件类型（站内信、发表了信息等）',
  `eventResult` bigint(20) DEFAULT NULL COMMENT '事件结果',
  `handle` bigint(11) DEFAULT NULL COMMENT '处理方式（已读或其他处理方式操作）',
  `sync` tinyint(3) unsigned zerofill NOT NULL COMMENT '0 数据未同步；1 数据已同步',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='事件日志存储  外部只写入本表，不查询\n暂时废弃，不实现';



# Dump of table ui_eventtype
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ui_eventtype`;

CREATE TABLE `ui_eventtype` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '事件类型id',
  `belongType` int(11) DEFAULT NULL COMMENT '消息还是动态等',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ui_friend_movement
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ui_friend_movement`;

CREATE TABLE `ui_friend_movement` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `from` bigint(20) DEFAULT NULL COMMENT '事件操作发起方（可能是系统本身）',
  `to` bigint(20) DEFAULT NULL COMMENT '事件影响方',
  `eventType` int(11) DEFAULT NULL COMMENT '事件类型（站内信、发表了信息等）',
  `eventResult` bigint(20) DEFAULT NULL COMMENT '事件结果',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='好友动态，只用于外部用户查询，不写入；由内部程序批量写入数据';



# Dump of table ui_notify_message
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ui_notify_message`;

CREATE TABLE `ui_notify_message` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `from` bigint(20) DEFAULT NULL COMMENT '事件操作发起方（可能是系统本身）',
  `to` bigint(20) DEFAULT NULL COMMENT '事件影响方',
  `eventType` int(11) DEFAULT NULL COMMENT '事件类型（站内信、发表了信息等）',
  `eventResult` bigint(20) DEFAULT NULL COMMENT '事件结果',
  `handle` bigint(11) DEFAULT NULL COMMENT '处理方式（已读或其他处理方式操作）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户的通知信息，只用于外部用户查询，不写入；由内部程序批量写入数据';



# Dump of table ui_relation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ui_relation`;

CREATE TABLE `ui_relation` (
  `from` bigint(11) NOT NULL COMMENT '关注人id',
  `to` bigint(11) NOT NULL COMMENT '被关注人id',
  `cross` tinyint(11) unsigned zerofill NOT NULL COMMENT '1 互相关注；0 单向关注',
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `ix_ui_rel_from` (`from`),
  KEY `ix_ui_rel_to` (`to`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户关系表';



# Dump of table ui_share
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ui_share`;

CREATE TABLE `ui_share` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(140) NOT NULL DEFAULT '' COMMENT '分享内容',
  `praiseCount` int(10) unsigned zerofill NOT NULL COMMENT '赞的次数',
  `commentCount` int(10) unsigned zerofill NOT NULL COMMENT '评论的次数',
  `location` int(11) DEFAULT NULL COMMENT '地理位置',
  `type` bigint(20) NOT NULL COMMENT '类型，位运算区分 2的n次方',
  `userId` bigint(11) DEFAULT NULL COMMENT '发布分享的用户，可能是某个社团',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建分享的时间',
  `hot` bigint(20) DEFAULT NULL COMMENT '热度，使用一定的规则计算',
  `campusId` int(11) DEFAULT NULL COMMENT '发布分享用户对应的校园id',
  `campusName` varchar(64) NOT NULL DEFAULT '' COMMENT '学校名称，冗余字段',
  `private` tinyint(3) unsigned zerofill NOT NULL COMMENT '私密分享，0是；1否（私密分享会隐藏用户图像和昵称等信息）',
  `source` int(11) DEFAULT NULL COMMENT '来源，（信息服务平台等）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户分享表（核心）';



# Dump of table ui_share_comments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ui_share_comments`;

CREATE TABLE `ui_share_comments` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `content` varchar(140) NOT NULL DEFAULT '' COMMENT '评论内容',
  `at` bigint(11) NOT NULL COMMENT '回复谁的评论',
  `userId` bigint(11) DEFAULT NULL COMMENT '发布评论的用户',
  `fromId` bigint(20) DEFAULT NULL COMMENT '源评论id，有值说明是评论的回复',
  `shareId` bigint(11) NOT NULL COMMENT '分享id',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '评论产生时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户分享评论表\n两层结构设计，不盖高楼\n排列按发表时间排序，”***回复*** 内容“的方式展示';



# Dump of table ui_share_extra
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ui_share_extra`;

CREATE TABLE `ui_share_extra` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户分享附加属性';



# Dump of table ui_share_great
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ui_share_great`;

CREATE TABLE `ui_share_great` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `userId` bigint(11) DEFAULT NULL COMMENT '发布赞的用户',
  `shareId` bigint(11) NOT NULL COMMENT '分享id',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '赞产生时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户赞表\n只是分享本身会被赞';



# Dump of table ui_share_tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ui_share_tags`;

CREATE TABLE `ui_share_tags` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `tid` int(11) DEFAULT NULL COMMENT '标签id',
  `sid` bigint(11) DEFAULT NULL COMMENT '源内容id（活动、分享、二手等）',
  `type` bigint(11) DEFAULT NULL COMMENT '源内容类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户分享标签关联表';



# Dump of table ui_share_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ui_share_type`;

CREATE TABLE `ui_share_type` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(16) DEFAULT NULL COMMENT '名称',
  `type` bigint(20) DEFAULT NULL COMMENT '类型 2的n次方',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户分享类型，例如 纯文本分享1、图片分享2、视频分享4、二手信息8、公共活动16、个人活动32、公告64';



# Dump of table ui_share_urls
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ui_share_urls`;

CREATE TABLE `ui_share_urls` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `shareId` bigint(20) NOT NULL COMMENT '分享id',
  `urls` varchar(255) NOT NULL DEFAULT '' COMMENT '图片/视频url，多图片/视频使用逗号隔开',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ui_tag
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ui_tag`;

CREATE TABLE `ui_tag` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL COMMENT '标签名称',
  `counts` bigint(20) unsigned zerofill NOT NULL COMMENT '标签的分享数',
  `prop` int(11) DEFAULT NULL COMMENT '属性，是否为活动',
  `hot` tinyint(3) unsigned zerofill NOT NULL COMMENT '1 热门标签，后台系统配置',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标签表';

LOCK TABLES `ui_tag` WRITE;
/*!40000 ALTER TABLE `ui_tag` DISABLE KEYS */;

INSERT INTO `ui_tag` (`id`, `name`, `counts`, `prop`, `hot`)
VALUES
	(1,'二手',00000000000000000000,NULL,000);

/*!40000 ALTER TABLE `ui_tag` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
