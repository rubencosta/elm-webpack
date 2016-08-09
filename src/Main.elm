module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Mouse
import Keyboard


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
    0


init : ( Model, Cmd Action )
init =
    ( model, Cmd.none )



-- UPDATE


type Action
    = MouseAction Mouse.Position
    | KeyboardAction Keyboard.KeyCode


update : Action -> Model -> (Model, Cmd Action)
update action model =
    case action of
        MouseAction position ->
            (model + 1, Cmd.none)
        KeyboardAction code ->
            (model + 1, Cmd.none)


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Action
subscriptions model =
    Sub.batch
        [ Mouse.clicks MouseAction
        , Keyboard.presses KeyboardAction ]



-- VIEW


view : Model -> Html Action
view model =
    div []
        [ div [] [ text (toString model) ]
        ]
