// MySQL 연결 풀 생성
const mysql = require('mysql2/promise');

const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: '030328mis*',
  database: 'timetable',
  waitForConnections: true,
  connectionLimit: 10
});

module.exports = pool;