-- dwd.dwd_order_cart definition

CREATE TABLE `dwd_order_cart` (
  `cart_id` bigint(20) NULL COMMENT '购物车ID',
  `customer_id` bigint(20) NULL COMMENT '用户ID',
  `product_id` bigint(20) NULL COMMENT '商品ID',
  `product_amount` bigint(20) NULL COMMENT '加入购物车商品数量',
  `price` DECIMAL(27, 2) NULL COMMENT '商品价格',
  `add_time` varchar(255) NULL COMMENT '加入购物车时间',
  `modified_time` varchar(255) NULL COMMENT '最后修改时间'
) ENGINE=OLAP
UNIQUE KEY(`cart_id`)
COMMENT '购物车表'
DISTRIBUTED BY HASH(`cart_id`) BUCKETS 1
PROPERTIES (
"replication_allocation" = "tag.location.default: 1",
"is_being_synced" = "false",
"storage_format" = "V2",
"light_schema_change" = "true",
"disable_auto_compaction" = "false",
"enable_single_replica_compaction" = "false"
);