/*
 Navicat Premium Data Transfer

 Source Server         : ESXI TEST
 Source Server Type    : MySQL
 Source Server Version : 50743 (5.7.43-log)
 Source Host           : 192.168.100.15:3306
 Source Schema         : test123

 Target Server Type    : MySQL
 Target Server Version : 50743 (5.7.43-log)
 File Encoding         : 65001

 Date: 11/05/2026 18:14:22
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account_log
-- ----------------------------
DROP TABLE IF EXISTS `account_log`;
CREATE TABLE `account_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `value` decimal(20, 8) NOT NULL DEFAULT 0.00000000,
  `created_time` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `info` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `type` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `currency` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `is_lock` tinyint(4) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `account_log_user_id_index`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3604 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `currency` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `notes` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'haha123' COMMENT '提币地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `password` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `role_id` tinyint(4) NOT NULL DEFAULT 0,
  `token` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `google` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '谷歌验证码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for admin_module
-- ----------------------------
DROP TABLE IF EXISTS `admin_module`;
CREATE TABLE `admin_module`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `module` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `status` int(1) NULL DEFAULT 0 COMMENT '1 开启  0 关闭',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for admin_module_action
-- ----------------------------
DROP TABLE IF EXISTS `admin_module_action`;
CREATE TABLE `admin_module_action`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `admin_module_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `action` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `level` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 142 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for admin_role
-- ----------------------------
DROP TABLE IF EXISTS `admin_role`;
CREATE TABLE `admin_role`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_super` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for admin_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_permission`;
CREATE TABLE `admin_role_permission`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL DEFAULT 0,
  `module` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `action` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `level` int(1) NULL DEFAULT 0,
  `admin_module_id` int(11) NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2545 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for agent
-- ----------------------------
DROP TABLE IF EXISTS `agent`;
CREATE TABLE `agent`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) UNSIGNED NOT NULL COMMENT '用户id',
  `username` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '登录代理商后台的帐号',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '登录代理商后台的密码',
  `parent_agent_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父级代理商ID，0表示该用户是一级代理商',
  `level` tinyint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '代理商等级,0:超级管理员； 1：一级代理商；2:二级代理商；3:三级代理商；4:四级代理商',
  `agent_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '代理商关系，用,拼接成字符串',
  `is_admin` tinyint(3) NOT NULL DEFAULT 0 COMMENT '是否为超级管理员',
  `is_lock` tinyint(3) NOT NULL DEFAULT 0 COMMENT '该代理商是否锁定',
  `is_addson` tinyint(3) NOT NULL DEFAULT 1 COMMENT '是否拥有开设下级代理商的权限',
  `pro_loss` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '头寸比例',
  `pro_ser` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '手续费比例',
  `status` tinyint(3) NOT NULL DEFAULT 1 COMMENT '1正常用户',
  `reg_time` int(11) NOT NULL DEFAULT 0 COMMENT '代理商注册时间',
  `lock_time` int(11) NOT NULL DEFAULT 0 COMMENT '代理商锁定时间',
  `money` decimal(20, 8) NULL DEFAULT 0.00000000 COMMENT '代理商帐户',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for agent_admin
-- ----------------------------
DROP TABLE IF EXISTS `agent_admin`;
CREATE TABLE `agent_admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agent_id` int(11) NOT NULL,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `role_id` tinyint(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '代理商后台管理员' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for agent_log
-- ----------------------------
DROP TABLE IF EXISTS `agent_log`;
CREATE TABLE `agent_log`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `agent_id` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '代理商ID',
  `type` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '类型',
  `value` decimal(15, 2) NULL DEFAULT 0.00 COMMENT '操作值',
  `info` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作详情',
  `relate_id` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '关联id',
  `add_time` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '日志添加时间',
  `status` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `agent_id`(`agent_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for agent_money_log
-- ----------------------------
DROP TABLE IF EXISTS `agent_money_log`;
CREATE TABLE `agent_money_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agent_id` int(11) NOT NULL DEFAULT 0 COMMENT '所属代理商',
  `type` tinyint(4) NOT NULL DEFAULT 1 COMMENT '类型。1.代理商头寸，2代理商手续费',
  `relate_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '关联id。比如订单id等',
  `before` decimal(20, 8) NOT NULL DEFAULT 0.00000000 COMMENT '原余额',
  `change` decimal(20, 8) NOT NULL DEFAULT 0.00000000 COMMENT '本次变动',
  `after` decimal(20, 8) NOT NULL DEFAULT 0.00000000 COMMENT '现余额',
  `memo` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `created_time` int(11) NOT NULL COMMENT '变动时间',
  `son_user_id` int(11) NOT NULL DEFAULT 0 COMMENT '贡献收益的用户id',
  `status` tinyint(4) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否体现',
  `legal_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '法币id',
  `updated_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '提现到账时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for agent_role
-- ----------------------------
DROP TABLE IF EXISTS `agent_role`;
CREATE TABLE `agent_role`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `agent_id` int(10) NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_super` tinyint(3) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '代理商角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for agent_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `agent_role_permission`;
CREATE TABLE `agent_role_permission`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `agent_id` int(10) NOT NULL,
  `role_id` int(11) NOT NULL DEFAULT 0,
  `module` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `action` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for algebra
-- ----------------------------
DROP TABLE IF EXISTS `algebra`;
CREATE TABLE `algebra`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `algebra` int(25) NOT NULL DEFAULT 0 COMMENT '代数',
  `rate` decimal(25, 4) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `algebra`(`algebra`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for area_code
-- ----------------------------
DROP TABLE IF EXISTS `area_code`;
CREATE TABLE `area_code`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `area_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '国家区号' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auto_list
-- ----------------------------
DROP TABLE IF EXISTS `auto_list`;
CREATE TABLE `auto_list`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `buy_user_id` int(11) NOT NULL DEFAULT 0 COMMENT '买方user_id',
  `sell_user_id` int(11) NOT NULL DEFAULT 0 COMMENT '卖方user_id',
  `currency_id` int(11) NOT NULL DEFAULT 0 COMMENT '币种id',
  `legal_id` int(11) NOT NULL DEFAULT 0 COMMENT '法币id',
  `min_price` decimal(20, 5) NOT NULL DEFAULT 0.00000 COMMENT '最低',
  `max_price` decimal(20, 5) NOT NULL DEFAULT 0.00000 COMMENT '最高',
  `min_number` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `max_number` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `need_second` int(11) NOT NULL DEFAULT 0,
  `create_time` int(11) NOT NULL DEFAULT 0,
  `is_start` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bank
-- ----------------------------
DROP TABLE IF EXISTS `bank`;
CREATE TABLE `bank`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bind_box
-- ----------------------------
DROP TABLE IF EXISTS `bind_box`;
CREATE TABLE `bind_box`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '哈希值',
  `type` tinyint(1) NOT NULL COMMENT '1:图片 2：动图3：音频4：视频',
  `currency_id` int(11) NOT NULL COMMENT '购买所需货币种类',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `price` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '价格',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '封面图',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '资产描述',
  `author_description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关于艺术家',
  `author` int(11) NOT NULL COMMENT '作者，不可修改',
  `owner` int(11) NOT NULL COMMENT '拥有者，可能会变动',
  `status` int(4) NULL DEFAULT 1 COMMENT '状态:1=开始,0=已结束,2=未开始',
  `start_time` datetime NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '失效日期',
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `pay_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT 'nft的售卖类型,1：一口价，2：竞拍，3：盲盒',
  `per_increase` double NULL DEFAULT NULL COMMENT '竞拍每次的加价',
  `chain` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所在链。eth trx ',
  `rarity` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '稀有度，N，R，SR',
  `margin` int(11) NOT NULL COMMENT '保证金',
  `rarity_house_id` int(11) NOT NULL COMMENT '盲盒实际的物品ID',
  `rarity_status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '1：已经打开盲盒，0未开启盲盒',
  `resell_nft_status` int(5) NOT NULL DEFAULT 0 COMMENT '竞拍状态，1：竞拍中 0：已结束',
  `lock_order` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '拍卖商品，等待支付，未超时  lock=1',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1034 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bind_box_collect
-- ----------------------------
DROP TABLE IF EXISTS `bind_box_collect`;
CREATE TABLE `bind_box_collect`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bind_box_margin_log
-- ----------------------------
DROP TABLE IF EXISTS `bind_box_margin_log`;
CREATE TABLE `bind_box_margin_log`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户',
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'NFT地址',
  `number` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '金额',
  `currency_id` int(11) NOT NULL COMMENT '币种',
  `status` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '1:保证金已交，0保证金已退',
  `is_expired` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '1：已过期，0未过期',
  `created` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bind_box_order
-- ----------------------------
DROP TABLE IF EXISTS `bind_box_order`;
CREATE TABLE `bind_box_order`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '哈希',
  `buyer_id` int(11) NOT NULL COMMENT '买入者',
  `sell_id` int(11) NOT NULL COMMENT '卖出者',
  `author_id` int(11) NOT NULL COMMENT '创作者',
  `status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单是否有效',
  `order_price` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '成交价',
  `currency_id` int(11) NOT NULL,
  `updated` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '修改时间',
  `created` datetime NOT NULL COMMENT '成交时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bind_box_quotation_log
-- ----------------------------
DROP TABLE IF EXISTS `bind_box_quotation_log`;
CREATE TABLE `bind_box_quotation_log`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `margin_log_id` int(11) NOT NULL COMMENT '保证金记录',
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '哈希',
  `buyer_id` int(11) NOT NULL COMMENT '出价者ID',
  `status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态',
  `price` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '出价价格',
  `currency_id` int(11) NOT NULL,
  `is_expired` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '数据是否过期,0未过期，1已过期',
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 90 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bind_box_raity_house
-- ----------------------------
DROP TABLE IF EXISTS `bind_box_raity_house`;
CREATE TABLE `bind_box_raity_house`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `rarity` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '稀有度N R SR',
  `file` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件地址',
  `status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '1:已被使用',
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bind_box_success_order
-- ----------------------------
DROP TABLE IF EXISTS `bind_box_success_order`;
CREATE TABLE `bind_box_success_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `quotrtion_log_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `currency_id` int(11) NOT NULL COMMENT '货币',
  `is_read` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '1:已读，0未读',
  `is_pay` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '是否支付1:已支付',
  `is_expired` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '1：失效 ，0有效',
  `overtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '过期时间',
  `created` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pay_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '支付时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for boss_account
-- ----------------------------
DROP TABLE IF EXISTS `boss_account`;
CREATE TABLE `boss_account`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `p_uid` int(11) NULL DEFAULT NULL COMMENT '父亲id',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态，1已申请 2:已激活',
  `invite_code` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邀请码',
  `total_invited` mediumint(9) NULL DEFAULT 0 COMMENT '邀请成为boss用户数',
  `total_active` mediumint(9) NULL DEFAULT 0 COMMENT '下线激活总人数',
  `total_profit` decimal(25, 8) NULL DEFAULT 0.00000000 COMMENT '总收益',
  `balance` decimal(25, 8) NULL DEFAULT 0.00000000 COMMENT '账户余额',
  `parent_id_array` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'json 祖宗uid数组 从父亲开始',
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for boss_account_log
-- ----------------------------
DROP TABLE IF EXISTS `boss_account_log`;
CREATE TABLE `boss_account_log`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `boss_account_id` int(11) NULL DEFAULT NULL,
  `key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `amount` decimal(25, 8) NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `created_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniqueLog`(`key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for boss_account_relation
-- ----------------------------
DROP TABLE IF EXISTS `boss_account_relation`;
CREATE TABLE `boss_account_relation`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(11) UNSIGNED NULL DEFAULT NULL,
  `relatived_uid` int(11) UNSIGNED NULL DEFAULT NULL,
  `type` tinyint(1) UNSIGNED NULL DEFAULT NULL COMMENT '1:parent 2:child',
  `generation` tinyint(2) UNSIGNED NULL DEFAULT NULL COMMENT '第几代关系，父子为第一代',
  `created_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uidIndex`(`uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for boss_account_return_fail
-- ----------------------------
DROP TABLE IF EXISTS `boss_account_return_fail`;
CREATE TABLE `boss_account_return_fail`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NULL DEFAULT NULL,
  `fail_type` tinyint(1) NULL DEFAULT NULL COMMENT '1:未激活，2:拉不够人',
  `relative_account_id` int(11) NULL DEFAULT NULL,
  `generation` tinyint(4) NULL DEFAULT NULL COMMENT '冗余字段，方便处理',
  `amount` decimal(25, 8) NULL DEFAULT NULL COMMENT '反佣数',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '1:未处理，2:已处理',
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for c2c_deal
-- ----------------------------
DROP TABLE IF EXISTS `c2c_deal`;
CREATE TABLE `c2c_deal`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `legal_deal_send_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `seller_id` int(11) NOT NULL DEFAULT 0 COMMENT '发布方用户id',
  `number` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `is_sure` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0 未完成 1 已完成  2取消  3已付款',
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `legal_deal_legal_deal_send_id_seller_id_index`(`legal_deal_send_id`, `seller_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for c2c_deal_send
-- ----------------------------
DROP TABLE IF EXISTS `c2c_deal_send`;
CREATE TABLE `c2c_deal_send`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `seller_id` int(11) NOT NULL DEFAULT 0 COMMENT '发布方用户id',
  `currency_id` int(11) NOT NULL DEFAULT 0,
  `type` enum('buy','sell') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'sell',
  `way` enum('bank','we_chat','ali_pay') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'bank',
  `price` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `total_number` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `surplus_number` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `min_number` decimal(20, 5) NOT NULL DEFAULT 0.00000 COMMENT '最小购买量',
  `is_done` tinyint(4) NOT NULL DEFAULT 0 COMMENT ' 0 未完成  1完成    2 24小时未交易取消',
  `create_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `legal_deal_send_seller_id_index`(`seller_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for candy_transfer
-- ----------------------------
DROP TABLE IF EXISTS `candy_transfer`;
CREATE TABLE `candy_transfer`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `from_user_id` int(10) UNSIGNED NOT NULL COMMENT '转出用户id',
  `to_user_id` int(10) UNSIGNED NOT NULL COMMENT '转入用户id',
  `transfer_qty` decimal(20, 6) UNSIGNED NOT NULL COMMENT '转账数量',
  `transfer_rate` decimal(20, 2) UNSIGNED NOT NULL COMMENT '手续费率(百分比)',
  `transfer_fee` decimal(20, 6) UNSIGNED NOT NULL COMMENT '手续费',
  `create_time` int(10) UNSIGNED NOT NULL COMMENT '转账时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `from_user_id`(`from_user_id`) USING BTREE,
  INDEX `to_user_id`(`to_user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '糖果转账' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for chain_hashes
-- ----------------------------
DROP TABLE IF EXISTS `chain_hashes`;
CREATE TABLE `chain_hashes`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '币种代码',
  `txid` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '链上交易hash',
  `amount` decimal(20, 8) NOT NULL DEFAULT 0.00000000 COMMENT '转账金额',
  `sender` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '转出地址',
  `recipient` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '转入地址',
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for charge_req
-- ----------------------------
DROP TABLE IF EXISTS `charge_req`;
CREATE TABLE `charge_req`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `amount` decimal(15, 8) NOT NULL,
  `user_account` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` tinyint(4) NOT NULL,
  `currency_id` int(11) NOT NULL,
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `type` int(2) NOT NULL,
  `give` decimal(15, 8) NULL DEFAULT 0.00000000,
  `give_rate` decimal(11, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 171 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for chat_log
-- ----------------------------
DROP TABLE IF EXISTS `chat_log`;
CREATE TABLE `chat_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` tinyint(3) NOT NULL DEFAULT 1 COMMENT '1,文字 2,图片 3,视频,4,日期',
  `content` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `from_user` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '发送人',
  `to_user` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '接收人',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '发送时间',
  `updated_at` timestamp NULL DEFAULT NULL,
  `trade_type` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '交易类型0.c2c',
  `trade_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '交易的id',
  `readed` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否已读0,未读。1，已读',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for coin_trade
-- ----------------------------
DROP TABLE IF EXISTS `coin_trade`;
CREATE TABLE `coin_trade`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `u_id` int(11) UNSIGNED NULL DEFAULT NULL,
  `currency_id` int(11) NULL DEFAULT NULL,
  `legal_id` int(11) NULL DEFAULT NULL,
  `type` tinyint(4) UNSIGNED NULL DEFAULT NULL COMMENT '1:buy 2:sell',
  `target_price` decimal(20, 8) NULL DEFAULT NULL COMMENT '目标价格',
  `trade_price` decimal(20, 8) NULL DEFAULT NULL COMMENT '交易当前价格',
  `trade_amount` decimal(20, 8) NULL DEFAULT NULL COMMENT '币数量',
  `charge_fee` decimal(10, 6) NULL DEFAULT NULL COMMENT '手续费',
  `status` tinyint(4) UNSIGNED NULL DEFAULT 1 COMMENT '状态 1 交易中 2 已完成',
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 153 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for conversion
-- ----------------------------
DROP TABLE IF EXISTS `conversion`;
CREATE TABLE `conversion`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `form_currency_id` int(11) NOT NULL,
  `to_currency_id` int(11) NOT NULL,
  `num` decimal(20, 4) NOT NULL,
  `fee` decimal(20, 4) NOT NULL,
  `sj_num` decimal(20, 4) NOT NULL,
  `create_time` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for currency
-- ----------------------------
DROP TABLE IF EXISTS `currency`;
CREATE TABLE `currency`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `get_address` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `sort` int(11) NOT NULL DEFAULT 0,
  `logo` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '',
  `is_display` tinyint(4) NOT NULL DEFAULT 0,
  `min_number` decimal(23, 8) NOT NULL DEFAULT 0.00000000 COMMENT '最小提币数量',
  `max_number` decimal(20, 8) NOT NULL DEFAULT 0.00000000 COMMENT '最大提币数量',
  `rate` decimal(20, 4) NOT NULL DEFAULT 0.0000 COMMENT '费率',
  `is_lever` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否杠杆币 0否 1是',
  `is_legal` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否法币 0否 1是',
  `is_match` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否撮合交易 0否 1是',
  `is_micro` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否微交易 0.否1是',
  `is_transfer` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '币币转换',
  `insurancable` tinyint(4) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否可买保险',
  `show_legal` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否显示法币商家 0否 1是',
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '基于哪个区块链',
  `black_limt` int(11) NOT NULL DEFAULT 0 COMMENT '币种黑名单限制数量',
  `key` varchar(1024) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `contract_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `total_account` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `collect_account` varchar(300) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '0' COMMENT '归拢地址',
  `currency_decimals` int(11) NULL DEFAULT NULL,
  `rmb_relation` decimal(23, 2) NOT NULL DEFAULT 0.00 COMMENT '折合人民币比例',
  `decimal_scale` int(11) NOT NULL DEFAULT 18 COMMENT '发布小数点',
  `chain_fee` decimal(20, 8) NOT NULL DEFAULT 0.00000000,
  `price` decimal(20, 8) NOT NULL DEFAULT 0.00000000 COMMENT '价值(美元)',
  `micro_trade_fee` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '微交易手续费%',
  `micro_min` decimal(20, 0) NULL DEFAULT 0 COMMENT '最小下单数量',
  `micro_max` decimal(20, 0) NULL DEFAULT 0 COMMENT '最大下单数量',
  `micro_holdtrade_max` int(11) NOT NULL DEFAULT 0 COMMENT '最大持仓笔数',
  `create_time` int(11) NOT NULL DEFAULT 0,
  `issue_num` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `sell_status` tinyint(1) NOT NULL DEFAULT 1,
  `address_erc` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `address_omni` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for currency_deposit
-- ----------------------------
DROP TABLE IF EXISTS `currency_deposit`;
CREATE TABLE `currency_deposit`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `currency_id` int(11) NOT NULL,
  `output_currency_id` int(11) NOT NULL,
  `day` smallint(6) NULL DEFAULT NULL,
  `save_min` decimal(20, 8) NULL DEFAULT 0.00000000,
  `total_interest_rate` int(10) NULL DEFAULT NULL COMMENT '百分比',
  `created_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for currency_deposit_order
-- ----------------------------
DROP TABLE IF EXISTS `currency_deposit_order`;
CREATE TABLE `currency_deposit_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `u_id` int(11) NOT NULL,
  `currency_id` int(11) NOT NULL,
  `output_currency_id` int(11) NOT NULL,
  `amount` decimal(20, 8) NOT NULL COMMENT '存款数量',
  `day_rate` decimal(10, 4) NOT NULL COMMENT '日利率',
  `total_rate` decimal(10, 4) NULL DEFAULT NULL,
  `total_interest` decimal(20, 8) NULL DEFAULT 0.00000000 COMMENT '总利息',
  `last_settle_time` date NULL DEFAULT NULL COMMENT '上次结息时间',
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `end_at` date NULL DEFAULT NULL COMMENT '结束日期',
  `start_at` date NULL DEFAULT NULL COMMENT '开始时间',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '1:进行中 2：已结束',
  `is_cancel` tinyint(1) NULL DEFAULT NULL COMMENT '是否毁约',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for currency_deposit_order_log
-- ----------------------------
DROP TABLE IF EXISTS `currency_deposit_order_log`;
CREATE TABLE `currency_deposit_order_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `currency_id` int(11) NOT NULL,
  `amount` decimal(20, 8) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for currency_matches
-- ----------------------------
DROP TABLE IF EXISTS `currency_matches`;
CREATE TABLE `currency_matches`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `legal_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '法币id',
  `currency_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '币种id',
  `is_display` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否显示',
  `market_from` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0.无,1.交易所,2.火币接口',
  `category` tinyint(4) NULL DEFAULT 1 COMMENT '1:主流区 2 创新区',
  `min` decimal(20, 8) NOT NULL DEFAULT 0.00000000 COMMENT '门槛',
  `open_transaction` tinyint(4) NOT NULL DEFAULT 0 COMMENT '开启撮合交易',
  `open_lever` tinyint(4) NOT NULL DEFAULT 0 COMMENT '开启杠杆交易',
  `open_microtrade` tinyint(4) NOT NULL DEFAULT 0 COMMENT '开启微交易',
  `open_coin_trade` tinyint(4) NOT NULL COMMENT '开启币币交易',
  `coin_trade_success` tinyint(4) NOT NULL DEFAULT 1 COMMENT '自动匹配交易',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  `micro_trade_fee` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '微交易手续费(百分比)',
  `lever_share_num` decimal(20, 8) NOT NULL DEFAULT 1.00000000 COMMENT '每手折合数量',
  `spread` decimal(20, 4) NOT NULL DEFAULT 0.0000 COMMENT '点差',
  `overnight` decimal(20, 4) NOT NULL DEFAULT 0.0000 COMMENT '隔夜费',
  `lever_trade_fee` decimal(20, 4) NOT NULL DEFAULT 0.0000 COMMENT '交易手续费(百分比)',
  `lever_min_share` int(11) UNSIGNED NOT NULL DEFAULT 1 COMMENT '杠杆交易最低手数',
  `lever_max_share` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '杠杆交易最高手数',
  `fluctuate_min` decimal(20, 8) NOT NULL DEFAULT 0.00000000 COMMENT '行情波动最小值',
  `fluctuate_max` decimal(20, 8) NOT NULL DEFAULT 0.00000000 COMMENT '行情波动最大值',
  `risk_group_result` tinyint(4) NOT NULL DEFAULT 0 COMMENT '群控结果',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `legal_id`(`legal_id`) USING BTREE,
  INDEX `currency_id`(`currency_id`) USING BTREE,
  INDEX `is_display`(`is_display`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for currency_project
-- ----------------------------
DROP TABLE IF EXISTS `currency_project`;
CREATE TABLE `currency_project`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `currency_id` int(11) NOT NULL,
  `pay_currency_id` int(11) NULL DEFAULT NULL,
  `title` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `logo` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `summary` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `price` decimal(20, 8) NULL DEFAULT NULL,
  `amount` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `min` decimal(20, 8) NULL DEFAULT 0.00000000,
  `total_sell` decimal(20, 8) NULL DEFAULT 0.00000000,
  `sell_amount` decimal(20, 8) NULL DEFAULT 0.00000000 COMMENT '配售数量',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `start_at` datetime NULL DEFAULT NULL,
  `end_at` datetime NULL DEFAULT NULL,
  `sell_begin` datetime NULL DEFAULT NULL,
  `white_book` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `link` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '1正常 2',
  `total_apply` int(11) NULL DEFAULT NULL,
  `win_rate` decimal(10, 2) NULL DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for currency_project_order
-- ----------------------------
DROP TABLE IF EXISTS `currency_project_order`;
CREATE TABLE `currency_project_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `u_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `currency_id` int(11) NULL DEFAULT NULL,
  `pay_currency_id` int(11) NULL DEFAULT NULL,
  `pay_wallet_id` int(11) NULL DEFAULT NULL,
  `wallet_id` int(11) NULL DEFAULT NULL,
  `type` tinyint(4) NULL DEFAULT 1 COMMENT '1:认购2:抽签 ',
  `coin_amount` decimal(20, 8) NULL DEFAULT NULL,
  `price` decimal(20, 8) NULL DEFAULT NULL,
  `total_price` decimal(20, 8) NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `end_at` datetime NULL DEFAULT NULL COMMENT '公布时间',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '1:已申请 2:已支付 3:已完成发币',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for currency_quotation
-- ----------------------------
DROP TABLE IF EXISTS `currency_quotation`;
CREATE TABLE `currency_quotation`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `match_id` int(11) NOT NULL DEFAULT 0 COMMENT '交易对id',
  `legal_id` int(11) NOT NULL DEFAULT 0,
  `currency_id` int(11) NOT NULL DEFAULT 0,
  `change` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '涨跌幅 带+ - 号',
  `volume` decimal(20, 5) NOT NULL DEFAULT 0.00000 COMMENT '成交量',
  `now_price` decimal(20, 5) NOT NULL DEFAULT 0.00000 COMMENT '当前价位',
  `add_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dual_currency
-- ----------------------------
DROP TABLE IF EXISTS `dual_currency`;
CREATE TABLE `dual_currency`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '理财产品名称',
  `rate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '年华收益率',
  `exercise_price` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '挂钩参考价',
  `currency_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '理财币种',
  `currency_id` int(11) NOT NULL COMMENT '币种ID',
  `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型 call 或者 put',
  `start_time` date NOT NULL COMMENT '开始时间',
  `end_time` date NOT NULL COMMENT '结束时间',
  `total_number` int(11) NOT NULL COMMENT '总份额',
  `remaining_number` int(11) NOT NULL COMMENT '剩余份额',
  `purchased_number` int(11) NOT NULL COMMENT '已购份额',
  `bar` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '进度条',
  `user_limit` int(11) NOT NULL DEFAULT 0 COMMENT '限制单个用户持有的份数',
  `status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '状态:1=进行中,0=已结束',
  `created` date NOT NULL,
  `updated` date NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dual_order
-- ----------------------------
DROP TABLE IF EXISTS `dual_order`;
CREATE TABLE `dual_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户昵称',
  `dual_id` int(11) NOT NULL COMMENT '购买的理财ID',
  `order_rate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '购买时的年化利率',
  `day` int(11) NOT NULL COMMENT '持仓期限',
  `number` int(11) NOT NULL COMMENT '份数',
  `price` int(11) NOT NULL COMMENT '购买时的价格',
  `total` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '总支出',
  `currency_id` int(11) NOT NULL COMMENT '购买使用的币种',
  `end_time` date NOT NULL COMMENT '订单到期时间',
  `status` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '是否结算，1已结算',
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for exception_log
-- ----------------------------
DROP TABLE IF EXISTS `exception_log`;
CREATE TABLE `exception_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `message` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `created_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `connection` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 208 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for false_data
-- ----------------------------
DROP TABLE IF EXISTS `false_data`;
CREATE TABLE `false_data`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `price` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'log',
  `time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `content` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `create_time` int(11) NOT NULL DEFAULT 0,
  `reply_time` int(11) NOT NULL DEFAULT 0,
  `reply_content` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `is_reply` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for flash_against
-- ----------------------------
DROP TABLE IF EXISTS `flash_against`;
CREATE TABLE `flash_against`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `left_currency_id` int(11) NOT NULL,
  `right_currency_id` int(11) NOT NULL,
  `num` decimal(25, 8) NOT NULL,
  `fee` decimal(25, 8) NULL DEFAULT NULL,
  `absolute_quantity` decimal(25, 8) NOT NULL,
  `market_price` decimal(25, 4) NOT NULL DEFAULT 0.0000 COMMENT '当时的行情价格',
  `price` decimal(25, 4) NOT NULL DEFAULT 0.0000 COMMENT '用户输入的兑换价格价格',
  `status` tinyint(2) NOT NULL DEFAULT 0 COMMENT '状态 0 审核中 ：1成功 ：2 失败',
  `review_time` int(11) NULL DEFAULT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for follow
-- ----------------------------
DROP TABLE IF EXISTS `follow`;
CREATE TABLE `follow`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '跟随者用户id',
  `follow_user_id` int(11) NOT NULL COMMENT '被跟随者用户id',
  `number` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '跟随数量',
  `type` tinyint(4) NOT NULL DEFAULT 1 COMMENT '跟随类型：1固定比例跟随 2固定手数跟随',
  `income_amount` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '跟随收益金额',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '跟随状态：1跟随中 2取消跟随',
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uni_userid_followuserid`(`user_id`, `follow_user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '跟随记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for gd_order
-- ----------------------------
DROP TABLE IF EXISTS `gd_order`;
CREATE TABLE `gd_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `gd_user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `value` int(11) NOT NULL,
  `day_max_value` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for gd_user
-- ----------------------------
DROP TABLE IF EXISTS `gd_user`;
CREATE TABLE `gd_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `total_profit_rate` decimal(10, 2) NOT NULL,
  `three_week_profit` decimal(10, 2) NOT NULL,
  `total_day` mediumint(9) NOT NULL,
  `trade_count` mediumint(9) NOT NULL,
  `total_follower` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for historical_data
-- ----------------------------
DROP TABLE IF EXISTS `historical_data`;
CREATE TABLE `historical_data`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `start_time` int(11) NOT NULL DEFAULT 0,
  `end_time` int(11) NOT NULL DEFAULT 0,
  `data` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for huobi_symbols
-- ----------------------------
DROP TABLE IF EXISTS `huobi_symbols`;
CREATE TABLE `huobi_symbols`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `base-currency` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `quote-currency` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `price-precision` int(11) NOT NULL DEFAULT 0,
  `amount-precision` int(11) NOT NULL DEFAULT 0,
  `symbol-partition` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `symbol` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 403 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for insurance_claim_applies
-- ----------------------------
DROP TABLE IF EXISTS `insurance_claim_applies`;
CREATE TABLE `insurance_claim_applies`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '用户id',
  `user_insurance_id` int(10) UNSIGNED NOT NULL COMMENT '用户保险单',
  `insurance_type` tinyint(1) UNSIGNED NOT NULL COMMENT '保险类型',
  `apply_status` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '赔付状态。0，申请中，1，已赔付。2，已拒绝',
  `compensate` float(10, 2) NOT NULL DEFAULT 0.00 COMMENT '赔付金额',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `operator` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '操作人,auto,自动。',
  `refuse_reason` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '拒绝理由',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for insurance_rules
-- ----------------------------
DROP TABLE IF EXISTS `insurance_rules`;
CREATE TABLE `insurance_rules`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `insurance_type_id` smallint(5) UNSIGNED NOT NULL COMMENT '险种id',
  `amount` float(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '金额',
  `place_an_order_max` float(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '下单最大金额限制',
  `existing_number` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '可同时存在最大订单数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '不同金额保险的不同规则。' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for insurance_types
-- ----------------------------
DROP TABLE IF EXISTS `insurance_types`;
CREATE TABLE `insurance_types`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `currency_id` smallint(5) UNSIGNED NOT NULL COMMENT '币种',
  `type` tinyint(2) UNSIGNED NOT NULL DEFAULT 1 COMMENT '保险类型1，正向。2，反向。',
  `min_amount` float(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '最低购买额',
  `max_amount` float(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '最大购买额',
  `insurance_assets` float(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '保险资产占比%',
  `profit_termination_condition` float(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '盈利比例解约条件%',
  `defective_claims_condition` float(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '亏损比例理赔条件%（正向）',
  `defective_claims_condition2` float(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '亏损理赔条件2(反向)',
  `claims_times_daily` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '每日赔付次数',
  `auto_claim` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '自动赔付0，否。1，是',
  `claim_rate` float(10, 2) UNSIGNED NOT NULL DEFAULT 100.00 COMMENT '赔付比例',
  `claim_direction` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '赔付去向。1，受保资产。2，可用资产。',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态1，开启.0，关闭',
  `is_t_add_1` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否T加1，1，是。0，不是。',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '险种的类型。' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for jobs
-- ----------------------------
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED NULL DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `jobs_queue_index`(`queue`(191)) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for js_news
-- ----------------------------
DROP TABLE IF EXISTS `js_news`;
CREATE TABLE `js_news`  (
  `id` int(11) NOT NULL,
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `summary` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `published_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lbx_hashes
-- ----------------------------
DROP TABLE IF EXISTS `lbx_hashes`;
CREATE TABLE `lbx_hashes`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wallet_id` int(11) NOT NULL COMMENT '钱包id',
  `txid` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '链上交易hash',
  `type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '业务类型:0.归拢,1.提币 2.打入手续费',
  `amount` decimal(20, 8) NOT NULL COMMENT '数量',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0 未处理  1处理成功   2处理失败',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for legal_deal
-- ----------------------------
DROP TABLE IF EXISTS `legal_deal`;
CREATE TABLE `legal_deal`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `legal_deal_send_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `seller_id` int(11) NOT NULL DEFAULT 0,
  `number` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `is_sure` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0未确认 1已确认 2已取消 3已付款',
  `pay_orders_img` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '付款凭证',
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `legal_deal_legal_deal_send_id_seller_id_index`(`legal_deal_send_id`, `seller_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for legal_deal_send
-- ----------------------------
DROP TABLE IF EXISTS `legal_deal_send`;
CREATE TABLE `legal_deal_send`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `seller_id` int(11) NOT NULL DEFAULT 0,
  `currency_id` int(11) NOT NULL DEFAULT 0,
  `type` enum('buy','sell') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'sell',
  `way` enum('bank','we_chat','ali_pay') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'bank',
  `price` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `total_number` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `surplus_number` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `min_number` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `max_number` decimal(20, 5) NULL DEFAULT 0.00000,
  `is_done` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0  1已完成  2撤回',
  `create_time` int(11) NOT NULL DEFAULT 0,
  `is_shelves` int(4) NULL DEFAULT 1 COMMENT '1:上架   2下架',
  `is_sendback` int(11) NULL DEFAULT 1 COMMENT '1:未撤回  2：撤回',
  `money_type` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `legal_deal_send_seller_id_index`(`seller_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for level
-- ----------------------------
DROP TABLE IF EXISTS `level`;
CREATE TABLE `level`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `fill_currency` decimal(25, 4) NOT NULL DEFAULT 0.0000 COMMENT '充币数量',
  `direct_drive_count` int(11) NOT NULL DEFAULT 0 COMMENT '直推数量',
  `direct_drive_price` decimal(25, 4) NOT NULL DEFAULT 0.0000 COMMENT '直推金额',
  `max_algebra` int(20) NOT NULL DEFAULT 0 COMMENT '最大代数',
  `level` int(25) NOT NULL DEFAULT 0 COMMENT '级别',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lever_multiple
-- ----------------------------
DROP TABLE IF EXISTS `lever_multiple`;
CREATE TABLE `lever_multiple`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NULL DEFAULT 1 COMMENT '1倍数  2手数',
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `currency_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 300 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lever_tolegal
-- ----------------------------
DROP TABLE IF EXISTS `lever_tolegal`;
CREATE TABLE `lever_tolegal`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `number` decimal(11, 5) NULL DEFAULT NULL COMMENT '杠杆转c2c数量',
  `add_time` int(11) NULL DEFAULT NULL,
  `type` int(11) NULL DEFAULT 1 COMMENT '1:c2c转杠杆  2杠杆转c2c',
  `status` int(11) NULL DEFAULT 1 COMMENT '1:未审核   2：审核通过 3:审核不通过',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '杠杆账户转c2c账户后台审核' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lever_transaction
-- ----------------------------
DROP TABLE IF EXISTS `lever_transaction`;
CREATE TABLE `lever_transaction`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) UNSIGNED NOT NULL DEFAULT 0 COMMENT '买卖类型:1.买入,2.卖出',
  `user_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户id',
  `currency` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '交易id',
  `legal` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '法币id',
  `origin_price` decimal(20, 8) UNSIGNED NOT NULL DEFAULT 0.00000000 COMMENT '原始价格',
  `price` decimal(20, 8) UNSIGNED NOT NULL DEFAULT 0.00000000 COMMENT '开仓价格(点差处理之后)',
  `update_price` decimal(20, 8) UNSIGNED NOT NULL DEFAULT 0.00000000 COMMENT '当前价格',
  `target_profit_price` decimal(20, 8) UNSIGNED NOT NULL DEFAULT 0.00000000 COMMENT '止盈价格',
  `stop_loss_price` decimal(20, 8) UNSIGNED NOT NULL DEFAULT 0.00000000 COMMENT '止亏价格',
  `share` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '手数',
  `number` decimal(20, 5) UNSIGNED NOT NULL DEFAULT 0.00000 COMMENT '手数换算数量(非放大的)',
  `multiple` tinyint(4) UNSIGNED NOT NULL DEFAULT 0 COMMENT '倍数',
  `origin_caution_money` decimal(20, 8) UNSIGNED NOT NULL DEFAULT 0.00000000 COMMENT '初始保证金',
  `caution_money` decimal(20, 8) UNSIGNED NOT NULL DEFAULT 0.00000000 COMMENT '当前可用保证金',
  `fact_profits` decimal(20, 8) NOT NULL DEFAULT 0.00000000 COMMENT '最终盈亏',
  `trade_fee` decimal(20, 8) UNSIGNED NOT NULL DEFAULT 0.00000000 COMMENT '交易手续费',
  `overnight` decimal(20, 4) UNSIGNED NOT NULL DEFAULT 0.0000 COMMENT '隔夜费率,百分比',
  `overnight_money` decimal(20, 8) UNSIGNED NOT NULL DEFAULT 0.00000000 COMMENT '隔夜费金额',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '交易状态:0.挂单中,1.交易中,2.平仓中,3.已平仓,4.已撤单',
  `settled` tinyint(4) NOT NULL DEFAULT 0 COMMENT '结算状态:0.未结算,1.已结算',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '下单时间',
  `transaction_time` decimal(20, 8) NOT NULL DEFAULT 0.00000000 COMMENT '交易时间',
  `update_time` decimal(20, 8) NOT NULL DEFAULT 0.00000000 COMMENT '价格刷新时间(毫秒级)',
  `handle_time` decimal(20, 8) NOT NULL DEFAULT 0.00000000 COMMENT '平仓时间',
  `complete_time` decimal(20, 8) NOT NULL DEFAULT 0.00000000 COMMENT '完成时间',
  `agent_path` varchar(2048) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '1' COMMENT '代理商关系',
  `follow_user_id` int(11) NOT NULL DEFAULT 0 COMMENT '被跟随者id 若此值存在则代表跟随订单',
  `follow_order_id` int(11) NOT NULL DEFAULT 0 COMMENT '被跟随者订单id 若此值存在则代表跟随订单',
  `order_type` tinyint(4) NOT NULL DEFAULT 1 COMMENT '订单类型 1自持 2跟随',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `currency`(`currency`) USING BTREE,
  INDEX `legal`(`legal`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `type`(`type`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `user_currency_status_type`(`user_id`, `status`, `currency`, `legal`, `type`, `settled`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 230 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lh_bank_account
-- ----------------------------
DROP TABLE IF EXISTS `lh_bank_account`;
CREATE TABLE `lh_bank_account`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NULL DEFAULT NULL,
  `p_uid` int(11) NULL DEFAULT NULL,
  `df_balance` decimal(25, 8) NULL DEFAULT 0.00000000,
  `usdt_balance` decimal(25, 8) NULL DEFAULT 0.00000000,
  `total_profit` decimal(25, 8) NULL DEFAULT 0.00000000,
  `total_deposit_amount` decimal(25, 8) NULL DEFAULT NULL,
  `team_deposit_amount` decimal(25, 8) NULL DEFAULT NULL COMMENT '团队存款总量',
  `m_level` tinyint(4) NULL DEFAULT 0 COMMENT '直推级别',
  `vip_level` tinyint(4) NULL DEFAULT 0 COMMENT '团队级别',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '1:正常',
  `updated_at` datetime NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `vip_log` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `coin_lock_balance` decimal(20, 8) NULL DEFAULT 0.00000000,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lh_bank_account_log
-- ----------------------------
DROP TABLE IF EXISTS `lh_bank_account_log`;
CREATE TABLE `lh_bank_account_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NULL DEFAULT NULL,
  `type` tinyint(1) NULL DEFAULT NULL COMMENT '1:usdt账户 2:df-one',
  `amount` decimal(25, 8) NULL DEFAULT NULL COMMENT '数量',
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lh_bank_team_member
-- ----------------------------
DROP TABLE IF EXISTS `lh_bank_team_member`;
CREATE TABLE `lh_bank_team_member`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NULL DEFAULT NULL,
  `leader_uid` int(11) NULL DEFAULT NULL,
  `generation` int(11) NULL DEFAULT NULL COMMENT '第几代团队',
  `created_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lh_deposit_config
-- ----------------------------
DROP TABLE IF EXISTS `lh_deposit_config`;
CREATE TABLE `lh_deposit_config`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `currency_id` int(11) NOT NULL,
  `interest_rate` decimal(10, 4) NOT NULL,
  `save_min` decimal(20, 8) NOT NULL DEFAULT 0.00000000,
  `day` int(10) NOT NULL,
  `intro` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lh_deposit_order
-- ----------------------------
DROP TABLE IF EXISTS `lh_deposit_order`;
CREATE TABLE `lh_deposit_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `currency_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL COMMENT '解冻数量',
  `day_rate` decimal(10, 5) NOT NULL COMMENT '日利率',
  `total_interest` decimal(20, 8) NULL DEFAULT 0.00000000 COMMENT '总利息',
  `last_settle_time` date NULL DEFAULT NULL COMMENT '上次结息时间',
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `end_at` date NULL DEFAULT NULL COMMENT '结束日期',
  `start_at` date NULL DEFAULT NULL COMMENT '开始时间',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '1:进行中 2：已结束',
  `is_return_reward` tinyint(1) NULL DEFAULT 0 COMMENT '是否执行反佣逻辑',
  `is_cancel` tinyint(1) NULL DEFAULT 0 COMMENT '是否毁约',
  `bank_account_id` int(5) NOT NULL,
  `usdt_amount` decimal(20, 4) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 227 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lh_deposit_order_log
-- ----------------------------
DROP TABLE IF EXISTS `lh_deposit_order_log`;
CREATE TABLE `lh_deposit_order_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `interest_amount` decimal(25, 8) NULL DEFAULT NULL COMMENT '利息数',
  `lh_order_id` int(11) NULL DEFAULT NULL,
  `bank_account_id` int(11) NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL COMMENT '什么时候结的',
  `interest_day` date NULL DEFAULT NULL COMMENT '哪天的利息',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `orderIndex`(`lh_order_id`, `interest_day`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lh_loan_order
-- ----------------------------
DROP TABLE IF EXISTS `lh_loan_order`;
CREATE TABLE `lh_loan_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bank_account_id` int(11) NULL DEFAULT NULL,
  `amount` int(11) NOT NULL COMMENT '存款数量',
  `day_rate` decimal(10, 5) NOT NULL COMMENT '日利率',
  `total_interest` decimal(20, 8) NULL DEFAULT 0.00000000 COMMENT '总利息',
  `total_return` decimal(20, 8) NULL DEFAULT NULL COMMENT '总还款数',
  `last_settle_time` date NULL DEFAULT NULL COMMENT '上次结息时间',
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `end_at` date NULL DEFAULT NULL COMMENT '结束日期',
  `start_at` date NULL DEFAULT NULL COMMENT '开始时间',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '1:进行中 2：已还清',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for market
-- ----------------------------
DROP TABLE IF EXISTS `market`;
CREATE TABLE `market`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `symbol` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `website_slug` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `rank` int(11) NOT NULL DEFAULT 0,
  `circulating_supply` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `total_supply` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `max_supply` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `quotes` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `last_updated` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for market_day
-- ----------------------------
DROP TABLE IF EXISTS `market_day`;
CREATE TABLE `market_day`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `currency_id` int(11) NOT NULL DEFAULT 0,
  `legal_id` int(11) NOT NULL DEFAULT 0,
  `start_price` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `end_price` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `highest` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `mminimum` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `number` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `times` varchar(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `mar_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `type` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for market_hour
-- ----------------------------
DROP TABLE IF EXISTS `market_hour`;
CREATE TABLE `market_hour`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `currency_id` int(11) NOT NULL DEFAULT 0,
  `legal_id` int(11) NOT NULL DEFAULT 0,
  `start_price` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `end_price` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `highest` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `mminimum` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `day_time` int(11) NOT NULL DEFAULT 0,
  `type` tinyint(4) NOT NULL DEFAULT 0,
  `number` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `mar_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `period` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `sign` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `currency_id_legal_id_day_time_type_period_sign`(`currency_id`, `legal_id`, `day_time`, `type`, `period`, `sign`) USING BTREE,
  INDEX `currency_id`(`currency_id`) USING BTREE,
  INDEX `legal_id`(`legal_id`) USING BTREE,
  INDEX `day_time`(`day_time`) USING BTREE,
  INDEX `type`(`type`) USING BTREE,
  INDEX `sign`(`sign`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 276995 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '跳转的连接',
  `sort` int(255) NOT NULL DEFAULT 1 COMMENT '排序，从小到大',
  `show` tinyint(255) NOT NULL DEFAULT 1 COMMENT '是否显示 1：显示，0：不显示',
  `open_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'navigateTo' COMMENT '跳转方式',
  `is_financial` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否在金融页显示',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for micro_numbers
-- ----------------------------
DROP TABLE IF EXISTS `micro_numbers`;
CREATE TABLE `micro_numbers`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `currency_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '币种id',
  `number` decimal(20, 8) NOT NULL DEFAULT 0.00000000 COMMENT '数量',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for micro_orders
-- ----------------------------
DROP TABLE IF EXISTS `micro_orders`;
CREATE TABLE `micro_orders`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户id',
  `match_id` int(11) UNSIGNED NOT NULL COMMENT '交易对id',
  `currency_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '支付的币种',
  `type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '买卖类型1.买涨,2.买跌',
  `is_insurance` tinyint(4) NOT NULL DEFAULT 0 COMMENT '订单险种:0.无,1.正向，2反向。',
  `seconds` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '秒数',
  `number` decimal(20, 8) UNSIGNED NOT NULL DEFAULT 0.00000000 COMMENT '下单数量',
  `open_price` decimal(20, 8) UNSIGNED NOT NULL DEFAULT 0.00000000 COMMENT '开仓价',
  `end_price` decimal(20, 8) UNSIGNED NOT NULL DEFAULT 0.00000000 COMMENT '收盘价',
  `fee` decimal(20, 8) UNSIGNED NOT NULL COMMENT '手续费',
  `profit_ratio` decimal(20, 2) UNSIGNED NOT NULL COMMENT '收益率',
  `fact_profits` decimal(20, 8) NOT NULL COMMENT '最终收益',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '状态:1.交易中,2.平仓中,3.已平仓',
  `pre_profit_result` tinyint(4) NOT NULL DEFAULT 0 COMMENT '预设盈利状态:-1.亏损,0.未设置,1.盈利',
  `profit_result` tinyint(4) NOT NULL DEFAULT 0 COMMENT '盈利结果:-1.亏损,0.平,1.盈利',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '提交日期',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新日期',
  `handled_at` timestamp NULL DEFAULT NULL COMMENT '平仓时间',
  `complete_at` timestamp NULL DEFAULT NULL COMMENT '完成时间',
  `return_at` timestamp NULL DEFAULT NULL COMMENT '返还手续费的时间',
  `agent_path` varchar(2048) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '代理商关系',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `match_id`(`match_id`) USING BTREE,
  INDEX `currency_id`(`currency_id`) USING BTREE,
  INDEX `type`(`type`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `seconds`(`seconds`) USING BTREE,
  INDEX `profit_result`(`profit_result`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for micro_orders_copy
-- ----------------------------
DROP TABLE IF EXISTS `micro_orders_copy`;
CREATE TABLE `micro_orders_copy`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户id',
  `match_id` int(11) UNSIGNED NOT NULL COMMENT '交易对id',
  `currency_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '支付的币种',
  `type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '买卖类型1.买涨,2.买跌',
  `seconds` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '秒数',
  `number` decimal(20, 8) UNSIGNED NOT NULL DEFAULT 0.00000000 COMMENT '下单数量',
  `open_price` decimal(20, 8) UNSIGNED NOT NULL DEFAULT 0.00000000 COMMENT '开仓价',
  `end_price` decimal(20, 8) UNSIGNED NOT NULL DEFAULT 0.00000000 COMMENT '收盘价',
  `fee` decimal(10, 8) UNSIGNED NOT NULL COMMENT '手续费',
  `profit_ratio` decimal(20, 8) UNSIGNED NOT NULL COMMENT '收益率',
  `fact_profits` decimal(20, 8) NOT NULL COMMENT '最终收益',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '状态:1.交易中,2.平仓中,3.已平仓',
  `pre_profit_result` tinyint(4) NOT NULL DEFAULT 0 COMMENT '预设盈利状态:-1.亏损,0.未设置,1.盈利',
  `profit_result` tinyint(4) NOT NULL DEFAULT 0 COMMENT '盈利结果:-1.亏损,0.平,1.盈利',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '提交日期',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新日期',
  `handled_at` timestamp NULL DEFAULT NULL COMMENT '平仓时间',
  `complete_at` timestamp NULL DEFAULT NULL COMMENT '完成时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `match_id`(`match_id`) USING BTREE,
  INDEX `currency_id`(`currency_id`) USING BTREE,
  INDEX `type`(`type`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `seconds`(`seconds`) USING BTREE,
  INDEX `profit_result`(`profit_result`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for micro_seconds
-- ----------------------------
DROP TABLE IF EXISTS `micro_seconds`;
CREATE TABLE `micro_seconds`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `seconds` int(11) UNSIGNED NOT NULL COMMENT '秒数',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '状态:0.禁用,1.启用',
  `profit_ratio` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '收益率',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `max_amount` decimal(11, 2) NULL DEFAULT NULL COMMENT '最大金额',
  `min_amount` decimal(11, 2) NULL DEFAULT NULL COMMENT '最下金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `c_id` int(11) NOT NULL DEFAULT 0,
  `lang` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '语言类型',
  `title` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `recommend` tinyint(4) NOT NULL DEFAULT 0,
  `audit` tinyint(4) NOT NULL DEFAULT 0,
  `display` tinyint(4) NOT NULL DEFAULT 0,
  `discuss` tinyint(4) NOT NULL DEFAULT 0,
  `author` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `browse_grant` tinyint(4) NOT NULL DEFAULT 0,
  `keyword` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `abstract` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `views` int(11) NOT NULL DEFAULT 0,
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  `thumbnail` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `cover` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `sorts` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 240 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for news_category
-- ----------------------------
DROP TABLE IF EXISTS `news_category`;
CREATE TABLE `news_category`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `sorts` int(11) NOT NULL DEFAULT 0,
  `is_show` tinyint(4) NOT NULL DEFAULT 0,
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  `site_id` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for news_copy
-- ----------------------------
DROP TABLE IF EXISTS `news_copy`;
CREATE TABLE `news_copy`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `c_id` int(11) NOT NULL DEFAULT 0,
  `lang` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '语言类型',
  `title` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `recommend` tinyint(4) NOT NULL DEFAULT 0,
  `audit` tinyint(4) NOT NULL DEFAULT 0,
  `display` tinyint(4) NOT NULL DEFAULT 0,
  `discuss` tinyint(4) NOT NULL DEFAULT 0,
  `author` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `browse_grant` tinyint(4) NOT NULL DEFAULT 0,
  `keyword` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `abstract` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `views` int(11) NOT NULL DEFAULT 0,
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  `thumbnail` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `cover` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `sorts` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for optional
-- ----------------------------
DROP TABLE IF EXISTS `optional`;
CREATE TABLE `optional`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `currency_id` int(11) NULL DEFAULT NULL,
  `create_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 89 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci COMMENT = '自选' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for prize_pool
-- ----------------------------
DROP TABLE IF EXISTS `prize_pool`;
CREATE TABLE `prize_pool`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `scene` int(11) NOT NULL DEFAULT 0 COMMENT '奖励场景',
  `reward_type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '奖励类型:0.糖果,1.数字货币',
  `reward_currency` int(11) NOT NULL DEFAULT 0 COMMENT '奖励币种,不是数字货币传0',
  `currency_type` int(11) NOT NULL DEFAULT 0 COMMENT '货币类型:1.法币,2.币币交易,3.杠杆交易',
  `reward_qty` decimal(20, 8) NOT NULL DEFAULT 0.00000000 COMMENT '奖励数量',
  `from_user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '触发用户',
  `to_user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '受奖励用户',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '状态:[0.未领取,1.已领取,2.已过期]',
  `sign` int(11) NOT NULL DEFAULT 0 COMMENT '扩展标识,与奖励类型配合使用,用于区分具体的奖励,非必填项',
  `extra_data` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '附加数据',
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` int(11) NULL DEFAULT NULL COMMENT '奖励时间',
  `expire_time` int(11) NULL DEFAULT NULL COMMENT '过期时间',
  `receive_time` int(11) NULL DEFAULT NULL COMMENT '领取时间',
  `error_info` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '错误信息',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `type`(`scene`) USING BTREE,
  INDEX `sign`(`sign`) USING BTREE,
  INDEX `from_user_id`(`from_user_id`) USING BTREE,
  INDEX `to_user_id`(`to_user_id`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `create_time`(`create_time`) USING BTREE,
  INDEX `expire_time`(`expire_time`) USING BTREE,
  INDEX `receive_time`(`receive_time`) USING BTREE,
  INDEX `reward_type`(`reward_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '奖金池' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rate
-- ----------------------------
DROP TABLE IF EXISTS `rate`;
CREATE TABLE `rate`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `currency` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '币种',
  `rate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '1美元兑换汇率',
  `updated` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for robot
-- ----------------------------
DROP TABLE IF EXISTS `robot`;
CREATE TABLE `robot`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `currency_id` int(11) NOT NULL DEFAULT 0,
  `legal_id` int(11) NOT NULL DEFAULT 0,
  `buy_user_id` int(11) NOT NULL DEFAULT 0,
  `sell_user_id` int(11) NOT NULL DEFAULT 0,
  `create_time` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0,
  `second` int(11) NOT NULL DEFAULT 0,
  `sell` int(11) NOT NULL DEFAULT 0,
  `buy` int(11) NOT NULL DEFAULT 0,
  `number_max` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `number_min` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `float_number_down` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `float_number_up` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for score_log
-- ----------------------------
DROP TABLE IF EXISTS `score_log`;
CREATE TABLE `score_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `type` int(3) NULL DEFAULT NULL COMMENT '1 后台增加  2 惩罚',
  `change` decimal(11, 2) NULL DEFAULT NULL,
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `create_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for seller
-- ----------------------------
DROP TABLE IF EXISTS `seller`;
CREATE TABLE `seller`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '',
  `seller_balance` decimal(20, 5) NULL DEFAULT 0.00000,
  `lock_seller_balance` decimal(20, 5) NULL DEFAULT 0.00000,
  `wechat_nickname` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '',
  `wechat_account` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '',
  `ali_nickname` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '',
  `ali_account` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '',
  `bank_id` int(11) NULL DEFAULT 0,
  `bank_account` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '',
  `bank_address` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '',
  `create_time` int(11) NOT NULL DEFAULT 0,
  `currency_id` int(11) NOT NULL DEFAULT 0,
  `mobile` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `alipay_qr_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '',
  `wechat_qr_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '',
  `status` int(2) NOT NULL DEFAULT 0 COMMENT '审核状态0：未通过  1：通过',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `seller_user_id_index`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for settings
-- ----------------------------
DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `value` varchar(1000) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `notes` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 176 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for term_arbitrage_items
-- ----------------------------
DROP TABLE IF EXISTS `term_arbitrage_items`;
CREATE TABLE `term_arbitrage_items`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `currency_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '币种id',
  `day_rate` decimal(10, 4) NOT NULL COMMENT '日利率(百分比)	',
  `save_min` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '投入最小值',
  `day` int(10) NOT NULL,
  `updated_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tokens
-- ----------------------------
DROP TABLE IF EXISTS `tokens`;
CREATE TABLE `tokens`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `token` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `time_out` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `lang` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `token`(`token`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3927 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for transaction
-- ----------------------------
DROP TABLE IF EXISTS `transaction`;
CREATE TABLE `transaction`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `from_user_id` int(11) NOT NULL DEFAULT 0,
  `currency` int(11) NOT NULL DEFAULT 0,
  `to_user_id` int(11) NOT NULL DEFAULT 0,
  `type` tinyint(4) NOT NULL DEFAULT 0,
  `number` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `remarks` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `time` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0,
  `price` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for transaction_complete
-- ----------------------------
DROP TABLE IF EXISTS `transaction_complete`;
CREATE TABLE `transaction_complete`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `way` tinyint(4) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `price` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `number` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `create_time` int(11) NOT NULL DEFAULT 0,
  `currency` int(11) NOT NULL DEFAULT 0,
  `from_user_id` int(11) NOT NULL DEFAULT 0,
  `legal` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `complete`(`create_time`, `currency`, `legal`, `number`, `price`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for transaction_in
-- ----------------------------
DROP TABLE IF EXISTS `transaction_in`;
CREATE TABLE `transaction_in`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `price` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `number` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `create_time` int(11) NOT NULL DEFAULT 0,
  `currency` int(11) NOT NULL DEFAULT 0,
  `legal` int(11) NOT NULL DEFAULT 0,
  `total_number` decimal(20, 8) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `transaction_in_price_user_id_index`(`price`, `user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for transaction_out
-- ----------------------------
DROP TABLE IF EXISTS `transaction_out`;
CREATE TABLE `transaction_out`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `price` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `number` decimal(20, 5) NOT NULL DEFAULT 0.00000,
  `create_time` int(11) NOT NULL DEFAULT 0,
  `currency` int(11) NOT NULL DEFAULT 0,
  `legal` int(11) NOT NULL DEFAULT 0,
  `total_number` decimal(20, 8) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `transaction_out_price_user_id_index`(`price`, `user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_algebra
-- ----------------------------
DROP TABLE IF EXISTS `user_algebra`;
CREATE TABLE `user_algebra`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `touch_user_id` int(11) NOT NULL COMMENT '触发者',
  `algebra` int(11) NOT NULL,
  `value` decimal(25, 8) NOT NULL,
  `info` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_cash_info
-- ----------------------------
DROP TABLE IF EXISTS `user_cash_info`;
CREATE TABLE `user_cash_info`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `bank_id` int(10) NOT NULL COMMENT '银行id',
  `bank_name` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '银行',
  `bank_branch` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '支行',
  `bank_dizhi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '开户省市',
  `bank_account` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '账户',
  `real_name` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '真实姓名',
  `alipay_account` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `wechat_nickname` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `wechat_account` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `create_time` int(11) NOT NULL DEFAULT 0,
  `alipay_qr_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '',
  `wechat_qr_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_cash_info_international
-- ----------------------------
DROP TABLE IF EXISTS `user_cash_info_international`;
CREATE TABLE `user_cash_info_international`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `bank_id` int(10) NOT NULL COMMENT '银行id',
  `bank_name` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '银行',
  `bank_branch` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '支行',
  `bank_dizhi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '开户省市',
  `bank_account` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '账户',
  `real_name` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '真实姓名',
  `bank_network` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '開戶網點',
  `swift_code` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '國際支付代碼',
  `phone` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '電話',
  `idcard` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '' COMMENT '證件號碼',
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_chat
-- ----------------------------
DROP TABLE IF EXISTS `user_chat`;
CREATE TABLE `user_chat`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `from_user_id` int(11) NOT NULL DEFAULT 0,
  `to_user_id` int(11) NOT NULL DEFAULT 0,
  `content` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `offline` tinyint(4) NOT NULL DEFAULT 0,
  `type` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `add_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_chat_from_user_id_index`(`from_user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_level
-- ----------------------------
DROP TABLE IF EXISTS `user_level`;
CREATE TABLE `user_level`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `amount` decimal(11, 2) NULL DEFAULT NULL,
  `give` decimal(11, 2) NULL DEFAULT NULL COMMENT '%',
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `file` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_level_log
-- ----------------------------
DROP TABLE IF EXISTS `user_level_log`;
CREATE TABLE `user_level_log`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `level_id` int(11) NULL DEFAULT NULL,
  `type` int(1) NULL DEFAULT NULL COMMENT '1 后台变动 2 自动升级',
  `create_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_profiles
-- ----------------------------
DROP TABLE IF EXISTS `user_profiles`;
CREATE TABLE `user_profiles`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0 COMMENT '用户id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '真实姓名',
  `card_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '证件号码',
  `front_pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '身份证正面',
  `reverse_pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '身份证反面',
  `hand_pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '手持身份证',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_real
-- ----------------------------
DROP TABLE IF EXISTS `user_real`;
CREATE TABLE `user_real`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `id_type` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '证件类型0身份证 1护照 2驾驶证',
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `card_id` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `review_status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1,未审核2,已审核',
  `advanced_user` int(11) NULL DEFAULT NULL COMMENT '高级认证',
  `front_pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `reverse_pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `hand_pic` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `create_time` int(11) NOT NULL DEFAULT 0,
  `review_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_real_user_id_index`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 264 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_real_copy
-- ----------------------------
DROP TABLE IF EXISTS `user_real_copy`;
CREATE TABLE `user_real_copy`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `card_id` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `review_status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1,未审核2,已审核',
  `front_pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `reverse_pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `hand_pic` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `create_time` int(11) NOT NULL DEFAULT 0,
  `review_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_real_user_id_index`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `area_code_id` int(11) NOT NULL DEFAULT 1 COMMENT '国家区号 1默认大陆',
  `area_code` int(10) NOT NULL COMMENT '区号',
  `account_number` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `type` tinyint(4) NOT NULL DEFAULT 0,
  `phone` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `agent_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0表示不是代理商，1以上表示该代理商id',
  `agent_note_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '代理商节点id。当该用户是代理商时该值等于上级代理商Id，当该用户不是代理商时该值等于节点代理商id',
  `parent_id` int(11) NULL DEFAULT 0,
  `email` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `pay_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `time` int(11) NOT NULL DEFAULT 0,
  `head_portrait` varchar(400) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `extension_code` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '1，已锁定',
  `gesture_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_auth` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `wallet_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_blacklist` tinyint(4) NOT NULL DEFAULT 0,
  `parents_path` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL COMMENT '上级推荐人节点',
  `push_status` int(4) NULL DEFAULT 0 COMMENT '0:未实名认证 1:实名认证  2:直推3人 3:直推5人 4:直推10人  5:直推30人  6:直推50人',
  `candy_number` decimal(10, 4) NULL DEFAULT 0.0000 COMMENT '糖果数量',
  `zhitui_real_number` int(11) NULL DEFAULT 0 COMMENT '实名认证过的直推人数',
  `real_teamnumber` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '实名认证通过的团队人数',
  `top_upnumber` decimal(20, 6) NULL DEFAULT 0.000000 COMMENT '团队业绩充值金额',
  `is_realname` int(4) NOT NULL DEFAULT 1 COMMENT '1:未实名认证过  2：实名认证过',
  `is_atelier` int(11) NOT NULL DEFAULT 0 COMMENT '是否工作室',
  `new_isreal_time` int(11) NULL DEFAULT 0 COMMENT '最新通过的下级实名认证时间',
  `today_real_teamnumber` int(11) NULL DEFAULT 0 COMMENT '今日新增团队实名认证人数',
  `today_LegalDealCancel_num` int(4) NULL DEFAULT 0 COMMENT '今天c2c订单已经取消次数',
  `LegalDealCancel_num__update_time` int(11) NULL DEFAULT NULL COMMENT 'c2c取消单子更新时间',
  `risk` tinyint(1) NOT NULL DEFAULT 0 COMMENT '-1.亏损,0.正常,1.盈利',
  `lock_time` int(11) NOT NULL DEFAULT 0 COMMENT '锁定时间',
  `level` int(25) NULL DEFAULT 0 COMMENT '代数',
  `fund` decimal(30, 8) NULL DEFAULT 0.00000000 COMMENT '秒合约资产',
  `is_service` tinyint(4) UNSIGNED NULL DEFAULT 0 COMMENT '是否是客服',
  `agent_path` varchar(2048) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '1' COMMENT '代理商关系',
  `wallet_pwd` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `country_code` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `label` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `nationality` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `last_login_ip` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `user_level` int(11) NOT NULL DEFAULT 0 COMMENT '用户等级标志',
  `score` decimal(10, 2) NULL DEFAULT 100.00,
  `is_bind_box_author` varchar(25) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '是否开通盲盒作者',
  `is_trader` tinyint(4) NOT NULL DEFAULT 2 COMMENT '是否为交易员：1-是 2-否',
  `virtual_follow_num` int(11) NOT NULL DEFAULT 0 COMMENT '交易员虚拟跟随人数',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `account_number`(`account_number`) USING BTREE,
  UNIQUE INDEX `phone`(`phone`) USING BTREE,
  INDEX `agent_id`(`agent_id`) USING BTREE,
  INDEX `agent_node`(`agent_note_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1085727 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for users_insurances
-- ----------------------------
DROP TABLE IF EXISTS `users_insurances`;
CREATE TABLE `users_insurances`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `insurance_type_id` mediumint(5) UNSIGNED NOT NULL COMMENT '险种类型id',
  `amount` float(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '投保金额（受保资产）',
  `insurance_amount` float(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '购买时的保险资产',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `yielded_at` timestamp NULL DEFAULT NULL COMMENT '生币时间',
  `rescinded_at` timestamp NULL DEFAULT NULL COMMENT '解约时间',
  `rescinded_type` tinyint(4) UNSIGNED NULL DEFAULT 0 COMMENT '解约类型0，自动解约。1，手动解约',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态，1，生效中。0，已失效。',
  `claim_status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否申请理赔中1,是',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for users_wallet
-- ----------------------------
DROP TABLE IF EXISTS `users_wallet`;
CREATE TABLE `users_wallet`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `currency` int(11) NOT NULL DEFAULT 0,
  `address` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '',
  `address_2` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '第二类型地址usdt',
  `address_3` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'trc20',
  `legal_balance` decimal(25, 8) NOT NULL DEFAULT 0.00000000 COMMENT '法币交易余额',
  `lock_legal_balance` decimal(25, 8) NOT NULL DEFAULT 0.00000000,
  `change_balance` decimal(25, 8) NOT NULL DEFAULT 0.00000000 COMMENT '币币交易余额',
  `lock_change_balance` decimal(25, 8) NOT NULL DEFAULT 0.00000000,
  `lever_balance` decimal(25, 8) NOT NULL DEFAULT 0.00000000 COMMENT '杠杆交易余额',
  `lever_balance_add_allnum` decimal(25, 8) NOT NULL DEFAULT 0.00000000 COMMENT '资产兑换累加产生的杠杆值(作为入金的一部分）',
  `lock_lever_balance` decimal(25, 8) NOT NULL DEFAULT 0.00000000,
  `micro_balance` decimal(25, 8) NOT NULL DEFAULT 0.00000000 COMMENT '微盘',
  `lock_micro_balance` decimal(25, 8) NOT NULL DEFAULT 0.00000000 COMMENT '锁定微盘',
  `insurance_balance` decimal(25, 8) NOT NULL DEFAULT 0.00000000 COMMENT '受保资产',
  `lock_insurance_balance` decimal(25, 8) NOT NULL DEFAULT 0.00000000 COMMENT '锁定受保资产  保险资产',
  `status` int(11) NOT NULL DEFAULT 0,
  `create_time` int(11) NOT NULL DEFAULT 0,
  `old_balance` decimal(20, 8) NOT NULL DEFAULT 0.00000000,
  `private` varchar(1024) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `private_2` varchar(1024) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `private_3` varchar(1024) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `cost` decimal(20, 5) NOT NULL DEFAULT 0.00000 COMMENT '持仓成本',
  `gl_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `txid` varchar(1024) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '交易哈希',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `currency`(`currency`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `user_id_currency`(`user_id`, `currency`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3451 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for users_wallet_out
-- ----------------------------
DROP TABLE IF EXISTS `users_wallet_out`;
CREATE TABLE `users_wallet_out`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `currency` int(11) NOT NULL DEFAULT 0,
  `address` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `number` decimal(20, 8) NOT NULL DEFAULT 0.00000000,
  `create_time` int(11) NOT NULL DEFAULT 0,
  `rate` decimal(20, 4) NOT NULL DEFAULT 0.0000,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `notes` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `real_number` decimal(20, 8) NOT NULL DEFAULT 0.00000000,
  `txid` varchar(1024) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '链上哈希',
  `verificationcode` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '',
  `update_time` int(11) NULL DEFAULT NULL,
  `type` int(5) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for users_wallet_withdraw
-- ----------------------------
DROP TABLE IF EXISTS `users_wallet_withdraw`;
CREATE TABLE `users_wallet_withdraw`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `currency` int(11) NOT NULL DEFAULT 0,
  `address` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `qrcode` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for wallet_log
-- ----------------------------
DROP TABLE IF EXISTS `wallet_log`;
CREATE TABLE `wallet_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户id',
  `from_user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '触发者id',
  `account_log_id` int(11) NOT NULL DEFAULT 0 COMMENT '关联account_log',
  `wallet_id` int(11) NOT NULL DEFAULT 0 COMMENT '钱包id',
  `balance_type` int(11) NOT NULL DEFAULT 0 COMMENT '余额类型:1.法币,2.币币,3.杆杠',
  `lock_type` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否锁定',
  `before` decimal(20, 8) NOT NULL DEFAULT 0.00000000 COMMENT '原余额',
  `change` decimal(20, 8) NOT NULL DEFAULT 0.00000000 COMMENT '变动余额',
  `after` decimal(20, 8) NOT NULL DEFAULT 0.00000000 COMMENT '当前余额',
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `extra_sign` int(11) NOT NULL DEFAULT 0 COMMENT '扩展标识',
  `extra_data` varchar(1024) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '扩展数据',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '发生时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `account_log_id`(`account_log_id`) USING BTREE,
  INDEX `balance_type`(`balance_type`) USING BTREE,
  INDEX `wallet_id`(`wallet_id`) USING BTREE,
  INDEX `lock_type`(`lock_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3604 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for wallet_unlock_order
-- ----------------------------
DROP TABLE IF EXISTS `wallet_unlock_order`;
CREATE TABLE `wallet_unlock_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `wallet_id` int(11) NULL DEFAULT NULL,
  `currency_id` int(11) NULL DEFAULT NULL,
  `amount` decimal(20, 8) NULL DEFAULT NULL,
  `remain_amount` decimal(20, 8) NULL DEFAULT NULL,
  `status` tinyint(4) NULL DEFAULT 1,
  `handle_time` datetime NULL DEFAULT NULL,
  `finished_time` datetime NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ztpay_log
-- ----------------------------
DROP TABLE IF EXISTS `ztpay_log`;
CREATE TABLE `ztpay_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `body` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `created_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `hash`(`unique_key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
