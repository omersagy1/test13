module Main exposing (Message(..), Model, init, main, update, view)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
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
    { result : String
    }


type Location
    = State StateCode


type alias StateCode =
    String


init : () -> ( Model, Cmd Message )
init _ =
    ( { result = "" }, Cmd.none )


type Message
    = PickLocation
    | NewLocation ( Maybe Location, List Location )


update : Message -> Model -> ( Model, Cmd Message )
update msg model =
    case msg of
        PickLocation ->
            ( model, Random.generate NewLocation (Random.List.choose [ State "Alabama", State "Alaska" ]) )

        NewLocation ( newLocation, notPicked ) ->
            case newLocation of
                Nothing ->
                    ( { result = "" }, Cmd.none )

                Just (State code) ->
                    ( { result = code }, Cmd.none )


view : Model -> Html Message
view model =
    div []
        [ button [ onClick PickLocation ] [ text "Where should I live?" ]
        , div [] [ text model.result ]
        ]
