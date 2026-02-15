{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module App (app) where

import Database.SQLite.Simple
import Network.Wai
import Servant
import Models
import DB
import Control.Monad.IO.Class

type AppAPI = "scrambles" :> Get '[JSON] [Scramble]

app :: Connection -> Application
app conn = serve (Proxy :: Proxy AppAPI) (appServer conn)

appServer :: Connection -> Server AppAPI
appServer conn = liftIO (getAllScrambles conn)
