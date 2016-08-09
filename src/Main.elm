module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- APP


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    Int


model : Model
model =
    1


init : ( Model, Cmd Action )
init =
    ( model, Cmd.none )



-- UPDATE


type Action
    = Input String
    | Save


update : Action -> Model -> (Model, Cmd Action)
update action model =
    case action of
        _ ->
            (model, Cmd.none)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Action
subscriptions model =
    Sub.none



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
