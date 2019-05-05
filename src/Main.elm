module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, onClick, onInput)
import Json.Decode
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
    , code : Int
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
            [ { key = "tab", row = 2, column = 2, wasPressed = False, code = 9 }, { code = 65, key = "a", row = 2, column = 1, wasPressed = False } ]
        )



-- UPDATE


type Msg
    = KeyPressed Int


updateKeyboard keys n =
    List.map
        (\x ->
            if x.code == n then
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


sortKeyboardRow : Keys -> Keys
sortKeyboardRow k =
    List.sortBy .column k


filterKeyboardRow : Int -> Keys -> Keys
filterKeyboardRow i k =
    List.filter (\x -> x.row == i) k


renderKeyboardRow : Keys -> Html Msg
renderKeyboardRow k =
    div [ classList [ ( "keyboard", True ) ] ] (List.map (\x -> div [ classList [ ( "key", True ), ( "pressed", x.wasPressed ) ] ] [ text x.key ]) k)


makeKeyboardRow : Int -> Keys -> Html Msg
makeKeyboardRow i k =
    filterKeyboardRow i k |> sortKeyboardRow |> renderKeyboardRow


onKeyUp : (Int -> msg) -> Attribute msg
onKeyUp tagger =
    Html.Events.on "keyup" (Json.Decode.map tagger Html.Events.keyCode)


view : Model -> Html Msg
view model =
    div []
        [ makeKeyboardRow 2 model.keys
        , div [ onClick (KeyPressed 9) ] [ text "hey" ]
        ]
