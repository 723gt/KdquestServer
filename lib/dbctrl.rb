
class Dbctrl
	SELECT_LIMIT = 5
	DATA_TYPE = 3

  def initialize
		@db = SQLite3::Database.new("rank.db")
		@tbl_rankA = Array.new(SELECT_LIMIT){Array.new(DATA_TYPE)}
		@name = Array.new(SELECT_LIMIT)
		@score = Array.new(SELECT_LIMIT)
		@chara = Array.new(SELECT_LIMIT)
		@modeIn = nil
		@nameIn = nil
		@scoreIn = nil
		@charaIn = nil
	end

	def table_selct(modeIn)
		case modeIn
		when 0 then
			mode_db = "rank_easy"
		when 1 then 
			mode_db = "rank_normal"
		when 2 then
			mode_db = "rank_hard"
		end

		return mode_db
	end

	def dbctrl
    @db.transaction do 
			sql_ins = "INSERT INTO #{mode_db} (name,score,chara) VALUSE (?,?,?)"
			@db.execute(spl_ins,nameIn,scoreIn,charIn)

			spl_sel = "SELECT name,score,chara FROM #{mode_db} ORDER BY score DESC LIMIT #{SELECT_LIMIT}"
			@tbl_rankA = @db.execute(spl_sel)
		end		
		@db.close
	end
  

end