module ResultsFixturesViewForPlayedGameTest exposing (..)

import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text, class)
import Date exposing (..)
import Date.Extra exposing (..)

import Msg exposing (..)
import ResultsFixturesViewHelpers exposing (..)
import Models.Game exposing (vanillaGame)

onePlayedGame : Test
onePlayedGame =
    describe "Displays date, teams and score for played games"
        [ 
        test "date" <|
            \_ ->
                dayElement
                |> Query.find [ Test.Html.Selector.class "data-test-dayHeader" ]
                |> Query.has [ Test.Html.Selector.text "March 23, 2006" ]
        , test "homeTeamName" <|
            \_ ->
                dayElement
                |> Query.find [ Test.Html.Selector.class "data-test-homeTeamName" ]
                |> Query.has [ Test.Html.Selector.text "Castle"]
        , test "homeTeamGoalCountcorers" <|
            \_ ->
                dayElement
                |> Query.find [ Test.Html.Selector.class "data-test-homeTeamGoalCountcorers" ]
                |> Query.has [ Test.Html.Selector.text "Cedd, Lisa, Barry"]
        , test "homeTeamGoalCount" <|
            \_ ->
                dayElement
                |> Query.find [ Test.Html.Selector.class "data-test-homeTeamGoalCount" ]
                |> Query.has [ Test.Html.Selector.text "3"]
        , test "awayTeamGoalCountcorers" <|
            \_ ->
                dayElement
                |> Query.find [ Test.Html.Selector.class "data-test-awayTeamGoalCountcorers" ]
                |> Query.has [ Test.Html.Selector.text "Chad, Pog"]
        , test "awayTeamGoalCount" <|
            \_ ->
                dayElement
                |> Query.find [ Test.Html.Selector.class "data-test-awayTeamGoalCount" ]
                |> Query.has [ Test.Html.Selector.text "2"]
        , test "awayTeamName" <|
            \_ ->
                dayElement
                |> Query.find [ Test.Html.Selector.class "data-test-awayTeamName" ]
                |> Query.has [ Test.Html.Selector.text "Meridian"]
        ]

dayElement: Query.Single Msg
dayElement =
    html { vanillaGame | 
        datePlayed = Just <| Date.Extra.fromCalendarDate 2006 Mar 23
        , homeTeamName = "Castle"
        , homeTeamGoalCount = Just 3
        , homeTeamGoals = [ "Cedd" , "Lisa", "Barry" ]
        , awayTeamName = "Meridian"
        , awayTeamGoals = [ "Chad", "Pog" ]
        , awayTeamGoalCount = Just 2 }
    |> Query.find [ Test.Html.Selector.class "data-test-day" ]
