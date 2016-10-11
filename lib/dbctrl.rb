require "sqlite3"
require "socket"

class Dbctrl
  SELECT_LIMIT = 5
  DATA_TYPE = 3
  PROT = 8080
  DBPATH = "./db/rank.db"

  def initialize
    @tbl_rankA = Array.new(SELECT_LIMIT){Array.new(DATA_TYPE)}
    @modeIn = nil
    @nameIn = "unkhown"
    @scoreIn = 0
    @charaIn = 0
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
    db = SQLite3::Database.new(DBPATH)
    db.transaction do |tr|
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
    db.close
    return @tbl_rankA
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

    table_selct()
    return @mode_db
  end

  def udp_receive
    udps = UDPSocket.open()
    udps.bind("0.0.0.0",PROT)
    msg = udps.recv(65535)
    udps.close

    #test file out 
    time = Time.now
    testfile = "#{time.month}_#{time.day}_#{time.hour}_#{time.min}_#{time.sec}"
    file = File.open("./test/#{testfile}.txt","w")
    file.puts(msg)
    file.close

    msg.slice!("[")
    msg.slice!("]")
    msg = msg.split(",")
     
    msg_analysis(msg)
    table_selct()
    return @mode_db
  end

  def msg_analysis(msg)
    msg.each do |st|
      hash = hash_make(st)
      key = hash.keys[0]
      val = hash.values[0]
      key.to_s
      
      case key
      when "name" then
        @nameIn = val.to_s
      when "score" then
        @scoreIn = val.to_i
      when "difficult" then
        @modeIn = val.to_i
      when "character" then
        @charaIn = val.to_i
      end
    end
  end

  def hash_make(msg)
    /:/ =~ msg
      key = $'
    /=/ =~ key
      key = $`
    
    />/ =~ msg
      val = $'
    val.slice!("}")

    if key == "name" then
      2.times do
        val.slice!("\"") 
      end
    end
    hash = {"#{key}" => "#{val}"}
    return hash
  end
end
