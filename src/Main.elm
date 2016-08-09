module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- APP


main : Program Never
main =
    App.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    Int


model : Model
model =
    1



-- UPDATE


type Action
    = Input String
    | Save


update : Action -> Model -> Model
update action model =
    case action of
        _ ->
            model



-- VIEW


view : Model -> Html Action
view model =
    div []
        [ Html.form
            [ onSubmit Save ]
            [ input
                [ type' "text"
                , onInput Input
                ]
                []
            ]
        , div [] [ text (toString model) ]
        ]
