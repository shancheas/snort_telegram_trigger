DELIMITER $$

DROP PROCEDURE IF EXISTS push_message$$

CREATE PROCEDURE push_message
(signatures int,
 timestmp datetime,
 ip_src int,
 ip_dst int,
 ip_proto int)
BEGIN
 SET @result = sys_exec(CONCAT('php E:\xampp\htdocs\message.php "', signatures, '" ', timestmp, ' ', ip_src, ' ', ip_dst, ' ', ip_proto));
END$$

DROP TRIGGER IF EXISTS push_message_trigger$$

CREATE TRIGGER `push_message_trigger` AFTER INSERT ON `acid_event`
FOR EACH ROW BEGIN
CALL push_message(NEW.sig_name, NEW.timestamp, NEW.ip_src, NEW.ip_dst, NEW.ip_proto);
END;
$$

DELIMITER ;