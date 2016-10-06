# KDクエスト ランキング表示システム　サーバ    

## ファイル説明  

 * server.rb 
   * サーバプログラム本体、オプション無しで実行。テストモードはオプション -t をつけて実行  
 * dbinit.sh
   * データベースを生成するシュルスクリプト  
 * Gemfile  
   * Ruby Games を管理するファイル  
 * lib/dbctrl.rb  
   * データベースを操作するプログラム  
 * ib/jsonmake.rb  
   * データベースの内容を元にJsonファイルを作成するプログラム   

## プログラムの実行方法  

### 初回のみ  
> $ chmod +x dbinit.sh  
> $ ./dbinit.sh  

### サーバの実行  
> $ ruby server.rb  

### サーバの実行(テストモード)  
> $ ruby server.rb -t