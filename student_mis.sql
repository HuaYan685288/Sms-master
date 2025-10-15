/*
 Navicat Premium Data Transfer

 Source Server         : 1
 Source Server Type    : MySQL
 Source Server Version : 80013
 Source Host           : localhost:3306
 Source Schema         : student_mis

 Target Server Type    : MySQL
 Target Server Version : 80013
 File Encoding         : 65001

 Date: 06/05/2025 20:26:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `level` tinyint(4) NOT NULL DEFAULT 0,
  `school` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `sex` tinyint(4) NOT NULL DEFAULT 0,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'root', '123456', '洋鱼鸡', 0, '湖南铁路科技职业技术学院', 'HuaYan685288@gmail.com', '18075751161', 0, '2024-12-16 15:06:24');

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '编号',
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '课程名',
  `credits` decimal(4, 1) NOT NULL DEFAULT 2.0 COMMENT '学分',
  `score` int(11) NOT NULL DEFAULT 100 COMMENT '满分',
  `number` int(4) NOT NULL DEFAULT 32 COMMENT '课时',
  `year` int(6) NOT NULL DEFAULT 2016 COMMENT '届时',
  `term` tinyint(4) NOT NULL DEFAULT 0 COMMENT '学期',
  `type` tinyint(4) NOT NULL DEFAULT 1 COMMENT '类别 1必修 2选修',
  `profession` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '专业',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('2024091001', '计算机网络技术运用', 4.0, 100, 32, 2023, 1, 1, '软件技术', '2024-12-17 14:39:06');
INSERT INTO `course` VALUES ('2024091002', '网络爬虫', 4.0, 100, 18, 2023, 1, 1, '软件技术', '2024-12-16 21:36:06');
INSERT INTO `course` VALUES ('2024091003', '数据分析与处理', 4.0, 100, 32, 2023, 1, 1, '软件技术', '2024-12-17 14:42:33');
INSERT INTO `course` VALUES ('2024091004', 'Python数据可视化', 4.0, 100, 32, 2023, 1, 1, '软件技术', '2024-12-17 14:41:23');

-- ----------------------------
-- Table structure for course_info
-- ----------------------------
DROP TABLE IF EXISTS `course_info`;
CREATE TABLE `course_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `start` int(11) NOT NULL,
  `end` int(11) NOT NULL,
  `room` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `profession` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of course_info
-- ----------------------------
INSERT INTO `course_info` VALUES (1, '2024091001', 2, 5, '信1#212', '软件技术');
INSERT INTO `course_info` VALUES (2, '2024091002', 6, 10, '信1#212', '软件技术');
INSERT INTO `course_info` VALUES (3, '2024091003', 11, 15, '信1#212', '软件技术');
INSERT INTO `course_info` VALUES (4, '2024091004', 16, 19, '信1#212', '软件技术');

-- ----------------------------
-- Table structure for profession
-- ----------------------------
DROP TABLE IF EXISTS `profession`;
CREATE TABLE `profession`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of profession
-- ----------------------------
INSERT INTO `profession` VALUES (1, '软件技术');

-- ----------------------------
-- Table structure for silent
-- ----------------------------
DROP TABLE IF EXISTS `silent`;
CREATE TABLE `silent`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of silent
-- ----------------------------
INSERT INTO `silent` VALUES (1, 0);

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `level` tinyint(4) NOT NULL DEFAULT 2,
  `school` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `admission_time` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  `profession` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `grade` int(11) NOT NULL,
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `sex` tinyint(4) NOT NULL DEFAULT 0,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('3168901101', '3168901101', '123456', '刘一', 2, '湖南铁路科技职业技术学院', '2023', '123456789@qq.com', '软件技术', 2303, '16666688888', 1, '2024-12-16 15:24:29');
INSERT INTO `student` VALUES ('3168901102', '3168901102', '123456', '陈二', 2, '湖南铁路科技职业技术学院', '2023', '987654321@qq.com', '软件技术', 2303, '16666688888', 0, '2024-12-16 15:50:22');
INSERT INTO `student` VALUES ('3168901103', '3168901103', '123456', '张三', 2, '湖南铁路科技职业技术学院', '2023', '123789456@qq.com', '软件技术', 2303, '16666688888', 0, '2024-12-16 15:53:31');
INSERT INTO `student` VALUES ('3168901104', '3168901104', '123456', '李四', 2, '湖南铁路科技职业技术学院', '2023', '456789123@qq.com', '软件技术', 2303, '16666688888', 1, '2024-12-16 15:53:31');
INSERT INTO `student` VALUES ('3168901105', '3168901105', '123456', '王五', 2, '湖南铁路科技职业技术学院', '2023', '456123789@qq.com', '软件技术', 2303, '16666688888', 0, '2024-12-16 15:53:31');
INSERT INTO `student` VALUES ('3168901106', '3168901106', '123456', '赵六', 2, '湖南铁路科技职业技术学院', '2023', '789123456@qq.com', '软件技术', 2303, '16666688888', 1, '2024-12-16 15:53:31');
INSERT INTO `student` VALUES ('3168901107', '3168901107', '123456', '孙七', 2, '湖南铁路科技职业技术学院', '2023', '789456123@qq.com', '软件技术', 2303, '16666688888', 0, '2024-12-16 15:53:32');
INSERT INTO `student` VALUES ('3168901108', '3168901108', '123456', '周八', 2, '湖南铁路科技职业技术学院', '2023', '987321654@qq.com', '软件技术', 2303, '16666688888', 1, '2024-12-16 15:53:32');
INSERT INTO `student` VALUES ('3168901109', '3168901109', '123456', '吴九', 2, '湖南铁路科技职业技术学院', '2023', '654987321@qq.com', '软件技术', 2303, '16666688888', 0, '2024-12-16 15:53:32');
INSERT INTO `student` VALUES ('3168901110', '3168901110', '123456', '郑十', 2, '湖南铁路科技职业技术学院', '2023', '654321987@qq.com', '软件技术', 2303, '16666688888', 0, '2024-12-16 15:53:32');

-- ----------------------------
-- Table structure for student_course
-- ----------------------------
DROP TABLE IF EXISTS `student_course`;
CREATE TABLE `student_course`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `course_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `score` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `point` decimal(4, 2) NOT NULL,
  `credits` decimal(4, 2) NOT NULL,
  `term` tinyint(4) NOT NULL,
  `year` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 504 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of student_course
-- ----------------------------
INSERT INTO `student_course` VALUES (1, '3168901101', '2024091002', '网络爬虫', '76', 2.60, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (2, '3168901102', '2024091002', '网络爬虫', '76', 2.60, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (3, '3168901103', '2024091002', '网络爬虫', '76', 2.60, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (4, '3168901104', '2024091002', '网络爬虫', '78', 2.80, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (5, '3168901105', '2024091002', '网络爬虫', '76', 2.60, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (6, '3168901106', '2024091002', '网络爬虫', '98', 4.80, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (7, '3168901107', '2024091002', '网络爬虫', '76', 2.60, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (8, '3168901108', '2024091002', '网络爬虫', '58', 0.00, 0.00, 1, 2023);
INSERT INTO `student_course` VALUES (9, '3168901109', '2024091002', '网络爬虫', '67', 1.70, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (10, '3168901110', '2024091002', '网络爬虫', '76', 2.60, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (475, '3168901103', '2024091001', '计算机网络技术运用', '59', 0.00, 0.00, 1, 2023);
INSERT INTO `student_course` VALUES (476, '3168901101', '2024091004', 'Python数据可视化', '77', 2.70, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (477, '3168901101', '2024091003', '数据分析与处理', '78', 2.80, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (478, '3168901101', '2024091001', '计算机网络技术运用', '88', 3.80, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (479, '3168901102', '2024091004', 'Python数据可视化', '69', 1.90, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (480, '3168901102', '2024091003', '数据分析与处理', '74', 2.40, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (481, '3168901102', '2024091001', '计算机网络技术运用', '84', 3.40, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (482, '3168901103', '2024091004', 'Python数据可视化', '64', 1.40, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (483, '3168901104', '2024091001', '计算机网络技术运用', '90', 4.00, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (484, '3168901104', '2024091003', '数据分析与处理', '83', 3.30, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (485, '3168901104', '2024091004', 'Python数据可视化', '79', 2.90, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (486, '3168901105', '2024091001', '计算机网络技术运用', '88', 3.80, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (487, '3168901105', '2024091003', '数据分析与处理', '79', 2.90, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (488, '3168901105', '2024091004', 'Python数据可视化', '86', 3.60, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (489, '3168901103', '2024091003', '数据分析与处理', '67', 1.70, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (490, '3168901106', '2024091001', '计算机网络技术运用', '100', 5.00, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (491, '3168901106', '2024091003', '数据分析与处理', '96', 4.60, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (492, '3168901106', '2024091004', 'Python数据可视化', '99', 4.90, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (493, '3168901107', '2024091001', '计算机网络技术运用', '80', 3.00, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (494, '3168901107', '2024091003', '数据分析与处理', '83', 3.30, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (495, '3168901107', '2024091004', 'Python数据可视化', '90', 4.00, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (496, '3168901108', '2024091001', '计算机网络技术运用', '61', 1.10, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (497, '3168901108', '2024091003', '数据分析与处理', '67', 1.70, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (498, '3168901108', '2024091004', 'Python数据可视化', '66', 1.60, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (499, '3168901109', '2024091001', '计算机网络技术运用', '70', 2.00, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (500, '3168901109', '2024091003', '数据分析与处理', '50', 0.00, 0.00, 1, 2023);
INSERT INTO `student_course` VALUES (501, '3168901109', '2024091004', 'Python数据可视化', '77', 2.70, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (502, '3168901110', '2024091001', '计算机网络技术运用', '88', 3.80, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (503, '3168901110', '2024091003', '数据分析与处理', '75', 2.50, 4.00, 1, 2023);
INSERT INTO `student_course` VALUES (504, '3168901110', '2024091004', 'Python数据可视化', '83', 3.30, 4.00, 1, 2023);

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `level` tinyint(4) NOT NULL DEFAULT 1,
  `school` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `sex` tinyint(4) NOT NULL DEFAULT 0,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3890001 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES (3890001, '3890001', '123456', '潘科龙', 1, '湖南铁路科技职业技术学院', '1688888888@qq.com', '18888888888', 0, '2024-12-03 16:32:12');

-- ----------------------------
-- Table structure for teacher_course
-- ----------------------------
DROP TABLE IF EXISTS `teacher_course`;
CREATE TABLE `teacher_course`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `teacher_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `profession` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `grade` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `term` tinyint(4) NOT NULL,
  `course_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of teacher_course
-- ----------------------------
INSERT INTO `teacher_course` VALUES (1, '3890001', '3890001', '计算机网络技术运用', '软件技术', '2303', 1, '2024091001');
INSERT INTO `teacher_course` VALUES (2, '3890001', '3890001', '网络爬虫', '软件技术', '2303', 1, '2024091002');
INSERT INTO `teacher_course` VALUES (3, '3890001', '3890001', '数据分析与处理', '软件技术', '2303', 1, '2024091003');
INSERT INTO `teacher_course` VALUES (4, '3890001', '3890001', 'Python数据可视化', '软件技术', '2303', 1, '2024091004');

-- ----------------------------
-- Table structure for timetable
-- ----------------------------
DROP TABLE IF EXISTS `timetable`;
CREATE TABLE `timetable`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `week_id` int(11) NOT NULL,
  `profession` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `grade` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `year` int(11) NOT NULL,
  `term` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of timetable
-- ----------------------------
INSERT INTO `timetable` VALUES (1, 6, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (2, 6, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (3, 6, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (4, 6, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (5, 7, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (6, 7, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (7, 7, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (8, 7, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (9, 8, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (10, 8, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (11, 8, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (12, 8, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (13, 9, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (14, 9, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (15, 9, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (16, 9, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (17, 2, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (18, 2, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (19, 2, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (20, 2, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (21, 3, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (22, 3, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (23, 3, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (24, 3, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (25, 4, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (26, 4, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (27, 4, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (28, 4, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (29, 5, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (30, 5, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (31, 5, '软件技术', '2303', 2023, 1);
INSERT INTO `timetable` VALUES (32, 5, '软件技术', '2303', 2023, 1);

-- ----------------------------
-- Table structure for upload
-- ----------------------------
DROP TABLE IF EXISTS `upload`;
CREATE TABLE `upload`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `level` int(11) NOT NULL DEFAULT 0,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of upload
-- ----------------------------
INSERT INTO `upload` VALUES (1, '1', 0, 'sms/static/img/1e3d1f1a-33b5-4677-a70d-7ab754f3c436.jpg');
INSERT INTO `upload` VALUES (2, '3168901102', 2, 'sms/static/img/98d6ec65-bb2c-4b41-8f7f-ac723085b59b.jpg');
INSERT INTO `upload` VALUES (3, '3890290', 1, 'sms/static/img/859d30a4-5089-47bd-822e-0c435b009a82.png');
INSERT INTO `upload` VALUES (4, '3168901101', 2, 'sms/static/img/4f60c9ba-d99c-4dac-9767-4d833a430d90.jpg');
INSERT INTO `upload` VALUES (5, '3890001', 1, 'sms/static/img/3d998c61-d43a-4be5-aaea-bb7398578422.jpg');

-- ----------------------------
-- Table structure for week
-- ----------------------------
DROP TABLE IF EXISTS `week`;
CREATE TABLE `week`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `monday` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tuesday` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `wednesday` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `thursday` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `friday` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `saturday` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sunday` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of week
-- ----------------------------
INSERT INTO `week` VALUES (1, '一', '一', '一', '一', '一', '一', '一');
INSERT INTO `week` VALUES (2, '计算机网络技术运用', '计算机网络技术运用', '一', '一', '一', '一', '一');
INSERT INTO `week` VALUES (3, '网络爬虫', '网络爬虫', '一', '一', '一', '一', '一');
INSERT INTO `week` VALUES (4, '数据分析与处理', '数据分析与处理', '一', '一', '一', '一', '一');
INSERT INTO `week` VALUES (5, 'Python数据可视化', 'Python数据可视化', '一', '一', '一', '一', '一');
INSERT INTO `week` VALUES (6, '一', '一', '一', '计算机网络技术运用', '计算机网络技术运用', '一', '一');
INSERT INTO `week` VALUES (7, '一', '一', '一', '网络爬虫', '网络爬虫', '一', '一');
INSERT INTO `week` VALUES (8, '一', '一', '一', '数据分析与处理', '数据分析与处理', '一', '一');
INSERT INTO `week` VALUES (9, '一', '一', '一', 'Python数据可视化', 'Python数据可视化', '一', '一');

SET FOREIGN_KEY_CHECKS = 1;
