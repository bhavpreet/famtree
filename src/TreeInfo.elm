module TreeInfo exposing (..)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html as Html exposing (Html)
import Html.Attributes as HAttr
import Input exposing (purple)
import Material.IconButton as IconButton
import Model exposing (..)


infoTreeButton : Model -> Element Msg
infoTreeButton model =
    let
        x : List (Html.Attribute Never) -> List (Html Never) -> Html Never
        x _ _ =
            Html.img
                [ HAttr.src "nb_infoicon.png"
                , HAttr.style "margin" "-10px"
                , HAttr.style "width" "35px"
                , HAttr.style "height" "35px"
                ]
                []

        -- layout [] <|
        --     image
        --         []
        --         { src = "nb_infoicon.png"
        --         , description = "Tree info toggle button"
        --         }
    in
    if model.treeInfoToggle == False then
        myPadding <|
            column []
                [ el
                    [ Border.rounded 50

                    -- , Border.color (rgb255 93 35 234)
                    , Border.width 1
                    ]
                  <|
                    html <|
                        IconButton.iconButton
                            (IconButton.config
                                |> IconButton.setOnClick TreeInfoToggle
                            )
                        <|
                            IconButton.customIcon x [] []

                -- , el
                --     [ centerX
                --     , Font.size 13
                --     , Font.color (rgb255 93 35 234)
                --     -- , Border.color (rgb255 93 35 234)
                --     ]
                --     (text "about")
                ]

    else
        el [] none


myPadding : Element Msg -> Element Msg
myPadding elem =
    el
        [ width (fill |> maximum 500)
        , centerX

        --, Background.color (rgb255 0 0 0)
        ]
    <|
        el
            [ alignRight
            , padding 40
            ]
            elem


treeInfo : Model -> Element Msg
treeInfo model =
    let
        xButton =
            myPadding <|
                el
                    [ Border.rounded 50

                    -- , Border.color (rgb255 93 35 234)
                    , Border.width 1
                    ]
                <|
                    html <|
                        IconButton.iconButton
                            (IconButton.config |> IconButton.setOnClick TreeInfoToggle)
                            (IconButton.icon "close")
    in
    if model.treeInfoToggle == False then
        el [] none

    else
        column
            [ width fill
            , Background.color (rgb255 255 255 255)
            , alpha 0.875
            ]
            [ xButton
            , treeInfoText model
            ]


treeInfoText : Model -> Element Msg
treeInfoText model =
    el
        [ centerX
        , paddingXY 10 0
        ]
    <|
        textColumn
            [ centerX
            , width (fill |> maximum 700)
            , paddingXY 40 0
            , spacing 18
            , Font.size 15
            ]
            [ paragraph []
                [ text "A new beginning 💝" ]
            , paragraph []
                [ text "We are initiating a new life together under the guidance of Sri Guru Granth Sahib." ]
            , paragraph []
                [ text """**Due to Covid and restrictions on mass gatherings, we are keeping an intimate wedding. Please rsvp under the tree. The virtual tree generates a new element with each entry. It is a reminder of two families uniting. We thought of creating a space where we can virtually know each other. """ ]
            , paragraph []
                [ text "Elements of the tree mapped to Age groups:"
                ]
            , column
                [ width fill
                , centerX
                ]
                [ row
                    [ centerX
                    ]
                    [ image [ width (px 27) ]
                        { src = model.assets.eldest
                        , description = "eldest"
                        }
                    , text " >50 years of age"
                    ]
                , row
                    [ centerX
                    ]
                    [ image [ width (px 25) ]
                        { src = model.assets.elder
                        , description = "elder"
                        }
                    , text "30-50 years of age"
                    ]
                , row
                    [ centerX
                    ]
                    [ image [ width (px 27) ]
                        { src = model.assets.adult
                        , description = "adult"
                        }
                    , text "20-30 years of age"
                    ]
                , row
                    [ centerX
                    ]
                    [ image [ width (px 25) ]
                        { src = model.assets.child
                        , description = "child"
                        }
                    , text "<20 years of age"
                    ]
                ]
            , column
                [ centerX
                , spacing 9
                ]
                [ el [ centerX ] (text "Discover the tree of love 💖")
                , el [ centerX ] (text "Symbolising a new life,")
                , el [ centerX ] (text "a new possibility of growth.")
                ]
            , paragraph []
                [ text "For any suggestions to improve this site, please write to us at "
                , link [ Font.color purple ]
                    { url = "natbhavs@gmail.com"
                    , label = text "natbhavs@gmail.com"
                    }
                ]
            , el [ padding 40 ] none
            ]
