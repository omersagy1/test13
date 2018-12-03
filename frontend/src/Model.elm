module Model exposing (City, Model)


type alias Model =
    { baseUrl : String
    , county : String
    , population : Int
    , resultCity : Maybe City
    }


type alias City =
    { name : String
    , population : Int
    }
