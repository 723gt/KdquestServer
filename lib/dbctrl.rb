require "sqlite3"
require "socket"

class Dbctrl
  SELECT_LIMIT = 5
  DATA_TYPE = 3
  PROT = 8080
  DBPATH = "./db/rank.db"

  def initialize(jsonmake)
    @jsonmake = jsonmake
    @db = SQLite3::Database.new(DBPATH)
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
    @db.transaction do |tr|
      sql_id = "SELECT max(id) FROM #{@mode_db}"
      getid = tr.execute(sql_id)
      id = getid[0][0]
      if id == nil then
        id = 1
      else
        id += 1
      end

      sql_ins = "INSERT INTO #{@mode_db} VALUES (?,?,?,?)"
      tr.execute(sql_ins,id,@nameIn,@scoreIn,@charaIn)

      spl_sel = "SELECT name,score,chara FROM #{@mode_db} ORDER BY score DESC LIMIT #{SELECT_LIMIT}"
      @tbl_rankA = tr.execute(spl_sel)
    end		
    @db.close
  end

  def test_input
    print "mode:"
    @modeIn = STDIN.gets.to_i
    print "name:"
    @nameIn = STDIN.gets.to_s
    print "score:"
    @scoreIn = STDIN.gets.to_i
    print "chara:"
    @charaIn = STDIN.gets.to_i
    class_ctrl()
  end

  def udp_receive
    udps = UDPSocket.open()
    udps.bind("0.0.0.0",PROT)
    msg = udps.recv(65535)
    class_ctrl()
  end

  def msg_analysis(msg)
    msg.each do |hash|
      case hash.key
      when "name"
        @nameIn = hash.values
      when "score"
        @scoreIn = hash.values.to_i
      when "difficult"
        @modeIn = hash.values.to_i
      when "character"
        @charaIn = hash.values.to_i
      end 
    end
  end

  def class_ctrl
    table_selct()
    db_ctrl()
    @jsonmake.class_ctrl(@tbl_rankA,@mode_db)
  end
  

end
