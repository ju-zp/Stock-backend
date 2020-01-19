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




bar1 = Product.create(name:'Nutcracker', description:"Nutcracker", image_url:"https://images.squarespace-cdn.com/content/v1/5c190cac2487fd8d27dba85e/1572527832736-HXZQE9UX4SMBYBVM6H60/ke17ZwdGBToddI8pDm48kLPswmMOqQZ9-Q6KHLjvbpZ7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QPOohDIaIeljMHgDF5CVlOqpeNLcJ80NK65_fV7S1UTcpTqfU-ZEsztPyQLxhSSK-PhJjRDDFQG0l3_ZnmWi1QjT9byXZM3ISxo3y1NRptg/The-Nutcracker-100g.jpg?format=500w")
bar2 = Product.create(name:'Cosmic Bubbles', description:"Cosmic Bubbles", image_url:"https://images.squarespace-cdn.com/content/v1/5c190cac2487fd8d27dba85e/1566455385119-RI5AIP59CIERIE00YEOE/ke17ZwdGBToddI8pDm48kLPswmMOqQZ9-Q6KHLjvbpZ7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QPOohDIaIeljMHgDF5CVlOqpeNLcJ80NK65_fV7S1UTcpTqfU-ZEsztPyQLxhSSK-PhJjRDDFQG0l3_ZnmWi1QjT9byXZM3ISxo3y1NRptg/Cosmic-Bubbles.jpg?format=500w")
bar3 = Product.create(name:'Ramen Bar', description:"Ramen Bar", image_url:"https://images.squarespace-cdn.com/content/v1/5c190cac2487fd8d27dba85e/1556272255397-1IBME2EN44MRLZU40LDQ/ke17ZwdGBToddI8pDm48kLPswmMOqQZ9-Q6KHLjvbpZ7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QPOohDIaIeljMHgDF5CVlOqpeNLcJ80NK65_fV7S1UTcpTqfU-ZEsztPyQLxhSSK-PhJjRDDFQG0l3_ZnmWi1QjT9byXZM3ISxo3y1NRptg/Ramen-bar.jpg?format=500w")

batch1 = Batch.create(code:'1242321', quantity:300, best_before:"2020-12-01", product:bar1)
batch2 = Batch.create(code:'1647132', quantity:400, best_before:"2020-10-01", product:bar2)
batch3 = Batch.create(code:'2167384', quantity:250, best_before:"2020-06-12", product:bar3)

order1 = Order.create(order_ref:"BAR-2361729")
order2 = Order.create(order_ref:"BAR-1237123")
order3 = Order.create(order_ref:"BAR-1267312")

BatchOrder.create(batch:batch1, order:order1, quantity:4)
BatchOrder.create(batch:batch2, order:order1, quantity:3)
BatchOrder.create(batch:batch3, order:order1, quantity:2)

BatchOrder.create(batch:batch1, order:order2, quantity:3)
BatchOrder.create(batch:batch2, order:order2, quantity:7)
BatchOrder.create(batch:batch3, order:order2, quantity:1)

BatchOrder.create(batch:batch1, order:order3, quantity:10)


