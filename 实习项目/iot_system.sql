-- MySQL dump 10.13  Distrib 8.4.2, for Win64 (x86_64)

/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS = @@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION = @@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;

--
-- 清理现有表
--
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `alarm_record`;
DROP TABLE IF EXISTS `device_data`;
DROP TABLE IF EXISTS `device_threshold`;
DROP TABLE IF EXISTS `device`;
DROP TABLE IF EXISTS `device_type`;
DROP TABLE IF EXISTS `user`;
SET FOREIGN_KEY_CHECKS = 1;

--
-- 核心表结构
--

-- 用户表
CREATE TABLE `user`
(
    `id`          bigint       NOT NULL AUTO_INCREMENT COMMENT '主键',
    `username`    varchar(50)  NOT NULL COMMENT '用户名',
    `password`    varchar(100) NOT NULL COMMENT '密码',
    `email`       varchar(100) NOT NULL COMMENT '电子邮箱',
    `phone`       varchar(20) DEFAULT NULL COMMENT '手机号',
    `status`      tinyint     DEFAULT '1' COMMENT '状态：1-正常，0-禁用',
    `role`        tinyint     DEFAULT '1' COMMENT '角色：0-管理员，1-普通用户',
    `create_time` datetime    DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_username` (`username`),
    UNIQUE KEY `uk_email` (`email`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT ='用户表';

-- 设备类型表
CREATE TABLE `device_type`
(
    `id`                bigint      NOT NULL AUTO_INCREMENT COMMENT '主键',
    `type_name`         varchar(50) NOT NULL COMMENT '设备类型名称',
    `code_prefix`       varchar(10) NOT NULL COMMENT '设备编号前缀',
    `measurable_values` json                 DEFAULT NULL COMMENT '可测量的值及其描述',
    `status`            tinyint     NOT NULL DEFAULT '1' COMMENT '状态：1-启用，0-禁用',
    `create_time`       datetime             DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time`       datetime             DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_type_name` (`type_name`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT ='设备类型表';

-- 设备表，移除物理外键
CREATE TABLE `device`
(
    `id`               bigint       NOT NULL AUTO_INCREMENT COMMENT '主键',
    `device_name`      varchar(100) NOT NULL COMMENT '设备名称',
    `device_code`      varchar(50)  NOT NULL COMMENT '设备编号',
    `type_id`          bigint       NOT NULL COMMENT '设备类型ID',
    `status`           tinyint      NOT NULL DEFAULT '0' COMMENT '设备状态：0-离线，1-在线',
    `location`         varchar(200)          DEFAULT NULL COMMENT '设备位置',
    `last_online_time` datetime              DEFAULT NULL COMMENT '最后在线时间',
    `owner_id`         bigint                DEFAULT NULL COMMENT '设备负责人ID',
    `department`       varchar(50)           DEFAULT NULL COMMENT '所属部门',
    `create_time`      datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time`      datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_device_code` (`device_code`),
    KEY `idx_type_status` (`type_id`, `status`),
    KEY `idx_owner` (`owner_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT ='设备表';

-- 设备数据表（优化分区和压缩）
CREATE TABLE `device_data`
(
    `id`           bigint   NOT NULL AUTO_INCREMENT COMMENT '主键',
    `device_id`    bigint   NOT NULL COMMENT '设备ID',
    `data_value`   json     NOT NULL COMMENT '数据值(JSON格式)',
    `collect_time` datetime NOT NULL COMMENT '采集时间',
    `create_time`  datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`, `collect_time`),
    KEY `idx_device_time` (`device_id`, `collect_time`),
    KEY `idx_collect_time` (`collect_time`)
) ENGINE = InnoDB
  ROW_FORMAT = COMPRESSED
  KEY_BLOCK_SIZE = 8
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
    COMMENT ='设备数据'
    PARTITION BY RANGE (TO_DAYS(collect_time)) (
        PARTITION p_future VALUES LESS THAN MAXVALUE
        );

-- 设备阈值表，移除物理外键
CREATE TABLE `device_threshold`
(
    `id`          bigint      NOT NULL AUTO_INCREMENT COMMENT '主键',
    `device_id`   bigint      NOT NULL COMMENT '设备ID',
    `metric_key`  varchar(50) NOT NULL COMMENT '指标键名',
    `min_value`   decimal(10, 2)       DEFAULT NULL COMMENT '最小阈值',
    `max_value`   decimal(10, 2)       DEFAULT NULL COMMENT '最大阈值',
    `alarm_level` tinyint     NOT NULL DEFAULT 1 COMMENT '告警级别：1-一般，2-重要，3-紧急',
    `status`      tinyint     NOT NULL DEFAULT 1 COMMENT '状态：1-启用，0-禁用',
    `create_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_device_metric` (`device_id`, `metric_key`),
    KEY `idx_device_status` (`device_id`, `status`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT ='设备阈值配置';

-- 告警记录表，移除物理外键
CREATE TABLE `alarm_record`
(
    `id`             bigint         NOT NULL AUTO_INCREMENT COMMENT '主键',
    `device_id`      bigint         NOT NULL COMMENT '设备ID',
    `threshold_id`   bigint         NOT NULL COMMENT '触发的阈值ID',
    `alarm_value`    decimal(10, 2) NOT NULL COMMENT '告警时的值',
    `alarm_time`     datetime       NOT NULL COMMENT '告警时间',
    `status`         tinyint        NOT NULL DEFAULT 0 COMMENT '状态：0-未处理，1-已处理',
    `handle_time`    datetime                DEFAULT NULL COMMENT '处理时间',
    `handle_user_id` bigint                  DEFAULT NULL COMMENT '处理人ID',
    `handle_desc`    varchar(500)            DEFAULT NULL COMMENT '处理说明',
    `create_time`    datetime       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time`    datetime       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`),
    KEY `idx_device_time` (`device_id`, `alarm_time`),
    KEY `idx_threshold` (`threshold_id`),
    KEY `idx_handler` (`handle_user_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT ='告警记录';

--
-- 初始数据
--

-- 初始化管理员账号
INSERT INTO `user` (`username`, `password`, `email`, `role`)
VALUES ('admin', '$2a$10$N.ZOn9G6/YLhy6r1sV67h.KQWqM4CM/n16PDACEPeOjt0h3DEMJnO', 'admin@example.com', 0);

-- 设备类型数据
INSERT INTO `device_type` (`id`, `type_name`, `code_prefix`, `measurable_values`, `status`)
VALUES (1, '温湿度传感器', 'TH', '{
  "humidity": "湿度(%RH)",
  "temperature": "温度(°C)"
}', 1),
       (2, '空气质量检测器', 'AQ', '{
         "co2": "二氧化碳(ppm)",
         "pm25": "PM2.5(μg/m³)"
       }', 1),
       (3, '水质监测器', 'WQ', '{
         "ph": "pH值",
         "turbidity": "浊度(NTU)"
       }', 1),
       (4, '光照传感器', 'LI', '{
         "illuminance": "光照度(lux)"
       }', 1),
       (5, '噪声检测器', 'NS', '{
         "noise": "噪声(dB)"
       }', 1);

-- 设备数据
INSERT INTO `device` (`id`, `device_name`, `device_code`, `type_id`, `status`)
VALUES (1, '实验室温湿度计1', 'TH001', 1, 1),
       (2, '实验室温湿度计2', 'TH002', 1, 1),
       (3, '办公室温湿度计1', 'TH003', 1, 1),
       (4, '会议室空气检测1', 'AQ001', 2, 1),
       (5, '会议室空气检测2', 'AQ002', 2, 0),
       (6, '实验室水质监测1', 'WQ001', 3, 1),
       (7, '实验室水质监测2', 'WQ002', 3, 1),
       (8, '室���光照1', 'LI001', 4, 1),
       (9, '室外光照2', 'LI002', 4, 0),
       (10, '工厂区噪声1', 'NS001', 5, 1);

-- 设备数据
INSERT INTO `device_data` (`device_id`, `data_value`, `collect_time`)
VALUES
-- 温湿度传感器数据
(1, '{
  "temperature": 23.50,
  "humidity": 45.20
}', '2024-12-23 10:00:00'),
(1, '{
  "temperature": 24.10,
  "humidity": 46.50
}', '2024-12-23 10:15:00'),
(2, '{
  "temperature": 22.80,
  "humidity": 44.80
}', '2024-12-23 10:00:00'),
(3, '{
  "temperature": 25.10,
  "humidity": 48.20
}', '2024-12-23 10:00:00'),

-- 空气质量检测器数据
(4, '{
  "pm25": 75.00,
  "co2": 850.00
}', '2024-12-23 10:00:00'),
(4, '{
  "pm25": 78.50,
  "co2": 920.00
}', '2024-12-23 10:15:00'),
(5, '{
  "pm25": 65.20,
  "co2": 780.00
}', '2024-12-23 10:00:00'),
(5, '{
  "pm25": 68.30,
  "co2": 800.00
}', '2024-12-23 10:15:00'),

-- 水质监测器数据
(6, '{
  "ph": 7.50,
  "turbidity": 5.20
}', '2024-12-23 10:00:00'),
(6, '{
  "ph": 7.80,
  "turbidity": 6.50
}', '2024-12-23 10:15:00'),
(7, '{
  "ph": 7.20,
  "turbidity": 4.80
}', '2024-12-23 10:00:00'),
(7, '{
  "ph": 7.40,
  "turbidity": 5.10
}', '2024-12-23 10:15:00'),

-- 光照传感器数据
(8, '{
  "illuminance": 45000.00
}', '2024-12-23 10:00:00'),
(8, '{
  "illuminance": 48000.00
}', '2024-12-23 10:15:00'),
(9, '{
  "illuminance": 42000.00
}', '2024-12-23 10:00:00'),
(9, '{
  "illuminance": 44000.00
}', '2024-12-23 10:15:00'),

-- 噪声检测器数据
(10, '{
  "noise": 65.50
}', '2024-12-23 10:00:00'),
(10, '{
  "noise": 68.20
}', '2024-12-23 10:15:00'),
(10, '{
  "noise": 70.10
}', '2024-12-23 10:30:00'),
(10, '{
  "noise": 67.80
}', '2024-12-23 10:45:00');

-- 设备阈值配置
INSERT INTO `device_threshold` (`device_id`, `metric_key`, `min_value`, `max_value`, `alarm_level`, `status`)
VALUES (1, 'temperature', 15.00, 30.00, 1, 1),
       (1, 'humidity', NULL, 70.00, 1, 1),
       (4, 'pm25', NULL, 75.00, 2, 1),
       (4, 'co2', NULL, 1000.00, 1, 1),
       (6, 'ph', 6.50, 8.50, 2, 1),
       (6, 'turbidity', NULL, 10.00, 1, 1);

-- 告警记录
INSERT INTO `alarm_record` (`device_id`, `threshold_id`, `alarm_value`, `alarm_time`, `status`)
VALUES (1, 1, 31.20, '2024-12-23 18:55:57', 0),
       (2, 2, 75.50, '2024-12-23 18:55:57', 1),
       (4, 3, 85.00, '2024-12-23 18:55:57', 0),
       (6, 5, 9.20, '2024-12-23 18:55:57', 1);

--
-- 视图定义
--

-- 设备最新数据视图
CREATE OR REPLACE VIEW v_device_latest_data AS
SELECT d.id                 as device_id,
       d.device_name,
       d.device_code,
       d.location,
       d.status             as device_status,
       dt.type_name,
       dt.measurable_values as metrics_config,
       dd.data_value        as latest_data,
       dd.collect_time      as latest_collect_time
FROM device d
         JOIN device_type dt ON dt.id = d.type_id
         LEFT JOIN (SELECT device_id,
                           data_value,
                           collect_time,
                           ROW_NUMBER() OVER (PARTITION BY device_id ORDER BY collect_time DESC) as rn
                    FROM device_data) dd ON dd.device_id = d.id AND dd.rn = 1;

-- 设备小时统计数据视图
CREATE OR REPLACE VIEW v_device_hourly_stats AS
WITH metric_values AS (SELECT dd.device_id,
                              d.device_name,
                              dt.type_name,
                              DATE_FORMAT(dd.collect_time, '%Y-%m-%d %H:00:00')                                as stat_hour,
                              jt.metric_key,
                              CAST(JSON_EXTRACT(dd.data_value, CONCAT('$.', jt.metric_key)) AS DECIMAL(10, 2)) as metric_value
                       FROM device_data dd
                                JOIN device d ON d.id = dd.device_id
                                JOIN device_type dt ON dt.id = d.type_id
                                CROSS JOIN JSON_TABLE(
                               JSON_KEYS(dd.data_value),
                               '$[*]' COLUMNS (metric_key VARCHAR(50) PATH '$')
                                           ) as jt),
     metric_stats AS (SELECT device_id,
                             device_name,
                             type_name,
                             stat_hour,
                             metric_key,
                             MIN(metric_value)           as min_value,
                             MAX(metric_value)           as max_value,
                             ROUND(AVG(metric_value), 2) as avg_value,
                             COUNT(*)                    as count_value
                      FROM metric_values
                      GROUP BY device_id,
                               device_name,
                               type_name,
                               stat_hour,
                               metric_key)
SELECT device_id,
       device_name,
       type_name,
       stat_hour,
       JSON_OBJECTAGG(
               metric_key,
               JSON_OBJECT(
                       'min', min_value,
                       'max', max_value,
                       'avg', avg_value,
                       'count', count_value
               )
       ) as stats
FROM metric_stats
GROUP BY device_id,
         device_name,
         type_name,
         stat_hour;

-- 设备告警统计视图
CREATE OR REPLACE VIEW v_device_alarm_stats AS
WITH alarm_details AS (SELECT d.id      as device_id,
                              d.device_name,
                              d.device_code,
                              dt.type_name,
                              ar.status as alarm_status,
                              ar.alarm_time,
                              dth.metric_key,
                              ar.alarm_value
                       FROM device d
                                JOIN device_type dt ON dt.id = d.type_id
                                LEFT JOIN device_threshold dth ON dth.device_id = d.id
                                LEFT JOIN alarm_record ar ON ar.threshold_id = dth.id
                       WHERE ar.alarm_time >= DATE_SUB(NOW(), INTERVAL 24 HOUR))
SELECT device_id,
       device_name,
       device_code,
       type_name,
       COUNT(CASE WHEN alarm_status = 0 THEN 1 END) as unhandled_alarms,
       COUNT(CASE WHEN alarm_status = 1 THEN 1 END) as handled_alarms,
       MAX(alarm_time)                              as last_alarm_time,
       JSON_ARRAYAGG(
               JSON_OBJECT(
                       'alarm_time', alarm_time,
                       'metric_key', metric_key,
                       'alarm_value', alarm_value,
                       'status', alarm_status
               )
       )                                            as recent_alarms
FROM alarm_details
GROUP BY device_id,
         device_name,
         device_code,
         type_name;

-- 设备图表数据视图
CREATE OR REPLACE VIEW v_device_chart_data AS
WITH metric_data AS (SELECT dd.device_id,
                            d.device_name,
                            dt.type_name,
                            dd.collect_time,
                            jt.metric_key,
                            CAST(JSON_EXTRACT(dd.data_value, CONCAT('$.', jt.metric_key)) AS DECIMAL(10, 2)) as metric_value,
                            JSON_EXTRACT(dt.measurable_values, CONCAT('$.', jt.metric_key))                  as metric_unit
                     FROM device_data dd
                              JOIN device d ON d.id = dd.device_id
                              JOIN device_type dt ON dt.id = d.type_id
                              CROSS JOIN JSON_TABLE(
                             JSON_KEYS(dd.data_value),
                             '$[*]' COLUMNS (metric_key VARCHAR(50) PATH '$')
                                         ) as jt
                     WHERE dd.collect_time >= DATE_SUB(NOW(), INTERVAL 24 HOUR))
SELECT device_id,
       device_name,
       type_name,
       metric_key,
       metric_unit,
       JSON_ARRAYAGG(
               JSON_OBJECT(
                       'time', collect_time,
                       'value', metric_value
               )
       ) as chart_data
FROM metric_data
GROUP BY device_id,
         device_name,
         type_name,
         metric_key,
         metric_unit;

-- 添加触发器来保证数据一致性
DELIMITER //

-- 设备类型检查触发器
CREATE TRIGGER device_before_insert
    BEFORE INSERT
    ON device
    FOR EACH ROW
BEGIN
    DECLARE type_exists INT;
    SELECT COUNT(*) INTO type_exists FROM device_type WHERE id = NEW.type_id;
    IF type_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid device_type_id';
    END IF;
END //

-- 设备存在性检查触发器
CREATE TRIGGER device_threshold_before_insert
    BEFORE INSERT
    ON device_threshold
    FOR EACH ROW
BEGIN
    DECLARE device_exists INT;
    SELECT COUNT(*) INTO device_exists FROM device WHERE id = NEW.device_id;
    IF device_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid device_id';
    END IF;
END //

-- 告警记录检查触发器
CREATE TRIGGER alarm_record_before_insert
    BEFORE INSERT
    ON alarm_record
    FOR EACH ROW
BEGIN
    DECLARE device_exists INT;
    DECLARE threshold_exists INT;
    DECLARE user_exists INT;

    SELECT COUNT(*) INTO device_exists FROM device WHERE id = NEW.device_id;
    IF device_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid device_id';
    END IF;

    SELECT COUNT(*) INTO threshold_exists FROM device_threshold WHERE id = NEW.threshold_id;
    IF threshold_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid threshold_id';
    END IF;

    IF NEW.handle_user_id IS NOT NULL THEN
        SELECT COUNT(*) INTO user_exists FROM user WHERE id = NEW.handle_user_id;
        IF user_exists = 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid handle_user_id';
        END IF;
    END IF;
END //

DELIMITER ;

/*!40103 SET TIME_ZONE = @OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE = @OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS = @OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION = @OLD_COLLATION_CONNECTION */;
