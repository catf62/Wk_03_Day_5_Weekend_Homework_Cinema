require_relative('../db/sql_runner')

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize( options )
  @id = options['id'].to_i if options['id']
  @name = options['name']
  @funds = options ['funds'].to_i
  end

  def save()
    sql = "INSERT INTO
    customers ( name, funds )
    VALUES ( $1, $2 )
    RETURNING id"
    values = [ @name, @funds ]
    result = SqlRunner.run( sql, values )
    @id = result[0]['id'].to_i
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [id]
    result = SqlRunner.run( sql, values )
    return Customer.new(result[0])
  end

  def self.find_all()
    sql = "SELECT * FROM customers"
    values = []
    result = SqlRunner.run( sql, values )
    return Customer.new(result[0])
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run( sql, values )
  end

  def update()
    sql = "UPDATE customers
    SET( name, funds )
    = ( $1, $2 )
    WHERE id = $3"
    values = [ @name, @funds, @id ]
    SqlRunner.run(sql,values)
  end

  def films_booked()
    sql = "SELECT films.*
    FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE customer_id = $1"
    values = [@id]
    films = SqlRunner.run(sql,values)
    return films.map { |film| Film.new(film) }
  end

  def pay_for_tickets()
    tickets = self.films_booked()
    ticket_prices = tickets.map{ |ticket| ticket.price }
    tickets_cost = ticket_prices.sum
    return @funds - tickets_cost
  end

  def number_of_films_booked()
  customer_films_booked = self.films_booked()
  return customer_films_booked.length
  end

end
