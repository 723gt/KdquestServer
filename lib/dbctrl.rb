require "sqlite3"

class dbctrl
  SELECT_LIMIT = 5
  DATA_TYPE = 3

  def initialize(jsonmake)
    @jsonmake = jsonmake
    @db = SQLite3::Database.new("rank.db")
    @tbl_rankA = Array.new(SELECT_LIMIT){Array.new(DATA_TYPE)}
    @modeIn = nil
    @nameIn = nil
    @scoreIn = nil
    @charaIn = nil
    @mode_db = nil
  end

  def table_selct
	  case @modeIn
	  when 0 then
	    @mode_db = "rank_easy"
  	when 1 then 
	    @mode_db = "rank_normal"
	  when 2 then
	    @mode_db = "rank_hard"
	  end
  end

  def db_ctrl
    @db.transaction do 
	    sql_ins = "INSERT INTO #{mode_db} (name,score,chara) VALUSE (?,?,?)"
	    @db.execute(spl_ins,nameIn,scoreIn,charIn)

	    spl_sel = "SELECT name,score,chara FROM #{mode_db} ORDER BY score DESC LIMIT #{SELECT_LIMIT}"
	    @tbl_rankA = @db.execute(spl_sel)
    end		
    @db.close
  end

  def test_input
    print "mode"
    @modeIn = gets.to_i
    print "name"
    @nameIn = gets.to_s
    print "score"
    @scoreIn = gets.to_i
    print "chara"
    @charaIn = gets.to_i
    class_ctrl()
  end

  def udp_receive
  end

  def class_ctrl
    table_selct()
    db_ctrl()
    @jsonmake.class_ctrl(@tbl_rankA,@modeIn)
  end
  

end
