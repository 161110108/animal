/*
Navicat MySQL Data Transfer

Source Server         : phpStydy
Source Server Version : 50726
Source Host           : localhost:3306
Source Database       : animal

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2020-06-08 15:05:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for adopter
-- ----------------------------
DROP TABLE IF EXISTS `adopter`;
CREATE TABLE `adopter` (
  `animal_id` int(11) NOT NULL,
  `adopt` int(11) NOT NULL,
  `certain` tinyint(4) NOT NULL DEFAULT '0',
  `time` datetime NOT NULL,
  PRIMARY KEY (`animal_id`),
  CONSTRAINT `adopter_animal_id` FOREIGN KEY (`animal_id`) REFERENCES `animal` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of adopter
-- ----------------------------

-- ----------------------------
-- Table structure for animal
-- ----------------------------
DROP TABLE IF EXISTS `animal`;
CREATE TABLE `animal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rescuer` int(11) NOT NULL,
  `status` int(1) NOT NULL DEFAULT '0',
  `time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `rescuer` (`rescuer`),
  CONSTRAINT `rescuer` FOREIGN KEY (`rescuer`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of animal
-- ----------------------------
INSERT INTO `animal` VALUES ('1', '1', '-1', '2020-04-26 20:12:35');
INSERT INTO `animal` VALUES ('40', '28', '1', '2020-04-26 09:09:10');
INSERT INTO `animal` VALUES ('42', '28', '0', '2020-04-27 02:54:16');
INSERT INTO `animal` VALUES ('44', '28', '1', '2020-05-03 01:54:57');
INSERT INTO `animal` VALUES ('45', '28', '1', '2020-05-07 01:32:09');
INSERT INTO `animal` VALUES ('46', '28', '1', '2020-05-07 01:33:38');
INSERT INTO `animal` VALUES ('47', '28', '1', '2020-05-07 01:34:58');
INSERT INTO `animal` VALUES ('52', '28', '1', '2020-05-08 08:46:33');
INSERT INTO `animal` VALUES ('53', '28', '1', '2020-05-08 09:02:43');
INSERT INTO `animal` VALUES ('54', '28', '1', '2020-05-08 09:04:12');
INSERT INTO `animal` VALUES ('55', '28', '1', '2020-05-08 09:05:34');
INSERT INTO `animal` VALUES ('56', '28', '1', '2020-05-08 09:06:42');
INSERT INTO `animal` VALUES ('57', '28', '1', '2020-05-08 09:07:44');
INSERT INTO `animal` VALUES ('58', '29', '0', '2020-05-24 03:15:55');
INSERT INTO `animal` VALUES ('59', '28', '1', '2020-05-27 08:01:14');
INSERT INTO `animal` VALUES ('60', '28', '1', '2020-05-28 10:00:28');
INSERT INTO `animal` VALUES ('61', '27', '1', '2020-05-28 10:08:52');
INSERT INTO `animal` VALUES ('62', '30', '1', '2020-05-29 12:22:53');
INSERT INTO `animal` VALUES ('63', '30', '0', '2020-05-29 07:51:29');
INSERT INTO `animal` VALUES ('64', '30', '0', '2020-05-29 08:01:54');
INSERT INTO `animal` VALUES ('65', '30', '0', '2020-05-29 09:23:03');

-- ----------------------------
-- Table structure for animal_img
-- ----------------------------
DROP TABLE IF EXISTS `animal_img`;
CREATE TABLE `animal_img` (
  `animal_id` int(11) NOT NULL,
  `img1` varchar(255) DEFAULT NULL,
  `img2` varchar(255) DEFAULT NULL,
  `img3` varchar(255) DEFAULT NULL,
  `img4` varchar(255) DEFAULT NULL,
  `img5` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`animal_id`),
  CONSTRAINT `id` FOREIGN KEY (`animal_id`) REFERENCES `animal` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of animal_img
-- ----------------------------
INSERT INTO `animal_img` VALUES ('1', null, null, null, null, null);
INSERT INTO `animal_img` VALUES ('40', '/static/images/animal/20200426/3f8980ac02fdd600d48f31e8efb2c5be.jpg', '/static/images/animal/20200426/3bb1b3f8364957a5f9ee6e864e1aa2a4.png', null, null, null);
INSERT INTO `animal_img` VALUES ('42', '/static/images/animal/20200427/dd4426f654512b2b74530bd1dba0155c.png', null, null, null, null);
INSERT INTO `animal_img` VALUES ('44', '/static/images/animal/20200503/379d09177b7358d7c1c35a5e3ef923a3.ico', null, null, null, null);
INSERT INTO `animal_img` VALUES ('45', '/static/images/animal/20200507/7f75b7450ee8d358b714ca509d413be8.jpg', '/static/images/animal/20200507/e3e093afd78c5b8ff27343c5d13e958f.jpg', '/static/images/animal/20200507/aa695e2e401f147b31ae0b975256ea8f.jpg', null, null);
INSERT INTO `animal_img` VALUES ('46', '/static/images/animal/20200507/262c021edcdeac7bc973da006cdf8a22.jpg', null, null, null, null);
INSERT INTO `animal_img` VALUES ('47', '/static/images/animal/20200507/09c11d772468ebd058ee98c2cf6d2392.png', null, null, null, null);
INSERT INTO `animal_img` VALUES ('52', '/static/images/animal/20200508/f99e321c587ed2fee00828f764f9d026.jpg', '/static/images/animal/20200508/822043c28988a96339bee9a247a980c7.jpg', '/static/images/animal/20200508/5c2290b2da92a56dd0e53cc561819eb5.jpg', null, null);
INSERT INTO `animal_img` VALUES ('53', '/static/images/animal/20200508/c085c8ca874886ac983ec829b5caa766.jpg', null, null, null, null);
INSERT INTO `animal_img` VALUES ('54', '/static/images/animal/20200508/2b225242f19938c4d8f7ae72cee41ada.jpg', null, null, null, null);
INSERT INTO `animal_img` VALUES ('55', '/static/images/animal/20200508/c205b7f348284cc7a1357adc88bff1bb.jpg', null, null, null, null);
INSERT INTO `animal_img` VALUES ('56', '/static/images/animal/20200508/a58fbbb355ffc18b22570986ac2f9452.jpg', null, null, null, null);
INSERT INTO `animal_img` VALUES ('57', '/static/images/animal/20200508/fce97c5446d69a2d954cfc8a2d162327.jpg', null, null, null, null);
INSERT INTO `animal_img` VALUES ('58', '/static/images/animal/20200524/122d4735b154ba6b9fa214a63a8b0095.jpg', null, null, null, null);
INSERT INTO `animal_img` VALUES ('59', '/static/images/animal/20200527/67a3f4ce48fce0bc70d9e682194b157f.jpg', '/static/images/animal/20200527/383076574229d35ecb494792b305222c.jpg', null, null, null);
INSERT INTO `animal_img` VALUES ('60', null, null, null, null, null);
INSERT INTO `animal_img` VALUES ('61', '/static/images/animal/20200528/5890ed2637ad8365841fc0976c0a12d1.jpg', '/static/images/animal/20200528/44d8131ef2d6f58a27e193906b14eb48.jpg', null, null, null);
INSERT INTO `animal_img` VALUES ('62', '/static/images/animal/20200529/d76d87c2c53c4c024dfc80dd69dda3b3.jpg', '/static/images/animal/20200529/46bad8fc6ec82daae227cb32c4dbf3e3.jpg', null, null, null);
INSERT INTO `animal_img` VALUES ('63', '/static/images/animal/20200529/2977964be7fbaa74e46ed2ec667d0f93.jpg', '/static/images/animal/20200529/9a34c7675b8a9cf2bd4b7166a85d3a4d.jpg', null, null, null);
INSERT INTO `animal_img` VALUES ('64', '/static/images/animal/20200529/25aea652ea5581c2ba47142121a2c6dc.jpg', '/static/images/animal/20200529/86336239ee86189c366aaffccc9f950c.jpg', '/static/images/animal/20200529/df0e4c70b9d9aa4f0fa5e9196d421dec.jpg', null, null);
INSERT INTO `animal_img` VALUES ('65', '/static/images/animal/20200529/6bff66dcfb0df8449c57abec1bf10310.jpg', null, null, null, null);

-- ----------------------------
-- Table structure for animal_info
-- ----------------------------
DROP TABLE IF EXISTS `animal_info`;
CREATE TABLE `animal_info` (
  `animal_id` int(11) NOT NULL,
  `type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tag` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `msg` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `adress` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`animal_id`),
  CONSTRAINT `animal_id` FOREIGN KEY (`animal_id`) REFERENCES `animal` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of animal_info
-- ----------------------------
INSERT INTO `animal_info` VALUES ('1', null, null, null, null, null);
INSERT INTO `animal_info` VALUES ('40', 'cat', '黑猫;', '今日份猫咪找领养，都是领养要求比较低的，私聊', 'test', '广东汕头');
INSERT INTO `animal_info` VALUES ('42', 'cat', '黑猫;亲人;无尾;', '两只蓝白找领养', 'test2', '梅州');
INSERT INTO `animal_info` VALUES ('44', 'cat', '流浪猫;无尾;怕生;', '会踩奶的白猫找领养', '干扰1', '广州');
INSERT INTO `animal_info` VALUES ('45', 'cat', '橘猫;小猫;亲人;', '三只橘白找暂养或者是收养', '我是测试1', '广东汕头');
INSERT INTO `animal_info` VALUES ('46', 'cat', '渐层;布偶;亲人;', '新收一只超级可爱的小宝贝，领养要求低，快来私聊吧', '测试2', '广东汕头');
INSERT INTO `animal_info` VALUES ('47', 'cat', '流浪猫;布偶;', '成年人要学会自己消化情绪，今日新收一只猫，有意愿领养的私聊', '测试3', '广东汕头');
INSERT INTO `animal_info` VALUES ('52', 'cat', '亲人;布偶;橘猫;', '新来一只小可爱，应该是被流浪的猫妈妈淘汰的，眼睛都糊住了', '推荐case1', '广东汕头');
INSERT INTO `animal_info` VALUES ('53', 'cat', '橘猫;小猫;', '橘猫找领养', '推荐case2', '广东汕头');
INSERT INTO `animal_info` VALUES ('54', 'cat', '橘猫;流浪猫;大猫;', '已驱虫找领养', '推荐case3', '广东汕头');
INSERT INTO `animal_info` VALUES ('55', 'cat', '渐层;怕生;布偶;', '狗子找领养，暂时收留也可以', '推荐case4', '广东汕头');
INSERT INTO `animal_info` VALUES ('56', 'cat', '小短腿;布偶;', '猫咪找领养，已经绝育', '推荐case5', '广东汕头');
INSERT INTO `animal_info` VALUES ('57', 'cat', '流浪猫;布偶;', '跨年夜的小可怜，希望有个好主人接收', '推荐case5', '广东汕头');
INSERT INTO `animal_info` VALUES ('58', 'cat', '', '已经绝育，找领养', 'test', '广州');
INSERT INTO `animal_info` VALUES ('59', 'cat', '流浪猫;橘猫;', '领养预定', '聊天案例', '广东汕头');
INSERT INTO `animal_info` VALUES ('60', 'cat', '已绝育;橘猫;', '。。。。', '流浪猫救助', '广东汕头');
INSERT INTO `animal_info` VALUES ('61', 'cat', '橘猫;已绝育;', '写一些简单的介绍之类的', '流浪猫领养', '广东汕头');
INSERT INTO `animal_info` VALUES ('62', 'cat', '橘猫;测试;', '详情', '流浪猫找领养', '广东汕头');
INSERT INTO `animal_info` VALUES ('63', 'cat', '橘猫;测试;', '并没有做', '简单的', '广东汕头');
INSERT INTO `animal_info` VALUES ('64', 'cat', '橘猫;测试;', 'cest', 'test', '广东汕头');
INSERT INTO `animal_info` VALUES ('65', 'cat', '橘猫;测试;', '123', 'test', '广东汕头');

-- ----------------------------
-- Table structure for apply
-- ----------------------------
DROP TABLE IF EXISTS `apply`;
CREATE TABLE `apply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `applyer` int(11) NOT NULL,
  `animal_id` int(11) NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `apply_user_id` (`applyer`),
  CONSTRAINT `apply_user_id` FOREIGN KEY (`applyer`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of apply
-- ----------------------------
INSERT INTO `apply` VALUES ('1', '27', '40', '2020-05-03 15:11:36');
INSERT INTO `apply` VALUES ('2', '1', '40', '2020-05-03 02:00:22');
INSERT INTO `apply` VALUES ('13', '27', '42', '2020-05-04 03:52:32');
INSERT INTO `apply` VALUES ('14', '29', '40', '2020-05-04 15:54:33');
INSERT INTO `apply` VALUES ('15', '30', '42', '2020-05-05 12:23:19');
INSERT INTO `apply` VALUES ('16', '29', '44', '2020-05-06 04:01:28');
INSERT INTO `apply` VALUES ('17', '29', '59', '2020-05-27 08:02:05');
INSERT INTO `apply` VALUES ('19', '27', '59', '2020-05-28 10:01:31');
INSERT INTO `apply` VALUES ('20', '27', '52', '2020-05-28 10:46:49');
INSERT INTO `apply` VALUES ('21', '30', '52', '2020-05-28 11:03:08');
INSERT INTO `apply` VALUES ('22', '30', '40', '2020-05-29 12:21:33');
INSERT INTO `apply` VALUES ('25', '30', '59', '2020-05-29 09:21:58');

-- ----------------------------
-- Table structure for apply_messages
-- ----------------------------
DROP TABLE IF EXISTS `apply_messages`;
CREATE TABLE `apply_messages` (
  `mes_id` int(11) NOT NULL AUTO_INCREMENT,
  `apply_id` int(11) NOT NULL,
  `msg` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `time` datetime NOT NULL,
  `send` int(11) NOT NULL,
  `access` int(11) NOT NULL,
  `animal_id` int(11) NOT NULL,
  PRIMARY KEY (`mes_id`),
  KEY `send` (`send`),
  KEY `access` (`access`),
  KEY `apply_id` (`apply_id`),
  CONSTRAINT `apply_id` FOREIGN KEY (`apply_id`) REFERENCES `apply` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of apply_messages
-- ----------------------------
INSERT INTO `apply_messages` VALUES ('49', '16', '11', '1', '2020-05-06 05:05:20', '29', '28', '44');
INSERT INTO `apply_messages` VALUES ('50', '13', '11', '1', '2020-05-06 05:06:12', '28', '27', '42');
INSERT INTO `apply_messages` VALUES ('51', '1', '12', '1', '2020-05-07 08:14:25', '27', '28', '40');
INSERT INTO `apply_messages` VALUES ('52', '13', '12', '1', '2020-05-07 08:14:36', '27', '28', '42');
INSERT INTO `apply_messages` VALUES ('53', '13', '12', '1', '2020-05-07 08:14:37', '27', '28', '42');
INSERT INTO `apply_messages` VALUES ('54', '1', '你好', '1', '2020-05-24 03:33:09', '28', '27', '40');
INSERT INTO `apply_messages` VALUES ('55', '1', '你好呀', '1', '2020-05-24 03:33:34', '27', '28', '40');
INSERT INTO `apply_messages` VALUES ('56', '13', '123', '1', '2020-05-27 07:54:09', '28', '27', '42');
INSERT INTO `apply_messages` VALUES ('57', '17', 'good', '1', '2020-05-27 08:02:16', '29', '28', '59');
INSERT INTO `apply_messages` VALUES ('58', '13', '123', '1', '2020-05-27 10:18:52', '28', '27', '42');
INSERT INTO `apply_messages` VALUES ('59', '13', 'nihao ', '1', '2020-05-27 10:20:17', '27', '28', '42');
INSERT INTO `apply_messages` VALUES ('61', '19', '你好', '1', '2020-05-28 10:02:31', '27', '28', '59');
INSERT INTO `apply_messages` VALUES ('62', '19', '我好', '1', '2020-05-28 10:02:47', '28', '27', '59');
INSERT INTO `apply_messages` VALUES ('63', '19', '这是一次聊天测试', '1', '2020-05-28 10:11:53', '27', '28', '59');
INSERT INTO `apply_messages` VALUES ('64', '19', '嗯', '1', '2020-05-28 10:12:14', '28', '27', '59');
INSERT INTO `apply_messages` VALUES ('65', '20', '哈喽', '0', '2020-05-28 10:47:06', '27', '28', '52');
INSERT INTO `apply_messages` VALUES ('66', '19', '这是演示', '1', '2020-05-28 10:48:43', '27', '28', '59');
INSERT INTO `apply_messages` VALUES ('67', '19', '进行领养', '0', '2020-05-28 10:49:32', '28', '27', '59');
INSERT INTO `apply_messages` VALUES ('68', '21', '哈喽', '0', '2020-05-28 11:03:23', '30', '28', '52');
INSERT INTO `apply_messages` VALUES ('69', '22', '你好', '0', '2020-05-29 12:21:50', '30', '28', '40');
INSERT INTO `apply_messages` VALUES ('72', '25', '你好', '1', '2020-05-29 09:22:09', '30', '28', '59');
INSERT INTO `apply_messages` VALUES ('73', '25', '123', '1', '2020-05-29 10:00:31', '30', '28', '59');
INSERT INTO `apply_messages` VALUES ('74', '25', '你好', '0', '2020-05-29 10:01:02', '28', '30', '59');

-- ----------------------------
-- Table structure for history
-- ----------------------------
DROP TABLE IF EXISTS `history`;
CREATE TABLE `history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `animal_id` int(11) NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `history_user_id` (`user_id`),
  KEY `history_animal_id` (`animal_id`),
  CONSTRAINT `history_animal_id` FOREIGN KEY (`animal_id`) REFERENCES `animal` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `history_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of history
-- ----------------------------
INSERT INTO `history` VALUES ('1', '27', '45', '2020-05-07 21:31:12');
INSERT INTO `history` VALUES ('2', '27', '46', '2020-05-07 21:32:29');
INSERT INTO `history` VALUES ('3', '27', '47', '2020-05-07 23:36:46');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` char(13) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `time` datetime NOT NULL,
  `power` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '1234', '123', '2020-04-16 18:26:39', '1');
INSERT INTO `user` VALUES ('27', '13670411523', 'a123456', '2020-04-15 09:18:56', '1');
INSERT INTO `user` VALUES ('28', '17875305705', 'a123456', '2020-04-15 10:13:59', '4');
INSERT INTO `user` VALUES ('29', '17875305704', 'a123456', '2020-04-17 04:07:12', '1');
INSERT INTO `user` VALUES ('30', '13622583302', 'a123456', '2020-05-05 12:23:04', '1');

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `user_id` int(11) NOT NULL,
  `adress` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `wechat` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qq` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `img` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `msg` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `show` varchar(3) COLLATE utf8_unicode_ci DEFAULT '0',
  `age` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES ('1', null, null, '', '/static/images/head-image.png', '游客', null, '0', null);
INSERT INTO `user_info` VALUES ('27', '广东', '', '568942470', '/static/images/user/20200528/b7cc734aa76748c1331f17a25bbaba76.jpg', '推荐用户', '', '000', '13');
INSERT INTO `user_info` VALUES ('28', '2', '', '568942470', '/static/images/user/20200428/bc6ff7eeed41b556778de28c970c405d.jpg', 'lye', '', '101', '13');
INSERT INTO `user_info` VALUES ('29', '梅州市', '', '568942470', '/static/images/user/20200528/96338cc4d24dd855f83c118d9e168e13.jpg', '丹凤', '', '100', '14');
INSERT INTO `user_info` VALUES ('30', '汕头市', '', '568942470', '/static/images/user/20200529/f868ef04fdd2f5db53577c1b750a1605.jpg', '镁德', '', '000', '12');
