# KDクエスト ランキング表示システム　サーバ    
2016年学園祭 ゲーム結果処理のサーバ

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

*screen で端末を複数化しておく必要有り*

### サーバの実行(テストモード)  
> $ ruby server.rb -t
