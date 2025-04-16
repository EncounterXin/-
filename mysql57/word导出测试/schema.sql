-- 创建数据库
CREATE DATABASE IF NOT EXISTS Cassell_Academy CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE Cassell_Academy;

-- 混血种用户表
CREATE TABLE IF NOT EXISTS bloodline_user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    code_name VARCHAR(50),
    bloodline_level VARCHAR(10) NOT NULL COMMENT '血统等级（A/B/S）',
    department VARCHAR(50) COMMENT '所属部门（狮心会/学生会/执行部等）',
    dragon_power INT COMMENT '龙血之力指数',
    language VARCHAR(100) COMMENT '掌握言灵',
    weapon VARCHAR(100) COMMENT '使用武器',
    register_date DATE COMMENT '入学日期',
    address VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 装备表
CREATE TABLE IF NOT EXISTS equipment (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL COMMENT '装备类别（灵刃/防具/药剂等）',
    power_level INT COMMENT '威力等级',
    price DECIMAL(10, 2) NOT NULL,
    create_date DATE COMMENT '锻造/制作日期',
    origin VARCHAR(100) COMMENT '来源（卡塞尔学院/日本皇室/秘党等）',
    element VARCHAR(50) COMMENT '元素属性（火/水/风/地/雷等）',
    special_effect TEXT COMMENT '特殊效果',
    blood_cost INT COMMENT '血统消耗',
    compatibility VARCHAR(50) COMMENT '适配血统（A/B/S/混血种/纯血龙族）'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 言灵表
CREATE TABLE IF NOT EXISTS dragon_language (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    element VARCHAR(50) COMMENT '元素属性',
    rank VARCHAR(10) NOT NULL COMMENT '言灵等级（S/A/B）',
    effect TEXT COMMENT '效果描述',
    energy_cost INT COMMENT '能量消耗',
    activation_key VARCHAR(100) COMMENT '启动咒文',
    origin_dragon VARCHAR(100) COMMENT '源龙',
    compatibility VARCHAR(50) COMMENT '血统兼容性'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 纯血龙族表
CREATE TABLE IF NOT EXISTS pureblood_dragon (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    origin_name VARCHAR(100) COMMENT '原始名称',
    element VARCHAR(50) COMMENT '元素属性',
    rank VARCHAR(50) NOT NULL COMMENT '等级（王级/皇级/君主级）',
    territory VARCHAR(255) COMMENT '领地/栖息地',
    appearance TEXT COMMENT '外观描述',
    power_index INT COMMENT '力量指数',
    special_ability TEXT COMMENT '特殊能力',
    status VARCHAR(20) NOT NULL COMMENT '状态（沉眠/活跃/死亡）',
    last_appearance DATE COMMENT '最后出现时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 以下是与龙族主题相关的核心表

-- 混血种-言灵关联表
CREATE TABLE IF NOT EXISTS bloodline_language (
    bloodline_user_id INT NOT NULL,
    dragon_language_id INT NOT NULL,
    mastery_level INT COMMENT '掌握程度（1-10）',
    unlock_date DATE COMMENT '觉醒日期',
    PRIMARY KEY (bloodline_user_id, dragon_language_id),
    FOREIGN KEY (bloodline_user_id) REFERENCES bloodline_user(id),
    FOREIGN KEY (dragon_language_id) REFERENCES dragon_language(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;