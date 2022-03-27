//
//  Shop.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/01/20.
//

import Foundation

extension HotPepperAPI {
    struct SearchShopsModel: Decodable {
        let shop: [Shop]
    }
    
    struct Shop: Decodable {
        let id: String
        let stationName: String
        let name: String
        let budget: Budget
        let logoImage: String
    }
    
    struct Budget: Decodable {
        let name: String
    }
}


extension HotPepperAPI.SearchShopsModel {
    static var exampleJSON: String {
        """
        {
           "results":{
              "api_version":"1.26",
              "results_available":28,
              "results_returned":"10",
              "results_start":1,
              "shop":[
                 {
                    "access":"西新駅4番出口より徒歩3分。駅から進んでパチンコのワンダーランドの横を通って左側。",
                    "address":"福岡県福岡市早良区城西３-19-16",
                    "band":"不可",
                    "barrier_free":"あり ：トイレは段差あり。",
                    "budget":{
                       "average":"3500円",
                       "code":"B003",
                       "name":"3001～4000円"
                    },
                    "budget_memo":"席代なし",
                    "capacity":62,
                    "card":"利用可",
                    "catch":"もつ鍋と焼肉のお得コース 宴会個室は最大20名様♪",
                    "charter":"貸切可 ：貸切は50名様から承ります。それ以下の人数の場合でもお気軽にご相談ください。",
                    "child":"お子様連れOK ：家族連れのお客様も多くいらっしゃいます。",
                    "close":"月",
                    "coupon_urls":{
                       "pc":"https://www.hotpepper.jp/strJ001194247/map/?vos=nhppalsa000016",
                       "sp":"https://www.hotpepper.jp/strJ001194247/scoupon/?vos=nhppalsa000016"
                    },
                    "course":"あり",
                    "english":"なし",
                    "free_drink":"あり ：単品飲み放題は2H1980円（税込）。飲み放題付コースがお得です。",
                    "free_food":"なし ：食べ放題はありませんが、もつ鍋と焼肉の両方が食べれるコースはリーズナブルでお腹いっぱいになります。",
                    "genre":{
                       "catch":"西新のもつ鍋・焼肉専門店/西新駅徒歩3分",
                       "code":"G008",
                       "name":"焼肉・ホルモン"
                    },
                    "horigotatsu":"あり ：個室は全て掘りごたつ個室になります。",
                    "id":"J001194247",
                    "karaoke":"なし",
                    "ktai_coupon":0,
                    "large_area":{
                       "code":"Z091",
                       "name":"福岡"
                    },
                    "large_service_area":{
                       "code":"SS90",
                       "name":"九州・沖縄"
                    },
                    "lat":33.5813747467,
                    "lng":130.3605712835,
                    "logo_image":"https://imgfp.hotp.jp/IMGH/93/76/P035429376/P035429376_69.jpg",
                    "lunch":"なし",
                    "middle_area":{
                       "code":"Y710",
                       "name":"西新・姪浜・その他西エリア"
                    },
                    "midnight":"営業している",
                    "mobile_access":"西新駅4番出口より徒歩3分｡",
                    "name":"もつ鍋 焼き肉 岩見 西新店",
                    "name_kana":"もつなべ　やきにく　いわみ　にしじんてん",
                    "non_smoking":"禁煙席なし",
                    "open":"火～日、祝日、祝前日: 18:00～翌0:00 （料理L.O. 23:30 ドリンクL.O. 23:30）",
                    "other_memo":"詳しくはお店にお問い合わせください",
                    "parking":"あり ：お店の目の前に4台の駐車場があります。",
                    "party_capacity":62,
                    "pet":"不可",
                    "photo":{
                       "mobile":{
                          "l":"https://imgfp.hotp.jp/IMGH/78/42/P029987842/P029987842_168.jpg",
                          "s":"https://imgfp.hotp.jp/IMGH/78/42/P029987842/P029987842_100.jpg"
                       },
                       "pc":{
                          "l":"https://imgfp.hotp.jp/IMGH/78/42/P029987842/P029987842_238.jpg",
                          "m":"https://imgfp.hotp.jp/IMGH/78/42/P029987842/P029987842_168.jpg",
                          "s":"https://imgfp.hotp.jp/IMGH/78/42/P029987842/P029987842_58_s.jpg"
                       }
                    },
                    "private_room":"あり ：6名様、4名様、2名様個室ございます。つなげて20名個室にもできます。",
                    "service_area":{
                       "code":"SA91",
                       "name":"福岡"
                    },
                    "shop_detail_memo":"",
                    "show":"なし",
                    "small_area":{
                       "code":"X708",
                       "name":"西新"
                    },
                    "station_name":"西新",
                    "sub_genre":{
                       "code":"G001",
                       "name":"居酒屋"
                    },
                    "tatami":"なし ：座敷はございませんが、掘りごたつ個室はございます。",
                    "tv":"なし",
                    "urls":{
                       "pc":"https://www.hotpepper.jp/strJ001194247/?vos=nhppalsa000016"
                    },
                    "wedding":"二次会は承っております。百地浜からも近いので、お気軽にご相談ください。",
                    "wifi":"あり"
                 },
                 {
                    "access":"駅前通りを海方面へ向かって直進、左手に伊予銀行のある信号を右折。最初の十字路で左手前方にある2F建てのお店です。",
                    "address":"大分県別府市北浜１-1-6",
                    "band":"不可",
                    "barrier_free":"なし ：お身体が不自由なお方は気軽にお声がけください。",
                    "budget":{
                       "average":"ランチ800円～、ディナー3500円～",
                       "code":"B003",
                       "name":"3001～4000円"
                    },
                    "budget_memo":"",
                    "capacity":96,
                    "card":"利用可",
                    "catch":"カウンターで1人焼き肉！ A4A5九州産黒毛和牛を！",
                    "charter":"貸切不可",
                    "child":"お子様連れOK ：個室もご用意しております。ご家族でお気軽にご来店ください。",
                    "close":"ランチは不定休！ディナーは水曜定休。",
                    "coupon_urls":{
                       "pc":"https://www.hotpepper.jp/strJ001267232/map/?vos=nhppalsa000016",
                       "sp":"https://www.hotpepper.jp/strJ001267232/scoupon/?vos=nhppalsa000016"
                    },
                    "course":"あり",
                    "english":"なし",
                    "free_drink":"なし ：単品のお料理ドリンクをご用意しております",
                    "free_food":"なし ：単品のお料理ドリンクをご用意しております",
                    "genre":{
                       "catch":"カウンターで…個室で…焼き肉を楽しむお店",
                       "code":"G008",
                       "name":"焼肉・ホルモン"
                    },
                    "horigotatsu":"あり ：掘り炬燵式の個室席がございます",
                    "id":"J001267232",
                    "karaoke":"なし",
                    "ktai_coupon":1,
                    "large_area":{
                       "code":"Z095",
                       "name":"大分"
                    },
                    "large_service_area":{
                       "code":"SS90",
                       "name":"九州・沖縄"
                    },
                    "lat":33.2783173359,
                    "lng":131.5026621778,
                    "logo_image":"https://imgfp.hotp.jp/IMGH/80/69/P038308069/P038308069_69.jpg",
                    "lunch":"なし",
                    "middle_area":{
                       "code":"Y903",
                       "name":"別府"
                    },
                    "midnight":"営業していない",
                    "mobile_access":"駅前通り伊予銀行の交差点を左折→ｱｰｻｰﾎﾃﾙ付近",
                    "name":"焼き肉 凡",
                    "name_kana":"やきにくぼん",
                    "non_smoking":"全面禁煙",
                    "open":"月、火、木～日、祝日、祝前日: 11:30～14:0017:30～23:00 （料理L.O. 22:00 ドリンクL.O. 22:30）水: 11:30～14:00",
                    "other_memo":"できるかぎりご要望にお応えしたいと思っております。ご相談ください。",
                    "parking":"なし ：お店の目の前にコインパーキングがございます。",
                    "party_capacity":36,
                    "pet":"不可",
                    "photo":{
                       "mobile":{
                          "l":"https://imgfp.hotp.jp/IMGH/80/70/P038308070/P038308070_168.jpg",
                          "s":"https://imgfp.hotp.jp/IMGH/80/70/P038308070/P038308070_100.jpg"
                       },
                       "pc":{
                          "l":"https://imgfp.hotp.jp/IMGH/80/70/P038308070/P038308070_238.jpg",
                          "m":"https://imgfp.hotp.jp/IMGH/80/70/P038308070/P038308070_168.jpg",
                          "s":"https://imgfp.hotp.jp/IMGH/80/70/P038308070/P038308070_58_s.jpg"
                       }
                    },
                    "private_room":"あり ：掘り炬燵式の個室席がございます",
                    "service_area":{
                       "code":"SA95",
                       "name":"大分"
                    },
                    "shop_detail_memo":"",
                    "show":"なし",
                    "small_area":{
                       "code":"X971",
                       "name":"別府市（別府駅・別府市中心地）"
                    },
                    "station_name":"別府",
                    "sub_genre":{
                       "code":"G001",
                       "name":"居酒屋"
                    },
                    "tatami":"なし",
                    "tv":"なし",
                    "urls":{
                       "pc":"https://www.hotpepper.jp/strJ001267232/?vos=nhppalsa000016"
                    },
                    "wedding":"ご相談に応じてお受けいたします まずは御連絡を！",
                    "wifi":"なし"
                 },
                 {
                    "access":"天文館電停より徒歩5分。文化通りを抜けて信号を左へ。右手に看板が見えます。山之口本通り沿い。",
                    "address":"鹿児島県鹿児島市千日町9-3 　天文館Kビル2F",
                    "band":"不可",
                    "barrier_free":"なし ：お手伝いが必要な場合はスタッフまでお声掛けください",
                    "budget":{
                       "average":"5000円",
                       "code":"B004",
                       "name":"5001～7000円"
                    },
                    "budget_memo":"PayPay使えます！",
                    "capacity":70,
                    "card":"利用可",
                    "catch":"全室完全個室！ 極上の出汁で黒豚しゃぶ",
                    "charter":"貸切不可 ：お気軽にお問い合わせください。",
                    "child":"お子様連れOK",
                    "close":"火",
                    "coupon_urls":{
                       "pc":"https://www.hotpepper.jp/strJ000591737/map/?vos=nhppalsa000016",
                       "sp":"https://www.hotpepper.jp/strJ000591737/scoupon/?vos=nhppalsa000016"
                    },
                    "course":"あり",
                    "english":"なし",
                    "free_drink":"あり ：不朽の名店の味にも飲み放題付コースが始まりました!!クーポンご利用でお得な内容詳細をご覧ください。",
                    "free_food":"なし ：申し訳ございません。食べ放題はありませんが、一品一品真心込めてお作りした料理が自慢です！",
                    "genre":{
                       "catch":"50年愛され続ける、鹿児島随一の老舗焼肉店",
                       "code":"G008",
                       "name":"焼肉・ホルモン"
                    },
                    "horigotatsu":"あり ：全席掘りごたつ式の個室を完備しております!!足をゆっくり伸ばしてお寛ぎ下さい。",
                    "id":"J000591737",
                    "karaoke":"なし",
                    "ktai_coupon":0,
                    "large_area":{
                       "code":"Z097",
                       "name":"鹿児島"
                    },
                    "large_service_area":{
                       "code":"SS90",
                       "name":"九州・沖縄"
                    },
                    "lat":31.5886052716,
                    "lng":130.5554026243,
                    "logo_image":"https://imgfp.hotp.jp/IMGH/48/29/P027814829/P027814829_69.jpg",
                    "lunch":"あり",
                    "middle_area":{
                       "code":"Y780",
                       "name":"鹿児島市　天文館・中央駅・ふ頭"
                    },
                    "midnight":"営業していない",
                    "mobile_access":"電停より文化通りを抜け5分｡信号を左に曲がると右手",
                    "name":"松坂 焼き肉",
                    "name_kana":"まつさか",
                    "non_smoking":"全面禁煙",
                    "open":"月、水～日、祝日、祝前日: 17:00～23:00 （料理L.O. 22:00 ドリンクL.O. 22:00）",
                    "other_memo":"※UberEats/出前館/foodpand/menuで配達も承っております。",
                    "parking":"なし ：近隣のコインパーキングをご利用ください",
                    "party_capacity":40,
                    "pet":"不可",
                    "photo":{
                       "mobile":{
                          "l":"https://imgfp.hotp.jp/IMGH/94/54/P029709454/P029709454_168.jpg",
                          "s":"https://imgfp.hotp.jp/IMGH/94/54/P029709454/P029709454_100.jpg"
                       },
                       "pc":{
                          "l":"https://imgfp.hotp.jp/IMGH/94/54/P029709454/P029709454_238.jpg",
                          "m":"https://imgfp.hotp.jp/IMGH/94/54/P029709454/P029709454_168.jpg",
                          "s":"https://imgfp.hotp.jp/IMGH/94/54/P029709454/P029709454_58_s.jpg"
                       }
                    },
                    "private_room":"あり ：接待や特別な日のお食事にご利用ください♪",
                    "service_area":{
                       "code":"SA97",
                       "name":"鹿児島"
                    },
                    "shop_detail_memo":"『老舗の拘り』で贅沢なお肉をご堪能頂けます♪お肉の質を選択して、最高の時間を★",
                    "show":"なし",
                    "small_area":{
                       "code":"X780",
                       "name":"天文館"
                    },
                    "station_name":"鹿児島中央駅前",
                    "sub_genre":{
                       "code":"G001",
                       "name":"居酒屋"
                    },
                    "tatami":"なし ：企業様のご宴会は座敷のご利用が大好評です。自由に動いて騒げるので大人数の場合はこちらをご利用下さい。",
                    "tv":"なし",
                    "urls":{
                       "pc":"https://www.hotpepper.jp/strJ000591737/?vos=nhppalsa000016"
                    },
                    "wedding":"※店舗へご確認ください",
                    "wifi":"なし"
                 }
              ]
           }
        }
        """
    }
}
