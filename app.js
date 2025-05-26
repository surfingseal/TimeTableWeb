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

  const sql = `
    SELECT DISTINCT s.id, s.name, s.school, s.email, s.gender, s.major
    FROM student_schedule AS t1
    JOIN student_schedule AS t2
      ON t1.day_of_week = t2.day_of_week
     AND t1.start_time   < t2.end_time
     AND t1.end_time     > t2.start_time
    JOIN student AS s
      ON s.id = t2.student_id
    WHERE t1.student_id = ?
      AND t2.student_id != ?
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