//
//  ViewController.swift
//  Words_practice
//
//  Created by 石橋龍 on 2017/10/04.
//  Copyright © 2017 Team snake. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, GADInterstitialDelegate {
    
    var interstitial: GADInterstitial!
    
    private let data_list: NSArray = ["第1回","第2回","第3回","第4回","第5回","第6回","第7回","第8回","第9回","第10回","第11回","第12回","第13回","第14回","第15回","第16回","第17回","第18回","第19回","第20回","第21回","第22回","第23回","第24回","第25回","第26回","第27回","第28回","第29回","第30回","第31回","第32回","第33回","第34回","第35回","第36回","第37回","第38回","第39回","第40回","第41回","第42回","第43回","第44回","第45回","第46回","第47回","第48回","第49回","第50回","第51回","第52回","第53回","第54回"]
    
    private var myUIPicker: UIPickerView!
    private var startButton: UIButton!
    let button1 = UIButton()
    let button2 = UIButton()
    let button3 = UIButton()
    let button4 = UIButton()
    let label = UILabel()
    let footer_label = UILabel()
    var index = 1
    var i = 0
    var count = 0
    var counter = 0
    var questions = [String]()
    var answers   = [String]()
    var choices   = [String]()
    
    var random_num1 = 0
    var random_num2 = 0
    var random_num3 = 0
    var answer_index = 0
    
    var selected = 0
    var kimagure = 0
    var finished = 0
    
    
    // about add
    let device_test_ID = "63b4e364bb2dcb82d2709fb9ae0f15d5"
    
    // 20 words
    let words1 = ["Adam's apple":"喉ぼとけ","auricle":"耳介","cheek":"頬","chin":"顎先、オトガイ","ear":"耳","eye":"目","eyebrow":"眉","eyelash":"睫毛","eyelid":"瞼、眼瞼","face":"顔","forehead":"額、前額部","hair":"髪","head":"頭","jaw":"顎","lip":"唇","mouth":"口","neck":"首","nose":"鼻","occiput":"後頭部","temple":"こめかみ、側頭部"]
    
    // 18 words
    let words2 = ["armpit":"脇の下","breast":"胸(前表面)","chest":"胸(部)","elbow":"肘(ひじ)","finger":"指","forearm":"前腕","hand":"手","index finger":"人さし指","little finger":"小指","middle finger":"中指","nail":"爪","nipple":"乳頭","palm":"手のひら","ring finger":"薬指","shoulder":"肩","thumb":"親指","upper arm":"上腕","wrist":"手首"]
    
    // 20 words
    let words3 = ["abdomen":"腹部","ankle":"足首","back":"背","buttock":"臀部","calf":"ふくらはぎ","foot":"足","genital area":"陰部","groin":"鼠径(蹊)部(そけい)","heel":"踵(かかと)","instep":"足の甲","knee":"膝(ひざ)","leg":"脚、下肢(かし)","lower back":"腰","navel":"臍(へそ)","shin":"すね","side":"わき腹","sole":"足底","thigh":"大腿(だいたい)","toe":"足指","torso":"胴"]
    
    // 20 words
    let words4 = ["brain":"脳","brain stem":"脳幹","cerebellum":"小脳","cerebrum":"大脳","conjunctiva":"結膜","cornea":"角膜","eardrum":"鼓膜","external ear canal":"外耳道","eyeball":"眼球","inner ear":"内耳","iris":"虹彩","lens":"水晶体","meninges":"髄膜","middle ear":"中耳","nerve":"神経","outer ear":"外耳","pupil":"瞳孔","retina":"網膜","spinal cord":"脊髄","sympathetic nerv":"交感神経"]
    
    // 19 words
    let words5 = ["aorta":"大動脈","artery":"動脈","atrium":"心房","blood":"血液","(blood) capillary":"毛細(血)管","blood vessel":"血管","bone marrow":"骨髄","heart":"心臓","lymph":"リンパ","lymphocyte":"リンパ球","myocardium":"心筋","plasma":"血漿(けっしょう)","platelet":"血小板","red blood cell":"赤血球","spleen":"脾臓(ひぞう)","valve":"弁","vein":"静脈","ventricle":"心室","white blood cell":"白血球"]
    
    // 18 words
    let words6 = ["adrenal gland":"副腎(ふくじん)","bronchus":"気管支","diaphragm":"横隔膜(おうかくまく)","epiglottis":"喉頭蓋(こうとうがい)","hypothalamus":"視床下部","larynx":"喉頭","lung":"肺","nasal cavity":"鼻腔(びくう)","pancreas":"膵臓(すいぞう)","pharynx":"咽頭","pineal gland":"松果体(しょうかたい)","pituitary gland":"下垂体","throat":"喉","thymus (gland)":"胸腺","thyroid gland":"甲状腺 ","tonsil":"扁桃","trachea":"気管","vocal cord":"声帯"]
    
    // 18 words
    let words7 = ["adult tooth":"永久歯","anus":"肛門","appendix":"虫垂","baby tooth":"乳歯","canine":"犬歯(けんし)","colon":"大腸","duodenum":"十二指腸","esophagus":"食道","gallbladder":"胆嚢(たんのう)","gum":"歯肉、歯茎(はぐき)","incisor":"切歯","liver":"肝臓","molar":"大臼歯","palate":"上顎","rectum":"直腸","small intestine":"小腸","stomach":"胃","tongue":"舌", "uvula":"口蓋垂"]
    
    // 19 words
    let words8 = ["bladder":"膀胱(ぼうこう)","fallopian tube":"卵管","kidney":"腎臓","mammary gland":"乳腺(にゅうせん)","ovary":"卵巣","ovum":"卵子","penis":"陰茎(いんけい)","placenta":"胎盤","prostate gland":"前立腺","scrotum":"陰嚢(いんのう)","seminal vesicles":"精嚢(せいのう)","sperm":"精子","testicle":"睾丸","umbilical cord":"臍帯(さいたい)","ureter":"尿管","urethra":"尿道","uterus":"子宮","vagina":"膣","vas deferens":"精管"]
    
    // 20 words
    let words9 = ["bone":"骨","cartilage":"軟骨","cheek bone":"頬骨","clavicle":"鎖骨","hip joint":"股関節","humerus":"上腕骨","joint":"関節","ligament":"靭帯(じんたい)","muscle":"筋肉","nasal bone":"鼻骨","patella":"膝蓋骨(しつがいこつ)","pelvis":"骨盤","rib":"肋骨","scapula":"肩甲骨","skull":"頭蓋骨","spine":"脊椎(せきつい)","sternum":"胸骨","tendon":"腱","thighbone":"大腿骨","vertebra":"椎骨(ついこつ)"]
    
    // 19 words
    let words10 = ["amniotic fluid":"羊水","earwax":"耳垢","embryo":"胎児(受精後8週未満","fatty tissue":"脂肪組織","fetus":"胎児(妊娠9週以上)","gastric juice":"胃液","membrane":"膜","Mongolian spot":"小児斑、蒙古斑","mucus":"粘液","pore":"毛穴","pus":"膿(のう)","saliva":"唾液","semen":"精液","skin":"皮膚","sputum":"痰(たん)","stool":"大便","sweat":"汗","tear":"涙","urine":"尿"]
    
    // 20 words
    let words11 = ["asthma":"喘息(ぜんそく)","bronchitis":"気管支炎","choking":"窒息","common cold":"風邪、感冒","cough":"咳","deafness":"聾(ろう)","difficulty in breathing":"呼吸困難","dumbness":"唖","earache":"耳痛","emphysema":"肺気腫","empyema":"蓄膿症","flu":"流行性感冒,インフルエンザ","goiter":"甲状腺腫","hay fever":"枯草(こそう)熱","hoarseness":"かれ声","impaired hearing":"難聴","inflammation of the larynx":"喉頭炎","inflammation of the middle ear":"中耳炎","inflammation of the nose":"鼻炎","inflammation of the tonsil":"扁桃炎"]
    
    // 19 words
    let words12 = ["laryngeal cancer":"喉頭ガン","loss of balance":"平衡感覚喪失","Meniere's syndrome":"メニエール症候群","mumps":"おたふくかぜ","nasal polyp":"鼻茸","nosebleed":"鼻血","otitis interna":"内耳炎","otorrhea":"耳漏(じろう)","pneumonia":"肺炎","pneumothorax":"気胸(ききょう)","ringing in the ears":"耳鳴り","runny nose":"鼻水、鼻汁","short breath":"息切れ","sneeze":"くしゃみ","snore":"いびき","sore throat":"喉の痛み","stuffy nose":"鼻づまり","tuberculosis":"結核","wheeze":"ぜいぜいいう音"]
    
    // 20 words
    let words13 = ["abnormal heart rhythm":"不整脈","aneurysm":"動脈瘤(どうみゃくりゅう）","angina pectoris":"狭心症","arteriosclerosis":"動脈硬化症","bleeding":"出血","brain hemorrhage":"脳出血","brain infarction":"脳梗塞","heart attack":"心臓発作","heart failure":"心不全","heart murmur":"心雑音","hemophilia":"血友病","high blood fat":"高脂血症","high blood pressure":"高血圧","leukemia":"白血病","low blood pressure":"低血圧","myocardial infarction":"心筋梗塞","palpitation( s)":"動悸","stroke":"発作","subarachnoid hemorrhage":"くも膜下出血","varicose veins":"静脈瘤"]
    
    // 20 words
    let words14 = ["abdominal hernia":"腹部ヘルニア","acid stomach":"胃酸過多症","alveolar pyorrhea":"歯槽膿漏","appendicitis":"虫垂炎","appetite loss":"食欲不振","bad bite":"不正咬合","bad breath":"口臭","bloated":"(お腹などが) 張った","bloody stool":"血便","burp":"げっぷ","canker sore":"鵞口瘡(がこうそう)","cavity":"虫歯","cholera":"コレラ","colon cancer":"大腸ガン","constipation":"便秘","diarrhea":"下痢","difficulty in swallowing":"嚥下(えんげ)困難","duodenal ulcer":"十二指腸潰瘍","dysentery":"赤痢","enteritis":"腸炎"]
    
    // 20 words
    let words15 = ["esophageal cancer":"食道ガン","fatty liver":"脂肪肝","food poisoning":"食中毒","gallstone":"胆石","gas":"屁","gastric dilation":"胃拡張","gastric ulcer":"胃潰瘍","gastroatonia":"胃アトニー","gastroptosis":"胃下垂","heartburn":"胸やけ","hemorrhoid":"痔疾(じしつ)","hepatitis":"肝炎","ileus":"腸閉塞","indigestion":"消化不良","inflammation of the colon":"大腸炎","inflammation of the esophagus":"食道炎","inflammation of the gallbladder":"胆嚢炎","inflammation of the gums":"歯肉炎","inflammation of the mouth":"口内炎","inflammation of the pancreas":"膵炎"]
    
    // 20 words
    let words16 = ["inflammation of the peritoneum":"腹膜炎","inflammation of the stomach":"胃炎","intestinal polyp":"腸ポリープ","irritable colon":"過敏(性)結腸","jaundice":"黄疸","liver cancer":"肝臓ガン","liver cirrhosis":"肝硬変","malnutrition":"栄養失調","nausea":"むかつき、吐き気","prolapse of anus":"肛","rectal cancer":"直腸ガン","regurgitation":"逆流(吐き戻し)","serum hepatitis":"血清肝炎","stomach cramps":"胃痙攣(いけいれん","stomachache":"腹痛","toothache":"歯痛","twisted bowel":"腸捻転","typhoid":"腸チフス","upset stomach":"胃の調子が悪いこと","vomit":"嘔吐"]
    
    // 20 words
    let words17 = ["bladder stone":"膀胱結石","bloody urine":"血尿","enlarged prostate":"前立腺肥大症","frequent urination":"頻尿","gonorrhea":"淋病","impotence":"性的不能(男性)","incontinence":"失禁","infertility":"不妊症","inflammation of the bladder":"膀胱炎","inflammation of the kidney":"腎炎","inflammation of the renal pelvis":"腎盂炎","inflammation of the testicle":"睾丸炎","inflammation of the urethra":"尿道炎","kidney stone":"腎臓結石","nephrosis":"ネフローゼ","sexually transmitted disease(STD)":"性的感染症","syphilis":"梅毒","uremia":"尿毒症","urinary calculus":"尿路結石","venereal disease(VD)":"性病"]
    
    // 16 words
    let words18 = ["breast cancer":"乳がん","breech baby":"逆子","candidiasis":"カンジダ症","cervical cancer":"子宮頸がん","discharge":"分泌物、おりもの","ectopic pregnancy":"子宮外妊娠","endometriosis":"子宮内膜症","frigidity":"不感症","heavy periods":"月経困難(症)","hemorrhage":"不正出血","hot flushes":"閉経期ののぼせ","inflammation of the mammary gland":"乳腺炎","inflammation of the ovary":"卵巣炎","inflammation of the vagina":"膣炎","inflammation of the vulva":"外陰炎","irregular periods":"月経異常"]
    
    // 18 words
    let words19 = ["menopausal disorder":"更年期障害","menorrhagia":"月経過多","menstrual cramps":"ひどい月経痛","menstrual disorder":"月経障害","menstrual pain":"月経痛","miscarriage":"流産","morning sickness":"つわり","ovarian cyst":"卵巣嚢腫","placenta previa":"前置胎盤","premature birth":"早産","puerperal fever":"産褥熱","retroflexion of the uterus":"子宮後屈","stillbirth":"死産","threatened abortion":"切迫流産","toxicosis of pregnancy":"妊娠中毒症","uterine cancer":"子宮がん","uterine myoma":"子宮筋腫","whites":"白帯下"]
    
    // 19 words
    let words20 = ["aged eyesight":"老眼","astigmatism":"乱視","blindness":"盲目","blood shot eyes":"充血した目","blurred vision":"視野のぼやけ","cataract":"白内障","color blindness":"色覚異常","conjunctivitis":"結膜炎","cross-eye":"内斜視","farsightedness":"遠視","glaucoma":"緑内障","nearsightedness":"近視","night blindness":"夜盲症","retinal detachment":"網膜剥離","squint":"斜視","stye":"麦粒腫、ものもらい","trachoma":"トラコーマ","watery eyes":"涙目","weak eyesight":"弱視"]
    
    // 20 words
    let words21 = ["ADHD":"注意欠陥多動症","bed-wetting":"夜尿症","chickenpox":"水痘","cleft palate":"口蓋裂","colic":"(幼児)の激しい腹痛","diphtheria":"ジフテリア","exanthema subitum":"突発性発疹","German measles":"風疹","harelip":"口唇裂","heat cramp":"熱性けいれん","infantile paralysis":"脳性(小児)麻痺","low birth weight baby":"低体重児","measles":"麻疹、はしか","night cry":"夜泣き","polio":"ポリオ、灰白髄炎","premature baby":"早産児","scarlet fever":"猩紅熱","sudden infant death syndrome(S":"I乳DS幼)児突然死症候群","water baby":"水頭症、脳水腫","whooping cough":"百日咳"]
    
    // 20 words
    let words22 = ["acrophobia":"高所恐怖症","alcoholism":"アルコール中毒","Alzheimer's disease":"アルツハイマー病","amnesia":"記憶喪失","aphasia":"失語症","auditory hallucination":"幻聴","autism":"自閉症","automatic imbalance":"自律神経失調症","bulimia":"過食症","coma":"昏睡","concussion":"脳震盪","dementia":"認知症","depression":"うつ病","derangement":"精神錯乱、精神障害","disorientation":"見当識障害","eating disorder":"摂食障害","epilepsy":"癲癇","faint":"気絶","fits":"(癲癇の)発作","forgetfulness":"物忘れ"]
    
    // 20 words
    let words23 = ["hallucination":"幻視、幻覚","headache":"頭痛","hysteria":"ヒステリー","insomnia":"不眠症","mania":"そう病","manic-depressive psychosis":"そううつ病","mental retardation":"精神遅滞","narcotic addiction":"麻薬中毒","nervous breakdown":"ノイローゼ","nervousness":"不安","obsession":"強迫観念","Parkinson's disease":"パーキンソン病","persecutory delusion":"被害妄想","psychic trauma":"精神的外傷","psychosis":"精神病","PTSD":"外傷後ストレス障害","schizophrenia":"統合失調症","sitophobia":"拒食症、恐食症","sleep disorder":"睡眠障害","stupor":"意識朦朧(もうろう)"]
    
    // 18 words
    let words24 = ["abrasion":"擦り傷","arthritis":"関節炎","backache":"腰痛","bedsore":"床ずれ","bow-leggedness":"O脚","broken bones":"骨折","bruise":"打撲傷","bump":"こぶ","burn":"やけど","caries":"カリエス","cramp":"痙攣","curvature of the spine":"脊椎弯曲","cut wound":"切り傷","deformity":"奇形","degeneration":"退化","dislocation":"脱臼","flat foot":"偏平足","frostbite":"凍傷"]
    
    // 19 words
    let words25 = ["frozen shoulder":"五十肩","gout":"痛風","herniated disk":"椎間板ヘルニア","hunchback":"脊柱後弯症、ねこ背","infected wound":"感染創","injury":"損傷、外傷","insect bite":"虫さされ","keloid":"ケロイド","laceration":"裂傷","limp":"片足をひきずること","lower back pain":"腰痛","muscular dystrophy":"筋ジストロフィー","neuralgia":"神経痛","numb":"しびれた、無感覚の","osteoporosis":"骨粗鬆症","paralysis":"麻痺","pigeon-toed":"内股の","rheumatism":"リューマチ","rupture":"(内臓)破裂"]
    
    // 16 words
    let words26 = ["scald":"熱傷","scar":"傷跡","sciatica":"座骨神経痛","scratch":"引っ掻き傷","shake":"(発熱、寒さによる) 震え","sore muscle":"筋肉痛","spasm":"痙攣、ひきつけ","sprain":"捻挫","stiffness":"こり、硬直","strain":"くじく、筋を違える","tenderness":"圧痛(あっつう)","tendovaginitis":"腱鞘炎","tennis elbow":"テニス肘","torn muscle":"肉離れ","whiplash injury":"むち打ち症","wound":"創傷(そうしょう)"]
    
    // 16 words
    let words27 = ["acne":"にきび","alopecia areata":"円形脱毛症","athlete's foot":"水虫","atopic dermatitis":"アトピー性皮膚炎","axillary odor":"わきが","birthmark":"あざ","blister":"水膨れ","boil":"おでき","chapped skin":"あかぎれ","cold sore":"単純ヘルペス","corn":"胼胝(たこ)","dandruff":"ふけ","drug eruption":"薬疹","eczema":"湿疹","erysipelas":"丹毒(たんどく)","gangrene":"壊疽(えそ)"]
    
    // 17 words
    let words28 = ["heat rash":"あせも","heavy sweating":"多汗","herpes zoster":"帯状疱疹","impetigo":"とびひ、伝染性膿痂疹","itch":"かゆみ","leprosy":"ライ病","malignant lentigo":"悪性ほくろ","melanoma":"黒色腫、メラノーマ","mole":"ほくろ、色素性母斑","pemphigus":"天疱瘡(てんぽうそう","psoriasis":"乾癬(かんせん)","rash":"発疹","ringworm":"白癬(はくせん)","skin cancer":"皮膚ガン","verruca":"いぼ","wheal":"蕁麻疹(じんましん)","whitlow":"ひょう疽"]
    
    // 20 words
    let words29 = ["AIDS":"エイズ","allergic disease":"アレルギー性疾患","autointoxication":"自家中毒","Basedow's disease":"バセドウ病","beriberi":"脚気(かっけ)","carbon monoxide poisoning":"一酸化炭素中毒","chronic fatigue syndrome":"慢性疲労症候群","collagen disease":"膠原(こうげん)病","diabetes":"糖尿病","Down's syndrome":"ダウン症候群","hospital acquired infection":"院内感染","Japanese encephalitis":"日本脳炎","malaria":"マラリア","mountain sickness":"高山病","rabies":"狂犬病","rickets":"くる病","scurvy":"壊血病","sepsis":"敗血症","smallpox":"天然痘","sunstroke":"日射病"]
    
    // 20 words
    let words30 = ["ache":"痛み","adhesion":"癒着","chill":"悪寒","convulsion":"ひきつけ、痙攣","cyst":"嚢胞(のうほう)","dehydration":"脱水","dizziness":"めまい","drowsiness":"眠気","edema":"むくみ","erosion":"びらん","fatigue":"疲労","fever":"熱","inflammation":"炎症","malaise":"倦怠(感)","obesity":"肥満","polyp":"ポリープ","swelling":"腫れ","tumor":"腫瘍","ulcer":"潰瘍","weight loss":"体重減少"]
    
    // 20 words
    let words31 = ["angiography":"血管造影(法)","barium enema":"バリウム注腸検査","biopsy":"生検","blood sugar":"血糖値","blood test":"血液検査","bronchoscopy":"気管支鏡検査","check by listening":"聴診","cholesterol count":"コレステロール値","complete blood count":"完全血球算定(CBC)","computed tomography":"コンピュータ連動断層撮影","digital examination":"指診","echography":"超音波検査(法)(ECHO)","electrocardiography":"心電図検査(法)(ECG,EKG)","electroencephalography":"脳波図検査(法)(EEG","electromyography":"筋電図検査(法)","endoscopy":"内視鏡検査(法)","erythrocyte sedimentation rate":"赤血球沈降速度率(ESR)","gastroscopy":"胃カメラ検査(法)","glucose tolerance test":"耐糖試験","hearing test":"聴力検査"]
    
    // 18 words
    let words32 = ["internal examination":"内診","lumbar puncture":"腰椎穿刺","lung capacity test":"肺活量検査","magnetic resonance imaging":"磁気共鳴画像診断法(MRI)","mammogram":"乳房レントゲン","mean corpuscular hemoglobin":"平均赤血球血色素量(MCH)","palpation":"触診","Pap test":"パップテスト、子宮ガン検査","physical checkup":"身体検査","rectal examination":"直腸診","red blood count":"赤血球数","sputum test":"喀痰検査","stool examination":"便検査","TB test":"ツベルクリン反応","urinalysis":"尿検査(U/A)","vision test":"視力検査","white blood count":"白血球数","X-ray test":"X線検査"]
    
    // 17 words
    let words33 = ["acquired":"後天性の","acupuncture":"鍼療法","amputation":"切断術","anesthesia":"麻酔","antibiotic":"抗生物質","antidiarrheal":"下痢止め","antidote":"解毒剤","antifebrile":"解熱剤","anti-inflammatory drug":"消炎剤","artificial abortion":"中絶","artificial insemination":"人工受精","artificial respiration":"人工呼吸","bacterial":"細菌性の","blood transfusion":"輸血","C(a)esarean section":"帝王切開(C-section)","capsule":"カプセル剤","chemotherapy":"化学療法"]
    
    // 18 words
    let words34 = ["complication":"合併症","contagious":"伝染性の、感染性の","cough medicine":"鎮咳剤","cure":"治療(する)","diagnosis":"診察、診断","dialysis":"透析","digestive medicine":"消化剤","diuretic":"利尿薬","dosage":"投薬(量)","dose":"服用量","drainage":"ドレナージ","enema":"浣腸","external application":"外用薬","eye drops":"点眼薬","first aid(treatment)":"応急処置","gastrectomy":"胃切除","gene therapy":"遺伝子療法","herbal medicine":"漢方薬"]
    
    // 18 words
    let words35 = ["hereditary":"遺伝性の、先天性の","immunotherapy":"免疫療法","incubation period":"潜伏期間","infectious":"感染性の","injection":"注射","laxative":"下剤","liquid(medicine)":"水薬","malignant":"悪性の","nasal spray":"鼻づまりスプレー","ointment":"軟膏","organ transplant":"臓器移植","painkiller":"痛み止め、鎮痛剤","pharmacotherapy":"薬物療法","physical therapy":"理学療法","poultice":"湿布薬","powder medicine":"粉薬","prescription drug":"処方薬","prognosis":"予後"]
    
    // 19 words
    let words36 = ["psychosomatic":"心因性の","radiotherapy":"放射線治療","recover":"回復する","recurrence":"再発","rejection":"拒絶反応","resuscitation":"蘇生術","sedative":"鎮静剤","sequela":"後遺症","side effect":"副作用","sleeping pill":"睡眠薬","spread":"転移(する)","stage":"期","sterilization":"避妊手術","sublingual medicine":"舌下錠","subside":"鎮まる、腫れがひく","suppository":"座薬","surgery":"手術","suspect":"疑う","tablet":"錠剤"]
    
    // 20 words
    let words37 = ["absorbent cotton":"脱脂綿","adhesive bandage":"ばんそうこう","ambulance":"救急車","anesthesia apparatus":"麻酔装置","antiseptic solution":"消毒液","applicator":"綿棒","artificial dialyzer":"人工透析装置","artificial heart pump":"人工心肺","audiometer":"聴力計","autoclave":"オートクレーブ","bandage":"包帯","basin":"洗面器","bed sheet":"シーツ","bedpan":"おまる、採便器","breast pump":"搾乳器","cast":"ギプス","catheter":"カテーテル","clamp":"鉗子、クランプ","contraceptive":"避妊用具、避妊薬","crash cart":"救急ワゴン"]
    
    // 20 words
    let words38 = ["crutch":"松葉杖","delivery stand":"分娩台","diaper":"おむつ","disposable":"使い捨ての","distilled water":"蒸留水","dressing cart":"包帯交換ワゴン","dynamometer":"握力計","endoscope":"内視鏡","enema":"浣腸(器)","eye chart":"視力検査表","eye patch":"眼帯","false teeth":"いれば","fiberscope":"ファイバースコープ","gastroscope":"胃カメラ","gauze":"ガーゼ","hearing aid":"補聴器","ice bag":"氷嚢","incubator":"保育器","inhaler":"吸入器","irrigator":"洗浄器、イリガートル"]
    
    // 20 words
    let words39 = ["IV stand":"点滴台","lancet":"披針、ランセット","laparoscope":"腹腔鏡","life-support system":"生命維持装置","microscope":"顕微鏡","monitor":"監視装置、モニター","nebulizer":"吸入器、噴霧器","needle":"注射針","nursing bottle":"哺乳瓶","operating table":"手術台","oxygen mask":"酸素マスク","pacemaker":"ペースメーカー","prosthesis":"人工器官","protective shield":"放射線用プロテクター","respirator":"人工呼吸器","retractor":"レトラクター、開創器","rubber glove":"ゴム手袋","scalpel":"メス","sling":"三角巾","sphygmomanometer":"血圧計"]
    
    // 19 words
    let words40 = ["spirometer":"肺活量計","splint":"副木","spout":"とがった飲み口","steamer":"蒸気吸入器","stethoscope":"聴診器","stretcher":"担架","suction machine":"吸引器","syringe":"注射器","test tube":"試験管","thermometer":"体温計","tongue depressor":"舌圧子","tweezers":"ピンセット","ultrasonograph":"超音波(診断装置)","urinal":"蓄尿器","urine bottle":"採尿器","walker":"歩行器","wheelchair":"車いす","wheeled stretcher":"担架車、ストレッチャー","X-ray apparatus":" X線撮影装置"]
    
    // 15 words
    let words41 = ["acupuncturist":"鍼灸医","anesthesiology":"麻酔科","attending physician":"主治医、担当医","cardiology":"心臓病学","chiropractic":"整体科","dental hygienist":"歯科衛生士","dental technician":"歯科技工士","dentistry":"歯科","dermatology":"皮膚科","dietitian":"栄養士","emergency medical technician(":"救急救命士","endocrinology":"内分泌学","gastroenterology":"胃腸病学","general practitioner(GP)":"一般開業医","geriatrics":"老年医学"]
    
    // 15 words
    let words42 = ["gynecology":"婦人科","head nurse":"看護師長","hematology":"血液病学","internal medicine":"内科","mental hospital":"精神病院","midwife":"助産師","neurology":"神経学科","neurosurgery":"脳神経外科学","nurse":"看護師長","obstetrics":"産科","oncology":"腫瘍学","ophthalmology":"眼科","orthodontics":"矯正歯科","orthopedics":"整形外科","otorhinolaryngology":"耳鼻咽喉科"]
    
    // 16 words
    let words43 = ["paramedic":"救急医療士、医療補助員","pediatrics":"小児科","pharmacist":"薬剤師","physical therapist":"理学療法士","physician":"医師、内科医","plastic surgery":"形成外科","podiatry":"足病学","psychiatry":"精神科","radiology":"放射線科","registered nurse(R.N.)":"正看護師","speech therapist":"言語療法士","surgery":"外科","surgical nurse":"手術専門看護師","technician":"技師","urology":"泌尿器科","veterinarian":"獣医"]
    
    // 16 words
    let words44 = ["admission desk":"入院受付窓口","cafeteria":"食堂","delivery room":"分娩室","duty doctor's room":"当直室","emergency exit":"非常口","emergency room(ER)":"救急処置室","examining room":"診察室","general hospital":"総合病院","germ-free room":"無菌室","hall(way)":"廊下","hospital store":"売店","intensive care unit":"集中治療室","laboratory room":"検査室","laundry room":"洗濯室","linen room":"理念室","locker room":"更衣室"]
    
    // 15 words
    let words45 = ["lounge":"休憩室","mortuary":"霊安室","nurses' station":"ナースステーション","nursing home":"老人ホーム","operating room":"手術室","patient's room":"病室","pharmacy":"薬局","reception desk":"受付","record storage center":"病歴室","treatment room":"処置室","university hospital":"大学病院","utility room":"ユーティリティホーム","waiting room":"待合室","ward":"病棟","X-ray room":"レントゲン室"]
    
    // 20 words
    let words46 = ["a-,an-,ar-":"無、欠乏","ab-":"離れて","ad-":"方向、変化、付加","aden(o)-":"腺","aero-":"空気","angio-":"血管","ante-":"~の前","anti-":"反、非、対","arter(i)-":"動脈","audio-":"聴覚","aut(o)-":"自身","bi-":"2倍、2度","bio-":"生物、生活","carcin(o)-":"ガン","cardi(o)-":"心臓","chem(o)-":" 科学","chrom(o)-":"色","circum-":"円運動、周囲","co-,com-(col-/cor-)":"共同、共通、相互","contra-":" 逆、反対"]
    
    // 20 words
    let words47 = ["counter-":"反対、対立","de-":"加工、分離、悪化","derm(o)-":"皮膚","dia-":"~を通して","dis-":"分離、脱、反対","dys-":"変質、異常、困難","encephal(o)-":"脳","end(o)-":"~の中の、内部の","epi-":"上の、次の","ex-,ec-":"~から外に、全く","extra-":"外部の","fore-":"前の","gastr(o)-":"胃","hem(o)-":"血","hemi-":"半分","hepat(o)-":"肝臓","hetero-":"異、不同","homeo-,hom(o)-":"同、類似","hydro-":"水","hyper-":"過剰、上部"]
    
    // 20 words
    let words48 = ["hypo-":"欠乏、水準以下","immno-":"免疫","in-,im-":"否定を表す、内へ","infra-":"下へ","inter-":"~の間の","intra-":"~の内の","intro-":"~の中へ","leuk(o)-":"白い","macro-":"大きい","maga(lo)-":"巨大","meta-":"変化、~の後の","micro-":"小さい","mono-":"単一の","multi-":"多数の","myo-":"筋肉","neo-":"新しい","nephr(o)-":"腎臓","neur(o)-":"神経","ost(eo)-":"骨"]
    
    // 20 words
    let words49 = ["para-":"副、傍","per-":"通過、過度","pneumo-":"肺、空気","post-":"後の、後方の","pre-":"前の","pro-":"前の","pseudo-":"仮の、偽の","psycho-":"精神、心","radio-":"放射、光線","re-":"再び、後方へ","retro-":"後方、後部","sub-":"下方の","super-,supra-":"過剰、上部","syn-,sym-":"合同、統合","thermo-":"熱","trans-":"横切って","ultra-":"超","un-":"無、否","uni-":"単一の","ur(o)-":"尿"]
    
    // 20 words
    let words50 = ["~algia":"痛","~cyte":"細胞","~ectomy":"切除(術)","~emia":"血症","~gen":"生ずるもの","~gram":"記録図","~graph":"記録装置","~ia":"~症","~itis":"炎症","~logy,~ology":"学、研究","~mania":"狂気","~meter":"計器","~oma":"腫瘍","~osis":"~症","~pathy,~opathy":"病的状態","~rrhea":"流出","~phobia":"恐怖症","~scope":"見る機械","~tomy":"切開(術)","~trophy":"栄養、食物"]
    
    // 17 words
    let words51 = ["A&P":"打聴診","Abn":"異常な","Admin":"投与、管理","Ag":"抗原","AVR":"平均排尿率","BCG vaccine":"(カルメット・ゲラン)ワクチン","BM(basal metabolism)":"基礎代謝","BM(bowel movement)":"便通、排便","BMI":"体格係数","BP":"血圧","BS":"血糖","BT":"体温","ca.":"およそ、約","CBR":"絶対安静","CC":"主訴","CI":"心係数","CPR":"心肺蘇生術"]
    
    // 15 words
    let words52 = ["D&C":"頚管拡張子宮掻爬術","DD":"劇薬","DNR":"蘇生術禁止","DOB":"生年月日","DOS":"手術年月日","DPT":"3種混合ワクチン","EDD":"出産予定日","Eq":"当量、等価量","F":"空腹時(検査)","FD":"致死量","FH":"家族歴","GA":"全身麻酔","GI":"胃腸の","GPC":"全身身体状態","gr+":"グラム陽性菌"]
    
    
    // 16 words
    let words53 = ["H&P":"病歴と身体所見","HIV":"エイズウイルス","HLA":"ヒト白血球抗原","HR":"心拍数","I&O":"摂取量と排出量","IQ":"知能指数","IV":"静脈内の","KUB":"腎、尿管、膀胱","LMP":"最終月経期","LOM":"運動制限","MR":"医療記録","NBM":"絶食","ND":"データなし","neg":"院生の","NG":"経鼻栄養チューブ","NR":"再調剤禁止"]
    
    // 16 words
    let words54 = ["NV":"予防接種をしていない","NZ":"正常範囲","OTC":"市販薬","PH":"既病歴","PI":"現病歴","po(per os)":"傾向で","PO(period":"開始時期","PR":"脈拍数","Px":"予後","resus":"蘇生術","RR":"呼吸数","SB":"皮下の","stat":"直ちに","TPR":"体温、脈、呼吸数","UC urinary":"尿カテーテル","VS":"生命兆候"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set about ad
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-9410270200655875/1648510209")
        let request = GADRequest()
        let DEVICE_TEST_ID = "63b4e364bb2dcb82d2709fb9ae0f15d5"
        request.testDevices = [DEVICE_TEST_ID]
        interstitial.load(request)
        interstitial = createAndLoadInterstitial()
        interstitial.delegate = self
        
        //print(Array(words1.keys))
        //print(Array(words1.values))
        
        // -------------------------------------about UI---------------------------------------------------------
        // background color
        self.view.backgroundColor = UIColor(red: 0.957, green: 0.957, blue: 0.859, alpha: 1.0)
        
        // make picker view
        myUIPicker = UIPickerView()
        myUIPicker.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width/2, height: 150.0)
        myUIPicker.delegate = self
        myUIPicker.dataSource = self
        self.view.addSubview(myUIPicker)
        
        // make a start button
        startButton = UIButton()
        let bWidth: CGFloat = 170
        let bHeight: CGFloat = 50
        let posX: CGFloat = self.view.frame.width*3/4 - bWidth/2
        let posY: CGFloat = 75
        startButton.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
        startButton.backgroundColor = UIColor.red
        startButton.layer.masksToBounds = true
        startButton.layer.cornerRadius = 20.0
        startButton.setTitle("スタート", for: .normal)
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.setTitle("スタート", for: .highlighted)
        startButton.setTitleColor(UIColor.black, for: .highlighted)
        startButton.tag = 0
        startButton.addTarget(self, action: #selector(ViewController.onClickstartButton(sender:)), for: .touchUpInside)
        self.view.addSubview(startButton)
        
        // make a question label
        let bbWidth: CGFloat = self.view.bounds.width
        let bbHeight: CGFloat = 50
        let pposX: CGFloat = self.view.bounds.width/2 - bbWidth/2
        let pposY: CGFloat = self.view.bounds.height/3 - bbHeight/2
        label.frame = CGRect(x: pposX, y: pposY, width: bbWidth, height: bbHeight)
        label.backgroundColor = UIColor.darkGray
        label.layer.masksToBounds = true
        label.font = UIFont(name: "HiraMinProN-W3", size: 20)
        label.text = "左上から選択！"
        label.textColor = UIColor.white
        label.shadowColor = UIColor.gray
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
        
        
        // make 4 answer buttons
        let aWidth: CGFloat = self.view.bounds.width/1.05
        let aHeight: CGFloat = self.view.bounds.height/11
        let posX1: CGFloat = self.view.bounds.width/2 - aWidth/2
        let posY1: CGFloat = self.view.frame.height*4.5/10 - bHeight/2 - 10
        let posX2: CGFloat = self.view.bounds.width/2 - aWidth/2
        let posY2: CGFloat = self.view.frame.height*5.5/10 - bHeight/2 - 10
        let posX3: CGFloat = self.view.bounds.width/2 - aWidth/2
        let posY3: CGFloat = self.view.frame.height*6.5/10 - bHeight/2
        let posX4: CGFloat = self.view.bounds.width/2 - aWidth/2
        let posY4: CGFloat = self.view.frame.height*7.5/10 - bHeight/2
        button1.frame = CGRect(x: posX1, y: posY1, width: aWidth, height: aHeight)
        button2.frame = CGRect(x: posX2, y: posY2, width: aWidth, height: aHeight)
        button3.frame = CGRect(x: posX3, y: posY3, width: aWidth, height: aHeight)
        button4.frame = CGRect(x: posX4, y: posY4, width: aWidth, height: aHeight)
        
        
        button1.layer.borderColor = UIColor.black.cgColor
        button1.layer.borderWidth = 5
        button1.layer.cornerRadius = 20.0
        button1.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button1.addTarget(self, action: #selector(ViewController.onClickbutton1(sender:)), for: .touchUpInside)
        
        
        button2.layer.borderColor = UIColor.black.cgColor
        button2.layer.borderWidth = 5
        button2.layer.cornerRadius = 20.0
        button2.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button2.addTarget(self, action: #selector(ViewController.onClickbutton2(sender:)), for: .touchUpInside)
        
        
        button3.layer.borderColor = UIColor.black.cgColor
        button3.layer.borderWidth = 5
        button3.layer.cornerRadius = 20.0
        button3.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button3.addTarget(self, action: #selector(ViewController.onClickbutton3(sender:)), for: .touchUpInside)
        
        
        button4.layer.borderColor = UIColor.black.cgColor
        button4.layer.borderWidth = 5
        button4.layer.cornerRadius = 20.0
        button4.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button4.addTarget(self, action: #selector(ViewController.onClickbutton4(sender:)), for: .touchUpInside)
        
        
        button1.setTitle("ボタン1", for: .normal)
        button1.setTitleColor(UIColor.black, for: .normal)
        button2.setTitle("ボタン2", for: .normal)
        button2.setTitleColor(UIColor.black, for: .normal)
        button3.setTitle("ボタン3", for: .normal)
        button3.setTitleColor(UIColor.black, for: .normal)
        button4.setTitle("ボタン4", for: .normal)
        button4.setTitleColor(UIColor.black, for: .normal)
        button1.setTitle("", for: .highlighted)
        button1.setTitleColor(UIColor.black, for: .highlighted)
        button2.setTitle("", for: .highlighted)
        button2.setTitleColor(UIColor.black, for: .highlighted)
        button3.setTitle("", for: .highlighted)
        button3.setTitleColor(UIColor.black, for: .highlighted)
        button4.setTitle("", for: .highlighted)
        button4.setTitleColor(UIColor.black, for: .highlighted)
        
        
        button1.tag = 1
        button2.tag = 2
        button3.tag = 3
        button4.tag = 4
        
        
        self.view.addSubview(button1)
        self.view.addSubview(button2)
        self.view.addSubview(button3)
        self.view.addSubview(button4)
        
        
        // make a footer label
        let fWidth: CGFloat = self.view.bounds.width
        let fHeight: CGFloat = 50
        let fposX: CGFloat = self.view.bounds.width/2 - fWidth/2
        let fposY: CGFloat = self.view.bounds.height/1.15 - fHeight/2
        footer_label.frame = CGRect(x: fposX, y: fposY, width: fWidth, height: fHeight)
        footer_label.backgroundColor = UIColor.orange
        footer_label.layer.masksToBounds = true
        footer_label.font = UIFont(name: "HiraMinProN-W3", size: 22)
        footer_label.text = "問題数をここに表示"
        footer_label.textColor = UIColor.white
        footer_label.shadowColor = UIColor.gray
        footer_label.textAlignment = NSTextAlignment.center
        self.view.addSubview(footer_label)
        
    }
    
    
    
    
    func createAndLoadInterstitial() -> GADInterstitial {
        var interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        interstitial.delegate = self as! GADInterstitialDelegate
        interstitial.load(GADRequest())
        return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data_list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data_list[row] as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("row: \(row)")
        print("value: \(data_list[row])")
        
        index = row + 1
    }
    
    @objc internal func onClickstartButton(sender: UIButton) {
        print("startButton is pushed:");
        print("sender.currentTitle: \(String(describing: sender.currentTitle))")
        print("sender.tag: \(sender.tag)")
        print("index:\(index)")
        
        // arrays to store , questions, answers, choices
        questions = []
        answers   = []
        choices   = []
        
        // counter is used to indicate how many questions are done
        // global variable "count" is to store the number of questions for each sessions
        // the variable "finished" is used for whether finished the session or not
        // compare "count" and "finished" , then decide finished or not
        // if not finished : finished = 0
        // if     finished : finished = 1
        counter = 0
        finished = 0
        
        if index == 1 {
            questions = Array(words1.keys)
            answers   = Array(words1.values)
            count = questions.count
        }else if index == 2 {
            questions = Array(words2.keys)
            answers   = Array(words2.values)
            count = questions.count
        }else if index == 3 {
            questions = Array(words3.keys)
            answers   = Array(words3.values)
            count = questions.count
        }else if index == 4 {
            questions = Array(words4.keys)
            answers   = Array(words4.values)
            count = questions.count
        }else if index == 5 {
            questions = Array(words5.keys)
            answers   = Array(words5.values)
            count = questions.count
        }else if index == 6 {
            questions = Array(words6.keys)
            answers   = Array(words6.values)
            count = questions.count
        }else if index == 7 {
            questions = Array(words7.keys)
            answers   = Array(words7.values)
            count = questions.count
        }else if index == 8 {
            questions = Array(words8.keys)
            answers   = Array(words8.values)
            count = questions.count
        }else if index == 9 {
            questions = Array(words9.keys)
            answers   = Array(words9.values)
            count = questions.count
        }else if index == 10 {
            questions = Array(words10.keys)
            answers   = Array(words10.values)
            count = questions.count
        }else if index == 11 {
            questions = Array(words11.keys)
            answers   = Array(words11.values)
            count = questions.count
        }else if index == 12 {
            questions = Array(words12.keys)
            answers   = Array(words12.values)
            count = questions.count
        }else if index == 13 {
            questions = Array(words13.keys)
            answers   = Array(words13.values)
            count = questions.count
        }else if index == 14 {
            questions = Array(words14.keys)
            answers   = Array(words14.values)
            count = questions.count
        }else if index == 15 {
            questions = Array(words15.keys)
            answers   = Array(words15.values)
            count = questions.count
        }else if index == 16 {
            questions = Array(words16.keys)
            answers   = Array(words16.values)
            count = questions.count
        }else if index == 17 {
            questions = Array(words17.keys)
            answers   = Array(words17.values)
            count = questions.count
        }else if index == 18 {
            questions = Array(words18.keys)
            answers   = Array(words18.values)
            count = questions.count
        }else if index == 19 {
            questions = Array(words19.keys)
            answers   = Array(words19.values)
            count = questions.count
        }else if index == 20 {
            questions = Array(words20.keys)
            answers   = Array(words20.values)
            count = questions.count
        }else if index == 21 {
            questions = Array(words21.keys)
            answers   = Array(words21.values)
            count = questions.count
        }else if index == 22 {
            questions = Array(words22.keys)
            answers   = Array(words22.values)
            count = questions.count
        }else if index == 23 {
            questions = Array(words23.keys)
            answers   = Array(words23.values)
            count = questions.count
        }else if index == 24 {
            questions = Array(words24.keys)
            answers   = Array(words24.values)
            count = questions.count
        }else if index == 25 {
            questions = Array(words25.keys)
            answers   = Array(words25.values)
            count = questions.count
        }else if index == 26 {
            questions = Array(words26.keys)
            answers   = Array(words26.values)
            count = questions.count
        }else if index == 27 {
            questions = Array(words27.keys)
            answers   = Array(words27.values)
            count = questions.count
        }else if index == 28 {
            questions = Array(words28.keys)
            answers   = Array(words28.values)
            count = questions.count
        }else if index == 29 {
            questions = Array(words29.keys)
            answers   = Array(words29.values)
            count = questions.count
        }else if index == 30 {
            questions = Array(words30.keys)
            answers   = Array(words30.values)
            count = questions.count
        }else if index == 31 {
            questions = Array(words31.keys)
            answers   = Array(words31.values)
            count = questions.count
        }else if index == 32 {
            questions = Array(words32.keys)
            answers   = Array(words32.values)
            count = questions.count
        }else if index == 33 {
            questions = Array(words33.keys)
            answers   = Array(words33.values)
            count = questions.count
        }else if index == 34 {
            questions = Array(words34.keys)
            answers   = Array(words34.values)
            count = questions.count
        }else if index == 35 {
            questions = Array(words35.keys)
            answers   = Array(words35.values)
            count = questions.count
        }else if index == 36 {
            questions = Array(words36.keys)
            answers   = Array(words36.values)
            count = questions.count
        }else if index == 37 {
            questions = Array(words37.keys)
            answers   = Array(words37.values)
            count = questions.count
        }else if index == 38 {
            questions = Array(words38.keys)
            answers   = Array(words38.values)
            count = questions.count
        }else if index == 39 {
            questions = Array(words39.keys)
            answers   = Array(words39.values)
            count = questions.count
        }else if index == 40 {
            questions = Array(words40.keys)
            answers   = Array(words40.values)
            count = questions.count
        }else if index == 41 {
            questions = Array(words41.keys)
            answers   = Array(words41.values)
            count = questions.count
        }else if index == 42 {
            questions = Array(words42.keys)
            answers   = Array(words42.values)
            count = questions.count
        }else if index == 43 {
            questions = Array(words43.keys)
            answers   = Array(words43.values)
            count = questions.count
        }else if index == 44 {
            questions = Array(words44.keys)
            answers   = Array(words44.values)
            count = questions.count
        }else if index == 45 {
            questions = Array(words45.keys)
            answers   = Array(words45.values)
            count = questions.count
        }else if index == 46 {
            questions = Array(words46.keys)
            answers   = Array(words46.values)
            count = questions.count
        }else if index == 47 {
            questions = Array(words47.keys)
            answers   = Array(words47.values)
            count = questions.count
        }else if index == 48 {
            questions = Array(words48.keys)
            answers   = Array(words48.values)
            count = questions.count
        }else if index == 49 {
            questions = Array(words49.keys)
            answers   = Array(words49.values)
            count = questions.count
        }else if index == 50 {
            questions = Array(words50.keys)
            answers   = Array(words50.values)
            count = questions.count
        }else if index == 51 {
            questions = Array(words51.keys)
            answers   = Array(words51.values)
            count = questions.count
        }else if index == 52 {
            questions = Array(words52.keys)
            answers   = Array(words52.values)
            count = questions.count
        }else if index == 53 {
            questions = Array(words53.keys)
            answers   = Array(words53.values)
            count = questions.count
        }else if index == 54 {
            questions = Array(words54.keys)
            answers   = Array(words54.values)
            count = questions.count
        }
        
        
        label.text = questions[counter]
        choices.append(answers[counter])
        footer_label.text = "現在\(counter+1)問目：全\(count)問"
        print(questions)
        
        while counter == random_num1 || counter == random_num2 || counter == random_num3 || random_num1 == random_num2 || random_num1 == random_num3 || random_num2 == random_num3 {
            random_num1 = Int(arc4random_uniform(UInt32(count-2)))
            random_num2 = Int(arc4random_uniform(UInt32(count-2)))
            random_num3 = Int(arc4random_uniform(UInt32(count-2)))
        }
        
        kimagure = Int(arc4random_uniform(UInt32(4)))
        if kimagure == 0 {
            button1.setTitle(answers[counter], for: .normal)
            button2.setTitle(answers[random_num1], for: .normal)
            button3.setTitle(answers[random_num2], for: .normal)
            button4.setTitle(answers[random_num3], for: .normal)
            answer_index = 1
        }else if kimagure == 1{
            button1.setTitle(answers[random_num1], for: .normal)
            button2.setTitle(answers[counter], for: .normal)
            button3.setTitle(answers[random_num2], for: .normal)
            button4.setTitle(answers[random_num3], for: .normal)
            answer_index = 2
        }else if kimagure == 2{
            button1.setTitle(answers[random_num1], for: .normal)
            button2.setTitle(answers[random_num2], for: .normal)
            button3.setTitle(answers[counter], for: .normal)
            button4.setTitle(answers[random_num3], for: .normal)
            answer_index = 3
        }else if kimagure == 3{
            button1.setTitle(answers[random_num1], for: .normal)
            button2.setTitle(answers[random_num2], for: .normal)
            button3.setTitle(answers[random_num3], for: .normal)
            button4.setTitle(answers[counter], for: .normal)
            answer_index = 4
        }
        
        selected = 1
        print("answer_index:\(answer_index)")
        print(counter)
    }
    
    // the function to judge choice is whether correct or not
    func judgeChoice(choice:Int) {
        // when choice is correct
        if choice == answer_index {
            let Alert1_correct: UIAlertController = UIAlertController(title: "正解！　⭕️", message: "\(questions[counter])  :  \(answers[counter])",  preferredStyle: .alert)
            let myOkAction = UIAlertAction(title: "OK", style: .default) { action in
                print("Action OK!!")
            }
            Alert1_correct.addAction(myOkAction)
            present(Alert1_correct, animated: true, completion: nil)
        } else {
            let Alert1_correct: UIAlertController = UIAlertController(title: "不正解　　❌", message: "\(questions[counter])  :  \(answers[counter])", preferredStyle: .alert)
            let myOkAction = UIAlertAction(title: "OK", style: .default) { action in
                print("Action OK!!")
            }
            Alert1_correct.addAction(myOkAction)
            present(Alert1_correct, animated: true, completion: nil)
        }
    }
    
    
    // the function to sellect next question
    func chooseNextQuestion() {
        if counter < count-1 {
            counter += 1
            label.text = questions[counter]
            
            while counter == random_num1 || counter == random_num2 || counter == random_num3 || random_num1 == random_num2 || random_num1 == random_num3 || random_num2 == random_num3 {
                random_num1 = Int(arc4random_uniform(UInt32(count-2)))
                random_num2 = Int(arc4random_uniform(UInt32(count-2)))
                random_num3 = Int(arc4random_uniform(UInt32(count-2)))
            }
            kimagure = Int(arc4random_uniform(UInt32(4)))
            if kimagure == 0 {
                button1.setTitle(answers[counter], for: .normal)
                button2.setTitle(answers[random_num1], for: .normal)
                button3.setTitle(answers[random_num2], for: .normal)
                button4.setTitle(answers[random_num3], for: .normal)
                answer_index = 1
            }else if kimagure == 1{
                button1.setTitle(answers[random_num1], for: .normal)
                button2.setTitle(answers[counter], for: .normal)
                button3.setTitle(answers[random_num2], for: .normal)
                button4.setTitle(answers[random_num3], for: .normal)
                answer_index = 2
            }else if kimagure == 2{
                button1.setTitle(answers[random_num1], for: .normal)
                button2.setTitle(answers[random_num2], for: .normal)
                button3.setTitle(answers[counter], for: .normal)
                button4.setTitle(answers[random_num3], for: .normal)
                answer_index = 3
            }else if kimagure == 3{
                button1.setTitle(answers[random_num1], for: .normal)
                button2.setTitle(answers[random_num2], for: .normal)
                button3.setTitle(answers[random_num3], for: .normal)
                button4.setTitle(answers[counter], for: .normal)
                answer_index = 4
            }
            footer_label.text = "現在\(counter+1)問目：全\(count)問"
        }else {
            finished = 1
            let myAlert: UIAlertController = UIAlertController(title: "おっと！", message: "このステージの問題は終わったぜ\nステージを選び直してスタートを押してくれ", preferredStyle: .alert)
            
            // OKのアクションを作成する.
            let myOkAction = UIAlertAction(title: "OK", style: .default) { action in
                print("Action OK!!")
            }
            myAlert.addAction(myOkAction)
            present(myAlert, animated: true, completion: nil)
            footer_label.text = "お疲れ様でした！"
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            } else {
                print("Ad wasn't ready")
            }
        }
    }
    
    
    
    
    @objc internal func onClickbutton1(sender: UIButton) {
        print("onClickButton1:");
        print("sender.currentTitle: \(String(describing: sender.currentTitle))")
        print("sender.tag: \(sender.tag)")
        
        if selected != 1 {
            let myAlert: UIAlertController = UIAlertController(title: "おっと！", message: "ステージを選んでスタートを押してくれ\nボタンを押すのはそれからだぜ", preferredStyle: .alert)
            // make OK action
            let myOkAction = UIAlertAction(title: "OK", style: .default) { action in
                print("Action OK!!")
            }
            myAlert.addAction(myOkAction)
            present(myAlert, animated: true, completion: nil)
            
            return
        }
        
        if counter <= count{
            if finished == 0{
                // judge_choice
                judgeChoice(choice: 1)
                chooseNextQuestion()
            }else{
                let myAlert: UIAlertController = UIAlertController(title: "おっと！", message: "このステージの問題は終わったぜ\nステージを選び直してスタートを押してくれ", preferredStyle: .alert)
                // make OK action
                let myOkAction = UIAlertAction(title: "OK", style: .default) { action in
                        print("Action OK!!")
                }
                myAlert.addAction(myOkAction)
                present(myAlert, animated: true, completion: nil)
            }
        }
    }
    
    
    
    @objc internal func onClickbutton2(sender: UIButton) {
        print("onClickButton2:");
        print("sender.currentTitle: \(String(describing: sender.currentTitle))")
        print("sender.tag: \(sender.tag)")
        
        if selected != 1 {
            let myAlert: UIAlertController = UIAlertController(title: "おっと！", message: "ステージを選んでスタートを押してくれ\nボタンを押すのはそれからだぜ", preferredStyle: .alert)
            
            // OKのアクションを作成する.
            let myOkAction = UIAlertAction(title: "OK", style: .default) { action in
                print("Action OK!!")
            }
            myAlert.addAction(myOkAction)
            present(myAlert, animated: true, completion: nil)
        }
        
        if counter <= count{
            if finished == 0{
                // judge_choice
                judgeChoice(choice: 2)
                chooseNextQuestion()
            }else{
                let myAlert: UIAlertController = UIAlertController(title: "おっと！", message: "このステージの問題は終わったぜ\nステージを選び直してスタートを押してくれ", preferredStyle: .alert)
                // make OK action
                let myOkAction = UIAlertAction(title: "OK", style: .default) { action in
                    print("Action OK!!")
                }
                myAlert.addAction(myOkAction)
                present(myAlert, animated: true, completion: nil)
            }
        }
    }
    
    
    
    @objc internal func onClickbutton3(sender: UIButton) {
        print("onClickButton3:");
        print("sender.currentTitle: \(String(describing: sender.currentTitle))")
        print("sender.tag: \(sender.tag)")
        
        if selected != 1 {
            let myAlert: UIAlertController = UIAlertController(title: "おっと！", message: "ステージを選んでスタートを押してくれ\nボタンを押すのはそれからだぜ", preferredStyle: .alert)
            // OKのアクションを作成する.
            let myOkAction = UIAlertAction(title: "OK", style: .default) { action in
                print("Action OK!!")
            }
            myAlert.addAction(myOkAction)
            present(myAlert, animated: true, completion: nil)
        }
        
        if counter <= count{
            if finished == 0{
                // judge_choice
                judgeChoice(choice: 3)
                chooseNextQuestion()
            }else{
                let myAlert: UIAlertController = UIAlertController(title: "おっと！", message: "このステージの問題は終わったぜ\nステージを選び直してスタートを押してくれ", preferredStyle: .alert)
                // OKのアクションを作成する.
                let myOkAction = UIAlertAction(title: "OK", style: .default) { action in
                    print("Action OK!!")
                }
                myAlert.addAction(myOkAction)
                present(myAlert, animated: true, completion: nil)
            }
        }
    }
    
    
    @objc internal func onClickbutton4(sender: UIButton) {
        print("onClickButton4:");
        print("sender.currentTitle: \(String(describing: sender.currentTitle))")
        print("sender.tag: \(sender.tag)")
        
        if selected != 1 {
            let myAlert: UIAlertController = UIAlertController(title: "おっと！", message: "ステージを選んでスタートを押してくれ\nボタンを押すのはそれからだぜ", preferredStyle: .alert)
            
            // OKのアクションを作成する.
            let myOkAction = UIAlertAction(title: "OK", style: .default) { action in
                print("Action OK!!")
            }
            myAlert.addAction(myOkAction)
            present(myAlert, animated: true, completion: nil)
        }
        
        if counter <= count{
            if finished == 0{
                // judge_choice
                judgeChoice(choice: 4)
                chooseNextQuestion()
            }else{
                let myAlert: UIAlertController = UIAlertController(title: "おっと！", message: "このステージの問題は終わったぜ\nステージを選び直してスタートを押してくれ", preferredStyle: .alert)
                // OKのアクションを作成する.
                let myOkAction = UIAlertAction(title: "OK", style: .default) { action in
                    print("Action OK!!")
                }
                myAlert.addAction(myOkAction)
                present(myAlert, animated: true, completion: nil)
            }
        }
    }
    
    
    override var shouldAutorotate: Bool {
        get {
            return false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}




