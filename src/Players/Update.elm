module Players.Update exposing (..)

import Navigation
import Players.Messages exposing (Msg(..))
import Players.Models exposing (Player, PlayerId)
import Players.Commands exposing (save)


update : Msg -> List Player -> ( List Player, Cmd Msg )
update msg players =
    case msg of
        FetchAllDone players' ->
            ( players', Cmd.none )

        FetchAllFail error ->
            ( players, Cmd.none )

        ShowPlayers ->
            ( players, Navigation.newUrl "#players" )

        ShowPlayer id ->
            ( players, Navigation.newUrl ("#players/" ++ (toString id)) )

        ChangeLevel id howMutch ->
            ( players, changeLevelCommands id howMutch players |> Cmd.batch )

        SaveSuccess player ->
            updatePlayer player players

        SaveFail string ->
            ( players, Cmd.none )


changeLevelCommands : PlayerId -> Int -> List Player -> List (Cmd Msg)
changeLevelCommands id howMutch players =
    let
        cmdForPlayer player =
            if player.id == id then
                save
                    { player | level = player.level + howMutch }
            else
                Cmd.none
    in
        List.map cmdForPlayer players


updatePlayer : Player -> List Player -> ( List Player, Cmd Msg )
updatePlayer updatedPlayer players =
    let
        updatePlayer player =
            if player.id == updatedPlayer.id then
                updatedPlayer
            else
                player
    in
        ( List.map updatePlayer players, Cmd.none )
