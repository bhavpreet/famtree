module InfoPage exposing (..)

import Element exposing (..)
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

            -- , Background.color (rgb255 249 223 179)
            , behindContent <|
                image
                    [ width (fill |> maximum 350)
                    , alignTop
                    , alignRight
                    ]
                    { src = model.assets.headerBgRight
                    , description = "Floral background image header"
                    }
            , behindContent <|
                image
                    [ width (fill |> maximum 350)
                    , alignBottom
                    , alignLeft
                    ]
                    { src = model.assets.footerBgLeft
                    , description = "Floral background image footer"
                    }
            , behindContent <|
                image
                    [ width (fill |> maximum 350)
                    , alignBottom
                    , alignRight
                    ]
                    { src = model.assets.footerBgRight
                    , description = "Floral background image footer"
                    }
            , inFront <| infoButtonLogic model
            ]
        <|
            column
                [ centerX
                , width fill
                , height (px model.window.height)

                -- , inFront <| infoPage model
                ]
                [ headerPadding
                , el
                    [ height <|
                        px
                            (model.window.height
                                - (headerHeight + footerHeight)
                            )
                    , scrollbarY
                    , centerX
                    ]
                  <|
                    messageLogic model
                , footerPadding
                ]


messageLogic : Model -> Element Msg
messageLogic model =
    if model.infoOK1 == False then
        message1 model

    else
        message2 model


gurmukhiHeader : Int -> Int -> Element Msg
gurmukhiHeader w h =
    column
        [ centerX
        , Font.bold
        , Font.color (rgb255 158 130 48)
        , spacing 4
        ]
        [ row
            [ centerX
            , width fill
            , spaceEvenly
            ]
            [ el [ Font.size 30 ] (text "☬")
            , paragraph
                [ centerX ]
                [ text "ੴ ਸਤਗੁਰ ਪ੍ਰਸਾਦਿ ।।" ]
            , el [ Font.size 30 ] (text "☬")
            ]
        , el [ padding 3 ] none
        , paragraph
            [ centerX ]
            [ text "ਨਾਨਕ ਸਤਗੁਰੁ ਤਿਨਾ ਮਿਲਾਇਆ" ]
        , paragraph [ centerX ]
            [ text "ਜਿਨਾ ਧੁਰੇ ਪਇਆ ਸੰਜੋਗੁ ।।" ]
        , el [ height (px <| h // 74) ] none
        ]


message1 : Model -> Element Msg
message1 model =
    textColumn
        [ width (fill |> maximum 700)

        -- , height <| px 100
        -- , Background.color (rgb255 0 0 0)
        , centerX
        , centerY
        , spacing 2
        , paddingXY 70 0
        , Font.family
            [ Font.typeface "Courgette"
            ]
        , Font.size 15

        -- , centerY
        ]
        [ el [ paddingXY 0 (model.window.height // 54) ] none
        , gurmukhiHeader model.window.width model.window.height
        , el [ padding 3 ] none
        , paragraph []
            [ text "You are cordially invited to the" ]
        , paragraph []
            [ text "wedding ceremony of" ]
        , el [ padding 9 ] none
        , paragraph
            [ Font.family [ Font.sansSerif ]
            , Font.bold
            , Font.size 20
            , Font.color (rgb255 214 105 21)
            ]
            [ text "BHAVPREET SINGH" ]
        , paragraph
            []
            [ text "(S/o Sdn. Mohanjit Kaur and S. Kirpal Singh)" ]
        , el [ padding 2 ] none
        , paragraph
            []
            [ text "with" ]
        , el [ padding 2 ] none
        , paragraph
            [ Font.family [ Font.sansSerif ]
            , Font.bold
            , Font.size 20
            , Font.color (rgb255 214 105 21)
            ]
            [ text "NATASHA SINGH" ]
        , paragraph
            []
            [ text "(D/o Sdn. Takinder Kaur and Dr. Pradeep Singh)" ]
        , el [ padding 6 ] none
        , paragraph
            []
            [ text "on" ]
        , paragraph
            [ Font.family [ Font.sansSerif ]
            , Font.bold
            , Font.size 20

            -- , Font.color (rgb255 94 105 60)
            ]
            [ text "17th January, 2021" ]
        , el [ padding 2 ] none
        , paragraph []
            [ text "Anand Karaj at 11am" ]
        , el [ padding 2 ] none
        , paragraph []
            [ text "- Venue -" ]
        , paragraph []
            [ link
                [ Font.color linkColor
                , Font.underline
                ]
                { url = "https://goo.gl/maps/fm9MmuZzpQsHfYeF9"
                , label = text "Gurudwara Nanak Satsang Sabha,"
                }
            ]
        , paragraph []
            [ text "Vasant Vihar, F-1/4 Munirka Marg." ]
        , el [ padding 5 ] none
        , paragraph []
            [ text "Followed by lunch at "
            , link
                [ Font.color linkColor
                , Font.underline
                ]
                { url = "https://goo.gl/maps/iSYthrgMtHGEz8a66"
                , label = text "Jaypee Vasant Continental"
                }
            ]
        , el [ paddingXY 0 (model.window.height // 54) ] none
        ]


message2 : Model -> Element Msg
message2 model =
    textColumn
        [ width (fill |> maximum 700)

        -- , height <| px 100
        -- , Background.color (rgb255 0 0 0)
        , centerX
        , spacing 10
        , paddingXY 70 90

        -- , centerY
        ]
        [ el [ height (px <| model.window.height // 14) ] none
        , paragraph []
            [ text "A new beginning 💝" ]
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


infoButtonLogic : Model -> Element Msg
infoButtonLogic model =
    let
        button =
            if model.infoOK1 == False then
                raisedButton "RSVP" InfoOK

            else
                raisedButton "Next" InfoOK
    in
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
            button
        , el
            [ padding (model.window.height // 39)
            , alignBottom
            ]
            none
        ]


raisedButton : String -> Msg -> Element Msg
raisedButton label msg =
    el
        [ alignBottom
        , centerX
        ]
    <|
        html <|
            Button.raised
                (Button.config |> Button.setOnClick msg)
                label


linkColor : Color
linkColor =
    rgb255 106 106 247


headerHeight : Int
headerHeight =
    98


headerPadding : Element Msg
headerPadding =
    el
        [ height (px headerHeight)
        , width fill
        , alignTop
        ]
        none


footerHeight : Int
footerHeight =
    87


footerPadding : Element Msg
footerPadding =
    el
        [ height (px footerHeight)
        , width fill
        , alignBottom
        ]
        none
