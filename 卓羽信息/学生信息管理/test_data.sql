-- 学生信息管理系统测试数据
-- 创建日期：2023-06-01
-- 作者：系统开发团队

-- 使用数据库
USE student_management;

-- 清空表数据（如果需要重新导入）
-- 注意：虽然没有物理外键约束，但为了保持数据一致性，仍建议先删除子表数据，再删除父表数据
-- 禁用外键检查（对于没有物理外键的表结构，此设置不会产生实际影响，但保留以兼容可能的导入工具）
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE student;
TRUNCATE TABLE department;
SET FOREIGN_KEY_CHECKS = 1;

-- 插入学院数据
-- 计算机相关专业学院
INSERT INTO department (id, name) VALUES
(1, '计算机学院'),
(2, '电子信息学院'),
(3, '机械工程学院'),
(4, '经济管理学院'),
(5, '外国语学院');

-- 插入学生数据
-- 计算机学院学生
-- 计算机学院-男生样本
INSERT INTO student (student_no, name, gender, age, class_name, department_id, major, enrollment_time, photo_url) VALUES
('20210001', '张三', 1, 20, '计算机2101', 1, '计算机科学与技术', '2021-09-01', 'http://example.com/photos/1.jpg'),
('20210002', '李四', 1, 21, '计算机2101', 1, '计算机科学与技术', '2021-09-01', 'http://example.com/photos/2.jpg'),
('20210003', '王五', 1, 20, '计算机2102', 1, '软件工程', '2021-09-01', 'http://example.com/photos/3.jpg'),
('20210004', '赵六', 2, 19, '计算机2102', 1, '软件工程', '2021-09-01', 'http://example.com/photos/4.jpg'),
('20210005', '钱七', 2, 20, '计算机2103', 1, '人工智能', '2021-09-01', 'http://example.com/photos/5.jpg');

-- 电子信息学院学生
INSERT INTO student (student_no, name, gender, age, class_name, department_id, major, enrollment_time, photo_url) VALUES
('20210006', '孙八', 1, 21, '电子2101', 2, '电子信息工程', '2021-09-01', 'http://example.com/photos/6.jpg'), -- 电子信息学院-男生样本
('20210007', '周九', 2, 20, '电子2101', 2, '电子信息工程', '2021-09-01', 'http://example.com/photos/7.jpg'), -- 电子信息学院-女生样本
('20210008', '吴十', 1, 22, '电子2102', 2, '通信工程', '2021-09-01', 'http://example.com/photos/8.jpg'); -- 电子信息学院-男生样本

-- 机械工程学院学生
INSERT INTO student (student_no, name, gender, age, class_name, department_id, major, enrollment_time, photo_url) VALUES
('20210009', '郑十一', 1, 21, '机械2101', 3, '机械设计制造及自动化', '2021-09-01', 'http://example.com/photos/9.jpg'), -- 机械工程学院-男生样本
('20210010', '王十二', 2, 20, '机械2101', 3, '机械设计制造及自动化', '2021-09-01', 'http://example.com/photos/10.jpg'); -- 机械工程学院-女生样本

-- 经济管理学院学生
INSERT INTO student (student_no, name, gender, age, class_name, department_id, major, enrollment_time, photo_url) VALUES
('20210011', '李十三', 2, 19, '经管2101', 4, '工商管理', '2021-09-01', 'http://example.com/photos/11.jpg'), -- 经济管理学院-女生样本
('20210012', '赵十四', 1, 20, '经管2102', 4, '市场营销', '2021-09-01', 'http://example.com/photos/12.jpg'); -- 经济管理学院-男生样本

-- 外国语学院学生
-- 外国语学院-女生样本
INSERT INTO student (student_no, name, gender, age, class_name, department_id, major, enrollment_time, photo_url) VALUES
('20210013', '钱十五', 2, 20, '外语2101', 5, '英语', '2021-09-01', 'http://example.com/photos/13.jpg');
-- 外国语学院-女生样本
INSERT INTO student (student_no, name, gender, age, class_name, department_id, major, enrollment_time, photo_url) VALUES
('20210014', '孙十六', 2, 19, '外语2102', 5, '日语', '2021-09-01', 'http://example.com/photos/14.jpg');
-- 外国语学院-男生样本
INSERT INTO student (student_no, name, gender, age, class_name, department_id, major, enrollment_time, photo_url) VALUES
('20210015', '周十七', 1, 21, '外语2102', 5, '日语', '2021-09-01', 'http://example.com/photos/15.jpg');

-- 添加不同入学年份的学生
-- 2022级-计算机学院-男生样本
INSERT INTO student (student_no, name, gender, age, class_name, department_id, major, enrollment_time, photo_url) VALUES
('20220001', '吴十八', 1, 19, '计算机2201', 1, '计算机科学与技术', '2022-09-01', 'http://example.com/photos/16.jpg');
-- 2022级-计算机学院-女生样本
INSERT INTO student (student_no, name, gender, age, class_name, department_id, major, enrollment_time, photo_url) VALUES
('20220002', '郑十九', 2, 18, '计算机2201', 1, '计算机科学与技术', '2022-09-01', 'http://example.com/photos/17.jpg');
-- 2023级-计算机学院-男生样本
INSERT INTO student (student_no, name, gender, age, class_name, department_id, major, enrollment_time, photo_url) VALUES
('20230001', '王二十', 1, 18, '计算机2301', 1, '计算机科学与技术', '2023-09-01', 'http://example.com/photos/18.jpg');
-- 2023级-计算机学院-女生样本
INSERT INTO student (student_no, name, gender, age, class_name, department_id, major, enrollment_time, photo_url) VALUES
('20230002', '李二十一', 2, 17, '计算机2301', 1, '计算机科学与技术', '2023-09-01', 'http://example.com/photos/19.jpg');