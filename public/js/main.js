// 로그인된 학생 ID (예시)
const CURRENT_STUDENT_ID = 5;

async function fetchOverlap(studentId) {
  const res = await fetch(`/api/overlap/${studentId}`);
  if (!res.ok) throw new Error('네트워크 에러');
  return res.json();
}

function renderTable(students) {
  const tbody = document.querySelector('#overlap-table tbody');
  tbody.innerHTML = '';

  students.forEach(s => {
    const tr = document.createElement('tr');
    tr.innerHTML = `
      <td>${s.id}</td>
      <td>${s.name}</td>
      <td>${s.school}</td>
      <td>${s.email}</td>
      <td>${s.gender}</td>
      <td>${s.major}</td>
    `;
    tbody.appendChild(tr);
  });
}

async function init() {
  try {
    const list = await fetchOverlap(CURRENT_STUDENT_ID);
    renderTable(list);
  } catch (err) {
    console.error(err);
    alert('공강 겹치는 학생 조회에 실패했습니다.');
  }
}

document.addEventListener('DOMContentLoaded', init);