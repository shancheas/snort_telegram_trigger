DELIMITER $$

DROP TABLE IF EXISTS acid_event_telegram$$
CREATE TABLE acid_event_telegram LIKE acid_event$$

DROP PROCEDURE IF EXISTS push_message$$
CREATE PROCEDURE push_message
(signatures varchar,
 timestmp datetime,
 ip_src int,
 ip_dst int,
 ip_proto int)
BEGIN
 SET @result = sys_exec(CONCAT('php E:\xampp\htdocs\message.php "', signatures, '" "', timestmp, '" "', ip_src, '" "', ip_dst, '" "', ip_proto, '"'));
END$$

DROP TRIGGER IF EXISTS push_message_trigger$$
CREATE TRIGGER `push_message_trigger` AFTER INSERT ON `acid_event_telegram`
FOR EACH ROW BEGIN
CALL push_message(NEW.sig_name, NEW.timestamp, NEW.ip_src, NEW.ip_dst, NEW.ip_proto);
END;
$$

DROP TRIGGER IF EXISTS acid_event_trigger$$
CREATE TRIGGER `acid_event_trigger` AFTER INSERT ON `event`
FOR EACH ROW BEGIN
INSERT INTO 
acid_event_telegram 
(
  sid, cid, signature, timestamp,
  ip_src, ip_dst, ip_proto,
  sig_name, sig_priority, sig_class_id
)
SELECT 
  NEW.sid as sid, NEW.cid as cid, NEW.signature, NEW.timestamp,
  ip_src, ip_dst, ip_proto, 
  sig_name, sig_priority, sig_class_id
FROM iphdr
INNER JOIN signature ON (NEW.signature = signature.sig_id) 
WHERE sid = NEW.sid AND cid = NEW.cid
END;
$$

DELIMITER ;