require_relative("../db/sql_runner")

#template find and replace
# tablename = gym_classes
# classname capitalize = Gym_class
# first variable = name
# second varible = status
# third variable = >echo<
# code .to_i for relevant variables in initialize that are integers
#line 34,70 references number of variables of your class. edit as appropriate
#fill attr reader and attr accessor
class Gym_class
    attr_accessor :name, :status
    attr_reader :id
        #initialize
    def initialize( options )
        @id = options['id'].to_i if options['id']
        @name = options['name']
		if options['status'] != nil
			@status = options['status']
		else
			@status = "active"
		end
    end
        #create
    def create()
        sql = "INSERT INTO gym_classes
        (
            status,
            name
        )
        VALUES
        (
        $1, $2, $3
        )
        RETURNING id"
        values = [
                    @status,
                    @name]
        visit = SqlRunner.run(sql, values).first
        @id = visit['id'].to_i
    end
        #read all
    def self.find_all()
        sql = "SELECT * FROM gym_classes"
        query = SqlRunner.run(sql,[])
        return nil if query.first == nil
        return query.map { |value| self.new( value ) }
    end
        #find by id
    def self.find
        sql = "SELECT * FROM gym_classes WHERE id = $1"
        values = [@id]
        query = SqlRunner.run(sql,values).first()
        return nil if query.first == nil
        return self.new(query)
    end
        #delete all
    def self.delete_all()
        sql = "DELETE FROM gym_classes"
        SqlRunner.run(sql,[])
    end
        #delete by id
    def self.delete_by_id(id)
        sql = "DELETE FROM gym_classes WHERE id = $1"
        values = [id]
        query = SqlRunner.run(sql,values)
    end
        #update
    def update
        sql = "UPDATE gym_classes SET (status,name) = ($1,$2) WHERE id= $3"
        values = [@status,@name,@id]
        SqlRunner.run(sql,values)
    end

	def toggle_status
		if @status == "active"
			@status = "inactive"
			update()
		else
			@status = "active"
			update()
		end
	end
end
