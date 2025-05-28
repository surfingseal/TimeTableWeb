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
	student_id int not null,
    mbti char(4) not null,
    age int not null,
    school_year int not null,
    kakao_id varchar(255) not null,
    smoking char(1) not null,
    meeting_method varchar(255) not null,
    study_purpose varchar(255) not null,
    study_atmosphere varchar(255) not null,
    speaking_style varchar(255) not null,
    environtal_sensitivity varchar(255) not null,
    PRIMARY KEY (student_id),
    FOREIGN KEY (student_id) REFERENCES student(id)
);


INSERT INTO survey (
    student_id,
    mbti,
    age,
    school_year,
    kakao_id,
    smoking,
    meeting_method,
    study_purpose,
    study_atmosphere,
    speaking_style,
    environtal_sensitivity
) VALUES
(1,  'INTJ', 22, 3, '@0123456789',  'N', 'off', '시험 대비',              '조용히 각자 집중', '경청형',         '조용한 환경 선호'),
(2,  'ENFP', 20, 1, '@1234567890',  'Y', 'on', '코딩',                '자유롭게 토론',   '아이디어 제안형', '적당한 백색소음'),
(3,  'ISTP', 23, 2, '@2345678901',  'N', 'on', '영어회화 / 언어 교환', '질문 위주',       '경청형',         '소음 신경 안씀'),
(4,  'ESFJ', 25, 4, '@3456789012',  'Y', 'on', '과제',                '상호 설명',       '리더형',         '적당한 백색소음'),
(5,  'ISFJ', 21, 3, '@4567890123',  'N', 'off', '자습',                '상관 없다',       '경청형',         '조용한 환경 선호'),
(6,  'ENTP', 24, 4, '@5678901234',  'N', 'off', '취업준비',            '질문 위주',       '아이디어 제안형', '소음 신경 안씀'),
(7,  'INFP', 20, 2, '@6789012345',  'N', 'off', '자격증 공부',         '조용히 각자 집중', '경청형',         '조용한 환경 선호'),
(8,  'ESTJ', 23, 3, '@7890123456',  'Y', 'off', '코딩',                '자유롭게 토론',   '리더형',         '적당한 백색소음'),
(9,  'ENTJ', 25, 4, '@8901234567',  'N', 'on', '기타',                '상호 설명',       '리더형',         '적당한 백색소음'),
(10, 'ISFP', 22, 1, '@9012345678',  'Y', 'off', '시험 대비',           '상관 없다',       '경청형',         '소음 신경 안씀');

-- select * from survey;

CREATE TABLE mbti_compatibility (
  type1               CHAR(4)    NOT NULL,   -- MBTI A
  type2               CHAR(4)    NOT NULL,   -- MBTI B
  compatibility_score DECIMAL(5,2) NOT NULL,      -- 수치 점수
  PRIMARY KEY (type1, type2)
);

INSERT INTO mbti_compatibility (type1, type2, compatibility_score) VALUES
('ISTJ','ISTJ',75),('ISTJ','ISFJ',70),('ISTJ','INFJ',50),('ISTJ','INTJ',65),('ISTJ','ISTP',60),('ISTJ','ISFP',55),('ISTJ','INFP',45),('ISTJ','INTP',50),('ISTJ','ESTP',55),('ISTJ','ESFP',60),('ISTJ','ENFP',55),('ISTJ','ENTP',60),('ISTJ','ESTJ',80),('ISTJ','ESFJ',70),('ISTJ','ENFJ',55),('ISTJ','ENTJ',60),
('ISFJ','ISTJ',70),('ISFJ','ISFJ',75),('ISFJ','INFJ',55),('ISFJ','INTJ',60),('ISFJ','ISTP',65),('ISFJ','ISFP',70),('ISFJ','INFP',55),('ISFJ','INTP',50),('ISFJ','ESTP',60),('ISFJ','ESFP',65),('ISFJ','ENFP',60),('ISFJ','ENTP',55),('ISFJ','ESTJ',70),('ISFJ','ESFJ',80),('ISFJ','ENFJ',60),('ISFJ','ENTJ',55),
('INFJ','ISTJ',50),('INFJ','ISFJ',55),('INFJ','INFJ',75),('INFJ','INTJ',70),('INFJ','ISTP',45),('INFJ','ISFP',50),('INFJ','INFP',65),('INFJ','INTP',60),('INFJ','ESTP',50),('INFJ','ESFP',55),('INFJ','ENFP',70),('INFJ','ENTP',65),('INFJ','ESTJ',55),('INFJ','ESFJ',60),('INFJ','ENFJ',80),('INFJ','ENTJ',70),
('INTJ','ISTJ',65),('INTJ','ISFJ',60),('INTJ','INFJ',70),('INTJ','INTJ',75),('INTJ','ISTP',50),('INTJ','ISFP',55),('INTJ','INFP',60),('INTJ','INTP',65),('INTJ','ESTP',55),('INTJ','ESFP',60),('INTJ','ENFP',70),('INTJ','ENTP',70),('INTJ','ESTJ',60),('INTJ','ESFJ',55),('INTJ','ENFJ',70),('INTJ','ENTJ',80),
('ISTP','ISTJ',60),('ISTP','ISFJ',65),('ISTP','INFJ',45),('ISTP','INTJ',50),('ISTP','ISTP',75),('ISTP','ISFP',60),('ISTP','INFP',55),('ISTP','INTP',60),('ISTP','ESTP',80),('ISTP','ESFP',75),('ISTP','ENFP',60),('ISTP','ENTP',55),('ISTP','ESTJ',60),('ISTP','ESFJ',65),('ISTP','ENFJ',50),('ISTP','ENTJ',55),
('ISFP','ISTJ',55),('ISFP','ISFJ',70),('ISFP','INFJ',50),('ISFP','INTJ',55),('ISFP','ISTP',60),('ISFP','ISFP',75),('ISFP','INFP',65),('ISFP','INTP',60),('ISFP','ESTP',75),('ISFP','ESFP',80),('ISFP','ENFP',65),('ISFP','ENTP',60),('ISFP','ESTJ',55),('ISFP','ESFJ',70),('ISFP','ENFJ',55),('ISFP','ENTJ',50),
('INFP','ISTJ',45),('INFP','ISFJ',55),('INFP','INFJ',65),('INFP','INTJ',60),('INFP','ISTP',55),('INFP','ISFP',65),('INFP','INFP',75),('INFP','INTP',70),('INFP','ESTP',60),('INFP','ESFP',65),('INFP','ENFP',80),('INFP','ENTP',75),('INFP','ESTJ',55),('INFP','ESFJ',70),('INFP','ENFJ',65),('INFP','ENTJ',80),
('INTP','ISTJ',50),('INTP','ISFJ',50),('INTP','INFJ',60),('INTP','INTJ',65),('INTP','ISTP',60),('INTP','ISFP',60),('INTP','INFP',70),('INTP','INTP',75),('INTP','ESTP',55),('INTP','ESFP',60),('INTP','ENFP',75),('INTP','ENTP',80),('INTP','ESTJ',55),('INTP','ESFJ',50),('INTP','ENFJ',65),('INTP','ENTJ',70),
('ESTP','ISTJ',55),('ESTP','ISFJ',60),('ESTP','INFJ',50),('ESTP','INTJ',55),('ESTP','ISTP',80),('ESTP','ISFP',75),('ESTP','INFP',60),('ESTP','INTP',55),('ESTP','ESTP',75),('ESTP','ESFP',80),('ESTP','ENFP',65),('ESTP','ENTP',60),('ESTP','ESTJ',75),('ESTP','ESFJ',70),('ESTP','ENFJ',55),('ESTP','ENTJ',60),
('ESFP','ISTJ',60),('ESFP','ISFJ',65),('ESFP','INFJ',55),('ESFP','INTJ',60),('ESFP','ISTP',75),('ESFP','ISFP',80),('ESFP','INFP',65),('ESFP','INTP',60),('ESFP','ESTP',80),('ESFP','ESFP',75),('ESFP','ENFP',70),('ESFP','ENTP',65),('ESFP','ESTJ',75),('ESFP','ESFJ',60),('ESFP','ENFJ',75),('ESFP','ENTJ',60),
('ENFP','ISTJ',55),('ENFP','ISFJ',60),('ENFP','INFJ',70),('ENFP','INTJ',70),('ENFP','ISTP',60),('ENFP','ISFP',65),('ENFP','INFP',80),('ENFP','INTP',75),('ENFP','ESTP',65),('ENFP','ESFP',70),('ENFP','ENFP',75),('ENFP','ENTP',80),('ENFP','ESTJ',60),('ENFP','ESFJ',65),('ENFP','ENFJ',70),('ENFP','ENTJ',70),
('ENTP','ISTJ',60),('ENTP','ISFJ',55),('ENTP','INFJ',65),('ENTP','INTJ',70),('ENTP','ISTP',55),('ENTP','ISFP',60),('ENTP','INFP',75),('ENTP','INTP',80),('ENTP','ESTP',60),('ENTP','ESFP',65),('ENTP','ENFP',80),('ENTP','ENTP',75),('ENTP','ESTJ',70),('ENTP','ESFJ',60),('ENTP','ENFJ',75),('ENTP','ENTJ',70),
('ESTJ','ISTJ',80),('ESTJ','ISFJ',70),('ESTJ','INFJ',55),('ESTJ','INTJ',60),('ESTJ','ISTP',60),('ESTJ','ISFP',55),('ESTJ','INFP',55),('ESTJ','INTP',55),('ESTJ','ESTP',75),('ESTJ','ESFP',75),('ESTJ','ENFP',60),('ESTJ','ENTP',70),('ESTJ','ESTJ',75),('ESTJ','ESFJ',70),('ESTJ','ENFJ',65),('ESTJ','ENTJ',70),
('ESFJ','ISTJ',70),('ESFJ','ISFJ',80),('ESFJ','INFJ',60),('ESFJ','INTJ',55),('ESFJ','ISTP',65),('ESFJ','ISFP',70),('ESFJ','INFP',70),('ESFJ','INTP',50),('ESFJ','ESTP',70),('ESFJ','ESFP',60),('ESFJ','ENFP',65),('ESFJ','ENTP',60),('ESFJ','ESTJ',70),('ESFJ','ESFJ',75),('ESFJ','ENFJ',75),('ESFJ','ENTJ',60),
('ENFJ','ISTJ',55),('ENFJ','ISFJ',60),('ENFJ','INFJ',80),('ENFJ','INTJ',70),('ENFJ','ISTP',50),('ENFJ','ISFP',55),('ENFJ','INFP',65),('ENFJ','INTP',65),('ENFJ','ESTP',55),('ENFJ','ESFP',60),('ENFJ','ENFP',70),('ENFJ','ENTP',75),('ENFJ','ESTJ',65),('ENFJ','ESFJ',75),('ENFJ','ENFJ',75),('ENFJ','ENTJ',70),
('ENTJ','ISTJ',60),('ENTJ','ISFJ',55),('ENTJ','INFJ',70),('ENTJ','INTJ',80),('ENTJ','ISTP',55),('ENTJ','ISFP',50),('ENTJ','INFP',80),('ENTJ','INTP',70),('ENTJ','ESTP',60),('ENTJ','ESFP',70),('ENTJ','ENFP',70),('ENTJ','ENTP',70),('ENTJ','ESTJ',70),('ENTJ','ESFJ',60),('ENTJ','ENFJ',70),('ENTJ','ENTJ',75);

select * from mbti_compatibility;

SELECT DISTINCT
      s.id,
      s.name,
      s.school,
      s.email,
      s.gender,
      s.major,
      comp.compatibility_score
    FROM student_schedule AS t1
      -- 대상 학생 스케줄
      JOIN student_schedule AS t2
        ON t1.day_of_week = t2.day_of_week
       AND t1.start_time   <  t2.end_time
       AND t1.end_time     >  t2.start_time
      -- 대상·상대 MBTI 정보
      JOIN survey AS su1
        ON su1.student_id = t1.student_id
      JOIN survey AS su2
        ON su2.student_id = t2.student_id
      -- 궁합 테이블 매칭
      JOIN mbti_compatibility AS comp
        ON comp.type1 = su1.mbti
       AND comp.type2 = su2.mbti
      -- 상대 학생 정보
      JOIN student AS s
        ON s.id = t2.student_id
    WHERE t1.student_id = 5
      AND t2.student_id != 5
    ORDER BY comp.compatibility_score DESC;

