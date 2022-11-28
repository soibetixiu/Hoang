-- 1. Thêm ít nhất 10 record vào mỗi table

-- 2. lấy ra tất cả các phòng ban
SELECT 
    *
FROM
    department; 

-- 3. lấy ra id của phòng ban "Sale"
SELECT 
    accountid
FROM
    `account`;

-- 4. lấy ra thông tin account có full name dài nhất
SELECT 
    *
FROM
    account
WHERE
    LENGTH(fullname) = (SELECT 
            MAX(LENGTH(fullname))
        FROM
            account);

-- 5. Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3
-- b1: lay ds acc co departmentid = 3
-- b2: tim maxlength cua fullname trong ds acc cua b1

SELECT 
    *
FROM
    account
WHERE
    departmentID = 3;-- => accountid = 4, 5

SELECT 
    MAX(LENGTH(fullname))
FROM
    account
WHERE
    accountid IN (4 , 5); -- => maxlength = 18
    
SELECT 
    *
FROM
    account
WHERE
    accountid IN (4 , 5)
        AND LENGTH(fullname) = 18; 
    
-- 6. Lấy ra tên group đã tham gia trước ngày 20/12/2019
SELECT 
    *
FROM
    account
WHERE
    Createdate < '2020-12-20';
    
-- 7. Lấy ra ID của question có >= 4 câu trả lời


-- 8. Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
SELECT 
    `code`
FROM
    exam
WHERE
    duration >= 60
        AND createdate < '2020-12-20';
        
-- 9. Lấy ra 5 group được tạo gần đây nhất
SELECT 
    *
FROM
    `group`
ORDER BY createdate DESC
LIMIT 5;

-- 10. Đếm số nhân viên thuộc department có id = 2
SELECT 
    departmentid, COUNT(*)
FROM
    `account`
WHERE
    departmentid = 2;
    
-- 11. Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
SELECT 
    fullname
FROM
    `account`
WHERE
    fullname LIKE 'D%o';
    
-- 12. Xóa tất cả các exam được tạo trước ngày 20/12/2019

-- 13. Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"

-- 14. Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
UPDATE `Account` 
SET 
    Fullname = 'Nguyễn Bá Lộc',
    Email = 'loc.nguyenba@vti.com.vn'
WHERE
    AccountID = 5;

-- 15. update account có id = 5 sẽ thuộc group có id = 4
UPDATE `GroupAccount` 
SET 
    AccountID = 5
WHERE
    GroupID = 4;
    

