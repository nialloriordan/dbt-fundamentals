with payments as (
    select * from {{ ref('stg_payments') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

payment_dollars as (
    select 
        amount_dollars,
        order_id
    from payments
    where payment_status = 'success'
),

payment_orders as (
    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        payment_dollars.amount_dollars as amount
    from orders
    join payment_dollars 
        on orders.order_id = payment_dollars.order_id
)

select * from payment_orders