module Players.Update exposing (..)

import Players.Messages exposing (Msg(..))
import Players.Models exposing (Player)


update : Msg -> List Player -> ( List Player, Cmd Msg )
update msg players =
    case msg of
        FetchAllDone players' ->
            ( players', Cmd.none )
        FetchAllFail error ->
            ( players, Cmd.none )
