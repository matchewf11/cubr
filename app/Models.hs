{-# LANGUAGE DeriveGeneric #-}

module Models where

import GHC.Generics (Generic)
import Data.Aeson.Types
import Database.SQLite.Simple.FromRow

data GetAllScramblesResponse = GetAllScramblesResponse {
    cursor :: Maybe String,
    scrambles :: [GetScrambleResponse]
} deriving (Generic)
instance ToJSON GetAllScramblesResponse

data GetScrambleResponse = GetScrambleResponse {
    scramble_id :: Int,
    scramble :: String,
    created_by :: String,
    created_at :: String
} deriving (Generic)
instance ToJSON GetScrambleResponse
instance FromRow GetScrambleResponse where
    fromRow = GetScrambleResponse <$> field <*> field <*> field <*> field
