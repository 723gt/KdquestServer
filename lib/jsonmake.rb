
class Jsonmake
  SELECT_LIMIT = 5
  def initialze
    @name = Array.new(SELECT_LIMIT)
    @score = Array.new(SELECT_LIMIT)
    @chara = Array.new(SELECT_LIMIT)
    @level = nil
  end

  def  json_make
    jsontmpl = [
      {
        "name" : @name[0],
        "score" : @score[0],
        "chara" : @chara[0]
      },
      {
        "name" : @name[1],
        "score" : @score[1],
        "chara" : @chara[1]
      },
      {
        "name" : @name[2],
        "score" : @score[2],
        "chara" : @chara[2]
      },
      {
        "name" : @name[3],
        "score" : @score[3],
        "chara" : @chara[3]
      },
      {
        "name" : @name[4],
        "score" : @score[4],
        "chara" : @chara[4]
      }
     ]

	end

  def array_analysis(tbl_rank)
    tbl_rank.each_with_index do |data,i|
      @name[i] = data[0]
      @score[i] = data[1]
      @chara[i] = data[2]
    end
    json_make()
  end

  def json_out(jsontmpl)
    jsons = JSON.pretty_generate(jsontmpl)
    file = File.open("../json/#{@level}","w")
    file.puts(jsons)
  end
end