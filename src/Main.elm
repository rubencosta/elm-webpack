module Main exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import Update exposing (update)
import View exposing (view)
import Players.Commands exposing (fetchAll)
import Routing exposing (Route)
import Navigation
import Hop.Types


init : ( Route, Hop.Types.Address ) -> ( Model, Cmd Msg )
init ( route, address ) =
    ( initialModel route address, Cmd.map PlayersMsg fetchAll )


urlUpdate : ( Route, Hop.Types.Address ) -> Model -> ( Model, Cmd Msg )
urlUpdate ( route, address ) model =
    ( { model | route = route, address = address }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never
main =
    Navigation.program Routing.urlParser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }
