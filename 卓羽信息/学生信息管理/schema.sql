-- 学生信息管理系统数据库表结构
-- 创建日期：2023-06-01
-- 作者：系统开发团队

-- 创建数据库
CREATE DATABASE IF NOT EXISTS student_management;

-- 使用数据库
USE student_management;

-- 学院表
-- 存储所有学院信息
CREATE TABLE IF NOT EXISTS department (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '学院ID，自增主键',
    name VARCHAR(50) NOT NULL COMMENT '学院名称，不允许为空',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) COMMENT='学院信息表';

-- 学生表
-- 存储所有学生的基本信息
CREATE TABLE IF NOT EXISTS student (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '学生ID，自增主键',
    student_no VARCHAR(20) NOT NULL UNIQUE COMMENT '学号，唯一标识，不允许为空',
    name VARCHAR(50) NOT NULL COMMENT '学生姓名，不允许为空',
    gender TINYINT NOT NULL DEFAULT 1 COMMENT '性别：1-男，2-女',
    age INT COMMENT '年龄',
    class_name VARCHAR(50) COMMENT '班级名称',
    department_id INT NOT NULL COMMENT '所属学院ID，在Java代码中与department表的id字段建立逻辑关联',
    major VARCHAR(50) COMMENT '专业名称',
    enrollment_time DATE COMMENT '入学时间',
    photo_url VARCHAR(255) COMMENT '照片URL地址',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) COMMENT='学生信息表，与学院表的逻辑关联在Java代码中实现';

-- 创建索引
-- 学生表索引
CREATE INDEX idx_student_department ON student(department_id) COMMENT '学院ID索引，用于按学院查询';
CREATE INDEX idx_student_enrollment ON student(enrollment_time) COMMENT '入学时间索引，用于按入学时间查询';
CREATE INDEX idx_student_name ON student(name) COMMENT '姓名索引，用于按姓名查询';