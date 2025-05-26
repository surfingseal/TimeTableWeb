create database timetable;
use timetable;

create table student (
	id int auto_increment,
    name varchar(50) not null,
    school varchar(255) not null,
    email varchar(255) not null,
    gender char(1) not null,
    major char(255) not null,
    primary key (id)
);

desc student;

insert into student (name, school, email, gender, major)
values ('김민수', '숭실대', 'minsu.kim@example.com', 'M', '컴퓨터공학');

insert into student (name, email, school, gender, major)
values ('이서연', 'seoyeon.lee@example.com', '숭실대', 'F', '경영학');

INSERT INTO student (name, school, email, gender, major) VALUES
('박지훈', '숭실대', 'jihoon.park@example.com', 'M', '전자공학'),
('최유진', '숭실대', 'yujin.choi@example.com', 'F', '영문학'),
('정우성', '숭실대', 'woosung.jung@example.com', 'M', '기계공학'),
('한지민', '숭실대', 'jimin.han@example.com', 'F', '심리학'),
('오세훈', '숭실대', 'sehoon.oh@example.com', 'M', '정치외교학'),
('강하늘', '숭실대', 'haneul.kang@example.com', 'M', '경제학'),
('배수지', '숭실대', 'suji.bae@example.com', 'F', '교육학'),
('서강준', '숭실대', 'gangjun.seo@example.com', 'M', '물리학');

CREATE TABLE student_schedule (
    student_id INT NOT NULL,
    day_of_week VARCHAR(10) NOT NULL,     -- 예: '월요일', '화요일'
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,           
    FOREIGN KEY (student_id) REFERENCES student(id)
);

INSERT INTO student_schedule (student_id, day_of_week, start_time, end_time) VALUES
-- 김민수 (id=1)
(1, '월요일', '09:00:00', '11:00:00'),
(1, '수요일', '11:00:00', '12:00:00'),


-- 이서연 (id=2)
(2, '화요일', '10:00:00', '11:00:00'),
(2, '목요일', '13:00:00', '14:00:00'),
(2, '금요일', '09:00:00', '10:00:00'),

-- 박지훈 (id=3)
(3, '월요일', '14:00:00', '15:00:00'),
(3, '수요일', '14:00:00', '15:00:00'),

-- 최유진 (id=4)
(4, '화요일', '09:00:00', '10:00:00'),
(4, '수요일', '13:00:00', '16:00:00'),
(4, '목요일', '09:00:00', '10:00:00'),
(4, '금요일', '11:00:00', '12:00:00'),

-- 정우성 (id=5)
(5, '월요일', '10:00:00', '11:00:00'),
(5, '수요일', '13:00:00', '14:00:00'),

-- 한지민 (id=6)
(6, '화요일', '14:00:00', '15:00:00'),
(6, '목요일', '14:00:00', '15:00:00'),
(6, '금요일', '13:00:00', '14:00:00'),

-- 오세훈 (id=7)
(7, '월요일', '15:00:00', '16:00:00'),
(7, '수요일', '15:00:00', '16:00:00'),

-- 강하늘 (id=8)
(8, '화요일', '11:00:00', '12:00:00'),
(8, '목요일', '11:00:00', '12:00:00'),
(8, '금요일', '15:00:00', '16:00:00'),

-- 배수지 (id=9)
(9, '월요일', '13:00:00', '14:00:00'),
(9, '수요일', '09:00:00', '10:00:00'),

-- 서강준 (id=10)
(10, '화요일', '13:00:00', '14:00:00'),
(10, '수요일', '13:00:00', '14:00:00'),
(10, '목요일', '15:00:00', '16:00:00'),
(10, '금요일', '10:00:00', '11:00:00');

select * from student_schedule;

SELECT 
    a.student_id AS student_1,
    b.student_id AS student_2,
    a.day_of_week,
    GREATEST(a.start_time, b.start_time) AS overlap_start,
    LEAST(a.end_time, b.end_time) AS overlap_end
FROM student_schedule a
JOIN student_schedule b
  ON a.day_of_week = b.day_of_week
  AND a.student_id = 5
  AND b.student_id != 5
  AND a.start_time < b.end_time
  AND a.end_time > b.start_time;

create table survey (
	studnet_id int not null,
    mbti char(4) not null,
    PRIMARY KEY (student_id),
    FOREIGN KEY (student_id) REFERENCES student(id)
);

CREATE TABLE mbti_compatibility (
  type1               CHAR(4)    NOT NULL,   -- MBTI A
  type2               CHAR(4)    NOT NULL,   -- MBTI B
  compatibility_score DECIMAL(5,2) NOT NULL,      -- 수치 점수
  PRIMARY KEY (type1, type2)
);

-- 이런 노가다 말고 다른 방법이 있을까...??? 
-- Dan Johnston’s Simplified Myers-Briggs Type Compatibility Chart 참고함
-- 빨간색 칸 0점 -> 노란색 칸 25점 -> .... 이런식으로

-- INSERT INTO mbti_compatibility (type1, type2, compatibility_score) VALUES
--   ('INFP','INFP', 75), ('INFP','ENFP', 75),
--   ('INFP','infj', 75), ('INFP','ENFj', 100),
--   ('INFP','intj', 75), ('INFP','entj', 100),
--   ('INFP','intp', 75), ('INFP','entp', 75),
--   ('INFP','isfp', 0), ('INFP','esfp', 0),
--   ('INFP','istp', 0), ('INFP','estp', 0),
--   ('INFP','isfj', 0), ('INFP','esfj', 0),
--   ('INFP','istj', 0), ('INFP','estj', 0),
--   ('ENFP','enfp', 75), ('ENFP','infj', 100),
--   ('ENFP','enfj', 75), ('ENFP','intj', 100),
--   ('ENFP','entj', 75), ('ENFP','intp', 75),
--   ('ENFP','entp', 75), ('ENFP','isfp', 0),
--   ('ENFP','esfp', 0), ('ENFP','istp', 0),
--   ('ENFP','estp', 0), ('ENFP','isfj', 0),
--   ('ENFP','esfj', 0), ('ENFP','istj', 0),
--   ('ENFP','estj', 0), ('infj','infj', 75),
--   ('infj','enfj', 75), ('infj','intj', 75),
--   ('infj','entj', 75), ('infj','intp', 75),
--   ('infj','entp', 100), ('infj','infj', 75),