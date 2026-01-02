//
//  Country.swift
//  Country Quiz
//
//  Created by Thomas Frank on 20/11/25.
//

import Foundation

enum Country: CaseIterable {
    case afghanistan
    case albania
    case algeria
    case andorra
    case angola
    case antiguaAndBarbuda
    case argentina
    case armenia
    case australia
    case austria
    case azerbaijan
    case bahamas
    case bahrain
    case bangladesh
    case barbados
    case belarus
    case belgium
    case belize
    case benin
    case bhutan
    case bolivia
    case bosniaAndHerzegovina
    case botswana
    case brazil
    case brunei
    case bulgaria
    case burkinaFaso
    case burundi
    case cambodia
    case cameroon
    case canada
    case capeVerde
    case centralAfricanRepublic
    case chad
    case chile
    case china
    case colombia
    case comoros
    case congoDemocratic
    case congoRepublic
    case costaRica
    case croatia
    case cuba
    case cyprus
    case czechia
    case denmark
    case djibouti
    case dominica
    case dominicanRepublic
    case ecuador
    case egypt
    case elSalvador
    case equatorialGuinea
    case eritrea
    case estonia
    case eswatini
    case ethiopia
    case fiji
    case finland
    case france
    case gabon
    case gambia
    case georgia
    case germany
    case ghana
    case greece
    case grenada
    case guatemala
    case guinea
    case guineaBissau
    case guyana
    case haiti
    case honduras
    case hongKong
    case hungary
    case iceland
    case india
    case indonesia
    case iran
    case iraq
    case ireland
    case israel
    case italy
    case ivoryCoast
    case jamaica
    case japan
    case jordan
    case kazakhstan
    case kenya
    case kiribati
    case kosovo
    case kuwait
    case kyrgyzstan
    case laos
    case latvia
    case lebanon
    case lesotho
    case liberia
    case libya
    case liechtenstein
    case lithuania
    case luxembourg
    case macau
    case madagascar
    case malawi
    case malaysia
    case maldives
    case mali
    case malta
    case marshallIslands
    case mauritania
    case mauritius
    case mexico
    case micronesia
    case moldova
    case monaco
    case mongolia
    case montenegro
    case morocco
    case mozambique
    case myanmar
    case namibia
    case nauru
    case nepal
    case netherlands
    case newZealand
    case nicaragua
    case niger
    case nigeria
    case northKorea
    case northMacedonia
    case norway
    case oman
    case pakistan
    case palau
    case palestine
    case panama
    case papuaNewGuinea
    case paraguay
    case peru
    case philippines
    case poland
    case portugal
    case puertoRico
    case qatar
    case romania
    case russia
    case rwanda
    case saintKittsAndNevis
    case saintLucia
    case saintVincentAndTheGrenadines
    case samoa
    case sanMarino
    case saoTomeAndPrincipe
    case saudiArabia
    case senegal
    case serbia
    case seychelles
    case sierraLeone
    case singapore
    case slovakia
    case slovenia
    case solomonIslands
    case somalia
    case southAfrica
    case southKorea
    case southSudan
    case spain
    case sriLanka
    case sudan
    case suriname
    case sweden
    case switzerland
    case syria
    case taiwan
    case tajikistan
    case tanzania
    case thailand
    case timorLeste
    case togo
    case tonga
    case trinidadAndTobago
    case tunisia
    case turkey
    case turkmenistan
    case tuvalu
    case uganda
    case ukraine
    case unitedArabEmirates
    case unitedKingdom
    case unitedStates
    case uruguay
    case uzbekistan
    case vanuatu
    case vaticanCity
    case venezuela
    case vietnam
    case yemen
    case zambia
    case zimbabwe
    
    var name: String {
        switch self {
        case .afghanistan: return "Afghanistan"
        case .albania: return "Albania"
        case .algeria: return "Algeria"
        case .andorra: return "Andorra"
        case .angola: return "Angola"
        case .antiguaAndBarbuda: return "Antigua and Barbuda"
        case .argentina: return "Argentina"
        case .armenia: return "Armenia"
        case .australia: return "Australia"
        case .austria: return "Austria"
        case .azerbaijan: return "Azerbaijan"
        case .bahamas: return "Bahamas"
        case .bahrain: return "Bahrain"
        case .bangladesh: return "Bangladesh"
        case .barbados: return "Barbados"
        case .belarus: return "Belarus"
        case .belgium: return "Belgium"
        case .belize: return "Belize"
        case .benin: return "Benin"
        case .bhutan: return "Bhutan"
        case .bolivia: return "Bolivia"
        case .bosniaAndHerzegovina: return "Bosnia and Herzegovina"
        case .botswana: return "Botswana"
        case .brazil: return "Brazil"
        case .brunei: return "Brunei"
        case .bulgaria: return "Bulgaria"
        case .burkinaFaso: return "Burkina Faso"
        case .burundi: return "Burundi"
        case .cambodia: return "Cambodia"
        case .cameroon: return "Cameroon"
        case .canada: return "Canada"
        case .capeVerde: return "Cape Verde"
        case .centralAfricanRepublic: return "Central African Republic"
        case .chad: return "Chad"
        case .chile: return "Chile"
        case .china: return "China"
        case .colombia: return "Colombia"
        case .comoros: return "Comoros"
        case .congoDemocratic: return "Democratic Republic of the Congo"
        case .congoRepublic: return "Republic of the Congo"
        case .costaRica: return "Costa Rica"
        case .croatia: return "Croatia"
        case .cuba: return "Cuba"
        case .cyprus: return "Cyprus"
        case .czechia: return "Czechia"
        case .denmark: return "Denmark"
        case .djibouti: return "Djibouti"
        case .dominica: return "Dominica"
        case .dominicanRepublic: return "Dominican Republic"
        case .ecuador: return "Ecuador"
        case .egypt: return "Egypt"
        case .elSalvador: return "El Salvador"
        case .equatorialGuinea: return "Equatorial Guinea"
        case .eritrea: return "Eritrea"
        case .estonia: return "Estonia"
        case .eswatini: return "Eswatini"
        case .ethiopia: return "Ethiopia"
        case .fiji: return "Fiji"
        case .finland: return "Finland"
        case .france: return "France"
        case .gabon: return "Gabon"
        case .gambia: return "Gambia"
        case .georgia: return "Georgia"
        case .germany: return "Germany"
        case .ghana: return "Ghana"
        case .greece: return "Greece"
        case .grenada: return "Grenada"
        case .guatemala: return "Guatemala"
        case .guinea: return "Guinea"
        case .guineaBissau: return "Guinea-Bissau"
        case .guyana: return "Guyana"
        case .haiti: return "Haiti"
        case .honduras: return "Honduras"
        case .hongKong: return "Hong Kong"
        case .hungary: return "Hungary"
        case .iceland: return "Iceland"
        case .india: return "India"
        case .indonesia: return "Indonesia"
        case .iran: return "Iran"
        case .iraq: return "Iraq"
        case .ireland: return "Ireland"
        case .israel: return "Israel"
        case .italy: return "Italy"
        case .ivoryCoast: return "Ivory Coast"
        case .jamaica: return "Jamaica"
        case .japan: return "Japan"
        case .jordan: return "Jordan"
        case .kazakhstan: return "Kazakhstan"
        case .kenya: return "Kenya"
        case .kiribati: return "Kiribati"
        case .kosovo: return "Kosovo"
        case .kuwait: return "Kuwait"
        case .kyrgyzstan: return "Kyrgyzstan"
        case .laos: return "Laos"
        case .latvia: return "Latvia"
        case .lebanon: return "Lebanon"
        case .lesotho: return "Lesotho"
        case .liberia: return "Liberia"
        case .libya: return "Libya"
        case .liechtenstein: return "Liechtenstein"
        case .lithuania: return "Lithuania"
        case .luxembourg: return "Luxembourg"
        case .macau: return "Macau"
        case .madagascar: return "Madagascar"
        case .malawi: return "Malawi"
        case .malaysia: return "Malaysia"
        case .maldives: return "Maldives"
        case .mali: return "Mali"
        case .malta: return "Malta"
        case .marshallIslands: return "Marshall Islands"
        case .mauritania: return "Mauritania"
        case .mauritius: return "Mauritius"
        case .mexico: return "Mexico"
        case .micronesia: return "Micronesia"
        case .moldova: return "Moldova"
        case .monaco: return "Monaco"
        case .mongolia: return "Mongolia"
        case .montenegro: return "Montenegro"
        case .morocco: return "Morocco"
        case .mozambique: return "Mozambique"
        case .myanmar: return "Myanmar"
        case .namibia: return "Namibia"
        case .nauru: return "Nauru"
        case .nepal: return "Nepal"
        case .netherlands: return "Netherlands"
        case .newZealand: return "New Zealand"
        case .nicaragua: return "Nicaragua"
        case .niger: return "Niger"
        case .nigeria: return "Nigeria"
        case .northKorea: return "North Korea"
        case .northMacedonia: return "North Macedonia"
        case .norway: return "Norway"
        case .oman: return "Oman"
        case .pakistan: return "Pakistan"
        case .palau: return "Palau"
        case .palestine: return "Palestine"
        case .panama: return "Panama"
        case .papuaNewGuinea: return "Papua New Guinea"
        case .paraguay: return "Paraguay"
        case .peru: return "Peru"
        case .philippines: return "Philippines"
        case .poland: return "Poland"
        case .portugal: return "Portugal"
        case .puertoRico: return "Puerto Rico"
        case .qatar: return "Qatar"
        case .romania: return "Romania"
        case .russia: return "Russia"
        case .rwanda: return "Rwanda"
        case .saintKittsAndNevis: return "Saint Kitts and Nevis"
        case .saintLucia: return "Saint Lucia"
        case .saintVincentAndTheGrenadines: return "Saint Vincent and the Grenadines"
        case .samoa: return "Samoa"
        case .sanMarino: return "San Marino"
        case .saoTomeAndPrincipe: return "São Tomé and Príncipe"
        case .saudiArabia: return "Saudi Arabia"
        case .senegal: return "Senegal"
        case .serbia: return "Serbia"
        case .seychelles: return "Seychelles"
        case .sierraLeone: return "Sierra Leone"
        case .singapore: return "Singapore"
        case .slovakia: return "Slovakia"
        case .slovenia: return "Slovenia"
        case .solomonIslands: return "Solomon Islands"
        case .somalia: return "Somalia"
        case .southAfrica: return "South Africa"
        case .southKorea: return "South Korea"
        case .southSudan: return "South Sudan"
        case .spain: return "Spain"
        case .sriLanka: return "Sri Lanka"
        case .sudan: return "Sudan"
        case .suriname: return "Suriname"
        case .sweden: return "Sweden"
        case .switzerland: return "Switzerland"
        case .syria: return "Syria"
        case .taiwan: return "Taiwan"
        case .tajikistan: return "Tajikistan"
        case .tanzania: return "Tanzania"
        case .thailand: return "Thailand"
        case .timorLeste: return "Timor-Leste"
        case .togo: return "Togo"
        case .tonga: return "Tonga"
        case .trinidadAndTobago: return "Trinidad and Tobago"
        case .tunisia: return "Tunisia"
        case .turkey: return "Turkey"
        case .turkmenistan: return "Turkmenistan"
        case .tuvalu: return "Tuvalu"
        case .uganda: return "Uganda"
        case .ukraine: return "Ukraine"
        case .unitedArabEmirates: return "United Arab Emirates"
        case .unitedKingdom: return "United Kingdom"
        case .unitedStates: return "United States"
        case .uruguay: return "Uruguay"
        case .uzbekistan: return "Uzbekistan"
        case .vanuatu: return "Vanuatu"
        case .vaticanCity: return "Vatican City"
        case .venezuela: return "Venezuela"
        case .vietnam: return "Vietnam"
        case .yemen: return "Yemen"
        case .zambia: return "Zambia"
        case .zimbabwe: return "Zimbabwe"
        }
    }
    
    var flag: String {
        switch self {
        case .afghanistan: return "🇦🇫"
        case .albania: return "🇦🇱"
        case .algeria: return "🇩🇿"
        case .andorra: return "🇦🇩"
        case .angola: return "🇦🇴"
        case .antiguaAndBarbuda: return "🇦🇬"
        case .argentina: return "🇦🇷"
        case .armenia: return "🇦🇲"
        case .australia: return "🇦🇺"
        case .austria: return "🇦🇹"
        case .azerbaijan: return "🇦🇿"
        case .bahamas: return "🇧🇸"
        case .bahrain: return "🇧🇭"
        case .bangladesh: return "🇧🇩"
        case .barbados: return "🇧🇧"
        case .belarus: return "🇧🇾"
        case .belgium: return "🇧🇪"
        case .belize: return "🇧🇿"
        case .benin: return "🇧🇯"
        case .bhutan: return "🇧🇹"
        case .bolivia: return "🇧🇴"
        case .bosniaAndHerzegovina: return "🇧🇦"
        case .botswana: return "🇧🇼"
        case .brazil: return "🇧🇷"
        case .brunei: return "🇧🇳"
        case .bulgaria: return "🇧🇬"
        case .burkinaFaso: return "🇧🇫"
        case .burundi: return "🇧🇮"
        case .cambodia: return "🇰🇭"
        case .cameroon: return "🇨🇲"
        case .canada: return "🇨🇦"
        case .capeVerde: return "🇨🇻"
        case .centralAfricanRepublic: return "🇨🇫"
        case .chad: return "🇹🇩"
        case .chile: return "🇨🇱"
        case .china: return "🇨🇳"
        case .colombia: return "🇨🇴"
        case .comoros: return "🇰🇲"
        case .congoDemocratic: return "🇨🇩"
        case .congoRepublic: return "🇨🇬"
        case .costaRica: return "🇨🇷"
        case .croatia: return "🇭🇷"
        case .cuba: return "🇨🇺"
        case .cyprus: return "🇨🇾"
        case .czechia: return "🇨🇿"
        case .denmark: return "🇩🇰"
        case .djibouti: return "🇩🇯"
        case .dominica: return "🇩🇲"
        case .dominicanRepublic: return "🇩🇴"
        case .ecuador: return "🇪🇨"
        case .egypt: return "🇪🇬"
        case .elSalvador: return "🇸🇻"
        case .equatorialGuinea: return "🇬🇶"
        case .eritrea: return "🇪🇷"
        case .estonia: return "🇪🇪"
        case .eswatini: return "🇸🇿"
        case .ethiopia: return "🇪🇹"
        case .fiji: return "🇫🇯"
        case .finland: return "🇫🇮"
        case .france: return "🇫🇷"
        case .gabon: return "🇬🇦"
        case .gambia: return "🇬🇲"
        case .georgia: return "🇬🇪"
        case .germany: return "🇩🇪"
        case .ghana: return "🇬🇭"
        case .greece: return "🇬🇷"
        case .grenada: return "🇬🇩"
        case .guatemala: return "🇬🇹"
        case .guinea: return "🇬🇳"
        case .guineaBissau: return "🇬🇼"
        case .guyana: return "🇬🇾"
        case .haiti: return "🇭🇹"
        case .honduras: return "🇭🇳"
        case .hongKong: return "🇭🇰"
        case .hungary: return "🇭🇺"
        case .iceland: return "🇮🇸"
        case .india: return "🇮🇳"
        case .indonesia: return "🇮🇩"
        case .iran: return "🇮🇷"
        case .iraq: return "🇮🇶"
        case .ireland: return "🇮🇪"
        case .israel: return "🇮🇱"
        case .italy: return "🇮🇹"
        case .ivoryCoast: return "🇨🇮"
        case .jamaica: return "🇯🇲"
        case .japan: return "🇯🇵"
        case .jordan: return "🇯🇴"
        case .kazakhstan: return "🇰🇿"
        case .kenya: return "🇰🇪"
        case .kiribati: return "🇰🇮"
        case .kosovo: return "🇽🇰"
        case .kuwait: return "🇰🇼"
        case .kyrgyzstan: return "🇰🇬"
        case .laos: return "🇱🇦"
        case .latvia: return "🇱🇻"
        case .lebanon: return "🇱🇧"
        case .lesotho: return "🇱🇸"
        case .liberia: return "🇱🇷"
        case .libya: return "🇱🇾"
        case .liechtenstein: return "🇱🇮"
        case .lithuania: return "🇱🇹"
        case .luxembourg: return "🇱🇺"
        case .macau: return "🇲🇴"
        case .madagascar: return "🇲🇬"
        case .malawi: return "🇲🇼"
        case .malaysia: return "🇲🇾"
        case .maldives: return "🇲🇻"
        case .mali: return "🇲🇱"
        case .malta: return "🇲🇹"
        case .marshallIslands: return "🇲🇭"
        case .mauritania: return "🇲🇷"
        case .mauritius: return "🇲🇺"
        case .mexico: return "🇲🇽"
        case .micronesia: return "🇫🇲"
        case .moldova: return "🇲🇩"
        case .monaco: return "🇲🇨"
        case .mongolia: return "🇲🇳"
        case .montenegro: return "🇲🇪"
        case .morocco: return "🇲🇦"
        case .mozambique: return "🇲🇿"
        case .myanmar: return "🇲🇲"
        case .namibia: return "🇳🇦"
        case .nauru: return "🇳🇷"
        case .nepal: return "🇳🇵"
        case .netherlands: return "🇳🇱"
        case .newZealand: return "🇳🇿"
        case .nicaragua: return "🇳🇮"
        case .niger: return "🇳🇪"
        case .nigeria: return "🇳🇬"
        case .northKorea: return "🇰🇵"
        case .northMacedonia: return "🇲🇰"
        case .norway: return "🇳🇴"
        case .oman: return "🇴🇲"
        case .pakistan: return "🇵🇰"
        case .palau: return "🇵🇼"
        case .palestine: return "🇵🇸"
        case .panama: return "🇵🇦"
        case .papuaNewGuinea: return "🇵🇬"
        case .paraguay: return "🇵🇾"
        case .peru: return "🇵🇪"
        case .philippines: return "🇵🇭"
        case .poland: return "🇵🇱"
        case .portugal: return "🇵🇹"
        case .puertoRico: return "🇵🇷"
        case .qatar: return "🇶🇦"
        case .romania: return "🇷🇴"
        case .russia: return "🇷🇺"
        case .rwanda: return "🇷🇼"
        case .saintKittsAndNevis: return "🇰🇳"
        case .saintLucia: return "🇱🇨"
        case .saintVincentAndTheGrenadines: return "🇻🇨"
        case .samoa: return "🇼🇸"
        case .sanMarino: return "🇸🇲"
        case .saoTomeAndPrincipe: return "🇸🇹"
        case .saudiArabia: return "🇸🇦"
        case .senegal: return "🇸🇳"
        case .serbia: return "🇷🇸"
        case .seychelles: return "🇸🇨"
        case .sierraLeone: return "🇸🇱"
        case .singapore: return "🇸🇬"
        case .slovakia: return "🇸🇰"
        case .slovenia: return "🇸🇮"
        case .solomonIslands: return "🇸🇧"
        case .somalia: return "🇸🇴"
        case .southAfrica: return "🇿🇦"
        case .southKorea: return "🇰🇷"
        case .southSudan: return "🇸🇸"
        case .spain: return "🇪🇸"
        case .sriLanka: return "🇱🇰"
        case .sudan: return "🇸🇩"
        case .suriname: return "🇸🇷"
        case .sweden: return "🇸🇪"
        case .switzerland: return "🇨🇭"
        case .syria: return "🇸🇾"
        case .taiwan: return "🇹🇼"
        case .tajikistan: return "🇹🇯"
        case .tanzania: return "🇹🇿"
        case .thailand: return "🇹🇭"
        case .timorLeste: return "🇹🇱"
        case .togo: return "🇹🇬"
        case .tonga: return "🇹🇴"
        case .trinidadAndTobago: return "🇹🇹"
        case .tunisia: return "🇹🇳"
        case .turkey: return "🇹🇷"
        case .turkmenistan: return "🇹🇲"
        case .tuvalu: return "🇹🇻"
        case .uganda: return "🇺🇬"
        case .ukraine: return "🇺🇦"
        case .unitedArabEmirates: return "🇦🇪"
        case .unitedKingdom: return "🇬🇧"
        case .unitedStates: return "🇺🇸"
        case .uruguay: return "🇺🇾"
        case .uzbekistan: return "🇺🇿"
        case .vanuatu: return "🇻🇺"
        case .vaticanCity: return "🇻🇦"
        case .venezuela: return "🇻🇪"
        case .vietnam: return "🇻🇳"
        case .yemen: return "🇾🇪"
        case .zambia: return "🇿🇲"
        case .zimbabwe: return "🇿🇼"
        }
    }
    
    var capital: String {
        switch self {
        case .afghanistan: return "Kabul"
        case .albania: return "Tirana"
        case .algeria: return "Algiers"
        case .andorra: return "Andorra la Vella"
        case .angola: return "Luanda"
        case .antiguaAndBarbuda: return "St. John's"
        case .argentina: return "Buenos Aires"
        case .armenia: return "Yerevan"
        case .australia: return "Canberra"
        case .austria: return "Vienna"
        case .azerbaijan: return "Baku"
        case .bahamas: return "Nassau"
        case .bahrain: return "Manama"
        case .bangladesh: return "Dhaka"
        case .barbados: return "Bridgetown"
        case .belarus: return "Minsk"
        case .belgium: return "Brussels"
        case .belize: return "Belmopan"
        case .benin: return "Porto-Novo"
        case .bhutan: return "Thimphu"
        case .bolivia: return "La Paz"
        case .bosniaAndHerzegovina: return "Sarajevo"
        case .botswana: return "Gaborone"
        case .brazil: return "Brasília"
        case .brunei: return "Bandar Seri Begawan"
        case .bulgaria: return "Sofia"
        case .burkinaFaso: return "Ouagadougou"
        case .burundi: return "Gitega"
        case .cambodia: return "Phnom Penh"
        case .cameroon: return "Yaoundé"
        case .canada: return "Ottawa"
        case .capeVerde: return "Praia"
        case .centralAfricanRepublic: return "Bangui"
        case .chad: return "N'Djamena"
        case .chile: return "Santiago"
        case .china: return "Beijing"
        case .colombia: return "Bogotá"
        case .comoros: return "Moroni"
        case .congoDemocratic: return "Kinshasa"
        case .congoRepublic: return "Brazzaville"
        case .costaRica: return "San José"
        case .croatia: return "Zagreb"
        case .cuba: return "Havana"
        case .cyprus: return "Nicosia"
        case .czechia: return "Prague"
        case .denmark: return "Copenhagen"
        case .djibouti: return "Djibouti"
        case .dominica: return "Roseau"
        case .dominicanRepublic: return "Santo Domingo"
        case .ecuador: return "Quito"
        case .egypt: return "Cairo"
        case .elSalvador: return "San Salvador"
        case .equatorialGuinea: return "Malabo"
        case .eritrea: return "Asmara"
        case .estonia: return "Tallinn"
        case .eswatini: return "Mbabane"
        case .ethiopia: return "Addis Ababa"
        case .fiji: return "Suva"
        case .finland: return "Helsinki"
        case .france: return "Paris"
        case .gabon: return "Libreville"
        case .gambia: return "Banjul"
        case .georgia: return "Tbilisi"
        case .germany: return "Berlin"
        case .ghana: return "Accra"
        case .greece: return "Athens"
        case .grenada: return "St. George's"
        case .guatemala: return "Guatemala City"
        case .guinea: return "Conakry"
        case .guineaBissau: return "Bissau"
        case .guyana: return "Georgetown"
        case .haiti: return "Port-au-Prince"
        case .honduras: return "Tegucigalpa"
        case .hongKong: return "Victoria"
        case .hungary: return "Budapest"
        case .iceland: return "Reykjavik"
        case .india: return "New Delhi"
        case .indonesia: return "Jakarta"
        case .iran: return "Tehran"
        case .iraq: return "Baghdad"
        case .ireland: return "Dublin"
        case .israel: return "Jerusalem"
        case .italy: return "Rome"
        case .ivoryCoast: return "Yamoussoukro"
        case .jamaica: return "Kingston"
        case .japan: return "Tokyo"
        case .jordan: return "Amman"
        case .kazakhstan: return "Astana"
        case .kenya: return "Nairobi"
        case .kiribati: return "Tarawa"
        case .kosovo: return "Pristina"
        case .kuwait: return "Kuwait City"
        case .kyrgyzstan: return "Bishkek"
        case .laos: return "Vientiane"
        case .latvia: return "Riga"
        case .lebanon: return "Beirut"
        case .lesotho: return "Maseru"
        case .liberia: return "Monrovia"
        case .libya: return "Tripoli"
        case .liechtenstein: return "Vaduz"
        case .lithuania: return "Vilnius"
        case .luxembourg: return "Luxembourg City"
        case .macau: return "Macau"
        case .madagascar: return "Antananarivo"
        case .malawi: return "Lilongwe"
        case .malaysia: return "Kuala Lumpur"
        case .maldives: return "Malé"
        case .mali: return "Bamako"
        case .malta: return "Valletta"
        case .marshallIslands: return "Majuro"
        case .mauritania: return "Nouakchott"
        case .mauritius: return "Port Louis"
        case .mexico: return "Mexico City"
        case .micronesia: return "Palikir"
        case .moldova: return "Chișinău"
        case .monaco: return "Monaco"
        case .mongolia: return "Ulaanbaatar"
        case .montenegro: return "Podgorica"
        case .morocco: return "Rabat"
        case .mozambique: return "Maputo"
        case .myanmar: return "Naypyidaw"
        case .namibia: return "Windhoek"
        case .nauru: return "Yaren"
        case .nepal: return "Kathmandu"
        case .netherlands: return "Amsterdam"
        case .newZealand: return "Wellington"
        case .nicaragua: return "Managua"
        case .niger: return "Niamey"
        case .nigeria: return "Abuja"
        case .northKorea: return "Pyongyang"
        case .northMacedonia: return "Skopje"
        case .norway: return "Oslo"
        case .oman: return "Muscat"
        case .pakistan: return "Islamabad"
        case .palau: return "Ngerulmud"
        case .palestine: return "Ramallah"
        case .panama: return "Panama City"
        case .papuaNewGuinea: return "Port Moresby"
        case .paraguay: return "Asunción"
        case .peru: return "Lima"
        case .philippines: return "Manila"
        case .poland: return "Warsaw"
        case .portugal: return "Lisbon"
        case .puertoRico: return "San Juan"
        case .qatar: return "Doha"
        case .romania: return "Bucharest"
        case .russia: return "Moscow"
        case .rwanda: return "Kigali"
        case .saintKittsAndNevis: return "Basseterre"
        case .saintLucia: return "Castries"
        case .saintVincentAndTheGrenadines: return "Kingstown"
        case .samoa: return "Apia"
        case .sanMarino: return "San Marino"
        case .saoTomeAndPrincipe: return "São Tomé"
        case .saudiArabia: return "Riyadh"
        case .senegal: return "Dakar"
        case .serbia: return "Belgrade"
        case .seychelles: return "Victoria"
        case .sierraLeone: return "Freetown"
        case .singapore: return "Singapore"
        case .slovakia: return "Bratislava"
        case .slovenia: return "Ljubljana"
        case .solomonIslands: return "Honiara"
        case .somalia: return "Mogadishu"
        case .southAfrica: return "Pretoria"
        case .southKorea: return "Seoul"
        case .southSudan: return "Juba"
        case .spain: return "Madrid"
        case .sriLanka: return "Colombo"
        case .sudan: return "Khartoum"
        case .suriname: return "Paramaribo"
        case .sweden: return "Stockholm"
        case .switzerland: return "Bern"
        case .syria: return "Damascus"
        case .taiwan: return "Taipei"
        case .tajikistan: return "Dushanbe"
        case .tanzania: return "Dar es Salaam"
        case .thailand: return "Bangkok"
        case .timorLeste: return "Dili"
        case .togo: return "Lomé"
        case .tonga: return "Nuku'alofa"
        case .trinidadAndTobago: return "Port of Spain"
        case .tunisia: return "Tunis"
        case .turkey: return "Ankara"
        case .turkmenistan: return "Ashgabat"
        case .tuvalu: return "Funafuti"
        case .uganda: return "Kampala"
        case .ukraine: return "Kyiv"
        case .unitedArabEmirates: return "Abu Dhabi"
        case .unitedKingdom: return "London"
        case .unitedStates: return "Washington, D.C."
        case .uruguay: return "Montevideo"
        case .uzbekistan: return "Tashkent"
        case .vanuatu: return "Port Vila"
        case .vaticanCity: return "Vatican City"
        case .venezuela: return "Caracas"
        case .vietnam: return "Hanoi"
        case .yemen: return "Sana'a"
        case .zambia: return "Lusaka"
        case .zimbabwe: return "Harare"
        }
    }
    
    var majorCities: [String] {
        switch self {
        case .afghanistan: return ["Kandahar", "Herat", "Mazar-i-Sharif"]
        case .albania: return ["Durrës", "Vlorë", "Shkodër"]
        case .algeria: return ["Oran", "Constantine", "Annaba"]
        case .andorra: return ["Escaldes-Engordany", "Sant Julià de Lòria", "Ordino"]
        case .angola: return ["Huambo", "Benguela", "Kuito"]
        case .antiguaAndBarbuda: return ["Codrington", "Liberta", "Parham"]
        case .argentina: return ["Córdoba", "Rosario", "Mendoza"]
        case .armenia: return ["Gyumri", "Vanadzor", "Vagharshapat"]
        case .australia: return ["Sydney", "Melbourne", "Brisbane"]
        case .austria: return ["Graz", "Linz", "Salzburg"]
        case .azerbaijan: return ["Ganja", "Lankaran", "Sumgait"]
        case .bahamas: return ["Freeport", "Marsh Harbour", "Exuma"]
        case .bahrain: return ["Riffa", "Muharraq", "Isa Town"]
        case .bangladesh: return ["Chittagong", "Khulna", "Rajshahi"]
        case .barbados: return ["Speightstown", "Oistins", "Holetown"]
        case .belarus: return ["Gomel", "Vitebsk", "Grodno"]
        case .belgium: return ["Antwerp", "Ghent", "Charleroi"]
        case .belize: return ["Belize City", "Orange Walk", "San Ignacio"]
        case .benin: return ["Cotonou", "Djougou", "Parakou"]
        case .bhutan: return ["Punakha", "Paro", "Phuentsholing"]
        case .bolivia: return ["Santa Cruz", "Cochabamba", "Oruro"]
        case .bosniaAndHerzegovina: return ["Banja Luka", "Zenica", "Tuzla"]
        case .botswana: return ["Francistown", "Selebi-Phikwe", "Maun"]
        case .brazil: return ["São Paulo", "Rio de Janeiro", "Salvador"]
        case .brunei: return ["Kuala Belait", "Seria", "Tutong"]
        case .bulgaria: return ["Plovdiv", "Varna", "Burgas"]
        case .burkinaFaso: return ["Bobo-Dioulasso", "Koudougou", "Banfora"]
        case .burundi: return ["Bujumbura", "Muyinga", "Ngozi"]
        case .cambodia: return ["Battambang", "Siem Reap", "Kompong Cham"]
        case .cameroon: return ["Douala", "Garoua", "Bamenda"]
        case .canada: return ["Toronto", "Vancouver", "Montreal"]
        case .capeVerde: return ["Mindelo", "Santa Maria", "Assomada"]
        case .centralAfricanRepublic: return ["Bimbo", "Berberati", "Carnot"]
        case .chad: return ["Moundou", "Abeché", "Sarh"]
        case .chile: return ["Valparaíso", "Concepción", "Temuco"]
        case .china: return ["Shanghai", "Guangzhou", "Shenzhen"]
        case .colombia: return ["Medellín", "Cali", "Barranquilla"]
        case .comoros: return ["Mutsamudu", "Fomboni", "Domoni"]
        case .congoDemocratic: return ["Lubumbashi", "Kisangani", "Goma"]
        case .congoRepublic: return ["Pointe-Noire", "Dolisie", "Nkayi"]
        case .costaRica: return ["Alajuela", "Cartago", "Heredia"]
        case .croatia: return ["Split", "Rijeka", "Osijek"]
        case .cuba: return ["Santiago de Cuba", "Holguín", "Camagüey"]
        case .cyprus: return ["Limassol", "Larnaca", "Paphos"]
        case .czechia: return ["Brno", "Ostrava", "Plzeň"]
        case .denmark: return ["Aarhus", "Odense", "Aalborg"]
        case .djibouti: return ["Ali Sabieh", "Arta", "Tadjourah"]
        case .dominica: return ["Portsmouth", "Marigot", "Berekua"]
        case .dominicanRepublic: return ["Santiago", "La Romana", "San Pedro de Macorís"]
        case .ecuador: return ["Guayaquil", "Cuenca", "Machala"]
        case .egypt: return ["Alexandria", "Giza", "Shubra El Kheima"]
        case .elSalvador: return ["Santa Ana", "San Miguel", "Mejicanos"]
        case .equatorialGuinea: return ["Bata", "Ebebiyin", "Aconibe"]
        case .eritrea: return ["Keren", "Assab", "Massawa"]
        case .estonia: return ["Tartu", "Narva", "Kohtla-Järve"]
        case .eswatini: return ["Manzini", "Siteki", "Nhlangano"]
        case .ethiopia: return ["Dire Dawa", "Adama", "Gondar"]
        case .fiji: return ["Nadi", "Lautoka", "Labasa"]
        case .finland: return ["Espoo", "Tampere", "Turku"]
        case .france: return ["Lyon", "Marseille", "Toulouse"]
        case .gabon: return ["Port-Gentil", "Franceville", "Oyem"]
        case .gambia: return ["Serrekunda", "Brikama", "Bakau"]
        case .georgia: return ["Kutaisi", "Batumi", "Zugdidi"]
        case .germany: return ["Hamburg", "Munich", "Cologne"]
        case .ghana: return ["Kumasi", "Tema", "Sekondi-Takoradi"]
        case .greece: return ["Thessaloniki", "Patras", "Heraklion"]
        case .grenada: return ["Grenville", "Gouyave", "Sauteurs"]
        case .guatemala: return ["Quetzaltenango", "Escuintla", "Antigua"]
        case .guinea: return ["Kindia", "Mamou", "Nzérékoré"]
        case .guineaBissau: return ["Gabu", "Bafatá", "Cacheu"]
        case .guyana: return ["Linden", "New Amsterdam", "Bartica"]
        case .haiti: return ["Cap-Haïtien", "Gonaïves", "Delmas"]
        case .honduras: return ["San Pedro Sula", "Choloma", "La Ceiba"]
        case .hongKong: return ["Kowloon", "Tuen Mun", "Sha Tin"]
        case .hungary: return ["Debrecen", "Szeged", "Miskolc"]
        case .iceland: return ["Akureyri", "Hafnarfjörður", "Kópavogur"]
        case .india: return ["Mumbai", "Bangalore", "Chennai"]
        case .indonesia: return ["Surabaya", "Bandung", "Medan"]
        case .iran: return ["Mashhad", "Esfahan", "Tabriz"]
        case .iraq: return ["Mosul", "Basra", "Erbil"]
        case .ireland: return ["Cork", "Galway", "Limerick"]
        case .israel: return ["Tel Aviv", "Haifa", "Beersheba"]
        case .italy: return ["Milan", "Naples", "Turin"]
        case .ivoryCoast: return ["Abidjan", "Bouaké", "Daloa"]
        case .jamaica: return ["Montego Bay", "Spanish Town", "Portmore"]
        case .japan: return ["Osaka", "Kyoto", "Yokohama"]
        case .jordan: return ["Zarqa", "Irbid", "Aqaba"]
        case .kazakhstan: return ["Almaty", "Karaganda", "Aktobe"]
        case .kenya: return ["Mombasa", "Kisumu", "Nakuru"]
        case .kiribati: return ["Betio", "Bairiki", "Bikenibeu"]
        case .kosovo: return ["Prizren", "Gjilan", "Peja"]
        case .kuwait: return ["Salmiya", "Hawalli", "Farwaniya"]
        case .kyrgyzstan: return ["Osh", "Jalal-Abad", "Karakol"]
        case .laos: return ["Savannakhet", "Pakse", "Luang Prabang"]
        case .latvia: return ["Daugavpils", "Liepaja", "Ventspils"]
        case .lebanon: return ["Tripoli", "Sidon", "Tyre"]
        case .lesotho: return ["Teyateyaneng", "Mafeteng", "Hlotse"]
        case .liberia: return ["Gbarnga", "Kakata", "Buchanan"]
        case .libya: return ["Benghazi", "Misrata", "Zawiya"]
        case .liechtenstein: return ["Schaan", "Triesen", "Balzers"]
        case .lithuania: return ["Kaunas", "Klaipėda", "Šiauliai"]
        case .luxembourg: return ["Esch-sur-Alzette", "Differdange", "Dudelange"]
        case .macau: return ["Taipa", "Coloane", "Cotai"]
        case .madagascar: return ["Toamasina", "Toliara", "Antsirabe"]
        case .malawi: return ["Blantyre", "Mzuzu", "Zomba"]
        case .malaysia: return ["George Town", "Johor Bahru", "Ipoh"]
        case .maldives: return ["Addu City", "Fuvahmulah", "Kulhudhuffushi"]
        case .mali: return ["Sikasso", "Ségou", "Mopti"]
        case .malta: return ["Birkirkara", "Mosta", "Qormi"]
        case .marshallIslands: return ["Ebeye", "Ailinglaplap", "Wotje"]
        case .mauritania: return ["Nouadhibou", "Atar", "Kiffa"]
        case .mauritius: return ["Beau Bassin-Rose Hill", "Vacoas-Phoenix", "Curepipe"]
        case .mexico: return ["Guadalajara", "Monterrey", "Puebla"]
        case .micronesia: return ["Kolonia", "Tol", "Weno"]
        case .moldova: return ["Tiraspol", "Bălți", "Bender"]
        case .monaco: return ["La Rousse", "Monte Carlo", "Fontvieille"]
        case .mongolia: return ["Darkhan", "Erdenet", "Choibalsan"]
        case .montenegro: return ["Nikšić", "Pljevlja", "Bijelo Polje"]
        case .morocco: return ["Casablanca", "Fez", "Marrakesh"]
        case .mozambique: return ["Beira", "Nampula", "Matola"]
        case .myanmar: return ["Yangon", "Mandalay", "Mawlamyine"]
        case .namibia: return ["Walvis Bay", "Oshakati", "Swakopmund"]
        case .nauru: return ["Denigomodu", "Anabar", "Yaren"]
        case .nepal: return ["Pokhara", "Lalitpur", "Biratnagar"]
        case .netherlands: return ["Rotterdam", "The Hague", "Utrecht"]
        case .newZealand: return ["Auckland", "Christchurch", "Hamilton"]
        case .nicaragua: return ["Granada", "León", "Masaya"]
        case .niger: return ["Maradi", "Zinder", "Tahoua"]
        case .nigeria: return ["Lagos", "Kano", "Ibadan"]
        case .northKorea: return ["Hamhŭng", "Chongjin", "Nampo"]
        case .northMacedonia: return ["Kumanovo", "Bitola", "Prilep"]
        case .norway: return ["Bergen", "Stavanger", "Trondheim"]
        case .oman: return ["Salalah", "Sohar", "Nizwa"]
        case .pakistan: return ["Lahore", "Karachi", "Faisalabad"]
        case .palau: return ["Koror", "Melekelok", "Airai"]
        case .palestine: return ["Ramallah", "Nablus", "Bethlehem"]
        case .panama: return ["Colón", "David", "La Chorrera"]
        case .papuaNewGuinea: return ["Lae", "Madang", "Mount Hagen"]
        case .paraguay: return ["Ciudad del Este", "Encarnación", "San Lorenzo"]
        case .peru: return ["Arequipa", "Trujillo", "Chiclayo"]
        case .philippines: return ["Quezon City", "Davao", "Cebu"]
        case .poland: return ["Kraków", "Wrocław", "Poznań"]
        case .portugal: return ["Porto", "Braga", "Amadora"]
        case .puertoRico: return ["Ponce", "Bayamón", "Carolina"]
        case .qatar: return ["Al Rayyan", "Umm Salal", "Al Wakrah"]
        case .romania: return ["Cluj-Napoca", "Timișoara", "Iași"]
        case .russia: return ["St. Petersburg", "Novosibirsk", "Yekaterinburg"]
        case .rwanda: return ["Butare", "Gitarama", "Musanze"]
        case .saintKittsAndNevis: return ["Charlestown", "Dieppe Bay", "Sandy Point"]
        case .saintLucia: return ["Vieux Fort", "Canaries", "Soufrière"]
        case .saintVincentAndTheGrenadines: return ["Layou", "Chateaubelair", "Barrouallie"]
        case .samoa: return ["Fogapoa", "Leulumoega", "Vaitele"]
        case .sanMarino: return ["Serravalle", "Domagnano", "Borgo Maggiore"]
        case .saoTomeAndPrincipe: return ["Santo António", "Trindade", "Neves"]
        case .saudiArabia: return ["Jeddah", "Mecca", "Medina"]
        case .senegal: return ["Kaolack", "Saint-Louis", "Thiès"]
        case .serbia: return ["Novi Sad", "Niš", "Kragujevac"]
        case .seychelles: return ["Mahe", "Praslin", "La Digue"]
        case .sierraLeone: return ["Kenema", "Bo", "Makeni"]
        case .singapore: return ["Jurong", "Bedok", "Tampines"]
        case .slovakia: return ["Košice", "Prešov", "Banská Bystrica"]
        case .slovenia: return ["Maribor", "Celje", "Kranj"]
        case .solomonIslands: return ["Gizo", "Auki", "Noro"]
        case .somalia: return ["Hargeisa", "Kismayo", "Bosaso"]
        case .southAfrica: return ["Cape Town", "Johannesburg", "Durban"]
        case .southKorea: return ["Busan", "Daegu", "Incheon"]
        case .southSudan: return ["Malakal", "Wau", "Yei"]
        case .spain: return ["Barcelona", "Valencia", "Seville"]
        case .sriLanka: return ["Galle", "Kandy", "Jaffna"]
        case .sudan: return ["Omdurman", "Port Sudan", "Kassala"]
        case .suriname: return ["Lelydorp", "Nieuw Nickerie", "Moengo"]
        case .sweden: return ["Gothenburg", "Malmö", "Uppsala"]
        case .switzerland: return ["Zurich", "Geneva", "Basel"]
        case .syria: return ["Aleppo", "Homs", "Latakia"]
        case .taiwan: return ["Kaohsiung", "Taichung", "Tainan"]
        case .tajikistan: return ["Khujand", "Kulob", "Bokhtar"]
        case .tanzania: return ["Dar es Salaam", "Mbeya", "Arusha"]
        case .thailand: return ["Chiang Mai", "Phuket", "Pattaya"]
        case .timorLeste: return ["Baucau", "Maliana", "Suai"]
        case .togo: return ["Sokodé", "Kpalimé", "Atakpamé"]
        case .tonga: return ["Neiafu", "Pangai", "Ohonua"]
        case .trinidadAndTobago: return ["San Fernando", "Arima", "Chaguanas"]
        case .tunisia: return ["Sfax", "Sousse", "Kairouan"]
        case .turkey: return ["Istanbul", "Izmir", "Bursa"]
        case .turkmenistan: return ["Turkmenbashi", "Balkanabat", "Mary"]
        case .tuvalu: return ["Nui", "Nukufetau", "Vaitupu"]
        case .uganda: return ["Gulu", "Lira", "Mbarara"]
        case .ukraine: return ["Kharkiv", "Lviv", "Odessa"]
        case .unitedArabEmirates: return ["Dubai", "Sharjah", "Ajman"]
        case .unitedKingdom: return ["Manchester", "Birmingham", "Glasgow"]
        case .unitedStates: return ["New York", "Los Angeles", "Chicago"]
        case .uruguay: return ["Salto", "Paysandú", "Las Piedras"]
        case .uzbekistan: return ["Samarkand", "Bukhara", "Namangan"]
        case .vanuatu: return ["Luganville", "Norsup", "Isangel"]
        case .vaticanCity: return ["Apostolic Palace", "St. Peter's Square", "Vatican Gardens"]
        case .venezuela: return ["Maracaibo", "Valencia", "Barquisimeto"]
        case .vietnam: return ["Ho Chi Minh City", "Da Nang", "Hai Phong"]
        case .yemen: return ["Aden", "Taiz", "Al Hudaydah"]
        case .zambia: return ["Ndola", "Livingstone", "Kitwe"]
        case .zimbabwe: return ["Bulawayo", "Mutare", "Gweru"]
        }
    }
}
