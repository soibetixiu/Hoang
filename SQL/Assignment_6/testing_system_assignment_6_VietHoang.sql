-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó
-- tên phòng ban --> show ra tất cả các account thuộc phòng ban đấy
DELIMITER $$
CREATE PROCEDURE proc_get_account_in_departmentName(
in in_departmentName VARCHAR(255))
BEGIN 
SELECT 
    *
FROM
    account a
WHERE
    EXISTS( SELECT 
            1
        FROM
            department d
        WHERE
            a.departmentId = d.departmentID
                AND d.departmentName = in_departmentName);
end$$
DELIMITER ;
CALL proc_get_account_in_departmentName('bảo vệ');

-- Question 2: Tạo store để in ra số lượng account trong mỗi group
-- đầu vào: groupID (in_groupId int)
-- đầu ra: số lượng account trong mỗi group (out_sl_account int)
DELIMITER $$
CREATE PROCEDURE proc_get_SL_account_in_group(
in in_groupId int,
out out_sl_account int)
	BEGIN 
		SELECT 
			COUNT(ga.AccountID) into out_sl_account 
		FROM
			`group` g
				LEFT JOIN
			groupaccount ga ON g.GroupID = ga.GroupID
		GROUP BY g.GroupID
		HAVING g.GroupID = in_groupId; 
	end$$
DELIMITER ;
set @out_sl_account = 0;
call testingsystem.proc_get_SL_account_in_group(3, @out_sl_account);
select @out_sl_account;

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại
DELIMITER $$
CREATE PROCEDURE proc_cau3()
	BEGIN 
		SELECT 
			tq.*, COUNT(q.typeid) AS sl_question
		FROM
			typequestion tq
				LEFT JOIN
			question q ON tq.typeid = q.typeid
		WHERE
			YEAR(q.createdate) = YEAR(NOW())
				AND MONTH(q.createdate) = MONTH(NOW())
		GROUP BY tq.typeid;
	end$$
DELIMITER ;
call testingsystem.proc_cau3();

-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất

-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question

-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
-- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa
-- chuỗi của người dùng nhập vào
-- đầu vào: in_sequence varchar(255))
DELIMITER $$
CREATE PROCEDURE proc_cau6(
in in_sequence varchar(255))
	BEGIN 
		select a.username as result from account a where a.username like CONCAT('%',in_sequence,'%')
        union
        select g.groupname as result from `group` g where g.groupname like CONCAT('%',in_sequence,'%');
	end$$
DELIMITER ;
call testingsystem.proc_cau6('a');
call testingsystem.proc_cau6('vti');





