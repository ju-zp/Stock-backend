# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
BatchOrder.destroy_all
Order.destroy_all
Batch.destroy_all
Product.destroy_all




bar1 = Product.create(name:'bar1', description:"test description")
bar2 = Product.create(name:'bar2', description:"test description")
bar3 = Product.create(name:'bar3', description:"test description")

batch1 = Batch.create(code:'abc', quantity:10, best_before:"2019-10-12", product:bar1)
batch2 = Batch.create(code:'cde', quantity:10, best_before:"2019-10-12", product:bar2)
batch3 = Batch.create(code:'fgh', quantity:10, best_before:"2019-10-12", product:bar3)

order1 = Order.create(order_ref:"123")
order2 = Order.create(order_ref:"456")
order3 = Order.create(order_ref:"789")

BatchOrder.create(batch:batch1, order:order1, quantity:4)
BatchOrder.create(batch:batch2, order:order1, quantity:3)
BatchOrder.create(batch:batch3, order:order1, quantity:2)

BatchOrder.create(batch:batch1, order:order2, quantity:3)
BatchOrder.create(batch:batch2, order:order2, quantity:7)
BatchOrder.create(batch:batch3, order:order2, quantity:1)

BatchOrder.create(batch:batch1, order:order3, quantity:10)


