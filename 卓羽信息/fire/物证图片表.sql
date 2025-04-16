# 旧表

create table evidence_info_img
(
    id          bigint auto_increment comment 'id'
        primary key,
    evidence_id varchar(20)  null,
    img1        varchar(255) null comment '第一张图片',
    img2        varchar(255) null comment '第二张图片',
    img3        varchar(255) null comment '第三张图片',
    img4        varchar(255) null comment '第四张图片'
)
    comment '图片';

#  新表
create table evidence_info_img
(
    id          bigint auto_increment comment '主键'
        primary key,
    evidence_id varchar(20)                         not null comment '物证id',
    img         varchar(255)                        not null comment '图片路径',
    upload_time timestamp default CURRENT_TIMESTAMP null comment '上传时间',
    description varchar(255)                        null comment '图片描述（作为拓展字段，可选）'
)
    comment '图片';

