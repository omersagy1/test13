module Main exposing (init, main, update)

import Browser
import Http
import Json.Decode exposing (Decoder, field, int, string)
import Message exposing (Message(..))
import Model exposing (City, Model)
import Random
import Random.List
import View


main =
    Browser.element
        { init = init
        , update = update
        , view = View.view
        , subscriptions = \m -> Sub.none
        }


init : { baseUrl : String } -> ( Model, Cmd Message )
init flags =
    ( { county = ""
      , baseUrl = ""
      , population = 10000
      , resultCity = Nothing
      }
    , Cmd.none
    )


update : Message -> Model -> ( Model, Cmd Message )
update msg model =
    case msg of
        PickCounty ->
            ( model, getRandomCounty model.baseUrl )

        GotCounty result ->
            case result of
                Ok countyName ->
                    ( { model | county = countyName }, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )

        ChangePopulation pop ->
            ( { model | population = pop }, Cmd.none )

        SearchPopulation pop ->
            ( model, searchCityByPopulation model.baseUrl pop )

        GotCity result ->
            case result of
                Ok city ->
                    ( { model | resultCity = Just city }, Cmd.none )

                Err _ ->
                    ( { model | resultCity = Nothing }, Cmd.none )


getRandomCounty : String -> Cmd Message
getRandomCounty baseUrl =
    Http.get
        { url = baseUrl ++ "/api/random/county"
        , expect = Http.expectJson GotCounty countyDecoder
        }


countyDecoder : Decoder String
countyDecoder =
    field "county" string


searchCityByPopulation : String -> Int -> Cmd Message
searchCityByPopulation baseUrl pop =
    Http.get
        { url = baseUrl ++ "/api/city?pop=" ++ String.fromInt pop
        , expect = Http.expectJson GotCity cityDecoder
        }


cityDecoder : Decoder City
cityDecoder =
    Json.Decode.map2 City
        (field "city" string)
        (field "population" int)
