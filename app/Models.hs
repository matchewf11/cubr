{-# LANGUAGE DeriveGeneric #-}

module Models (Solve(..)) where

import GHC.Generics (Generic)
import Data.Aeson.Types
import Database.SQLite.Simple.FromRow

data Solve = Solve {
    sovleId :: Int,
    scramble :: String
} deriving (Generic)

instance ToJSON Solve

instance FromRow Solve where
    fromRow = Solve <$> field <*> field
