from faker import Faker
import random
from datetime import datetime, timedelta
import time

def return_order_master(database_type):
    fake = Faker(locale='zh_CN')

    # 订单编号
    order_sn = fake.pyint(min_value=0, max_value=999999, step=1)

    # 支付方式
    payment_method_list = [1, 2, 3, 4, 5]
    payment_method = random.choice(payment_method_list)

    # 订单金额
    order_money = fake.pyfloat()

    # 优惠金额
    district_money = fake.pyfloat()

    # 运费金额
    shipping_money = fake.pyfloat()

    # 支付金额
    payment_money = fake.pyfloat()

    # 快递单号
    shipping_sn = fake.ssn()

    # 下单时间
    start = datetime(2022, 5, 23, 0, 0, 0)
    end = datetime(2023, 5, 23, 17, 30, 0)
    create_time = start + timedelta(
        seconds=random.randint(0, int((end - start).total_seconds())))

    # 发货时间
    shipping_time = start + timedelta(
        seconds=random.randint(0, int((end - start).total_seconds())))

    # 支付时间
    pay_time = start + timedelta(
        seconds=random.randint(0, int((end - start).total_seconds())))

    # 收货时间
    receive_time = start + timedelta(
        seconds=random.randint(0, int((end - start).total_seconds())))

    # 订单状态
    order_status_list = [0, 1]
    order_status = random.choice(order_status_list)

    # 订单积分
    order_point = fake.pyint()

    if database_type == 'mysql':

        order_master = (order_sn, payment_method, order_money, district_money, shipping_money, payment_money, shipping_sn, create_time, shipping_time, pay_time, receive_time, order_status, order_point)

        return order_master

    else:
        # 获取当前时间戳
        timestamp = time.time()
        # 将时间戳转换为整数
        id = int(timestamp)
        create_time = create_time.strftime("%Y-%m-%d %H:%M:%S")
        shipping_time = shipping_time.strftime("%Y-%m-%d %H:%M:%S")
        pay_time = pay_time.strftime("%Y-%m-%d %H:%M:%S")
        receive_time = receive_time.strftime("%Y-%m-%d %H:%M:%S")
        # 创建一个 datetime 对象
        now = datetime.now()
        # 转换为字符串
        str_now = now.strftime("%Y-%m-%d %H:%M:%S")
        order_master = (id, order_sn, payment_method, order_money, district_money, shipping_money, payment_money, shipping_sn, create_time, shipping_time, pay_time, receive_time, order_status, order_point, str_now)
        return order_master


