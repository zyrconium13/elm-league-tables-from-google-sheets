module Pages.MaybeResponse exposing (maybeResponse)

import Element exposing (..)
import Element.Attributes exposing (..)
import Html exposing (div)
import Html.Attributes exposing (class)
import Http exposing (..)
import LeagueStyleElements exposing (..)
import RemoteData exposing (WebData)


maybeResponse : WebData payload -> (payload -> Element Styles variation msg) -> Element Styles variation msg
maybeResponse response success =
    case response of
        RemoteData.NotAsked ->
            unhappyPathText unexpectedNotAskedMessage

        RemoteData.Loading ->
            loading

        RemoteData.Success payload ->
            success payload

        RemoteData.Failure error ->
            unhappyPathText <| httpErrorMessage error


unexpectedNotAskedMessage : String
unexpectedNotAskedMessage =
    "Hmmm, There is a bug in my code. You could report a bug at https://github.com/ceddlyburge/elm-league-tables-from-google-sheets/issues/new, or maybe try going back to the homepage and starting again"


httpErrorMessage : Http.Error -> String
httpErrorMessage error =
    case error of
        Http.Timeout ->
            "Timeout, maybe your WiFi is disabled or there is no connection to the internet."

        Http.NetworkError ->
            "Network error, maybe your WiFi is disabled or there is no connection to the internet."

        Http.BadPayload _ _ ->
            "Unexpected Payload. Hmmm, there is probably a problem in my configuration, please contact the League Administrator"

        Http.BadStatus _ ->
            "Bad Response. Hmmm, there is probably a problem in my configuration, please contact the League Administrator"

        Http.BadUrl _ ->
            "Bad Url. Hmmm, there is probably a problem in my configuration, please contact the League Administrator"



-- It is nice to wait before showing the loading animation, to avoid Jank
-- style-elements doesn't really support this, so using standard html / css


loading : Element style variation msg
loading =
    Html.div
        [ Html.Attributes.class "loading" ]
        [ Html.div
            [ Html.Attributes.class "la-ball-newton-cradle la-3x" ]
            [ Html.div [] []
            , Html.div [] []
            , Html.div [] []
            , Html.div [] []
            ]
        ]
        |> Element.html


unhappyPathText : String -> Element Styles variation msg
unhappyPathText string =
    paragraph UnhappyPathText [ width (percent 90) ] [ text string ]
