-- 创建CATALOG
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

-- 切换CATALOG
USE CATALOG catalog_paimon;

-- 创建database
create  DATABASE IF NOT EXISTS dwd;

-- 切换database
use dwd;

-- 创建paimon表
CREATE  TABLE IF NOT EXISTS dwd.dwd_customer_addr (
    customer_addr_id BIGINT,
    zip STRING,
	province STRING,
	city STRING,
    district STRING,
    address STRING,
    is_default int,
    event_time STRING,
	customer_id BIGINT
);

-- 创建database
create  DATABASE IF NOT EXISTS dws;

use dws;

-- DROP Table dws.dws_customer_addr;

-- 创建paimon dws表
CREATE  TABLE IF NOT EXISTS dws.dws_customer_addr (
    customer_id BIGINT ,
    event_day STRING,
	address_count BIGINT,
    primary key(customer_id, event_day)  NOT ENFORCED
);

-- 是指checkpoint时间
SET 'execution.checkpointing.interval' = '10 s';

INSERT INTO dws.dws_customer_addr
SELECT
	customer_id,
    event_time,
	COUNT(customer_id) as address_count
FROM
	dwd.dwd_customer_addr
GROUP BY
	customer_id,
    event_time;