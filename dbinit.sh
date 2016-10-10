#!/bin/sh

if [ ! -e db/rank.db ]; then
  cd db
  sqlite3 rank.db "create table rank_easy(id INTEGER PRAIMARY KEY,name TEXT NOT NULL,score INTEGER NOT NULL,chara INTEGER NOT NULL)"
  sqlite3 rank.db "create table rank_normal(id INTEGER PRAIMARY KEY,name TEXT NOT NULL,score INTEGER NOT NULL,chara INTEGER NOT NULL)"
  sqlite3 rank.db "create table rank_hard(id INTEGER PRAIMARY KEY,name TEXT NOT NULL,score INTEGER NOT NULL,chara INTEGER NOT NULL)"

  echo "db create"
  cd ../
fi

if [ ! -e json/rank_easy.json ]; then
  touch json/rank_easy.json
  echo "rank_easy.json create"
fi

if [ ! -e json/rank_normal.json ]; then
  touch json/rank_normal.json
  echo "rank_normal.json create"
fi

if [ ! -e json/rank_hard.json ]; then
  touch json/rank_hard.json
  echo "rank_hard.json create"
fi
