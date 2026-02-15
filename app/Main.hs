module Main where

import Database.SQLite.Simple
import Network.Wai.Handler.Warp 
import DB
import App

main :: IO ()
main = do
    let port = 4000
    conn <- initConn
    putStrLn ("Starting at port " ++ show port)
    run port (app conn)
    close conn
