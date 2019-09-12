/*
MySQL Data Transfer
Source Host: localhost
Source Database: manager
Target Host: localhost
Target Database: manager
Date: 2017/4/16 21:42:47
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for privilege
-- ----------------------------
DROP TABLE IF EXISTS `privilege`;
CREATE TABLE `privilege` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `createusername` varchar(255) DEFAULT NULL,
  `createuserid` int(11) DEFAULT NULL,
  `createusercompany` varchar(255) DEFAULT NULL,
  `createuserip` varchar(255) DEFAULT NULL,
  `createusermobile` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for privilege_h
-- ----------------------------
DROP TABLE IF EXISTS `privilege_h`;
CREATE TABLE `privilege_h` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `privilegeid` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `createusername` varchar(255) DEFAULT NULL,
  `createuserid` int(11) DEFAULT NULL,
  `createusercompany` varchar(255) DEFAULT NULL,
  `createuserip` varchar(255) DEFAULT NULL,
  `createusermobile` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `createusername` varchar(255) DEFAULT NULL,
  `createuserid` int(11) DEFAULT NULL,
  `createusercompany` varchar(255) DEFAULT NULL,
  `createuserip` varchar(255) DEFAULT NULL,
  `createusermobile` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for role_h
-- ----------------------------
DROP TABLE IF EXISTS `role_h`;
CREATE TABLE `role_h` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleid` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `createusername` varchar(255) DEFAULT NULL,
  `createuserid` int(11) DEFAULT NULL,
  `createusercompany` varchar(255) DEFAULT NULL,
  `createuserip` varchar(255) DEFAULT NULL,
  `createusermobile` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for roleprivilege
-- ----------------------------
DROP TABLE IF EXISTS `roleprivilege`;
CREATE TABLE `roleprivilege` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `privilegeid` int(11) DEFAULT NULL,
  `privilegename` varchar(255) DEFAULT NULL,
  `roleid` int(11) DEFAULT NULL,
  `rolename` varchar(255) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `createusername` varchar(255) DEFAULT NULL,
  `createuserid` int(11) DEFAULT NULL,
  `createusercompany` varchar(255) DEFAULT NULL,
  `createuserip` varchar(255) DEFAULT NULL,
  `createusermobile` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for roleprivilege_h
-- ----------------------------
DROP TABLE IF EXISTS `roleprivilege_h`;
CREATE TABLE `roleprivilege_h` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleprivilegeid` int(11) NOT NULL,
  `privilegeid` int(11) DEFAULT NULL,
  `privilegename` varchar(255) DEFAULT NULL,
  `roleid` int(11) DEFAULT NULL,
  `rolename` varchar(255) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `createusername` varchar(255) DEFAULT NULL,
  `createuserid` int(11) DEFAULT NULL,
  `createusercompany` varchar(255) DEFAULT NULL,
  `createuserip` varchar(255) DEFAULT NULL,
  `createusermobile` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loginname` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `borndate` datetime DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(11) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `tel` varchar(255) DEFAULT NULL,
  `qq` varchar(50) DEFAULT NULL,
  `division` varchar(255) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `createusername` varchar(255) DEFAULT NULL,
  `createuserid` int(11) DEFAULT NULL,
  `createusercompany` varchar(255) DEFAULT NULL,
  `createuserip` varchar(255) DEFAULT NULL,
  `createusermobile` varchar(255) DEFAULT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `imei` varchar(255) DEFAULT NULL,
  `x1` double DEFAULT NULL,
  `y1` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_h
-- ----------------------------
DROP TABLE IF EXISTS `user_h`;
CREATE TABLE `user_h` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `loginname` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `borndate` datetime DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(11) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `tel` varchar(255) DEFAULT NULL,
  `qq` varchar(50) DEFAULT NULL,
  `division` varchar(255) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `createusername` varchar(255) DEFAULT NULL,
  `createuserid` int(11) DEFAULT NULL,
  `createusercompany` varchar(255) DEFAULT NULL,
  `createuserip` varchar(255) DEFAULT NULL,
  `createusermobile` varchar(11) DEFAULT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `imei` varchar(255) DEFAULT NULL,
  `x1` double DEFAULT NULL,
  `y1` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1216 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for userprivilege
-- ----------------------------
DROP TABLE IF EXISTS `userprivilege`;
CREATE TABLE `userprivilege` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `privilegeid` int(11) DEFAULT NULL,
  `privilegename` varchar(255) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `createusername` varchar(255) DEFAULT NULL,
  `createuserid` int(11) DEFAULT NULL,
  `createusercompany` varchar(255) DEFAULT NULL,
  `createuserip` varchar(255) DEFAULT NULL,
  `createusermobile` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=129 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for userprivilege_h
-- ----------------------------
DROP TABLE IF EXISTS `userprivilege_h`;
CREATE TABLE `userprivilege_h` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userprivilegeid` int(11) NOT NULL,
  `userid` int(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `privilegeid` int(11) DEFAULT NULL,
  `privilegename` varchar(255) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `createusername` varchar(255) DEFAULT NULL,
  `createuserid` int(11) DEFAULT NULL,
  `createusercompany` varchar(255) DEFAULT NULL,
  `createuserip` varchar(255) DEFAULT NULL,
  `createusermobile` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for userrole
-- ----------------------------
DROP TABLE IF EXISTS `userrole`;
CREATE TABLE `userrole` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `roleid` int(11) DEFAULT NULL,
  `rolename` varchar(255) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `createusername` varchar(255) DEFAULT NULL,
  `createuserid` int(11) DEFAULT NULL,
  `createusercompany` varchar(255) DEFAULT NULL,
  `createuserip` varchar(255) DEFAULT NULL,
  `createusermobile` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for userrole_h
-- ----------------------------
DROP TABLE IF EXISTS `userrole_h`;
CREATE TABLE `userrole_h` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userroleid` int(11) NOT NULL,
  `userid` int(11) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `roleid` int(11) DEFAULT NULL,
  `rolename` varchar(255) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `createusername` varchar(255) DEFAULT NULL,
  `createuserid` int(11) DEFAULT NULL,
  `createusercompany` varchar(255) DEFAULT NULL,
  `createuserip` varchar(255) DEFAULT NULL,
  `createusermobile` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', '222222', '超级管理员', '', null, '', 'wubbzz@qq.com', '22322332', '', '', '1112223', '', '2016-11-17 21:03:07', '验证登录', '有效', '超级管理员', '17', '', '127.0.0.1', '22322332', null, null, null, null, null);