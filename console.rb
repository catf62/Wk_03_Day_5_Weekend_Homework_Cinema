require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

require('pp')
require('pry-byebug')

# Customer.delete_all

customer1 = Customer.new({
  'name' => 'Ben',
  'funds' => 50
})
customer2 = Customer.new({
  'name' => 'Amy',
  'funds' => 20
  })
customer3 = Customer.new({
  'name' => 'Jenny',
  'funds' => 4
  })
customer4 = Customer.new({
  'name' => 'Pat',
  'funds' => 9
  })


film1 = Film.new({
  'title' => 'Superbad',
  'price' => 5
  })
film2 = Film.new({
  'title' => 'Hot Fuzz',
  'price' => 6
  })
film3 = Film.new({
  'title' => 'Back to the Future',
  'price' => 8
  })
film4 = Film.new({
  'title' => 'Avatar',
  'price' => 10
  })

  customer1.save()
  customer2.save()
  customer3.save()
  customer4.save()

  film1.save()
  film2.save()
  film3.save()
  film4.save()

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id
  })
ticket2 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film3.id
  })
ticket3 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film4.id
  })
ticket4 = Ticket.new({
  'customer_id' => customer4.id,
  'film_id' => film2.id
  })


ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()

ticket_by_id_test =  Ticket.find_by_id(ticket1.id)
film_by_id_test =  Film.find_by_id(film2.id)
customer_by_id_test = Customer.find_by_id(customer4.id)


# customer1.delete()
# film2.delete()
# ticket4.delete()

all_customers = Customer.find_all()
all_films = Film.find_all()
all_tickets = Ticket.find_all()

binding.pry
# customer1.name = 'Charlie'
# customer1.update()
# pp customer1

# film1.title = 'The Greatest Showman'
# film1.update()
# pp film1

# ticket1.customer_id = 238
# ticket1.update()
# pp ticket1

pp customer1.films_booked()
pp film1.customers_attending()

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

nil
