require_relative('../db/sqlrunner')

class GymClass
    attr_accessor :name, :status
    attr_reader :id
        #initialize
    def initialize( options )
        @id = options['id'].to_i if options['id']
        @name = options['name']
		if !options['status']
			@status = "active"
		else
			@status = options['status']
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
        $1, $2
        )
        RETURNING *"
        values =[@status,@name]
        query = SqlRunner.run(sql, values).first
        @id = query['id'].to_i
		return GymClass.new(query)
    end
        #read all
    def self.find_all()
        sql = "SELECT * FROM gym_classes"
        query = SqlRunner.run(sql,[])
        return nil if query.first == nil
        return query.map { |value| self.new( value ) }
    end
        #find by id
    def find
        sql = "SELECT * FROM gym_classes WHERE id = $1"
        values = [@id]
        query = SqlRunner.run(sql,values)
        return nil if query.first == nil
        return GymClass.new(query.first)
    end

        #delete by id
    def delete
        sql = "DELETE FROM gym_classes WHERE id = $1"
        values = [@id]
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
