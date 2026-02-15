module Main where

import Database.SQLite.Simple
import Network.Wai.Handler.Warp 
import DB
import App

main :: IO ()
main = do
    db <- initConn
    run 4000 app
    close db
