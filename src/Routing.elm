module Routing exposing (..)

import Navigation
import UrlParser exposing ((</>))
import Hop
import Hop.Types exposing (Config, Address, Query)
import Players.Models exposing (PlayerId)


type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute


routes : UrlParser.Parser (Route -> a) a
routes =
    UrlParser.oneOf
        [ UrlParser.format PlayersRoute (UrlParser.s "")
        , UrlParser.format PlayerRoute (UrlParser.s "players" </> UrlParser.int)
        , UrlParser.format PlayersRoute (UrlParser.s "players")
        ]



-- oneOf
--     [ format PlayersRoute (s "")
--     , format PlayerRoute (s "players" </> int)
--     , format PlayersRoute (s "players")
--     ]


hopConfig : Config
hopConfig =
    { hash = True
    , basePath = ""
    }


parse : String -> Route
parse path =
    path
        |> UrlParser.parse identity routes
        |> Result.withDefault NotFoundRoute


urlParser : Navigation.Parser ( Route, Address )
urlParser =
    let
        resolver =
            Hop.makeResolver hopConfig parse
    in
        Navigation.makeParser (.href >> resolver)


routeFromResult : Result String Route -> Route
routeFromResult result =
    case result of
        Ok route ->
            route

        Err string ->
            NotFoundRoute
