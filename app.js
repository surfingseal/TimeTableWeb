const express = require('express');
const path = require('path');
const db = require('./db');

const app = express();
app.use(express.json());
app.use('/', express.static(path.join(__dirname, 'public')));

// 특정 학생과 공강 겹치는 학생 조회
app.get('/api/overlap/:studentId', async (req, res) => {
  const id = parseInt(req.params.studentId, 10);
  if (isNaN(id)) return res.status(400).json({ error: 'Invalid studentId' });

  // 기본정렬
  // const sql = `
  //   SELECT DISTINCT s.id, s.name, s.school, s.email, s.gender, s.major
  //   FROM student_schedule AS t1
  //   JOIN student_schedule AS t2
  //     ON t1.day_of_week = t2.day_of_week
  //    AND t1.start_time   < t2.end_time
  //    AND t1.end_time     > t2.start_time
  //   JOIN student AS s
  //     ON s.id = t2.student_id
  //   WHERE t1.student_id = ?
  //     AND t2.student_id != ?
  // `;

  // mbti 순으로 정렬
  // const sql = `
  //   SELECT DISTINCT
  //     s.id,
  //     s.name,
  //     s.school,
  //     s.email,
  //     s.gender,
  //     s.major,
  //     comp.compatibility_score
  //   FROM student_schedule AS t1
  //     -- 대상 학생 스케줄
  //     JOIN student_schedule AS t2
  //       ON t1.day_of_week = t2.day_of_week
  //      AND t1.start_time   <  t2.end_time
  //      AND t1.end_time     >  t2.start_time
  //     -- 대상·상대 MBTI 정보
  //     JOIN survey AS su1
  //       ON su1.student_id = t1.student_id
  //     JOIN survey AS su2
  //       ON su2.student_id = t2.student_id
  //     -- 궁합 테이블 매칭
  //     JOIN mbti_compatibility AS comp
  //       ON comp.type1 = su1.mbti
  //      AND comp.type2 = su2.mbti
  //     -- 상대 학생 정보
  //     JOIN student AS s
  //       ON s.id = t2.student_id
  //   WHERE t1.student_id = ?
  //     AND t2.student_id != ?
  //   ORDER BY comp.compatibility_score DESC
  // `;

  //만남 선호 방식에 따라 정렬
  // const sql = `
  //   SELECT DISTINCT
  //     s.id,
  //     s.name,
  //     s.school,
  //     s.email,
  //     s.gender,
  //     s.major,
  //     su2.meeting_method
  //   FROM student_schedule AS t1
  //     JOIN student_schedule AS t2
  //       ON t1.day_of_week = t2.day_of_week
  //      AND t1.start_time   <  t2.end_time
  //      AND t1.end_time     >  t2.start_time
  //     -- 본인 meeting_method
  //     JOIN survey AS su1
  //       ON su1.student_id = t1.student_id
  //     -- 상대 meeting_method
  //     JOIN survey AS su2
  //       ON su2.student_id = t2.student_id
  //     -- 같은 meeting_method 끼리만
  //     AND su1.meeting_method = su2.meeting_method
  //     -- 상대 학생 정보
  //     JOIN student AS s
  //       ON s.id = t2.student_id
  //   WHERE t1.student_id = ?
  //     AND t2.student_id != ?
  //   ORDER BY s.id
  // `;

// 스터디 목적에 따라 정렬
//   const sql = `
//   SELECT DISTINCT
//     s.id,
//     s.name,
//     s.school,
//     s.email,
//     s.gender,
//     s.major,
//     su2.study_purpose
//   FROM student_schedule AS t1
//     JOIN student_schedule AS t2
//       ON t1.day_of_week = t2.day_of_week
//      AND t1.start_time   <  t2.end_time
//      AND t1.end_time     >  t2.start_time
//     -- 본인 survey
//     JOIN survey AS su1
//       ON su1.student_id = t1.student_id
//     -- 상대 survey
//     JOIN survey AS su2
//       ON su2.student_id = t2.student_id
//       AND su1.study_purpose = su2.study_purpose
//     -- 상대 학생 정보
//     JOIN student AS s
//       ON s.id = t2.student_id
//   WHERE t1.student_id   = ?
//     AND t2.student_id  != ?
//   ORDER BY s.id ASC
// `;


// 환경민감도에 따라 정렬
// const sql = `
//     SELECT DISTINCT
//       s.id,
//       s.name,
//       s.school,
//       s.email,
//       s.gender,
//       s.major,
//       su2.environtal_sensitivity
//     FROM student_schedule AS t1
//       JOIN student_schedule AS t2
//         ON t1.day_of_week = t2.day_of_week
//        AND t1.start_time   <  t2.end_time
//        AND t1.end_time     >  t2.start_time
//       -- 본인 survey
//       JOIN survey AS su1
//         ON su1.student_id = t1.student_id
//       -- 상대 survey (환경 민감도 같아야 함)
//       JOIN survey AS su2
//         ON su2.student_id = t2.student_id
//        AND su1.environtal_sensitivity = su2.environtal_sensitivity
//       -- 상대 학생 정보
//       JOIN student AS s
//         ON s.id = t2.student_id
//     WHERE t1.student_id  = ?
//       AND t2.student_id != ?
//     ORDER BY s.id ASC
//   `;

//성별에 따라 정렬
const sql = `
    SELECT DISTINCT
      s2.id,
      s2.name,
      s2.school,
      s2.email,
      s2.gender,
      s2.major
    FROM student_schedule AS t1
      JOIN student_schedule AS t2
        ON t1.day_of_week = t2.day_of_week
       AND t1.start_time   <  t2.end_time
       AND t1.end_time     >  t2.start_time
      -- 본인 정보
      JOIN student AS s1
        ON s1.id = t1.student_id
      -- 상대 정보
      JOIN student AS s2
        ON s2.id = t2.student_id
      -- 성별이 같아야 함
      AND s1.gender = s2.gender
    WHERE t1.student_id  = ?
      AND t2.student_id != ?
    ORDER BY s2.id ASC
  `;


  try {
    const [rows] = await db.execute(sql, [id, id]);
    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'DB error' });
  }
});

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});