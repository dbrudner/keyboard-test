module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Key =
    { key : String
    , row : Int
    , column : Int
    , wasPressed : Bool
    }


type alias Keys =
    List Key


type alias Model =
    { keys : List Key }


init : Model
init =
    Model
        (List.map
            (\x -> { x | wasPressed = False })
            [ { key = "tab", row = 2, column = 1, wasPressed = True } ]
        )



-- UPDATE


type Msg
    = KeyPressed String


updateKeyboard keys s =
    List.map
        (\x ->
            if x.key == s then
                { x | wasPressed = True }

            else
                x
        )
        keys


update : Msg -> Model -> Model
update msg model =
    case msg of
        KeyPressed x ->
            { model | keys = updateKeyboard model.keys x }



-- VIEW
-- makeKeyboardRow : Int -> Keys -> Html Msg
-- makeKeyboardRow i k =
--     div [ classList [ ( "keyboard-row-" ++ i, True ) ] k.filter (\x -> x.row == i) ] k |> List.map (\x -> div [ classList [ ( "key", True ), ( "pressed", x.wasPressed ) ] ] [ text x.key ])


filterKeyboardRow : Int -> Keys -> Keys
filterKeyboardRow i k =
    List.filter (\x -> x.row == i) k


renderKeyboardRow : Keys -> Html Msg
renderKeyboardRow k =
    div [ classList [ ( "keyboard", True ) ] ] (List.map (\x -> div [ classList [ ( "key", True ), ( "pressed", x.wasPressed ) ] ] [ text x.key ]) k)


makeKeyboardRow : Int -> Keys -> Html Msg
makeKeyboardRow i k =
    filterKeyboardRow i k |> renderKeyboardRow


view : Model -> Html Msg
view model =
    div []
        [ makeKeyboardRow 2 model.keys
        ]
