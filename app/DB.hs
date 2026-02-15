{-# LANGUAGE OverloadedStrings #-}

module DB (initConn, getAllScrambles) where

import Database.SQLite.Simple
import Models

initConn :: IO Connection
initConn = do
    conn <- open "app.db"
    mapM_ (execute_ conn) initQueries
    return conn

getAllScrambles :: Connection -> IO [GetScrambleResponse]
getAllScrambles conn = query_ conn "SELECT * FROM scrambles"

initQueries :: [Query]
initQueries = 
    [ "PRAGMA foreign_keys = ON"
    , "CREATE TABLE IF NOT EXISTS users (\
    \ user_id INTEGER PRIMARY KEY AUTOINCREMENT,\
    \ username TEXT NOT NULL UNIQUE CHECK (username GLOB '[A-Za-z0-9]?*'),\
    \ password TEXT NOT NULL,\
    \ created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP\
    \ )"
    , "CREATE TABLE IF NOT EXISTS scrambles (\
    \ scramble_id INTEGER PRIMARY KEY AUTOINCREMENT,\
    \ scramble TEXT NOT NULL,\
    \ created_by INTEGER,\
    \ created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,\
    \ FOREIGN KEY(created_by) REFERENCES users(user_id) ON DELETE SET NULL\
    \ )"
    , "CREATE INDEX IF NOT EXISTS idx_scrambles_created_at ON scrambles(created_at)"
    , "CREATE INDEX IF NOT EXISTS idx_scrambles_created_by ON scrambles(created_by)"
    , "CREATE TABLE IF NOT EXISTS sessions (\
    \ session_id INTEGER PRIMARY KEY AUTOINCREMENT,\
    \ name TEXT NOT NULL,\
    \ created_by INTEGER,\
    \ created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,\
    \ FOREIGN KEY(created_by) REFERENCES users(user_id) ON DELETE CASCADE,\
    \ UNIQUE(name, created_by)\
    \ )"
    , "CREATE TABLE IF NOT EXISTS solves (\
    \ solve_id INTEGER PRIMARY KEY AUTOINCREMENT,\
    \ scramble_id INTEGER NOT NULL,\
    \ session_id INTEGER NOT NULL,\
    \ created_by INTEGER NOT NULL,\
    \ time TEXT NOT NULL,\
    \ created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,\
    \ FOREIGN KEY(scramble_id) REFERENCES scrambles(scramble_id) ON DELETE RESTRICT,\
    \ FOREIGN KEY(session_id) REFERENCES sessions(session_id) ON DELETE CASCADE,\
    \ FOREIGN KEY(created_by) REFERENCES users(user_id) ON DELETE CASCADE\
    \ )"
    , "CREATE INDEX IF NOT EXISTS idx_solves_time ON solves(time)"
    , "CREATE INDEX IF NOT EXISTS idx_solves_created_at ON solves(created_at)"
    , "CREATE INDEX IF NOT EXISTS idx_solves_session_id ON solves(session_id)"
    , "CREATE INDEX IF NOT EXISTS idx_solves_created_by ON solves(created_by)"
    ]
