{-# LANGUAGE OverloadedStrings #-}

module DB (initConn, getAllSolves) where

import Database.SQLite.Simple
import Models

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

getAllSolves :: Connection -> IO [Solve]
getAllSolves conn = query_ conn "SELECT * FROM solves"
