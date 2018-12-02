module Message exposing (Message(..))

import Http


type Message
    = PickCounty
    | GotCounty (Result Http.Error String)
