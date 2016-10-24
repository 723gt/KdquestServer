require "sqlite3"
require "socket"
require "json"

class Dbctrl
  SELECT_LIMIT = 5
  DATA_TYPE = 3
  PROT = 8080
  DBPATH = "./db/rank.db"

  #コンストラクタ
  def initialize
    @tbl_rankA = Array.new(SELECT_LIMIT){Array.new(DATA_TYPE)}
    @modeIn = nil
    @nameIn = "unkhown"
    @scoreIn = 0
    @charaIn = 0
    @mode_db = nil
  end

  #解析したデータからdbのテーブルを選択する
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

  #解析したデータをdbに格納する 戻り値:ソート済みのデータ
  def db_ctrl
    begin
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
    rescue => e
    end

    return @tbl_rankA
  end

  #テスト用に標準入力
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

  #UDPデータを待ち受ける 戻り値:モード番号
  def udp_receive
    begin
      udps = UDPSocket.open()
      udps.bind("0.0.0.0",PROT)
      msg = udps.recv(65535)
      udps.close

      msg.slice!("[")
      msg.slice!("]")
      msg = msg.split(",")
     
      msg_analysis(msg)
      table_selct()
    rescue => e
    end
    
    return @mode_db
  end

  #データを解析する
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

  #受信したデータをハッシュに変換する 引数:受信したデータ 戻り値:変換済みのハッシュ
  def hash_make(msg)
    msg =	JSON.load(msg)

	  while msg.include?("\\") do
	  	msg.slice!("\\")
	  end
    return msg
  end
end
