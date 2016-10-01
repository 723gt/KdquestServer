#!/bin/sh

cd db
sqlite3 rank.db "create table rank_easy(id INTEGER PRAIMARY KEY,name TEXT NOT NULL,score INTEGER NOT NULL,chara INTEGER NOT NULL)"
sqlite3 rank.db "create table rank_normal(id INTEGER PRAIMARY KEY,name TEXT NOT NULL,score INTEGER NOT NULL,chara INTEGER NOT NULL)"
sqlite3 rank.db "create table rank_hard(id INTEGER PRAIMARY KEY,name TEXT NOT NULL,score INTEGER NOT NULL,chara INTEGER NOT NULL)"
