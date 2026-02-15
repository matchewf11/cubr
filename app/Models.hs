{-# LANGUAGE DeriveGeneric #-}

module Models (Scramble(..)) where

import GHC.Generics (Generic)
import Data.Aeson.Types
import Database.SQLite.Simple.FromRow

data Scramble = Scramble {
    scramble_id :: Int,
    scramble :: String,
    created_by :: String,
    created_at :: String
} deriving (Generic)

instance ToJSON Scramble

instance FromRow Scramble where
    fromRow = Scramble <$> field <*> field <*> field <*> field
