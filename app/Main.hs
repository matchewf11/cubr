module Main where

import Network.Wai.Handler.Warp 
import App
import DB
import Database.SQLite.Simple

main :: IO ()
main = do
    let port = 4000
    conn <- initConn
    putStrLn ("Starting at port " ++ show port)
    run port (app conn)
    close conn
