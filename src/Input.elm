module Input exposing (..)

import Element exposing (..)
import Element.Font as Font
import Html exposing (Html)
import Html.Attributes as HAttr
import InfoPage exposing (raisedButton)
import Material.Button as Button
import Material.LayoutGrid as LayoutGrid
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
                backButton "Related to :" NoOp
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
                        (Button.config |> Button.setOnClick (UpdateRelatedTo "Natasha"))
                        "Natasha"
            , el
                [ centerX
                ]
              <|
                html <|
                    Button.outlined
                        (Button.config |> Button.setOnClick (UpdateRelatedTo "Bhavpreet"))
                        "Bhavpreet"

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
    let
        nameBox =
            TextField.outlined
                (TextField.config
                    |> TextField.setLabel (Just "Name")
                    |> TextField.setValue (Just model.name)
                    |> TextField.setOnInput UpdateName
                    |> TextField.setAttributes [ HAttr.style "max-width" "200px" ]
                )
    in
    column
        [ centerX
        , paddingXY 20 0
        , spacing 3
        ]
        [ row
            [ centerX
            ]
            [ infoButton model
            , el [ centerX ] (text "/")
            , el [ alignRight ] <|
                backButton (backButtonStr model)
                    BackToInputRelatedTo
            ]
        , html <|
            LayoutGrid.layoutGrid
                [ LayoutGrid.alignMiddle
                ]
                [ LayoutGrid.inner
                    [ LayoutGrid.alignMiddle ]
                    [ LayoutGrid.cell [] [ nameBox ]
                    , LayoutGrid.cell [] [ ageDropDown model ]
                    , LayoutGrid.cell [] [ relationTextOrSelect model ]
                    ]
                ]
        , submitNAR model
        ]


ageDropDown : Model -> Html Msg
ageDropDown model =
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


relationTextOrSelect : Model -> Html Msg
relationTextOrSelect model =
    if model.showRelationText == True then
        TextField.outlined
            (TextField.config
                |> TextField.setLabel (Just "Relation")
                |> TextField.setValue (Just <| toStr model.relation)
                |> TextField.setOnInput UpdateRelation
                |> TextField.setAttributes
                    [ HAttr.id "relation-other-field" ]
            )

    else
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
    let
        rsvpDropdown =
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
    in
    column
        [ padding 20
        , centerX
        ]
        [ row [ centerX ]
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
            html <| rsvpDropdown
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
        [ row []
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
                    |> Button.setIcon (Just (Button.icon "navigate_before"))
                    |> Button.setOnClick Model.BackToInfoPage
                )
                "Venue"



-- IconButton.iconButton
--     (IconButton.config |> IconButton.setOnClick BackToInfoPage)
--     (IconButton.icon "info_outlined")


backButtonStr model =
    toStr model.relatedTo



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


purple =
    rgb255 93 35 234
