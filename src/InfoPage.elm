module InfoPage exposing (..)

import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Material.Button as Button
import Model exposing (..)
import Sheets exposing (..)
import Sketch exposing (..)


infoPage : Model -> Element Msg
infoPage model =
    html <|
        layout
            [ width (px model.window.width)
            , height (px model.window.height)
            , inFront <|
                el
                    [ Background.color (rgb255 255 255 255)
                    , height (px 100)
                    , width fill
                    ]
                    none
            , inFront <|
                el
                    [ Background.color (rgb255 255 255 255)
                    , height (px 85)
                    , width fill
                    , alignBottom
                    ]
                    none
            , inFront <|
                image
                    [ width (fill |> maximum 350)
                    , alignTop
                    , alignRight
                    ]
                    { src = "invitation-header-right.png"
                    , description = "Floral background image header"
                    }
            , inFront <|
                image
                    [ width (fill |> maximum 350)
                    , alignBottom
                    , alignLeft
                    ]
                    { src = "invitation-footer-left.png"
                    , description = "Floral background image footer"
                    }
            , inFront <|
                image
                    [ width (fill |> maximum 350)
                    , alignBottom
                    , alignRight
                    ]
                    { src = "invitation-footer-right.png"
                    , description = "Floral background image footer"
                    }
            , inFront <|
                column
                    [ -- height fill
                      -- , width fill
                      alignBottom
                    , centerX
                    ]
                    [ el
                        [ alignBottom
                        , centerX
                        ]
                      <|
                        html <|
                            Button.raised
                                (Button.config |> Button.setOnClick InfoOK)
                                "Welcome!"
                    , el
                        [ padding 50
                        , alignBottom
                        ]
                        none
                    ]
            ]
        <|
            column
                [ centerX
                , width fill
                , height (px model.window.height)

                -- , inFront <| infoPage model
                ]
                [ message1 model
                , el [ padding 70 ] none
                ]


gurmukhiHeader : Int -> Element Msg
gurmukhiHeader height_ =
    column
        [ centerX
        , Font.bold
        , spacing 4
        ]
        [ el [ height (px <| height_ // 14) ] none
        , paragraph
            [ centerX ]
            [ text "ੴ ਸਤਗੁਰ ਪ੍ਰਸਾਦ ।।" ]
        , el [ padding 3 ] none
        , paragraph
            [ centerX ]
            [ text "ਨਾਨਕ ਸਤਗੁਰੁ ਤਿਨਾ ਮਿਲਾਇਆ," ]
        , paragraph [ centerX ]
            [ text "ਜਿਨਾ ਧੁਰੇ ਪਇਆ ਸੰਜੋਗੁ ।।" ]
        , el [ height (px <| height_ // 74) ] none
        ]


message1 : Model -> Element Msg
message1 model =
    textColumn
        [ width (fill |> maximum 700)

        -- , height <| px 100
        -- , Background.color (rgb255 0 0 0)
        , centerX
        , spacing 10
        , paddingXY 70 90

        -- , centerY
        ]
        [ gurmukhiHeader model.window.height
        , el
            [ centerX
            , Font.bold
            , padding 15
            ]
            (text "Invitation 💝")
        , paragraph []
            [ text "A new beginning" ]
        , paragraph []
            [ text "We are initiating a new life together under the guidance of our Guru. The occasion is celebrated at gurudwara Shri Guru Nanak\u{00A0}Satsang" ]
        , paragraph []
            [ text """**Due to Covid and restrictions on mass gatherings, we are keeping an intimate wedding and
Thus request to have only two members per family. Join us with your blissful presence.
Please rsvp under the tree of our clan. """
            ]
        , paragraph []
            [ text """For those lovely members of our clan who are outside the country and might not be able to join us,
you can leave us a message under this tree of our clan. """
            ]
        , paragraph []
            [ text """The virtual tree is a reminder of two families uniting. Since we wouldn’t have an official milni, we thought of creating a space where we can virtually know each other. """ ]
        , paragraph []
            [ text """Discover the tree of love 💖
Symbolising a new life,
a new possibility of growth.""" ]
        ]
