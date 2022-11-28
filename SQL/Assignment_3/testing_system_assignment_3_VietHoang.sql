-- 1. Thêm ít nhất 10 record vào mỗi table
-- 2. lấy ra tất cả các phòng ban
SELECT 
    *
FROM
    Department;
-- 3. lấy ra id của phòng ban "Sale"
SELECT 
    DepartmentID, DepartmentName
FROM
    Department
WHERE
    DepartmentName = N'Sale';
-- 4. lấy ra thông tin account có full name dài nhất
SELECT 
    MAX(LENGTH(fullname))
FROM
    `Account`;
SELECT 
    *
FROM
    `Account`
WHERE
    length(fullname) = 18;
-- 5. Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id= 2
SELECT 
    *
FROM
    `account`
WHERE
    DepartmentID = 2; -- accountID 3,7,9
SELECT 
    max(length(fullname))
FROM
    `account`
WHERE
AccountID in (3,7,9); -- tìm fullname dài nhất trong số accountid 3,7,9 -> ra bằng 10
SELECT 
    *
FROM
    account
WHERE
    accountID IN (3 , 7, 9)
        AND LENGTH(fullname) = 10;
-- 6. Lấy ra tên group đã tạo trước ngày 20/12/2019
SELECT 
    GroupName, Createdate
FROM
    `Group`
WHERE
    CreateDate < '2020-3-20';
-- 7. Lấy ra ID của question có >= 4 câu trả lời
SELECT 
    questionID, COUNT(*) as Số_câu_trả_lời
FROM
    answer
GROUP BY questionID
HAVING COUNT(*) >= 4;
-- 8. Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
SELECT 
    `Code`
FROM
    Exam
WHERE
    Duration >= 60
        AND CreateDate < '2020-12-20';
-- 9. Lấy ra 5 group được tạo gần đây nhất
SELECT 
    *
FROM
    `Group`
ORDER BY Createdate DESC
LIMIT 5;
-- 10. Đếm số nhân viên thuộc department có id = 2
SELECT 
    COUNT(*)
FROM
    department
WHERE
    DepartmentID = 2;
-- 11. Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
SELECT 
    AccountID, Fullname
FROM
    account
WHERE
    FullName LIKE 'D%o';
-- 12. Xóa tất cả các exam được tạo trước ngày 20/12/2020
-- 13. Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
-- 14. Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
UPDATE `account` 
SET 
    fullname = 'Nguyễn Bá Lộc',
    email = 'loc.nguyenba@vti.com.vn'
WHERE
    accountid = 5;
-- 15. update account có id = 5 sẽ thuộc group có id = 4
UPDATE `groupaccount` 
SET 
    accountid = 5
WHERE
    groupid = 4;