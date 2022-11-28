-- 1. Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT 
    a.*, departmentname
FROM
    account a
       LEFT JOIN
    department d ON a.departmentid = a.departmentid;
    
-- 2. Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
SELECT 
    *
FROM
    `account`
WHERE
    createdate > '2020-03-20';
    
-- 3. Viết lệnh để lấy ra tất cả các developer
SELECT 
    a.*, positionname
FROM
    account a
        JOIN
    position p ON a.positionid = p.positionid
WHERE
    positionname = 'dev';
    
-- 4. Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT 
    d.*, COUNT(a.departmentid)
FROM
    account a
        JOIN
    department d ON a.departmentid = d.departmentid
GROUP BY a.departmentid
HAVING COUNT(a.accountid) > 3;

-- 5. Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT 
    q.questionid, q.content, count(eq.questionid) as SL_exam
FROM
    question q
        JOIN
    examquestion eq ON q.questionid = eq.questionid
GROUP BY eq.questionid
order by count(eq.questionid) DESC; -- max = 3
SELECT 
    q.questionid, q.content, COUNT(eq.questionid) as SL_exam
FROM
    question q
        JOIN
    examquestion eq ON q.questionid = eq.questionid
GROUP BY eq.questionid
HAVING COUNT(eq.questionid) = 3;

-- 6. Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
SELECT 
    cq.CategoryID, cq.CategoryName, COUNT(q.questionid) AS SL
FROM
    question q
        RIGHT JOIN
    categoryquestion cq ON q.categoryid = cq.categoryid
GROUP BY cq.categoryid;

-- 7. Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT 
    questionid, COUNT(*) AS SL_Exam
FROM
    question q
        JOIN
    examquestion eq ON q.questionid = eq.questionid
GROUP BY questionid; 

-- 8. Lấy ra Question có nhiều câu trả lời nhất
SELECT 
    questionid, COUNT(questionid) AS SL_answer
FROM
    answer
GROUP BY questionid
ORDER BY questionid DESC;-- max = 4
SELECT 
    questionid, COUNT(questionid) AS SL_answer
FROM
    answer
GROUP BY questionid
HAVING COUNT(questionid) = 4;

-- 9. Thống kê số lượng account trong mỗi group
SELECT 
    g.*, COUNT(ga.accountid) AS SL_account
FROM
    groupaccount ga
        RIGHT JOIN
    `group` g ON ga.groupid = g.groupid
GROUP BY g.groupid
ORDER BY g.groupid ASC;

-- 10. Tìm chức vụ có ít người nhất
SELECT 
    departmentname, count(d.departmentid)
FROM
    department d
        JOIN
    `account` a ON d.departmentid = a.departmentid
GROUP BY d.departmentid
ORDER BY d.departmentid ASC; -- SL người có chức vụ ít nhất là 1
SELECT 
    d.*, COUNT(d.departmentid) AS SL_account
FROM
    department d
        JOIN
    `account` a ON d.departmentid = a.departmentid
GROUP BY d.departmentid
HAVING COUNT(d.departmentid) = 1;

-- 11. Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT 
    d.departmentid, d.departmentname, 
    p.positionname,
    COUNT(a.accountid) AS SL_account
FROM
    `account` a
        RIGHT JOIN
    department d ON a.departmentid = d.departmentid
        LEFT JOIN
    position p ON p.positionid = a.positionid
GROUP BY a.positionid , d.departmentid;

-- 12. Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...
SELECT 
    q.questionID,
    q.content,
    acc.fullName,
    tq.typeName AS Author,
    a.content
FROM
    question q
        JOIN
    answer a ON q.questionid = a.questionid
        JOIN
    examquestion e ON q.questionid = e.questionid
        JOIN
    typequestion tq ON q.typeid = tq.typeid
        JOIN
    account acc ON q.creatorid = acc.accountid;

-- 13. Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT 
    tq.typename, count(q.typeid) as SL_question
FROM
    question q
         RIGHT JOIN
    typequestion tq ON q.typeid = tq.typeid
    group by tq.typeid;

-- 14. Lấy ra group không có account nào, sử dụng leftjoin
SELECT 
    *
FROM
    `group` g
        LEFT JOIN
    groupaccount ga ON g.GroupID = ga.GroupID
WHERE
    GA.AccountID IS NULL;

-- 15. Lấy ra group không có account nào
SELECT 
    *
FROM
    groupaccount ga
        RIGHT JOIN
    `group` g ON g.GroupID = ga.GroupID
WHERE
    GA.AccountID IS NULL;
    
-- 16. Lấy ra question không có answer nào
SELECT 
    *
FROM
    answer a
        RIGHT JOIN
    question q ON a.questionid = q.questionid
WHERE
    a.answerid IS NULL;
    
-- 17. a) Lấy các account thuộc nhóm thứ 1 b) Lấy các account thuộc nhóm thứ 2 c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT 
    acc.accountid, acc.fullname, ga.groupid
FROM
    `account` acc
        JOIN
    groupaccount ga ON acc.accountid = ga.accountid
WHERE
    ga.groupid = 1 
UNION 
SELECT 
    acc.accountid, acc.fullname, ga.groupid
FROM
    `account` acc
        JOIN
    groupaccount ga ON acc.accountid = ga.accountid
WHERE
    ga.groupid = 2;
    
-- 18. a) Lấy các group có lớn hơn 5 thành viên b) Lấy các group có nhỏ hơn 7 thành viên c) Ghép 2 kết quả từ câu a) và câu b)
SELECT 
    ga.groupid, groupname, COUNT(g.groupid) AS SL_account
FROM
    `groupaccount` ga
        JOIN
    `group` g ON ga.groupid = g.groupid
GROUP BY ga.groupid
HAVING COUNT(ga.groupid) >= 5 
UNION ALL SELECT 
    ga.groupid, groupname, COUNT(g.groupid) AS SL_account
FROM
    `groupaccount` ga
        JOIN
    `group` g ON ga.groupid = g.groupid
GROUP BY ga.groupid
HAVING COUNT(ga.groupid) < 7;
