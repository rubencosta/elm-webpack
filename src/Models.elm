module Models exposing (..)

import Players.Models exposing (Player)
import Routing
import Hop.Types


type alias Model =
    { players : List Player
    , route : Routing.Route
    , address : Hop.Types.Address
    }


initialModel : Routing.Route -> Hop.Types.Address -> Model
initialModel route address =
    { players = []
    , route = route
    , address = address
    }
