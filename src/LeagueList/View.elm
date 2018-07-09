module LeagueList.View exposing (..)

import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src, class)
import Html.Events exposing (onClick)

import Messages.Msg exposing ( .. )
import Models.Model exposing ( Model )
import Models.League exposing ( League )


view : Model -> Html Msg
view model =
    div  
        [ 
            class "leagues"
            , onClick Messages.Msg.SheetRequest -- this on click is here so that the end to end tests can trigger the request
        ] 
        [
            h1 [] [ text "Leagues" ]
            , div [] (List.map leagueTitle model.leagues)
        ]

leagueTitle : League -> Html Msg
leagueTitle league =
    div [ class "league"] [ text league.title ]
