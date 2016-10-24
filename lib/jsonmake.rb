require "json"

class Jsonmake
  SELECT_LIMIT = 5
  JSONPATH = "./json/"

  #コンストラクタ
  def initialize
    @name = Array.new(SELECT_LIMIT)
    @score = Array.new(SELECT_LIMIT)
    @chara = Array.new(SELECT_LIMIT)
    @mode = nil
  end

  #出力用のjsonテンプレートにデータを格納
  def  json_make
    jsontmpl = [
      {
        "name" => @name[0],
        "score" => @score[0],
        "chara" => @chara[0]
      },
      {
        "name" => @name[1],
        "score" => @score[1],
        "chara" => @chara[1]
      },
      {
        "name" => @name[2],
        "score" => @score[2],
        "chara" => @chara[2]
      },
      {
        "name" => @name[3],
        "score" => @score[3],
        "chara" => @chara[3]
      },
      {
        "name" => @name[4],
        "score" => @score[4],
        "chara" => @chara[4]
      }
     ]

     json_out(jsontmpl)
  end
  
  #dbから取得したデータ配列を解析
  def array_analysis(tbl_rank)
    tbl_rank.each_with_index do |data,i|
      @name[i] = data[0]
      @score[i] = data[1]
      @chara[i] = data[2]
    end
    json_make()
  end

  #jsonファイルを出力する
  def json_out(jsontmpl)
    begin
      jsons = JSON.pretty_generate(jsontmpl)
      file = File.open("#{JSONPATH}#{@mode}.json","w")
      file.puts(jsons)
      file.close
      puts "Json file output filename:#{JSONPATH}#{@mode}.json"
    rescue => e
    end
  end

  #インスタンス変数への格納とメソッド呼び出し
  def class_ctrl(tbl_rank,mode)
    @mode = mode
    array_analysis(tbl_rank)
  end
end
