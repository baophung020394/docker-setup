-- Tạo database "maps"
CREATE DATABASE maps;

-- Cho phép kết nối qua TCP
ALTER SYSTEM SET listen_addresses = '*';

-- Restart PostgreSQL để áp dụng thay đổi
SELECT pg_reload_conf();
