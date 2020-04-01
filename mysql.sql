-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text COMMENT '文章内容',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` tinyint(1) DEFAULT '1' COMMENT '是否有效  1.有效  2无效',
  `update_by` bigint(11) DEFAULT NULL,
  `create_by` bigint(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='发布号作者表';

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('5', '技术', '2020-03-31 09:08:45', '2020-03-31 14:34:23', '1', '1', '1');
INSERT INTO `article` VALUES ('6', '产品', '2020-03-31 10:49:28', '2020-03-31 14:34:23', '1', '1', '1');
INSERT INTO `article` VALUES ('10', '运营', '2020-03-31 14:57:45', '2020-03-31 14:34:24', '1', '1', '1');
INSERT INTO `article` VALUES ('11', '开发', '2020-03-31 15:23:42', '2020-03-31 14:34:24', '1', '1', '1');
INSERT INTO `article` VALUES ('19', '测试', '2020-03-31 13:37:07', '2020-03-31 14:34:24', '1', '1', '1');
INSERT INTO `article` VALUES ('20', '运维', '2020-03-31 14:28:58', '2020-03-31 14:34:28', '1', '1', '1');
INSERT INTO `article` VALUES ('23', 'UI1', '2020-03-31 05:33:32', '2020-03-31 18:35:30', '1', '1', '1');

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '自定id,主要供前端展示权限列表分类排序使用.',
  `menu_code` varchar(255) DEFAULT '' COMMENT '归属菜单,前端判断并展示菜单使用,',
  `menu_name` varchar(255) DEFAULT '' COMMENT '菜单的中文释义',
  `permission_code` varchar(255) DEFAULT '' COMMENT '权限的代码/通配符,对应代码中@RequiresPermissions 的value',
  `permission_name` varchar(255) DEFAULT '' COMMENT '本权限的中文释义',
  `required_permission` tinyint(1) DEFAULT '2' COMMENT '是否本菜单必选权限, 1.必选 2非必选 通常是"列表"权限是必选',
  `create_by` bigint(11) DEFAULT NULL,
  `update_by` bigint(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `del_flag` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='后台权限表';

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES ('101', 'article', '文章管理', 'article:list', '列表', '1', '1', '1', '2020-03-31 14:34:56', '2020-03-31 14:34:56', '1');
INSERT INTO `sys_permission` VALUES ('102', 'article', '文章管理', 'article:add', '新增', '2', '1', '1', '2020-03-31 14:34:56', '2020-03-31 14:34:56', '1');
INSERT INTO `sys_permission` VALUES ('103', 'article', '文章管理', 'article:update', '修改', '2', '1', '1', '2020-03-31 14:34:56', '2020-03-31 14:34:56', '1');
INSERT INTO `sys_permission` VALUES ('601', 'user', '用户', 'user:list', '列表', '1', '1', '1', '2020-03-31 14:34:56', '2020-03-31 14:34:56', '1');
INSERT INTO `sys_permission` VALUES ('602', 'user', '用户', 'user:add', '新增', '2', '1', '1', '2020-03-31 14:34:56', '2020-03-31 14:34:56', '1');
INSERT INTO `sys_permission` VALUES ('603', 'user', '用户', 'user:update', '修改', '2', '1', '1', '2020-03-31 14:34:56', '2020-03-31 14:34:56', '1');
INSERT INTO `sys_permission` VALUES ('701', 'role', '角色权限', 'role:list', '列表', '1', '1', '1', '2020-03-31 14:34:56', '2020-03-31 14:34:56', '1');
INSERT INTO `sys_permission` VALUES ('702', 'role', '角色权限', 'role:add', '新增', '2', '1', '1', '2020-03-31 14:34:56', '2020-03-31 14:34:56', '1');
INSERT INTO `sys_permission` VALUES ('703', 'role', '角色权限', 'role:update', '修改', '2', '1', '1', '2020-03-31 14:34:56', '2020-03-31 14:34:56', '1');
INSERT INTO `sys_permission` VALUES ('704', 'role', '角色权限', 'role:delete', '删除', '2', '1', '1', '2020-03-31 14:34:56', '2020-03-31 14:34:56', '1');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(20) DEFAULT NULL COMMENT '角色名',
  `role_ename` varchar(20) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `del_flag` tinyint(1) DEFAULT '1' COMMENT '是否有效  1有效  2无效',
  `create_by` bigint(11) DEFAULT NULL,
  `update_by` bigint(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='后台角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '管理员1', 'admin', '2020-03-31 14:34:56', '2020-03-31 14:36:22', '1', '1', '1');
INSERT INTO `sys_role` VALUES ('2', '作家', 'admin1', '2020-03-31 14:34:56', '2020-03-31 14:36:23', '1', '1', '1');
INSERT INTO `sys_role` VALUES ('3', '程序员', 'admin6', '2020-03-31 14:34:56', '2020-03-31 14:36:23', '1', '1', '1');
INSERT INTO `sys_role` VALUES ('4', '管理员2', 'admin2', '2020-03-31 14:34:56', '2020-03-31 14:36:24', '1', '1', '1');
INSERT INTO `sys_role` VALUES ('5', '管理员3', 'admin3', '2020-03-31 14:34:56', '2020-03-31 14:36:21', '2', '1', '1');
INSERT INTO `sys_role` VALUES ('6', '管理员4', 'admin4', '2020-03-31 14:34:56', '2020-03-31 14:36:20', '1', '1', '1');
INSERT INTO `sys_role` VALUES ('8', '管理员5', 'admin5', '2020-03-31 14:34:56', '2020-03-31 14:36:20', '2', '1', '1');
INSERT INTO `sys_role` VALUES ('12', '管理员7-1', 'admin7', '2020-03-31 06:37:46', '2020-03-31 19:38:23', '2', '1', '1');

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL COMMENT '角色id',
  `permission_id` int(11) DEFAULT NULL COMMENT '权限id',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `del_flag` varchar(1) DEFAULT '1' COMMENT '是否有效 1有效     2无效',
  `update_by` bigint(11) DEFAULT NULL,
  `create_by` bigint(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='角色-权限关联表';

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES ('1', '2', '101', '2020-03-31 14:34:56', '2020-03-31 14:38:32', '1', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('2', '2', '102', '2020-03-31 14:34:56', '2020-03-31 14:38:34', '1', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('5', '2', '602', '2020-03-31 14:34:56', '2020-03-31 14:38:33', '1', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('6', '2', '601', '2020-03-31 14:34:56', '2020-03-31 14:38:35', '1', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('7', '2', '603', '2020-03-31 14:34:56', '2020-03-31 14:38:35', '1', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('8', '2', '703', '2020-03-31 14:34:56', '2020-03-31 14:38:36', '1', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('9', '2', '701', '2020-03-31 14:34:56', '2020-03-31 14:38:36', '1', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('10', '2', '702', '2020-03-31 14:34:56', '2020-03-31 14:38:37', '1', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('11', '2', '704', '2020-03-31 14:34:56', '2020-03-31 14:38:37', '1', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('12', '2', '103', '2020-03-31 14:34:56', '2020-03-31 14:38:38', '1', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('13', '3', '601', '2020-03-31 14:34:56', '2020-03-31 14:38:38', '1', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('14', '3', '701', '2020-03-31 14:34:56', '2020-03-31 14:38:38', '1', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('15', '3', '702', '2020-03-31 14:34:56', '2020-03-31 14:38:39', '1', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('16', '3', '704', '2020-03-31 14:34:56', '2020-03-31 14:38:39', '1', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('17', '3', '102', '2020-03-31 14:34:56', '2020-03-31 14:38:40', '1', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('18', '3', '101', '2020-03-31 14:34:56', '2020-03-31 14:38:40', '1', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('19', '3', '603', '2020-03-31 14:34:56', '2020-03-31 14:38:42', '1', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('20', '1', '101', '2020-03-26 19:12:31', '2020-03-31 14:38:58', '1', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('21', '1', '102', '2020-03-26 19:12:31', '2020-03-31 14:38:58', '1', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('22', '1', '103', '2020-03-26 19:12:31', '2020-03-31 14:38:59', '2', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('25', '4', '101', '2020-03-26 19:27:06', '2020-03-31 14:38:59', '1', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('26', '4', '103', '2020-03-26 19:27:06', '2020-03-31 14:39:00', '1', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('28', '5', '101', '2020-03-26 19:28:38', '2020-03-31 14:39:00', '1', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('29', '5', '103', '2020-03-26 19:28:38', '2020-03-31 14:39:02', '1', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('31', '6', '101', '2020-03-31 14:34:56', '2020-03-31 14:39:03', '1', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('32', '6', '103', '2020-03-31 14:34:56', '2020-03-31 14:39:04', '1', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('35', '8', '101', '2020-03-31 14:34:56', '2020-03-31 14:39:05', '2', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('36', '8', '103', '2020-03-31 14:34:56', '2020-03-31 14:39:05', '2', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('40', '12', '1', '2020-03-31 19:32:53', '2020-03-31 19:38:23', '2', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('41', '12', '3', '2020-03-31 19:32:53', '2020-03-31 19:38:23', '2', '1', '1');
INSERT INTO `sys_role_permission` VALUES ('42', '12', '5', '2020-03-31 19:37:47', '2020-03-31 19:38:23', '2', '1', '1');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `nickname` varchar(255) DEFAULT NULL COMMENT '昵称',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` tinyint(1) DEFAULT '1' COMMENT '是否有效  1有效  2无效',
  `create_by` bigint(11) DEFAULT NULL,
  `update_by` bigint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10014 DEFAULT CHARSET=utf8 COMMENT='运营后台用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', '4280d89a5a03f812751f504cc10ee8a5', '超级用户', '2020-03-30 11:52:38', '2020-03-31 14:30:56', '1', '1', '1');
INSERT INTO `sys_user` VALUES ('2', 'user1', '4280d89a5a03f812751f504cc10ee8a5', 'user1', '2020-03-31 16:13:02', '2020-03-31 14:30:54', '1', '1', '1');
INSERT INTO `sys_user` VALUES ('3', 'user2', '4280d89a5a03f812751f504cc10ee8a5', 'user2', '2020-03-31 14:02:56', '2020-03-31 14:30:54', '1', '1', '1');
INSERT INTO `sys_user` VALUES ('4', 'user3', '4280d89a5a03f812751f504cc10ee8a5', 'user3', '2020-03-31 16:29:41', '2020-03-31 14:30:49', '1', '1', '2');
INSERT INTO `sys_user` VALUES ('5', 'zjw', '4280d89a5a03f812751f504cc10ee8a5', 'zjw', '2020-03-31 19:36:06', '2020-03-31 14:30:51', '1', '1', '2');
INSERT INTO `sys_user` VALUES ('10012', 'user', '4280d89a5a03f812751f504cc10ee8a5', 'zjw', '2020-03-31 19:39:32', '2020-03-31 19:39:32', '1', '10012', '10012');
INSERT INTO `sys_user` VALUES ('10013', '123', 'c4b679c21b2cdcc9f7e464b2513846fb', 'zjw', '2020-03-31 19:40:09', '2020-03-31 06:43:54', '1', '10007', '1');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `role_id` int(11) DEFAULT NULL COMMENT '角色id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` tinyint(1) DEFAULT NULL COMMENT '删除标识，1为正常，2为删除',
  `update_by` int(11) DEFAULT NULL COMMENT '更新人',
  `create_by` int(11) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '1', '1', '2020-03-25 15:44:02', '2020-03-25 15:44:05', '1', '1', '1');
INSERT INTO `sys_user_role` VALUES ('2', '1', '2', '2020-03-25 15:44:27', '2020-03-25 15:44:29', '1', '1', '1');
INSERT INTO `sys_user_role` VALUES ('3', '2', '1', '2020-03-25 15:44:52', '2020-03-25 15:44:54', '1', '1', '1');
INSERT INTO `sys_user_role` VALUES ('4', '3', '3', '2020-03-25 15:49:00', '2020-03-25 15:49:03', '1', '1', '1');
