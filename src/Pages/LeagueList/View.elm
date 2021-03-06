module Pages.LeagueList.View exposing (page)

import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (onClick)
import LeagueStyleElements exposing (..)
import Models.Config exposing (Config)
import Models.LeagueSummary exposing (LeagueSummary)
import Msg exposing (..)
import Pages.HeaderBar exposing (..)
import Pages.HeaderBarItem exposing (..)
import Pages.MaybeResponse exposing (..)
import Pages.Page exposing (..)
import Pages.Responsive exposing (..)
import RemoteData exposing (WebData)


page : Config -> WebData (List LeagueSummary) -> Responsive -> Page
page config response responsive =
    Page
        (SingleHeader <|
            HeaderBar
                [ HeaderButtonSizedSpace ]
                config.applicationTitle
                [ RefreshHeaderButton RefreshLeagueList ]
        )
        (maybeResponse response <| leagueList responsive)


leagueList : Responsive -> List LeagueSummary -> Element Styles variation Msg
leagueList responsive leagueSummaries =
    column
        None
        [ width (percent 100)
        , class "data-test-leagues"
        ]
        (List.map (leagueTitle responsive) leagueSummaries)


leagueTitle : Responsive -> LeagueSummary -> Element Styles variation Msg
leagueTitle responsive league =
    el
        LeagueListLeagueTitle
        [ padding responsive.mediumGap
        , spacing responsive.smallGap
        , width <| percent responsive.designPortraitPercentageWidth
        , class "data-test-league"
        , center
        , onClick <| ShowLeagueTable league.title
        ]
        (paragraph None [] [ text league.title ])
