module Input exposing (..)

import Element exposing (..)
import Element.Font as Font
import Html exposing (Html)
import Html.Attributes as HAttr
import InfoPage exposing (raisedButton)
import Material.Button as Button
import Material.IconButton as IconButton
import Material.Select as Select
import Material.Select.Item as SelectItem
import Material.TextField as TextField
import Model exposing (..)
import Sheets exposing (..)
import Sketch exposing (..)


inputRelatedTo : Model -> Element Msg
inputRelatedTo model =
    column []
        [ row [ width fill ]
            [ infoButton model
            , el [ centerX ] (text "/")
            , el [ alignRight ] <|
                backButton "Guest Of?" NoOp
            ]
        , row
            [ spacing 20
            , width fill
            ]
            [ el
                [ centerX
                ]
              <|
                html <|
                    Button.outlined
                        (Button.config |> Button.setOnClick (UpdateRelatedTo "Bride"))
                        "Bride"
            , el
                [ centerX
                ]
              <|
                html <|
                    Button.outlined
                        (Button.config |> Button.setOnClick (UpdateRelatedTo "Groom"))
                        "Groom"

            -- Select.outlined
            --     (Select.config
            --         |> Select.setLabel (Just "Related To")
            --         |> Select.setSelected (Just "")
            --         |> Select.setOnChange UpdateRelatedTo
            --     )
            --     (SelectItem.selectItem
            --         (SelectItem.config { value = "" })
            --         [ Html.text "" ]
            --     )
            -- <|
            --     List.map
            --         (\x ->
            --             SelectItem.selectItem
            --                 (SelectItem.config { value = x })
            --                 [ Html.text x ]
            --         )
            --         relatedToList
            ]
        ]


inputNameAgeRelation : Model -> Element Msg
inputNameAgeRelation model =
    column
        [ centerX
        , paddingXY 20 0
        , spacing 3
        ]
        [ row [ width fill ]
            [ infoButton model
            , el [ centerX ] (text "/")
            , el [ alignRight ] <|
                backButton (backButtonStr model)
                    BackToInputRelatedTo
            ]
        , row
            [ width fill
            , spacing 5
            ]
            [ el [ width fill ] <|
                html <|
                    TextField.outlined
                        (TextField.config
                            |> TextField.setLabel (Just "Name")
                            |> TextField.setValue (Just model.name)
                            |> TextField.setOnInput UpdateName
                        )
            , el [ width fill ] <|
                ageDropDown model
            ]
        , el [ padding 3 ] none
        , el [ centerX ] <| relationTextOrSelect model
        , el [ padding 5 ] none
        , submitNAR model
        ]


ageDropDown : Model -> Element Msg
ageDropDown model =
    html <|
        Select.outlined
            (Select.config
                |> Select.setLabel (Just "Age Group")
                |> Select.setSelected (Just model.age)
                |> Select.setOnChange UpdateAge
            )
            (SelectItem.selectItem
                (SelectItem.config { value = "" })
                [ Html.text "" ]
            )
        <|
            List.map
                (\x ->
                    SelectItem.selectItem
                        (SelectItem.config { value = x })
                        [ Html.text x ]
                )
                ageGroup


relationTextOrSelect : Model -> Element Msg
relationTextOrSelect model =
    if model.showRelationText == True then
        el
            [ width fill
            ]
        <|
            html <|
                TextField.outlined
                    (TextField.config
                        |> TextField.setLabel (Just "Relation")
                        |> TextField.setValue (Just <| toStr model.relation)
                        |> TextField.setOnInput UpdateRelation
                        |> TextField.setAttributes
                            [ HAttr.id "relation-other-field" ]
                    )

    else
        html <|
            Select.outlined
                (Select.config
                    |> Select.setLabel (Just "Relation")
                    |> Select.setSelected model.relation
                    |> Select.setOnChange UpdateRelation
                )
                (SelectItem.selectItem
                    (SelectItem.config { value = "" })
                    [ Html.text "" ]
                )
            <|
                SelectItem.selectItem
                    (SelectItem.config { value = "Add New" })
                    [ Html.text "Add New" ]
                    :: List.map
                        (\x ->
                            SelectItem.selectItem
                                (SelectItem.config { value = x })
                                [ Html.text x ]
                        )
                        model.relationsList


inputRSVP : Model -> Element Msg
inputRSVP model =
    column
        [ padding 20
        , centerX
        ]
        [ row [ width fill ]
            [ infoButton model
            , el [ centerX ] (text "/")
            , el [ alignRight ] <|
                backButton (backButtonStr model)
                    BackToInputNAR
            ]
        , el
            [ centerX
            , padding 20
            ]
          <|
            html <|
                Select.outlined
                    (Select.config
                        |> Select.setLabel (Just "RSVP")
                        |> Select.setSelected model.rsvp
                        |> Select.setOnChange UpdateRSVP
                    )
                    (SelectItem.selectItem
                        (SelectItem.config { value = "" })
                        [ Html.text "" ]
                    )
                <|
                    List.map
                        (\x ->
                            SelectItem.selectItem
                                (SelectItem.config { value = x })
                                [ Html.text x ]
                        )
                        rsvpList
        , submitRSVP model
        ]


submitRSVP : Model -> Element Msg
submitRSVP model =
    let
        rsvpFilled : Model -> Bool
        rsvpFilled m =
            if m.rsvp == Nothing then
                False

            else
                True
    in
    if model.awaitResp == True then
        el [ centerX ] inputAwaitResp

    else if rsvpFilled model == True then
        el [ centerX ] <|
            html <|
                Button.outlined
                    (Button.config |> Button.setOnClick Submit)
                    "Add me to the tree !!"

    else
        el [] none


submitNAR : Model -> Element Msg
submitNAR model =
    let
        narFieldsFilled : Model -> Bool
        narFieldsFilled m =
            if m.name == "" then
                False
                -- else if m.age == Nothing then
                --     False

            else if m.relation == Nothing then
                False

            else
                True
    in
    if narFieldsFilled model == True then
        el [ centerX ] <|
            html <|
                Button.outlined
                    (Button.config |> Button.setOnClick NextNAR)
                    "Next"

    else
        el [] none


inputEnd : Model -> Element Msg
inputEnd model =
    column
        [ padding 20
        , centerX
        ]
        [ row [ width fill ]
            [ infoButton model
            , el [ centerX ] (text "/")
            , el [ alignRight ] <|
                backButton "Add More"
                    AddMore
            ]
        , el [ padding 4 ] none
        , paragraph
            [ Font.family
                [ Font.typeface "Courgette" ]
            , Font.bold
            , Font.size 18
            , Font.color (rgb255 93 35 234)
            ]
            [ text "Looking forward to see you!"
            ]
        ]


infoButton : Model -> Element Msg
infoButton model =
    el
        []
    <|
        html <|
            Button.text
                (Button.config
                    |> Button.setIcon (Just (Button.icon "info_outlined"))
                    |> Button.setOnClick Model.BackToInfoPage
                )
                "Venue"



-- IconButton.iconButton
--     (IconButton.config |> IconButton.setOnClick BackToInfoPage)
--     (IconButton.icon "info_outlined")


backButtonStr model =
    "Related to : "
        ++ toStr model.relatedTo



-- ++ " /"


backButton : String -> Msg -> Element Msg
backButton strVal msg =
    html <|
        Button.text
            (Button.config
                |> Button.setIcon (Just (Button.icon "perm_identity_outlined"))
                |> Button.setOnClick msg
            )
            strVal


textButton : String -> Msg -> Element Msg
textButton label msg =
    el [] <|
        html <|
            Button.text
                (Button.config |> Button.setOnClick msg)
                label


inputAwaitResp : Element Msg
inputAwaitResp =
    el
        [ Font.family
            [ Font.typeface "Courgette" ]
        , Font.bold
        , Font.size 18
        , Font.color (rgb255 93 35 234)
        ]
    <|
        text
            "Please wait.."
