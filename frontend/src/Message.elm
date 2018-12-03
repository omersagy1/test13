module Message exposing (Message(..))

import Http
import Model exposing (City)


type Message
    = PickCounty
    | GotCounty (Result Http.Error String)
    | ChangePopulation Int
    | SearchPopulation Int
    | GotCity (Result Http.Error City)
