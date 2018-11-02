require_relative('../db/sql_runner')

class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO
    films( title, price)
    VALUES ( $1, $2 )
    RETURNING id"
    values = [ @title, @price ]
    result = SqlRunner.run( sql, values )
    @id = result[0]['id'].to_i
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM films WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return Film.new(result[0])
  end

  def self.find_all()
    sql = "SELECT * FROM films"
    values = []
    result = SqlRunner.run( sql, values )
    return Film.new(result[0])
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    values = []
    SqlRunner.run( sql, values )
  end

  def update()
    sql = "UPDATE films
    SET( title, price )
    = ( $1, $2 )
    WHERE id = $3"
    values = [ @title, @price, @id ]
    SqlRunner.run(sql,values)
  end

  def customers_attending()
    sql = "SELECT customers.*
    FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE film_id = $1"
    values = [@id]
    films = SqlRunner.run(sql,values)
    return films.map { |film| Customer.new(film) }
  end

  def number_of_customers_attending()
  film_customers_attending = self.customers_attending()
  return film_customers_attending.length
  end

end
