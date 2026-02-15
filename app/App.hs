{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DeriveGeneric #-}

module App (app) where

import Network.Wai
import Servant
import GHC.Generics (Generic)
import Data.Aeson.Types

type AppAPI = "solves" :> Get '[JSON] [Solve]

data Solve = Solve {
    scramble :: String
} deriving (Generic)

instance ToJSON Solve

app :: Application
app = serve appAPI appServer

appAPI :: Proxy AppAPI
appAPI = Proxy

appServer :: Server AppAPI
appServer = return solves

solves :: [Solve]
solves = 
    [ Solve "TEST SCRAMBLE"
    , Solve "TEST SCRAMBLE"
    ]
