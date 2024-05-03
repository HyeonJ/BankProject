// 가상의 데이터
const data = [
    { name: 'John', email: 'john@example.com' },
    { name: 'Alice', email: 'alice@example.com' },
    { name: 'Bob', email: 'bob@example.com' },
    // 추가 데이터...
];

const itemsPerPage = 2; // 페이지당 항목 수
let currentPage = 1;

function displayData() {
    const startIndex = (currentPage - 1) * itemsPerPage;
    const endIndex = startIndex + itemsPerPage;
    const paginatedData = data.slice(startIndex, endIndex);

    const dataContainer = document.getElementById('data');
    dataContainer.innerHTML = '';

    paginatedData.forEach(item => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${item.name}</td>
            <td>${item.email}</td>
        `;
        dataContainer.appendChild(row);
    });
}

function displayPagination() {
    const totalPages = Math.ceil(data.length / itemsPerPage);
    const paginationContainer = document.getElementById('pagination');
    paginationContainer.innerHTML = '';

    for (let i = 1; i <= totalPages; i++) {
        const link = document.createElement('a');
        link.href = '#';
        link.textContent = i;
        if (i === currentPage) {
            link.classList.add('active');
        }
        link.addEventListener('click', () => {
            currentPage = i;
            displayData();
            displayPagination();
        });
        paginationContainer.appendChild(link);
    }
}

// 페이지 로드 시 초기 데이터 및 페이지네이션 표시
displayData();
displayPagination();
