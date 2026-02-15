{-# LANGUAGE OverloadedStrings #-}

module DB (initConn) where

import Database.SQLite.Simple

createSolvesTable :: Query
createSolvesTable = "CREATE TABLE IF NOT EXISTS solves ( \
                    \solve_id INTEGER PRIMARY KEY AUTOINCREMENT, \
                    \scramble TEXT NOT NULL \
                    \)"

initConn :: IO Connection
initConn = do
    conn <- open "app.db"
    execute_ conn "PRAGMA foreign_keys = ON"
    execute_ conn createSolvesTable
    return conn
