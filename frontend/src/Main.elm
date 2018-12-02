module Main exposing (Message(..), Model, init, main, update, view)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Http
import Json.Decode exposing (Decoder, field, string)
import Random
import Random.List


main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = \m -> Sub.none
        }


type alias Model =
    { baseUrl : String
    , county : String
    }


type Location
    = State StateCode


type alias StateCode =
    String


init : { baseUrl : String } -> ( Model, Cmd Message )
init flags =
    ( { county = ""
      , baseUrl = ""
      }
    , Cmd.none
    )


type Message
    = PickCounty
    | GotCounty (Result Http.Error String)


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


getRandomCounty : String -> Cmd Message
getRandomCounty baseUrl =
    Http.get
        { url = baseUrl ++ "/api/random/county"
        , expect = Http.expectJson GotCounty countyDecoder
        }


countyDecoder : Decoder String
countyDecoder =
    field "county" string


view : Model -> Html Message
view model =
    div []
        [ button [ onClick PickCounty ] [ text "Give me a random county!" ]
        , div [] [ text model.county ]
        ]
