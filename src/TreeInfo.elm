module TreeInfo exposing (..)

import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Input exposing (purple)
import Material.IconButton as IconButton
import Model exposing (..)


treeInfo : Model -> Element Msg
treeInfo model =
    let
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

        infoButton =
            myPadding <|
                html <|
                    IconButton.iconButton
                        (IconButton.config |> IconButton.setOnClick TreeInfoToggle)
                        (IconButton.icon "info_outlined")

        xButton =
            myPadding <|
                html <|
                    IconButton.iconButton
                        (IconButton.config |> IconButton.setOnClick TreeInfoToggle)
                        (IconButton.icon "highlight_off")
    in
    if model.treeInfoToggle == False then
        infoButton

    else
        column
            [ width fill
            , Background.color (rgb255 255 255 255)
            , alpha 0.875
            ]
            [ xButton
            , treeInfoText
            ]


treeInfoText : Element Msg
treeInfoText =
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
                [ text "We are initiating a new life together under the guidance of our Guru." ]
            , paragraph []
                [ text """**Due to Covid and restrictions on mass gatherings, we are keeping an intimate wedding. Please rsvp under the tree. The virtual tree generates a new element with each entry. It is a reminder of two families uniting. Since we wouldn’t have an official milni, we thought of creating a space where we can virtually know each other. """ ]
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
                        { src = "01_eldest-min.png"
                        , description = "eldest"
                        }
                    , text " >50 years of age"
                    ]
                , row
                    [ centerX
                    ]
                    [ image [ width (px 25) ]
                        { src = "02_elder-min.png"
                        , description = "elder"
                        }
                    , text "30-50 years of age"
                    ]
                , row
                    [ centerX
                    ]
                    [ image [ width (px 27) ]
                        { src = "03_adult-min.png"
                        , description = "adult"
                        }
                    , text "20-30 years of age"
                    ]
                , row
                    [ centerX
                    ]
                    [ image [ width (px 25) ]
                        { src = "04_young-min.png"
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
