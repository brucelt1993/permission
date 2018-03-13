-- MySQL dump 10.13  Distrib 5.7.20, for Win64 (x86_64)
--
-- Host: localhost    Database: test1
-- ------------------------------------------------------
-- Server version	5.7.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `sys_acl`
--

DROP TABLE IF EXISTS `sys_acl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_acl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '权限码',
  `name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '权限名称',
  `acl_module_id` int(11) NOT NULL DEFAULT '0' COMMENT '权限所在的权限模块id',
  `url` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '请求的url，可以正则表达式',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '类型  1:菜单  2:按钮  3:其他',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态  1:正常 0:冻结 ',
  `seq` int(11) NOT NULL DEFAULT '0' COMMENT '权限在当前模块下的顺序',
  `remark` varchar(200) COLLATE utf8_bin DEFAULT '' COMMENT '备注',
  `operator` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '操作者',
  `operator_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新的时间',
  `operator_ip` varchar(20) COLLATE utf8_bin DEFAULT '' COMMENT '更新者的ip',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_acl`
--

LOCK TABLES `sys_acl` WRITE;
/*!40000 ALTER TABLE `sys_acl` DISABLE KEYS */;
INSERT INTO `sys_acl` VALUES (1,'20180306233113_0','进入产品页面',1,'/sys/product/product.page',1,1,1,'','bruce','2018-03-06 23:35:01','0:0:0:0:0:0:0:1'),(2,'20180306233601_0','产品列表',1,'/sys/product/page.json',2,1,2,'','bruce','2018-03-06 23:36:01','0:0:0:0:0:0:0:1'),(3,'20180306233654_0','产品上架',4,'/sys/product/online.json',2,1,3,'','bruce','2018-03-12 23:21:09','0:0:0:0:0:0:0:1'),(4,'20180306233725_0','产品下架',5,'/sys/product/offline.json',2,1,4,'功能下线','bruce','2018-03-12 23:32:25','0:0:0:0:0:0:0:1'),(5,'20180312231037_0','进入订单页',2,'/sys/order/order.page',1,1,1,'','bruce','2018-03-12 23:20:44','0:0:0:0:0:0:0:1'),(6,'20180312232233_0','查询订单列表',2,'/sys/order/list.json',2,1,2,'','bruce','2018-03-12 23:22:33','0:0:0:0:0:0:0:1'),(7,'20180312232557_0','进入权限管理页',7,'/sys/aclModule/acl.page',1,1,1,'','bruce','2018-03-12 23:25:57','0:0:0:0:0:0:0:1'),(8,'20180312232618_0','进入角色管理页',8,'/sys/role/role.page',1,1,1,'','bruce','2018-03-12 23:26:19','0:0:0:0:0:0:0:1'),(9,'20180312232649_0','进入用户管理页',9,'/sys/dept/dept.page',1,1,1,'','bruce','2018-03-12 23:26:49','0:0:0:0:0:0:0:1');
/*!40000 ALTER TABLE `sys_acl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_acl_module`
--

DROP TABLE IF EXISTS `sys_acl_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_acl_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限模块id',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '权限模块名称',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '上级权限模块的id',
  `level` varchar(200) NOT NULL DEFAULT '' COMMENT '权限模块层级',
  `seq` int(11) NOT NULL DEFAULT '0' COMMENT '部门在当前层级下的顺序',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态',
  `remark` varchar(200) DEFAULT '' COMMENT '备注',
  `operator` varchar(20) NOT NULL DEFAULT '' COMMENT '操作者',
  `operator_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次操作的时间',
  `operator_ip` varchar(20) NOT NULL DEFAULT '' COMMENT '最后一次更新者的ip',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_acl_module`
--

LOCK TABLES `sys_acl_module` WRITE;
/*!40000 ALTER TABLE `sys_acl_module` DISABLE KEYS */;
INSERT INTO `sys_acl_module` VALUES (1,'产品管理',0,'0',1,1,'撒大大','bruce','2018-03-06 22:45:28','0:0:0:0:0:0:0:1'),(2,'订单管理',0,'0',2,1,'','bruce','2018-03-06 22:40:17','0:0:0:0:0:0:0:1'),(3,'公告管理',0,'0',3,1,'','bruce','2018-03-06 22:40:36','0:0:0:0:0:0:0:1'),(4,'出售中产品管理',1,'0.1',1,1,'','bruce','2018-03-06 22:41:13','0:0:0:0:0:0:0:1'),(5,'下架产品管理',1,'0.1',2,1,'','bruce','2018-03-06 22:41:26','0:0:0:0:0:0:0:1'),(6,'权限管理',0,'0',4,1,'','bruce','2018-03-12 23:23:19','0:0:0:0:0:0:0:1'),(7,'权限管理',6,'0.6',1,1,'','bruce','2018-03-12 23:24:37','0:0:0:0:0:0:0:1'),(8,'角色管理',6,'0.6',2,1,'','bruce','2018-03-12 23:24:58','0:0:0:0:0:0:0:1'),(9,'用户管理',6,'0.6',3,1,'','bruce','2018-03-12 23:25:15','0:0:0:0:0:0:0:1');
/*!40000 ALTER TABLE `sys_acl_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dept`
--

DROP TABLE IF EXISTS `sys_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_dept` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '部门名称',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '上级部门的id',
  `level` varchar(200) NOT NULL DEFAULT '' COMMENT '部门层级',
  `seq` int(11) NOT NULL DEFAULT '0' COMMENT '部门在当前层级下的顺序',
  `remark` varchar(200) DEFAULT '' COMMENT '备注',
  `operator` varchar(20) NOT NULL DEFAULT '' COMMENT '操作者',
  `operator_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次操作的时间',
  `operator_ip` varchar(20) NOT NULL DEFAULT '' COMMENT '最后一次更新者的ip',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept`
--

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;
INSERT INTO `sys_dept` VALUES (1,'技术部',0,'0',1,'技术部','system','2018-03-01 23:08:22','127.0.0.1'),(2,'后端开发',1,'0.1',1,'后端设计','system-update','2018-03-03 23:03:15','127.0.0.1'),(3,'前端开发',1,'0.1',2,'','system','2018-03-01 23:09:59','127.0.0.1'),(4,'UI设计',1,'0.1',3,'UI设计','system','2018-03-03 20:15:22','127.0.0.1');
/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_log`
--

DROP TABLE IF EXISTS `sys_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '权限更新的类型 1:部门 2:用户 3:权限模块 4:权限 5:角色 6:角色用户关系 7:角色权限关系',
  `target_id` int(11) NOT NULL COMMENT '基于type后指定的id',
  `old_value` text COLLATE utf8_bin COMMENT '旧值',
  `new_value` text COLLATE utf8_bin COMMENT '新值',
  `operator` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '操纵者',
  `operator_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新的时间',
  `operator_ip` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '最后一次更新者的ip',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '当前是否复原过  0:没有 1:复原过',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_log`
--

LOCK TABLES `sys_log` WRITE;
/*!40000 ALTER TABLE `sys_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '角色名称',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '角色类型 1:管理员角色 2:其他',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态 ',
  `remark` varchar(200) COLLATE utf8_bin DEFAULT '' COMMENT '备注',
  `operator` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '操作者',
  `operator_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新的时间',
  `operator_ip` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '最后一次更新者的ip地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'产品管理员',1,1,'uu','bruce','2018-03-12 21:31:26','0:0:0:0:0:0:0:1'),(2,'订单管理员',1,1,'','bruce','2018-03-12 21:31:32','0:0:0:0:0:0:0:1'),(3,'公告管理员',1,1,'','bruce','2018-03-12 21:31:49','0:0:0:0:0:0:0:1'),(4,'权限管理员',1,1,'','bruce','2018-03-12 23:33:01','0:0:0:0:0:0:0:1');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_acl`
--

DROP TABLE IF EXISTS `sys_role_acl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_acl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `acl_id` int(11) NOT NULL COMMENT '权限id',
  `operator` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '操作者',
  `operator_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新的时间',
  `operator_ip` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '最后一次操作者的ip地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_acl`
--

LOCK TABLES `sys_role_acl` WRITE;
/*!40000 ALTER TABLE `sys_role_acl` DISABLE KEYS */;
INSERT INTO `sys_role_acl` VALUES (4,4,7,'bruce','2018-03-12 23:51:07','0:0:0:0:0:0:0:1'),(5,4,8,'bruce','2018-03-12 23:51:07','0:0:0:0:0:0:0:1');
/*!40000 ALTER TABLE `sys_role_acl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_user`
--

DROP TABLE IF EXISTS `sys_role_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `operator` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '操作者',
  `operator_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次操作的时间',
  `operator_ip` varchar(20) COLLATE utf8_bin DEFAULT '' COMMENT '最后一次操作者的ip地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_user`
--

LOCK TABLES `sys_role_user` WRITE;
/*!40000 ALTER TABLE `sys_role_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_role_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '用户名称',
  `telephone` varchar(13) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '手机号',
  `mail` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '邮箱',
  `password` varchar(40) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '加密后的密码',
  `dept_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户所在部门的id',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态,1:正常 , 0:冻结  2:删除',
  `remark` varchar(200) COLLATE utf8_bin DEFAULT '' COMMENT '备注',
  `operator` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '操作者',
  `operator_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新时间',
  `operator_ip` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '最后一次更新者的ip',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,'bruce','13535430871','1253565646@qq.com','E10ADC3949BA59ABBE56E057F20F883E',1,1,'系统超级管理员，哈哈','bruce','2018-03-05 21:51:07','0:0:0:0:0:0:0:1'),(2,'flower','15622197948','bruclet_1993@163.com','E10ADC3949BA59ABBE56E057F20F883E',1,1,'小仙女一枚','bruce','2018-03-05 21:45:12','127.0.0.1'),(3,'小强','13843764132','w3341321@qq.com','E10ADC3949BA59ABBE56E057F20F883E',2,1,'专业背锅侠','bruce','2018-03-05 22:09:11','0:0:0:0:0:0:0:1'),(4,'小丽','12323434453','3121231@qq.com','F94517B7B18A73103537BBF34BF9E648',3,1,'效率第一','bruce','2018-03-05 22:14:02','0:0:0:0:0:0:0:1');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `a` char(1) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-03-13 20:51:40
