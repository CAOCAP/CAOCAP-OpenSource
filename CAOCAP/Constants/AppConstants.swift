//
//  AppConstants.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 14/09/2023.
//

/*
 
 Why You Should Use a Constants File ?
 it is a methodology to help us writing clear, concise code
 
 What is a Constants file?
 A file dedicated to store declared constant properties.
 The beauty of this file is that it’s accessible globally throughout the app.
 
 Key benefits is having a central place for managing globally and repetitively used properties,
 the file is highly custom and you reduce the amount of mistakes such as typing in the wrong code.
 
 So what kind of properties can you store in the Constants file?
 ...

 
 learn more form this article:
 https://medium.com/swlh/why-you-should-use-a-constants-file-in-swift-ff8c40af1b39
*/

import Foundation

struct AppConstants {
    static let bodyID = "_body_"
    
    static let html = #"""
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>webview</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://unpkg.com/react@18/umd/react.development.js"></script>
        <script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js"></script>
        <script src="https://unpkg.com/redux@4.2.1/dist/redux.js"></script>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body id="\#(bodyID)"></body>
</html>
"""#
}


typealias ISOLanguageCode = (lang: String, code: String)
let isoLanguageCodes: [ISOLanguageCode] = [
    (lang: "Abkhazian", code: "ab"),
    (lang: "Afar", code: "aa"),
    (lang: "Afrikaans", code: "af"),
    (lang: "Akan", code: "ak"),
    (lang: "Albanian", code: "sq"),
    (lang: "Amharic", code: "am"),
    (lang: "Arabic", code: "ar"),
    (lang: "Aragonese", code: "an"),
    (lang: "Armenian", code: "hy"),
    (lang: "Assamese", code: "as"),
    (lang: "Avaric", code: "av"),
    (lang: "Avestan", code: "ae"),
    (lang: "Aymara", code: "ay"),
    (lang: "Azerbaijani", code: "az"),
    (lang: "Bambara", code: "bm"),
    (lang: "Bashkir", code: "ba"),
    (lang: "Basque", code: "eu"),
    (lang: "Belarusian", code: "be"),
    (lang: "Bengali (Bangla)", code: "bn"),
    (lang: "Bihari", code: "bh"),
    (lang: "Bislama", code: "bi"),
    (lang: "Bosnian", code: "bs"),
    (lang: "Breton", code: "br"),
    (lang: "Bulgarian", code: "bg"),
    (lang: "Burmese", code: "my"),
    (lang: "Catalan", code: "ca"),
    (lang: "Chamorro", code: "ch"),
    (lang: "Chechen", code: "ce"),
    (lang: "Chichewa, Chewa, Nyanja", code: "ny"),
    (lang: "Chinese (Simplified)", code: "zh-Hans"),
    (lang: "Chinese (Traditional)", code: "zh-Hant"),
    (lang: "Chinese", code: "zh"),
    (lang: "Chuvash", code: "cv"),
    (lang: "Cornish", code: "kw"),
    (lang: "Corsican", code: "co"),
    (lang: "Cree", code: "cr"),
    (lang: "Croatian", code: "hr"),
    (lang: "Czech", code: "cs"),
    (lang: "Danish", code: "da"),
    (lang: "Divehi, Dhivehi, Maldivian", code: "dv"),
    (lang: "Dutch", code: "nl"),
    (lang: "Dzongkha", code: "dz"),
    (lang: "English", code: "en"),
    (lang: "Esperanto", code: "eo"),
    (lang: "Estonian", code: "et"),
    (lang: "Ewe", code: "ee"),
    (lang: "Faroese", code: "fo"),
    (lang: "Fijian", code: "fj"),
    (lang: "Finnish", code: "fi"),
    (lang: "French", code: "fr"),
    (lang: "Fula, Fulah, Pulaar, Pular", code: "ff"),
    (lang: "Gaelic (Manx)", code: "gv"),
    (lang: "Gaelic (Scottish)", code: "gd"),
    (lang: "Galician", code: "gl"),
    (lang: "Georgian", code: "ka"),
    (lang: "German", code: "de"),
    (lang: "Greek", code: "el"),
    (lang: "Greenlandic", code: "kl"),
    (lang: "Guarani", code: "gn"),
    (lang: "Gujarati", code: "gu"),
    (lang: "Haitian Creole", code: "ht"),
    (lang: "Hausa", code: "ha"),
    (lang: "Hebrew", code: "he"),
    (lang: "Herero", code: "hz"),
    (lang: "Hindi", code: "hi"),
    (lang: "Hiri Motu", code: "ho"),
    (lang: "Hungarian", code: "hu"),
    (lang: "Icelandic", code: "is"),
    (lang: "Ido", code: "io"),
    (lang: "Igbo", code: "ig"),
    (lang: "Indonesian", code: "id"),
    (lang: "Interlingua", code: "ia"),
    (lang: "Interlingue", code: "ie"),
    (lang: "Inuktitut", code: "iu"),
    (lang: "Inupiak", code: "ik"),
    (lang: "Irish", code: "ga"),
    (lang: "Italian", code: "it"),
    (lang: "Japanese", code: "ja"),
    (lang: "Javanese", code: "jv"),
    (lang: "Kalaallisut, Greenlandic", code: "kl"),
    (lang: "Kannada", code: "kn"),
    (lang: "Kanuri", code: "kr"),
    (lang: "Kashmiri", code: "ks"),
    (lang: "Kazakh", code: "kk"),
    (lang: "Khmer", code: "km"),
    (lang: "Kikuyu", code: "ki"),
    (lang: "Kinyarwanda (Rwanda)", code: "rw"),
    (lang: "Kirundi", code: "rn"),
    (lang: "Komi", code: "kv"),
    (lang: "Kongo", code: "kg"),
    (lang: "Korean", code: "ko"),
    (lang: "Kurdish", code: "ku"),
    (lang: "Kwanyama", code: "kj"),
    (lang: "Kyrgyz", code: "ky"),
    (lang: "Lao", code: "lo"),
    (lang: "Latin", code: "la"),
    (lang: "Latvian (Lettish)", code: "lv"),
    (lang: "Limburgish ( Limburger)", code: "li"),
    (lang: "Lingala", code: "ln"),
    (lang: "Lithuanian", code: "lt"),
    (lang: "Luga-Katanga", code: "lu"),
    (lang: "Luganda, Ganda", code: "lg"),
    (lang: "Luxembourgish", code: "lb"),
    (lang: "Macedonian", code: "mk"),
    (lang: "Malagasy", code: "mg"),
    (lang: "Malay", code: "ms"),
    (lang: "Malayalam", code: "ml"),
    (lang: "Maltese", code: "mt"),
    (lang: "Manx", code: "gv"),
    (lang: "Maori", code: "mi"),
    (lang: "Marathi", code: "mr"),
    (lang: "Marshallese", code: "mh"),
    (lang: "Moldavian", code: "mo"),
    (lang: "Mongolian", code: "mn"),
    (lang: "Nauru", code: "na"),
    (lang: "Navajo", code: "nv"),
    (lang: "Ndonga", code: "ng"),
    (lang: "Nepali", code: "ne"),
    (lang: "Northern Ndebele", code: "nd"),
    (lang: "Norwegian bokmål", code: "nb"),
    (lang: "Norwegian nynorsk", code: "nn"),
    (lang: "Norwegian", code: "no"),
    (lang: "Nuosu", code: "ii"),
    (lang: "Occitan", code: "oc"),
    (lang: "Ojibwe", code: "oj"),
    (lang: "Old Church Slavonic, Old Bulgarian", code: "cu"),
    (lang: "Oriya", code: "or"),
    (lang: "Oromo (Afaan Oromo)", code: "om"),
    (lang: "Ossetian", code: "os"),
    (lang: "Pashto, Pushto", code: "ps"),
    (lang: "Persian (Farsi)", code: "fa"),
    (lang: "Polish", code: "pl"),
    (lang: "Portuguese", code: "pt"),
    (lang: "Punjabi (Eastern)", code: "pa"),
    (lang: "Pāli", code: "pi"),
    (lang: "Quechua", code: "qu"),
    (lang: "Romanian", code: "ro"),
    (lang: "Romansh", code: "rm"),
    (lang: "Russian", code: "ru"),
    (lang: "Sami", code: "se"),
    (lang: "Samoan", code: "sm"),
    (lang: "Sango", code: "sg"),
    (lang: "Sanskrit", code: "sa"),
    (lang: "Serbian", code: "sr"),
    (lang: "Serbo-Croatian", code: "sh"),
    (lang: "Sesotho", code: "st"),
    (lang: "Setswana", code: "tn"),
    (lang: "Shona", code: "sn"),
    (lang: "Sichuan Yi", code: "ii"),
    (lang: "Sindhi", code: "sd"),
    (lang: "Sinhalese", code: "si"),
    (lang: "Siswati", code: "ss"),
    (lang: "Slovak", code: "sk"),
    (lang: "Slovenian", code: "sl"),
    (lang: "Somali", code: "so"),
    (lang: "Southern Ndebele", code: "nr"),
    (lang: "Spanish", code: "es"),
    (lang: "Sundanese", code: "su"),
    (lang: "Swahili (Kiswahili)", code: "sw"),
    (lang: "Swati", code: "ss"),
    (lang: "Swedish", code: "sv"),
    (lang: "Tagalog", code: "tl"),
    (lang: "Tahitian", code: "ty"),
    (lang: "Tajik", code: "tg"),
    (lang: "Tamil", code: "ta"),
    (lang: "Tatar", code: "tt"),
    (lang: "Telugu", code: "te"),
    (lang: "Thai", code: "th"),
    (lang: "Tibetan", code: "bo"),
    (lang: "Tigrinya", code: "ti"),
    (lang: "Tonga", code: "to"),
    (lang: "Tsonga", code: "ts"),
    (lang: "Turkish", code: "tr"),
    (lang: "Turkmen", code: "tk"),
    (lang: "Twi", code: "tw"),
    (lang: "Ukrainian", code: "uk"),
    (lang: "Urdu", code: "ur"),
    (lang: "Uyghur", code: "ug"),
    (lang: "Uzbek", code: "uz"),
    (lang: "Venda", code: "ve"),
    (lang: "Vietnamese", code: "vi"),
    (lang: "Volapük", code: "vo"),
    (lang: "Wallon", code: "wa"),
    (lang: "Welsh", code: "cy"),
    (lang: "Western Frisian", code: "fy"),
    (lang: "Wolof", code: "wo"),
    (lang: "Xhosa", code: "xh"),
    (lang: "Yiddish", code: "yi"),
    (lang: "Yoruba", code: "yo"),
    (lang: "Zhuang, Chuang", code: "za"),
    (lang: "Zulu", code: "zu"),

]
