-- ./sql-client.sh

-- 执行以下代码

-- CREATE CATALOG catalog_paimon WITH (
--     'type'='paimon',
--     'warehouse'='file:/opt/software/paimon_catelog'
-- );

CREATE CATALOG catalog_paimon WITH (
    'type' = 'paimon',
    'warehouse' = 's3://warehouse/wh',  -- S3 存储路径
    's3.endpoint' = 'http://minio:9000',  -- S3 端点
    's3.access-key' = 'admin',  -- S3 访问密钥
    's3.secret-key' = 'password',  -- S3 密钥
    's3.region' = 'us-east-1'  -- S3 区域
);

USE CATALOG catalog_paimon;

create  DATABASE IF NOT EXISTS ods;

use ods;

-- 创建paimon表
CREATE  TABLE IF NOT EXISTS ods.ods_customer_addr (
    customer_addr_id BIGINT,
    zip STRING,
	province STRING,
	city STRING,
    district STRING,
    address STRING,
    is_default int,
    event_time TIMESTAMP,
	customer_id BIGINT
);


-- 批量读取数据
SET 'sql-client.execution.result-mode' = 'tableau';

SET 'execution.runtime-mode' = 'batch';

SELECT * FROM ods_customer_addr;

-- 流式读取数据

SET 'execution.runtime-mode' = 'streaming';

SELECT * FROM ods_customer_addr;