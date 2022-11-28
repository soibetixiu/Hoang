-- Question 1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo
-- trước 1 năm trước
DROP TRIGGER IF EXISTS khong_cho_nhap_vao_group;
DELIMITER $$
		CREATE TRIGGER khong_cho_nhap_vao_group
		BEFORE INSERT ON `Group`
		FOR EACH ROW
		BEGIN
			IF year(NEW.createdate) < year(now()) - 1 THEN
            SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'thời gian nhập không chính xác';
		END IF;
		END$$
DELIMITER ;
INSERT INTO testingsystem.`group` (`GroupName`, `CreatorID`, `CreateDate`)
VALUES ('hoang', '11', '2020-04-10 00:00:00');





-- Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào
-- department "Sale" nữa, khi thêm thì hiện ra thông báo "Department
-- "Sale" cannot add more user"
-- Question 3: Cấu hình 1 group có nhiều nhất là 5 user
-- Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question