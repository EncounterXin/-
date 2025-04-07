-- MySQL dump 10.13  Distrib 8.4.4, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: student_management
-- ------------------------------------------------------
-- Server version	8.4.4

/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS = @@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION = @@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE = @@TIME_ZONE */;
/*!40103 SET TIME_ZONE = '+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES = @@SQL_NOTES, SQL_NOTES = 0 */;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department`
(
    `id`          int         NOT NULL AUTO_INCREMENT COMMENT '学院ID，自增主键',
    `name`        varchar(50) NOT NULL COMMENT '学院名称，不允许为空',
    `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 19
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT ='学院信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department`
    DISABLE KEYS */;
INSERT INTO `department` (`id`, `name`, `create_time`, `update_time`)
VALUES (1, '计算机学院', '2025-03-24 12:11:00', '2025-03-25 20:27:46'),
       (2, '电子信息学院', '2025-03-24 12:11:00', '2025-03-25 20:27:46'),
       (3, '机械工程学院', '2025-03-24 12:11:00', '2025-03-25 20:27:46'),
       (4, '经济管理学院', '2025-03-24 12:11:00', '2025-03-25 20:27:46'),
       (5, '外国语学院', '2025-03-24 12:11:00', '2025-03-25 20:27:46'),
       (6, '土木工程学院', '2025-03-26 01:54:34', '2025-03-26 03:38:00');
/*!40000 ALTER TABLE `department`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student`
(
    `id`              int         NOT NULL AUTO_INCREMENT COMMENT '学生ID，自增主键',
    `student_no`      varchar(20) NOT NULL COMMENT '学号，唯一标识，不允许为空',
    `name`            varchar(50) NOT NULL COMMENT '学生姓名，不允许为空',
    `gender`          tinyint     NOT NULL DEFAULT '1' COMMENT '性别：1-男，2-女',
    `age`             int                  DEFAULT NULL COMMENT '年龄',
    `class_name`      varchar(50)          DEFAULT NULL COMMENT '班级名称',
    `department_id`   int         NOT NULL COMMENT '所属学院ID',
    `major`           varchar(50)          DEFAULT NULL COMMENT '专业名称',
    `enrollment_time` date                 DEFAULT NULL COMMENT '入学时间',
    `photo_url`       varchar(255)         DEFAULT NULL COMMENT '照片URL地址',
    `create_time`     datetime             DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time`     datetime             DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `student_no` (`student_no`),
    KEY `idx_student_department` (`department_id`) COMMENT '学院ID索引，用于按学院查询',
    KEY `idx_student_enrollment` (`enrollment_time`) COMMENT '入学时间索引，用于按入学时间查询',
    KEY `idx_student_name` (`name`) COMMENT '姓名索引，用于按姓名查询'
) ENGINE = InnoDB
  AUTO_INCREMENT = 34
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT ='学生信息表，与学院表的逻辑关联在Java代码中实现';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student`
    DISABLE KEYS */;
INSERT INTO `student` (`id`, `student_no`, `name`, `gender`, `age`, `class_name`, `department_id`, `major`,
                       `enrollment_time`, `photo_url`, `create_time`, `update_time`)
VALUES (1, '20210001', '张三', 1, 20, '计算机2101', 1, '计算机科学与技术', '2021-09-01',
        'http://example.com/photos/1.jpg', '2025-03-24 12:11:00', '2025-03-24 12:11:00'),
       (2, '20210002', '李四', 1, 21, '计算机2101', 1, '计算机科学与技术', '2021-09-01',
        'http://example.com/photos/2.jpg', '2025-03-24 12:11:00', '2025-03-24 12:11:00'),
       (3, '20210003', '王五', 1, 20, '计算机2102', 1, '软件工程', '2021-09-01', 'http://example.com/photos/3.jpg',
        '2025-03-24 12:11:00', '2025-03-24 12:11:00'),
       (4, '20210004', '赵六', 2, 19, '计算机2102', 1, '软件工程', '2021-09-01', 'http://example.com/photos/4.jpg',
        '2025-03-24 12:11:00', '2025-03-24 12:11:00'),
       (5, '20210005', '钱七', 2, 20, '计算机2103', 1, '人工智能', '2021-09-01', 'http://example.com/photos/5.jpg',
        '2025-03-24 12:11:00', '2025-03-24 12:11:00'),
       (6, '20210006', '孙八', 1, 21, '电子2101', 2, '电子信息工程', '2021-09-01', 'http://example.com/photos/6.jpg',
        '2025-03-24 12:11:00', '2025-03-24 12:11:00'),
       (7, '20210007', '周九', 2, 20, '电子2101', 2, '电子信息工程', '2021-09-01', 'http://example.com/photos/7.jpg',
        '2025-03-24 12:11:00', '2025-03-24 12:11:00'),
       (8, '20210008', '吴十', 1, 22, '电子2102', 2, '通信工程', '2021-09-01', 'http://example.com/photos/8.jpg',
        '2025-03-24 12:11:00', '2025-03-24 12:11:00'),
       (9, '20210009', '郑十一', 1, 21, '机械2101', 3, '机械设计制造及自动化', '2021-09-01',
        'http://example.com/photos/9.jpg', '2025-03-24 12:11:00', '2025-03-24 12:11:00'),
       (10, '20210010', '王十二', 2, 20, '机械2101', 3, '机械设计制造及自动化', '2021-09-01',
        'http://example.com/photos/10.jpg', '2025-03-24 12:11:00', '2025-03-24 12:11:00'),
       (11, '20210011', '李十三', 2, 19, '经管2101', 4, '工商管理', '2021-09-01', 'http://example.com/photos/11.jpg',
        '2025-03-24 12:11:00', '2025-03-24 12:11:00'),
       (12, '20210012', '赵十四', 1, 20, '经管2102', 4, '市场营销', '2021-09-01', 'http://example.com/photos/12.jpg',
        '2025-03-24 12:11:00', '2025-03-24 12:11:00'),
       (13, '20210013', '钱十五', 2, 20, '外语2101', 5, '英语', '2021-09-01', 'http://example.com/photos/13.jpg',
        '2025-03-24 12:11:00', '2025-03-24 12:11:00'),
       (14, '20210014', '孙十六', 2, 19, '外语2102', 5, '日语', '2021-09-01', 'http://example.com/photos/14.jpg',
        '2025-03-24 12:11:00', '2025-03-24 12:11:00'),
       (15, '20210015', '周十七', 1, 21, '外语2102', 5, '日语', '2021-09-01', 'http://example.com/photos/15.jpg',
        '2025-03-24 12:11:00', '2025-03-24 12:11:00'),
       (16, '20220001', '吴十八', 1, 19, '计算机2201', 1, '计算机科学与技术', '2022-09-01',
        'http://example.com/photos/16.jpg', '2025-03-24 12:11:00', '2025-03-24 12:11:00'),
       (17, '20220002', '郑十九', 2, 18, '计算机2201', 1, '计算机科学与技术', '2022-09-01',
        'http://example.com/photos/17.jpg', '2025-03-24 12:11:00', '2025-03-24 12:11:00'),
       (18, '20230001', '王二十', 1, 18, '计算机2301', 1, '计算机科学与技术', '2023-09-01',
        'https://encounter-personal.oss-cn-beijing.aliyuncs.com/zhuoyu/student/f6b9e403-eb46-4866-8d68-594d2a502d8c.jpg',
        '2025-03-24 12:11:00', '2025-03-25 19:53:29'),
       (30, 'asdq', 'asd', 1, 18, 'sa', 11111, 'sad', '2025-03-25',
        'https://encounter-personal.oss-cn-beijing.aliyuncs.com/zhuoyu/student/e7b9ffb0-d264-438d-b485-8f1b1ab71daa.jpg',
        '2025-03-26 08:14:10', '2025-03-26 08:14:10'),
       (31, 'zxcv', 'zxcva', 1, 18, 'sada', 55555, 'asdq', '2025-03-20',
        'https://encounter-personal.oss-cn-beijing.aliyuncs.com/zhuoyu/student/da5dbe7c-af05-4217-9381-d8b811b785f1.jpg',
        '2025-03-26 08:16:22', '2025-03-26 08:16:22'),
       (32, 'qweqwea', 'ceshi', 1, 18, 'asd', 11111, 'dc', '2025-02-25',
        'https://encounter-personal.oss-cn-beijing.aliyuncs.com/zhuoyu/student/c8bea5fe-5f31-43f2-b6cb-90c1f402679b.jpg',
        '2025-03-26 10:20:26', '2025-03-26 10:20:26'),
       (33, '22233', '测试', 1, 18, 'asd', 11111, 'sad', '2025-03-07',
        'https://encounter-personal.oss-cn-beijing.aliyuncs.com/zhuoyu/student/bb87b907-38c2-4467-b465-20965b58165b.jpg',
        '2025-03-26 10:24:11', '2025-03-26 10:24:11');
/*!40000 ALTER TABLE `student`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_ws`
--

DROP TABLE IF EXISTS `student_ws`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_ws`
(
    `id`              int         NOT NULL AUTO_INCREMENT COMMENT '主键',
    `student_no`      varchar(20) NOT NULL COMMENT '学号',
    `name`            varchar(50) NOT NULL COMMENT '姓名',
    `gender`          int         NOT NULL COMMENT '性别',
    `age`             int          DEFAULT NULL COMMENT '年龄',
    `class_name`      varchar(50)  DEFAULT NULL COMMENT '班名',
    `department_id`   int         NOT NULL COMMENT '学院id',
    `enrollment_time` date         DEFAULT NULL COMMENT '入学日期',
    `major`           varchar(50)  DEFAULT NULL COMMENT '专业',
    `photo_url`       varchar(255) DEFAULT NULL COMMENT '照片',
    `create_time`     datetime     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time`     datetime     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `UK_iw38jacxlt7rqu9lkqaocuau8` (`student_no`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 4
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT ='ws';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_ws`
--

LOCK TABLES `student_ws` WRITE;
/*!40000 ALTER TABLE `student_ws`
    DISABLE KEYS */;
INSERT INTO `student_ws` (`id`, `student_no`, `name`, `gender`, `age`, `class_name`, `department_id`, `enrollment_time`,
                          `major`, `photo_url`, `create_time`, `update_time`)
VALUES (1, 'asdq', 'asd', 1, 18, 'sa', 11111, '2025-03-25', 'sad',
        'https://encounter-personal.oss-cn-beijing.aliyuncs.com/zhuoyu/student/e7b9ffb0-d264-438d-b485-8f1b1ab71daa.jpg',
        '2025-03-26 08:14:11', '2025-03-26 08:14:11'),
       (2, 'zxcv', 'zxcva', 1, 18, 'sada', 55555, '2025-03-20', 'asdq',
        'https://encounter-personal.oss-cn-beijing.aliyuncs.com/zhuoyu/student/da5dbe7c-af05-4217-9381-d8b811b785f1.jpg',
        '2025-03-26 08:16:22', '2025-03-26 08:16:22'),
       (3, '22233', '测试', 1, 18, 'asd', 11111, '2025-03-07', 'sad',
        'https://encounter-personal.oss-cn-beijing.aliyuncs.com/zhuoyu/student/bb87b907-38c2-4467-b465-20965b58165b.jpg',
        '2025-03-26 10:24:11', '2025-03-26 10:24:11');
/*!40000 ALTER TABLE `student_ws`
    ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE = @OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE = @OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS = @OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION = @OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES = @OLD_SQL_NOTES */;

-- Dump completed on 2025-03-27  2:19:49
