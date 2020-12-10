module Input exposing (..)

import Element exposing (..)
import Html exposing (Html)
import Material.Button as Button
import Material.Select as Select
import Material.Select.Item as SelectItem
import Material.TextField as TextField
import Model exposing (..)
import Sheets exposing (..)
import Sketch exposing (..)


inputRelatedTo : Model -> Element Msg
inputRelatedTo model =
    column []
        [ sketchCanvas model
        , el
            [ centerX
            , padding 20
            ]
          <|
            html <|
                Select.filled
                    (Select.config
                        |> Select.setLabel (Just "Related To")
                        |> Select.setSelected (Just "")
                        |> Select.setOnChange UpdateRelatedTo
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
                        relatedToList
        ]


inputNameAgeRelation : Model -> Element Msg
inputNameAgeRelation model =
    column
        [ padding 20
        , centerX
        ]
        [ sketchCanvas model
        , el [] <| backButton (toStr model.relatedTo) BackToInputRelatedTo
        , el [ padding 3 ] none
        , row
            [ spacing 15
            ]
            [ el [ width fill ] <|
                html <|
                    TextField.filled
                        (TextField.config
                            |> TextField.setLabel (Just "Name")
                            |> TextField.setValue (Just model.name)
                            |> TextField.setOnInput UpdateName
                        )
            , el [ width fill ] <|
                html <|
                    TextField.filled
                        (TextField.config
                            |> TextField.setLabel (Just "Age")
                            |> TextField.setValue (Just <| ageToStr model.age)
                            |> TextField.setOnInput UpdateAge
                        )
            ]
        , el [ padding 3 ] none
        , el [ centerX ] <| relationTextOrSelect model
        , el [ padding 5 ] none
        , submitNAR model
        ]


relationTextOrSelect : Model -> Element Msg
relationTextOrSelect model =
    if model.showRelationText == True then
        el [ width fill ] <|
            html <|
                TextField.filled
                    (TextField.config
                        |> TextField.setLabel (Just "Relation")
                        |> TextField.setValue (Just <| toStr model.relation)
                        |> TextField.setOnInput UpdateRelation
                    )

    else
        html <|
            Select.filled
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
                    (SelectItem.config { value = "Other" })
                    [ Html.text "Other" ]
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
        [ sketchCanvas model
        , el [] <| backButton (toStr model.relatedTo) BackToInputNAR
        , el
            [ centerX
            , padding 20
            ]
          <|
            html <|
                Select.filled
                    (Select.config
                        |> Select.setLabel (Just "RSVP")
                        |> Select.setSelected (Just "")
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
                    "Save"

    else
        el [] none


submitNAR : Model -> Element Msg
submitNAR model =
    let
        narFieldsFilled : Model -> Bool
        narFieldsFilled m =
            if m.name == "" then
                False

            else if m.age == Nothing then
                False

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
        [ sketchCanvas model
        , el [] <|
            backButton "Add Another" AddMore
        ]


backButton : String -> Msg -> Element Msg
backButton strVal msg =
    html <|
        Button.text
            (Button.config
                |> Button.setIcon (Just (Button.icon "keyboard_arrow_left"))
                |> Button.setOnClick msg
            )
            strVal


inputAwaitResp : Element Msg
inputAwaitResp =
    text
        "Please wait.."
