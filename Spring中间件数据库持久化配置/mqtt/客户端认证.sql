CREATE TABLE `mqtt_user`
(
    `id`            int(11) unsigned NOT NULL AUTO_INCREMENT,
    `username`      varchar(100) DEFAULT NULL,
    `password_hash` varchar(100) DEFAULT NULL,
    `salt`          varchar(35)  DEFAULT NULL,
    `is_superuser`  tinyint(1)   DEFAULT '0',
    `created`       datetime     DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `mqtt_username` (`username`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 3
  DEFAULT CHARSET = utf8mb4;


SELECT password_hash, salt
FROM mqtt_user.mqtt_user
where username = ${username}
LIMIT 1;

INSERT INTO `mqtt_user`.`mqtt_user`(`id`, `username`, `password_hash`, `salt`, `is_superuser`, `created`)
VALUES (1, 'encounter', SHA2(concat('encounter', 'dx'), 256), 'dx', 0, NULL);

# 查看密码
select SHA2(concat('encounter', 'dx'), 256);