CREATE TABLE `sys_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` varchar(64) DEFAULT NULL COMMENT '操作用户ID',
  `username` varchar(50) DEFAULT NULL COMMENT '操作用户名',
  `operation` varchar(100) DEFAULT NULL COMMENT '操作描述',
  `operation_type` int(2) DEFAULT NULL COMMENT '操作类型',
  `method` varchar(200) DEFAULT NULL COMMENT '操作方法',
  `params` text DEFAULT NULL COMMENT '请求参数',
  `ip` varchar(50) DEFAULT NULL COMMENT '请求IP',
  `url` varchar(255) DEFAULT NULL COMMENT '请求URL',
  `cost_time` bigint(20) DEFAULT NULL COMMENT '请求耗时(毫秒)',
  `status` int(1) DEFAULT 1 COMMENT '操作结果（0:失败,1:成功）',
  `error_msg` varchar(2000) DEFAULT NULL COMMENT '错误消息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `module_name` varchar(100) DEFAULT NULL COMMENT '模块名称',
  PRIMARY KEY (`id`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统日志表';

CREATE TABLE `file_operation_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` varchar(64) DEFAULT NULL COMMENT '操作用户ID',
  `operation_type` int(2) DEFAULT NULL COMMENT '操作类型（1:扫描目录,2:分类文件,3:删除文件,4:重命名）',
  `operation_type_desc` varchar(100) DEFAULT NULL COMMENT '操作类型描述',
  `source_path` varchar(500) DEFAULT NULL COMMENT '源目录/文件路径',
  `target_path` varchar(500) DEFAULT NULL COMMENT '目标目录/文件路径',
  `file_count` int(11) DEFAULT 0 COMMENT '处理文件数量',
  `status` int(1) DEFAULT 1 COMMENT '操作结果（0:失败,1:成功）',
  `error_msg` varchar(2000) DEFAULT NULL COMMENT '错误消息',
  `ip` varchar(50) DEFAULT NULL COMMENT '操作IP',
  `cost_time` bigint(20) DEFAULT NULL COMMENT '操作耗时(毫秒)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `details` text DEFAULT NULL COMMENT '详细信息（JSON格式）',
  PRIMARY KEY (`id`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文件操作日志表';