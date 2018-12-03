module View exposing (view)

import Html exposing (Html, button, div, input, text)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onClick, onInput)
import Message exposing (Message(..))
import Model exposing (City, Model)


view : Model -> Html Message
view model =
    div []
        [ button [ onClick PickCounty ] [ text "Give me a random county!" ]
        , div [] [ text model.county ]
        , populationSearch model.population
        , cityDisplay model.resultCity
        ]


populationSearch : Int -> Html Message
populationSearch currentValue =
    div []
        [ button [ onClick (SearchPopulation currentValue) ] [ text "City with population nearest to:" ]
        , input
            [ placeholder "10000"
            , value (String.fromInt currentValue)
            , onInput (String.toInt >> Maybe.withDefault 0 >> ChangePopulation)
            ]
            []
        ]


cityDisplay : Maybe City -> Html Message
cityDisplay result =
    case result of
        Nothing ->
            div [] [ text "No result..." ]

        Just city ->
            div []
                [ div [] [ text city.name ]
                , div [] [ text ("population: " ++ String.fromInt city.population) ]
                ]
