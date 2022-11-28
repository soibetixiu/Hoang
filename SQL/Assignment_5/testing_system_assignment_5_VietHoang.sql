-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
-- b1: account 
-- b2: department = sale
-- VIEW
CREATE OR REPLACE VIEW DSNV_Sale AS
SELECT A.*, D.DepartmentName
FROM account A
INNER JOIN department D ON A.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Sale';
SELECT * FROM DSNV_Sale;
-- CTE
WITH DSNV_Sale AS(
SELECT A.*, D.DepartmentName
FROM account A
INNER JOIN department D ON A.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Sale'
)
SELECT * FROM DSNV_Sale;

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
-- b1: group có nhiều account tham gia nhất --> thông tin account
-- VIEW
CREATE OR REPLACE VIEW a_groupmax AS
    SELECT 
        *
    FROM
        account a
    WHERE
        EXISTS( SELECT 
                1
            FROM
                groupaccount ga
            WHERE
                a.accountid = ga.accountID 
                GROUP BY ga.accountid
                HAVING count(ga.accountid) = (SELECT MAX(c) 
												FROM (select count(ga.AccountID) as c 
                                                FROM groupaccount ga GROUP BY ga.accountID)test));
SELECT * FROM a_groupmax;
-- CTE
WITH a_groupmax AS(
SELECT a.*
FROM account a
LEFT JOIN groupaccount ga ON a.accountID = ga.accountID
GROUP BY ga.accountid
HAVING count(ga.accountid) = (SELECT MAX(c) 
								FROM (SELECT count(ga.AccountID) as c 
								FROM groupaccount ga GROUP BY ga.accountID)test))
SELECT *
FROM a_groupmax;

-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi
-- VIEW
CREATE OR REPLACE VIEW contenttren15tu AS(
SELECT 
	* 
FROM question 
WHERE LENGTH(content) > 15);
SELECT * FROM Contenttren15Tu;
DELETE FROM Contenttren15Tu;

-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
-- b1: đếm số lượng nvien các phòng ban từ bảng account
-- b2: lấy phòng ban có sl nvien nhiều nhất
-- VIEW
CREATE OR REPLACE VIEW Dep_MaxNV AS
SELECT 
    DepartmentName, COUNT(a.DepartmentID) AS SL
FROM
    account a
        JOIN
    department d ON a.DepartmentID = d.DepartmentID
GROUP BY a.DepartmentID
HAVING COUNT(a.DepartmentID) = (SELECT 
        MAX(count_DepID) AS DepID_max
    FROM
        (SELECT 
            COUNT(a.DepartmentID) as count_DepID
        FROM
            account a
        GROUP BY a.DepartmentID) test);
SELECT * FROM Dep_MaxNV;
-- CTE
WITH CTE_Count_NV AS(
SELECT count(A.DepartmentID) AS countDEP_ID FROM account A
GROUP BY A.DepartmentID)
SELECT D.DepartmentName, count(A.DepartmentID) AS SL
FROM account A
JOIN department D ON D.DepartmentID = A.DepartmentID
GROUP BY A.DepartmentID
HAVING count(A.DepartmentID) = (SELECT max(countDEP_ID) FROM CTE_Count_NV);

-- 5.Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
-- b1: tìm danh sách các user họ nguyễn
-- b2: tìm danh sách các câu hỏi do user họ nguyễn tạo
-- VIEW
CREATE OR REPLACE VIEW Q_NGUYEN AS
SELECT 
    q.*, a.FullName AS Creator
FROM
    question q
        JOIN
    account a ON q.CreatorID = a.AccountID
    WHERE substring_index( A.FullName, ' ', 1 ) = 'Nguyễn'; 
SELECT * FROM Q_NGUYEN;
-- CTE
WITH cte_Q_NGUYEN AS(
SELECT q.*, a.FullName AS Creator FROM question Q
JOIN account a ON a.accountID = q.CreatorID
WHERE SUBSTRING_INDEX( a.FullName, ' ', 1 ) = 'Nguyễn')
SELECT * FROM cte_Q_NGUYEN;


    
    

    
    
    
    
    
    
    
    
    
