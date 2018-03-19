module Main exposing (..)

import Css exposing (..)
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)


main : Program Never String Msg
main =
    Html.beginnerProgram
        { model = ""
        , update = update
        , view = view
        }


type Msg
    = Input String


update : Msg -> String -> String
update msg model =
    case msg of
        Input model ->
            model


view : String -> Html Msg
view model =
    div
        [ css
            [ displayFlex
            , flexDirection column
            , Css.width (vw 100)
            , Css.height (vh 100)
            , margin auto
            ]
        ]
        [ textarea
            [ css
                [ Css.height (vh 20)
                , margin (vh 20)
                , fontFamilies [ "FiraCode-Retina", "Menlo", "monospace" ]
                , fontSize (px 30)
                ]
            , onInput Input
            ]
            []
        , viewString model
        ]


viewString : String -> Html Msg
viewString string =
    string
        |> String.split ""
        |> List.indexedMap viewChar
        |> ul
            [ css
                [ displayFlex
                , flexWrap Css.wrap
                , flexDirection row
                , justifyContent center
                , listStyle none
                , padding zero
                , margin zero
                ]
            ]


viewChar : Int -> String -> Html Msg
viewChar index char =
    let
        border =
            [ borderTop3 (px 1) solid (rgba 0 0 0 0.3)
            , borderRight3 (px 1) solid (rgba 0 0 0 0.3)
            , borderBottom3 (px 1) solid (rgba 0 0 0 0.3)
            ]
                |> List.append
                    (if index == 0 then
                        [ borderLeft3 (px 1) solid (rgba 0 0 0 0.3) ]
                     else
                        []
                    )
                |> Css.batch
    in
        li
            [ css
                [ displayFlex
                , flexDirection column
                , justifyContent flexEnd
                , border
                , padding (px 10)
                , if Basics.rem index 2 == 1 then
                    backgroundColor (rgba 74 144 226 0.25)
                  else
                    backgroundColor transparent
                ]
            ]
            [ span
                [ css
                    [ fontFamilies [ "FiraCode-Retina", "Menlo", "monospace" ]
                    , fontSize (px 30)
                    , fontWeight bold
                    , textAlign center
                    , marginBottom (px 10)
                    ]
                ]
                [ text char ]
            , Html.small
                [ css
                    [ fontFamilies [ "FiraCode-Retina", "Menlo", "monospace" ]
                    , fontSize (px 20)
                    , textAlign center
                    ]
                ]
                [ text <| toString index ]
            ]
