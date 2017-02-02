module View.Dialog exposing (Config, Visible, visible, hidden, render)

import Html exposing (..)
import Html.Attributes exposing (..)


type alias Config msg =
    { styles : List ( String, String )
    , title : String
    , content : List (Html msg)
    , actionBar : List (Html msg)
    }


type alias Visible =
    Bool


hidden : Visible
hidden =
    False


visible : Visible
visible =
    True


{-| Render the Dialog

    Dialog.render
        { styles = [ "width" "40%" ]
        , title = "My Dialog"
        , content = [ text "This is my dialog's body." ]
        , actionBar = [ button [ onClick ToggleMyDialogVisible ] [ text "Close" ] ] }
        model.myDialogVisible

You take care of the open and close Msg yourself. Just include a Bool in you model,
that holds the Visible value for each Dialog:

    init =
        { myDialogVisible = Dialog.hidden }

    update msg model =
        case msg of
            ToggleMyDialogVisible ->
                { model | myDialogVisible = not model.myDialogVisible } ! []

-}
render : Config msg -> Visible -> Html msg
render config visible =
    let
        visibility =
            if visible == True then
                (,) "display" "flex"
            else
                (,) "display" "none"

        dialogStyle_ =
            dialogBaseStyle ++ config.styles
    in
        div [ style <| overlayStyle ++ [ visibility ] ]
            [ div [ style dialogStyle_ ]
                [ div [ class "mdl-dialog__title" ] [ text config.title ]
                , div [ class "mdl-dialog__content" ] config.content
                , br [] []
                , div [ class "mdl-dialog__actions" ] config.actionBar
                ]
            ]


overlayStyle : List ( String, String )
overlayStyle =
    [ (,) "position" "fixed"
    , (,) "overflow-x" "hidden"
    , (,) "top" "0"
    , (,) "left" "0"
    , (,) "bottom" "0"
    , (,) "right" "0"
    , (,) "z-index" "10"
    , (,) "background-color" "rgba(0,0,0,0.5)"
    , (,) "justify-content" "center"
    , (,) "align-items" "center"
    ]


dialogBaseStyle : List ( String, String )
dialogBaseStyle =
    [ (,) "min-width" "300px"
    , (,) "background-color" "white"
    , (,) "padding" "8px 16px 8px 16px"
    , (,) "border-radius" "4px"
    , (,) "border" "1px solid #757575"
    , (,) "box-shadow" "4px 4px 5px 0px rgba(97,97,97,1)"
    ]
