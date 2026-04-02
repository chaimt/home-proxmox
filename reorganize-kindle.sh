#!/bin/bash
set -euo pipefail

BASE="/Volumes/Kindle/books"

echo "=== Step 1: Rename fantasy/ to fiction/ ==="
mv "$BASE/fantasy" "$BASE/fiction"

echo "=== Step 2: Create new directories ==="
mkdir -p "$BASE/fiction/J.K. Rowling"
mkdir -p "$BASE/fiction/John Grisham"
mkdir -p "$BASE/reference"

echo "=== Step 3: Move loose books from root to topic folders ==="

# --> how to/Productivity/
echo "  Moving to how to/Productivity/..."
mv "$BASE/A World Without Email_ Reimagining Work in an Age of Communication Overload by Cal Newport_34BB9662E4484EABB6A8AF271658F30D.azw3" "$BASE/how to/Productivity/"
mv "$BASE/A World Without Email_ Reimagining Work in an Age of Communication Overload by Cal Newport_34BB9662E4484EABB6A8AF271658F30D.sdr" "$BASE/how to/Productivity/"
mv "$BASE/Deep Work by Cal Newport_D79B7BE685574C66A9E5445CD1D730F7.azw3" "$BASE/how to/Productivity/"
mv "$BASE/Deep Work by Cal Newport_D79B7BE685574C66A9E5445CD1D730F7.sdr" "$BASE/how to/Productivity/"
mv "$BASE/Digital Minimalism_ Choosing a Focused Life in a Noisy World by Cal Newport_31488DA89EE1444CB83494EE2E01EC43.azw3" "$BASE/how to/Productivity/"
mv "$BASE/Digital Minimalism_ Choosing a Focused Life in a Noisy World by Cal Newport_31488DA89EE1444CB83494EE2E01EC43.sdr" "$BASE/how to/Productivity/"
mv "$BASE/So Good They Can't Ignore You by Cal Newport_F1256CD8FB2D4CE7A9D57E570B64D8B1.azw3" "$BASE/how to/Productivity/"
mv "$BASE/So Good They Can't Ignore You by Cal Newport_F1256CD8FB2D4CE7A9D57E570B64D8B1.sdr" "$BASE/how to/Productivity/" 2>/dev/null || true
mv "$BASE/Building_a_Second_Brain_6683255797AE491980F1B5852D6C8E9F.kfx" "$BASE/how to/Productivity/"
mv "$BASE/Building_a_Second_Brain_6683255797AE491980F1B5852D6C8E9F.sdr" "$BASE/how to/Productivity/"
mv "$BASE/Eat That Frog - Registered_0419FC98E4A548209CA0E99EE6B64674.azw3" "$BASE/how to/Productivity/"
mv "$BASE/Eat That Frog - Registered_0419FC98E4A548209CA0E99EE6B64674.sdr" "$BASE/how to/Productivity/"
mv "$BASE/Moonwalking With Einstein (Joshua Foer)_49C66AAA80134F78AA4178E2048B63FF.azw3" "$BASE/how to/Productivity/"
mv "$BASE/Moonwalking With Einstein (Joshua Foer)_49C66AAA80134F78AA4178E2048B63FF.sdr" "$BASE/how to/Productivity/"
mv "$BASE/Show Your Work.pdf-cdeKey_0635A7ADB0FD4E7194C42E3728A630DA.pdf" "$BASE/how to/Productivity/"
mv "$BASE/Show Your Work.pdf-cdeKey_0635A7ADB0FD4E7194C42E3728A630DA.sdr" "$BASE/how to/Productivity/" 2>/dev/null || true
mv "$BASE/Voice and Speaking Skills for Dummies - Judy Apps_23D879D46ACB4442A423926005FE9CAA.azw3" "$BASE/how to/Productivity/"
mv "$BASE/Voice and Speaking Skills for Dummies - Judy Apps_23D879D46ACB4442A423926005FE9CAA.sdr" "$BASE/how to/Productivity/" 2>/dev/null || true

# --> how to/Business/
echo "  Moving to how to/Business/..."
mv "$BASE/Business_Adventures_Twelve_Classic_Tales_from_the_198B6FD9A76C46DC87C1EE099A3FB74B.azw3" "$BASE/how to/Business/"
mv "$BASE/Business_Adventures_Twelve_Classic_Tales_from_the_198B6FD9A76C46DC87C1EE099A3FB74B.sdr" "$BASE/how to/Business/"
mv "$BASE/Give and Take_DBB426A61DBD4CCC99C7EE94EC0E7C25.azw3" "$BASE/how to/Business/"
mv "$BASE/Give and Take_DBB426A61DBD4CCC99C7EE94EC0E7C25.sdr" "$BASE/how to/Business/"
mv "$BASE/Good to Great_ Why Some Companies Make the Leap...and Others Don't by Jim Collins_02995BF2EDC7435F88000336C4C84F39.azw3" "$BASE/how to/Business/"
mv "$BASE/Good to Great_ Why Some Companies Make the Leap...and Others Don't by Jim Collins_02995BF2EDC7435F88000336C4C84F39.sdr" "$BASE/how to/Business/"
mv "$BASE/Great by Choice_ Uncertainty, Chaos, and Luck--Why Some Thrive Despite Them All by Jim Collins_06C2E1B5CA1241A18A9C5B273EC1618A.azw3" "$BASE/how to/Business/"
mv "$BASE/Great by Choice_ Uncertainty, Chaos, and Luck--Why Some Thrive Despite Them All by Jim Collins_06C2E1B5CA1241A18A9C5B273EC1618A.sdr" "$BASE/how to/Business/"
mv "$BASE/Turning the Flywheel_ A Monograph to Accompany Good to Great by Jim Collins_165118D05096474F80AFDBC3282ADEBF.azw3" "$BASE/how to/Business/"
mv "$BASE/Turning the Flywheel_ A Monograph to Accompany Good to Great by Jim Collins_165118D05096474F80AFDBC3282ADEBF.sdr" "$BASE/how to/Business/" 2>/dev/null || true

# --> how to/Thinking-and-Philosophy/
echo "  Moving to how to/Thinking-and-Philosophy/..."
mv "$BASE/12 Rules for Life_ An Antidote to Chaos - Jordan B. Peterson_06DD70C9C3E2469C8C7BD5D73842EB4F.azw3" "$BASE/how to/Thinking-and-Philosophy/"
mv "$BASE/12 Rules for Life_ An Antidote to Chaos - Jordan B. Peterson_06DD70C9C3E2469C8C7BD5D73842EB4F.sdr" "$BASE/how to/Thinking-and-Philosophy/"
mv "$BASE/Pi A Biography of the Worlds Most Mysterious Number (Alfred S. Posamentier, Ingmar Lehmann) (Z-Library) - Unknown.epub" "$BASE/how to/Thinking-and-Philosophy/"
mv "$BASE/._Pi A Biography of the Worlds Most Mysterious Number (Alfred S. Posamentier, Ingmar Lehmann) (Z-Library) - Unknown.epub" "$BASE/how to/Thinking-and-Philosophy/" 2>/dev/null || true
mv "$BASE/Pi A Biography of the Worlds Most Mysterious Number (Alfred S. Posamentier, Ingmar Lehmann) (Z-Library) - Unknown.sdr" "$BASE/how to/Thinking-and-Philosophy/" 2>/dev/null || true

# --> how to/Psychology-and-Wellness/
echo "  Moving to how to/Psychology-and-Wellness/..."
mv "$BASE/Surrounded By Idiots (Thomas Erikson)_815FAA8927C04F5F870748D310A0C204.azw3" "$BASE/how to/Psychology-and-Wellness/"
mv "$BASE/Surrounded By Idiots (Thomas Erikson)_815FAA8927C04F5F870748D310A0C204.sdr" "$BASE/how to/Psychology-and-Wellness/"
mv "$BASE/The_Art_of_Being_ALONE_Solitude_Is_My_HOME,_Loneliness_A4FE72EC300D44CF933755138AE2BE0F.kfx" "$BASE/how to/Psychology-and-Wellness/"
mv "$BASE/The_Art_of_Being_ALONE_Solitude_Is_My_HOME,_Loneliness_A4FE72EC300D44CF933755138AE2BE0F.sdr" "$BASE/how to/Psychology-and-Wellness/"
mv "$BASE/What Everybody is Saying.pdf-cdeKey_81650D70C305467AABB79A55F9A4B34C.pdf" "$BASE/how to/Psychology-and-Wellness/"
mv "$BASE/What Everybody is Saying.pdf-cdeKey_81650D70C305467AABB79A55F9A4B34C.sdr" "$BASE/how to/Psychology-and-Wellness/" 2>/dev/null || true

# --> fiction/Jeffrey Archer/
echo "  Moving to fiction/Jeffrey Archer/..."
mv "$BASE/And Thereby Hangs a Tale - Jeffrey Archer_32065C6B264B4B3F8909059723AA7903.azw3" "$BASE/fiction/Jeffrey Archer/"
mv "$BASE/And Thereby Hangs a Tale - Jeffrey Archer_32065C6B264B4B3F8909059723AA7903.sdr" "$BASE/fiction/Jeffrey Archer/"
mv "$BASE/Twelve Red Herrings - Jeffrey Archer_82AFD79FE0C043E3A23AE7D71E4737A5.azw3" "$BASE/fiction/Jeffrey Archer/"
mv "$BASE/Twelve Red Herrings - Jeffrey Archer_82AFD79FE0C043E3A23AE7D71E4737A5.sdr" "$BASE/fiction/Jeffrey Archer/" 2>/dev/null || true

# --> fiction/Michael Crichton/
echo "  Moving to fiction/Michael Crichton/..."
mv "$BASE/Binary_ A Novel - Michael Crichton & John Lange_C0782F8182BF489B8CBF0A87374BBAFE.azw3" "$BASE/fiction/Michael Crichton/"
mv "$BASE/Binary_ A Novel - Michael Crichton & John Lange_C0782F8182BF489B8CBF0A87374BBAFE.sdr" "$BASE/fiction/Michael Crichton/"
mv "$BASE/Drug of Choice - Michael Crichton_25ED094A2DA848D7AC1FB30165C6C078.azw3" "$BASE/fiction/Michael Crichton/"
mv "$BASE/Drug of Choice - Michael Crichton_25ED094A2DA848D7AC1FB30165C6C078.sdr" "$BASE/fiction/Michael Crichton/"

# --> fiction/J.K. Rowling/
echo "  Moving to fiction/J.K. Rowling/..."
mv "$BASE/2 The Silkworm_21F6996DBF9B4696BC7C2B7E2E39FD8D.kfx" "$BASE/fiction/J.K. Rowling/"
mv "$BASE/2 The Silkworm_21F6996DBF9B4696BC7C2B7E2E39FD8D.sdr" "$BASE/fiction/J.K. Rowling/"
mv "$BASE/3 Career of Evil_89AB5FEF9A8C4473BC3D9828E9F13406.kfx" "$BASE/fiction/J.K. Rowling/"
mv "$BASE/3 Career of Evil_89AB5FEF9A8C4473BC3D9828E9F13406.sdr" "$BASE/fiction/J.K. Rowling/"
mv "$BASE/4 Lethal Whiteepub_3A2E53BCA4A740829ED85CFB2A2C6E9A.kfx" "$BASE/fiction/J.K. Rowling/"
mv "$BASE/4 Lethal Whiteepub_3A2E53BCA4A740829ED85CFB2A2C6E9A.sdr" "$BASE/fiction/J.K. Rowling/"
mv "$BASE/5 Troubled Blood_01EE4659BE6945FBA8EAB0CC56879820.kfx" "$BASE/fiction/J.K. Rowling/"
mv "$BASE/5 Troubled Blood_01EE4659BE6945FBA8EAB0CC56879820.sdr" "$BASE/fiction/J.K. Rowling/"
mv "$BASE/hpmor_5588B546FABC4DFA933409E4C670BF59.kfx" "$BASE/fiction/J.K. Rowling/"
mv "$BASE/hpmor_5588B546FABC4DFA933409E4C670BF59.sdr" "$BASE/fiction/J.K. Rowling/"

# --> philosophy/Ethics/
echo "  Moving to philosophy/Ethics/..."
mv "$BASE/Animal Liberation by Peter Singer_E592A9918C92436A91CF824A186CD7E8.azw3" "$BASE/philosophy/Ethics/"
mv "$BASE/Animal Liberation by Peter Singer_E592A9918C92436A91CF824A186CD7E8.sdr" "$BASE/philosophy/Ethics/"
mv "$BASE/The Way We Eat_ Why Our Food Choices Matter by Peter Singer_B531D56F0205463CA4B66CF5AC890FE1.azw3" "$BASE/philosophy/Ethics/"
mv "$BASE/The Way We Eat_ Why Our Food Choices Matter by Peter Singer_B531D56F0205463CA4B66CF5AC890FE1.sdr" "$BASE/philosophy/Ethics/" 2>/dev/null || true
mv "$BASE/lying - sam harris_81663A253F9147DCB681E43D3D8811C4.azw3" "$BASE/philosophy/Ethics/"
mv "$BASE/lying - sam harris_81663A253F9147DCB681E43D3D8811C4.sdr" "$BASE/philosophy/Ethics/"

# --> philosophy/AI/
echo "  Moving to philosophy/AI/..."
mv "$BASE/Rationality_ From AI to Zombies by Eliezer Yudkowsky_7378E7E892BE4E9BA8323DF226B6B65D.kfx" "$BASE/philosophy/AI/"
mv "$BASE/Rationality_ From AI to Zombies by Eliezer Yudkowsky_7378E7E892BE4E9BA8323DF226B6B65D.sdr" "$BASE/philosophy/AI/" 2>/dev/null || true
mv "$BASE/Superintelligence_ Paths, Dangers_B19A68DD97B2479CA1C0499844A7AB6A.azw3" "$BASE/philosophy/AI/"
mv "$BASE/Superintelligence_ Paths, Dangers_B19A68DD97B2479CA1C0499844A7AB6A.sdr" "$BASE/philosophy/AI/" 2>/dev/null || true

# --> psychology/psychotherapy/
echo "  Moving to psychology/psychotherapy/..."
mv "$BASE/A_Very_Brief_Introduction_to_Lacan_5246697D0C184A79B4C6465F49CD0AAA.azw3" "$BASE/psychology/psychotherapy/"
mv "$BASE/A_Very_Brief_Introduction_to_Lacan_5246697D0C184A79B4C6465F49CD0AAA.sdr" "$BASE/psychology/psychotherapy/"

# --> psychology/cognitive-psychology/
echo "  Moving to psychology/cognitive-psychology/..."
mv "$BASE/Dont Believe Everything You Think Why Your Thinking-cdeKey_AA8F360A5B124113AF7874206B81DFC1.pdf" "$BASE/psychology/cognitive-psychology/"
mv "$BASE/Dont Believe Everything You Think Why Your Thinking-cdeKey_AA8F360A5B124113AF7874206B81DFC1.sdr" "$BASE/psychology/cognitive-psychology/"

# --> jewish/
echo "  Moving to jewish/..."
mv "$BASE/Arye_Edrei_and_Amir_Mashiach_The_Four_Cu.pdf-cdeKey_2B3FAA7909E847A2BE18C4E6FCC63E8C.pdf" "$BASE/jewish/"
mv "$BASE/Arye_Edrei_and_Amir_Mashiach_The_Four_Cu.pdf-cdeKey_2B3FAA7909E847A2BE18C4E6FCC63E8C.sdr" "$BASE/jewish/" 2>/dev/null || true
mv "$BASE/Bodies of God and the World of Ancient Israel, The - Benjamin D. Sommer_D431F9D74DD04F519D0F4853D0434007.azw3" "$BASE/jewish/"
mv "$BASE/Bodies of God and the World of Ancient Israel, The - Benjamin D. Sommer_D431F9D74DD04F519D0F4853D0434007.sdr" "$BASE/jewish/"

# --> religion/
echo "  Moving to religion/..."
mv "$BASE/Waking Up_ A Guide to Spirituality Without Religion - Sam Harris_0E3C424EC1C0439782B6F2DE1586DD41.azw3" "$BASE/religion/"
mv "$BASE/Waking Up_ A Guide to Spirituality Without Religion - Sam Harris_0E3C424EC1C0439782B6F2DE1586DD41.sdr" "$BASE/religion/" 2>/dev/null || true
mv "$BASE/the end of faith - sam harris_7326D2371FB04ED086AA846080FEBF35.azw3" "$BASE/religion/"
mv "$BASE/the end of faith - sam harris_7326D2371FB04ED086AA846080FEBF35.sdr" "$BASE/religion/"

# --> health/Body-and-Longevity/
echo "  Moving to health/Body-and-Longevity/..."
mv "$BASE/Reflexology_Foot_Chart1_5D2A8FF5F4A64B61A187F8702C12B876.kfx" "$BASE/health/Body-and-Longevity/"
mv "$BASE/Reflexology_Foot_Chart1_5D2A8FF5F4A64B61A187F8702C12B876.sdr" "$BASE/health/Body-and-Longevity/" 2>/dev/null || true
mv "$BASE/Thai Massage Manual.pdf-cdeKey_D9127C15DB3B4A83A0560567250A30F7.pdf" "$BASE/health/Body-and-Longevity/"
mv "$BASE/Thai Massage Manual.pdf-cdeKey_D9127C15DB3B4A83A0560567250A30F7.sdr" "$BASE/health/Body-and-Longevity/" 2>/dev/null || true

# --> health/Mindfulness-and-Mental-Health/
echo "  Moving to health/Mindfulness-and-Mental-Health/..."
mv "$BASE/Biohack_Your_Brain_How_to_Boost_Cognitive_Health_D6A4B9359AFF45649FD7D24914936A5B.kfx" "$BASE/health/Mindfulness-and-Mental-Health/"
mv "$BASE/Biohack_Your_Brain_How_to_Boost_Cognitive_Health_D6A4B9359AFF45649FD7D24914936A5B.sdr" "$BASE/health/Mindfulness-and-Mental-Health/"
mv "$BASE/Burnout_ The Secret to Unlocking the Stress Cycle by Emily Nagoski, Amelia Nagoski_7ADA92E0D20B45D0A69F9050FB51838B.azw3" "$BASE/health/Mindfulness-and-Mental-Health/"
mv "$BASE/Burnout_ The Secret to Unlocking the Stress Cycle by Emily Nagoski, Amelia Nagoski_7ADA92E0D20B45D0A69F9050FB51838B.sdr" "$BASE/health/Mindfulness-and-Mental-Health/"

# --> history/
echo "  Moving to history/..."
mv "$BASE/Sapiens_099BEB0023BA4C2288E294E7387B5C0C.azw3" "$BASE/history/"
mv "$BASE/Sapiens_099BEB0023BA4C2288E294E7387B5C0C.sdr" "$BASE/history/" 2>/dev/null || true
mv "$BASE/On the Origin of Species.pdf-cdeKey_D7EA4993FB1F49DA802291D5B5C3A5F6.pdf" "$BASE/history/"
mv "$BASE/On the Origin of Species.pdf-cdeKey_D7EA4993FB1F49DA802291D5B5C3A5F6.sdr" "$BASE/history/" 2>/dev/null || true

# --> computers/Programming/
echo "  Moving to computers/Programming/..."
mv "$BASE/Designing Data-Intensive Applications_ The Big Ideas Behind Reliable, Scalable, and Maintainable Systems_FFD658B23F6C45508F6518AE54AC8FEC.kfx" "$BASE/computers/Programming/"
mv "$BASE/Designing Data-Intensive Applications_ The Big Ideas Behind Reliable, Scalable, and Maintainable Systems_FFD658B23F6C45508F6518AE54AC8FEC.sdr" "$BASE/computers/Programming/"
mv "$BASE/Shvets A. Dive Into Design Patterns 2019_954F4E1719CE4844B2F1B07875654723.azw3" "$BASE/computers/Programming/"
mv "$BASE/Shvets A. Dive Into Design Patterns 2019_954F4E1719CE4844B2F1B07875654723.sdr" "$BASE/computers/Programming/" 2>/dev/null || true
mv "$BASE/Think_Complexity_by_Allen_Downey_C77ACC81C499475C8D72C6D9A884440D.azw3" "$BASE/computers/Programming/"
mv "$BASE/Think_Complexity_by_Allen_Downey_C77ACC81C499475C8D72C6D9A884440D.sdr" "$BASE/computers/Programming/" 2>/dev/null || true
mv "$BASE/pve-admin-guide_7D2C32700A9A4C9A9E1C7CB8DCF1BCB6.azw3" "$BASE/computers/Programming/"
mv "$BASE/pve-admin-guide_7D2C32700A9A4C9A9E1C7CB8DCF1BCB6.sdr" "$BASE/computers/Programming/"

# --> computers/Data-Science/
echo "  Moving to computers/Data-Science/..."
mv "$BASE/Scalable Analytics Architecture With Airflow and dbt - Astronomer_52D1B1F32F5744C78BD68E06D414BBD1.azw3" "$BASE/computers/Data-Science/"
mv "$BASE/Scalable Analytics Architecture With Airflow and dbt - Astronomer_52D1B1F32F5744C78BD68E06D414BBD1.sdr" "$BASE/computers/Data-Science/" 2>/dev/null || true

# --> computers/Machine-Learning/
echo "  Moving to computers/Machine-Learning/..."
mv "$BASE/Sahu N. Mathematics for Machine Learning. A Deep Dive into Algorithm 2023-cdeKey_2A42C64AA4654E428E534F10477F9812.pdf" "$BASE/computers/Machine-Learning/"
mv "$BASE/Sahu N. Mathematics for Machine Learning. A Deep Dive into Algorithm 2023-cdeKey_2A42C64AA4654E428E534F10477F9812.sdr" "$BASE/computers/Machine-Learning/" 2>/dev/null || true

# --> sex/
echo "  Moving to sex/..."
mv "$BASE/The Joys (and Challenges) of Sex After 70_7E69F3BF95B54630BDF3C40394851952.azw3" "$BASE/sex/"
mv "$BASE/The Joys (and Challenges) of Sex After 70_7E69F3BF95B54630BDF3C40394851952.sdr" "$BASE/sex/" 2>/dev/null || true

# --> fiction/ (root)
echo "  Moving to fiction/ root..."
mv "$BASE/The Love Hypothesis by Ali Hazelwood_B83233DA70B64E5A8E7511E896669FDD.azw3" "$BASE/fiction/"
mv "$BASE/The Love Hypothesis by Ali Hazelwood_B83233DA70B64E5A8E7511E896669FDD.sdr" "$BASE/fiction/" 2>/dev/null || true
mv "$BASE/The Raven_B00DX0F4FK.kfx" "$BASE/fiction/"
mv "$BASE/The Raven_B00DX0F4FK.sdr" "$BASE/fiction/" 2>/dev/null || true
mv "$BASE/Davies_Love_in_the_Afternoon_1A3D7D0521DC416E9F3589D825F95316.azw3" "$BASE/fiction/"
mv "$BASE/Davies_Love_in_the_Afternoon_1A3D7D0521DC416E9F3589D825F95316.sdr" "$BASE/fiction/"

echo "=== Step 4: Fix misplaced books in existing folders ==="

# fiction/ root Jeffrey Archer --> fiction/Jeffrey Archer/
echo "  Consolidating Jeffrey Archer..."
mv "$BASE/fiction/A Matter of Honour - Jeffrey Archer_1D2A75F16C804B178DEA7BFC5E7A855A.azw3" "$BASE/fiction/Jeffrey Archer/"
mv "$BASE/fiction/A Matter of Honour - Jeffrey Archer_1D2A75F16C804B178DEA7BFC5E7A855A.sdr" "$BASE/fiction/Jeffrey Archer/"
mv "$BASE/fiction/A Prisoner of Birth - Jeffrey Archer_309399A9E1934BF891F6609BC61F9007.azw3" "$BASE/fiction/Jeffrey Archer/"
mv "$BASE/fiction/A Prisoner of Birth - Jeffrey Archer_309399A9E1934BF891F6609BC61F9007.sdr" "$BASE/fiction/Jeffrey Archer/"
mv "$BASE/fiction/A Quiver Full of Arrows - Jeffrey Archer_6859697F6DB349A8B51721DC27117BE2.azw3" "$BASE/fiction/Jeffrey Archer/"
mv "$BASE/fiction/A Quiver Full of Arrows - Jeffrey Archer_6859697F6DB349A8B51721DC27117BE2.sdr" "$BASE/fiction/Jeffrey Archer/"
mv "$BASE/fiction/A Twist in the Tale - Jeffrey Archer_724D90FC741D4678855AB00E472FBAA3.azw3" "$BASE/fiction/Jeffrey Archer/"
mv "$BASE/fiction/A Twist in the Tale - Jeffrey Archer_724D90FC741D4678855AB00E472FBAA3.sdr" "$BASE/fiction/Jeffrey Archer/"
mv "$BASE/fiction/Honour Among Thieves - Jeffrey Archer_94B21D57BDED465CB8D00A27540F3A5A.azw3" "$BASE/fiction/Jeffrey Archer/"
mv "$BASE/fiction/Honour Among Thieves - Jeffrey Archer_94B21D57BDED465CB8D00A27540F3A5A.sdr" "$BASE/fiction/Jeffrey Archer/"
mv "$BASE/fiction/Over My Dead Body by Jeffrey Archer_7A0FABE4EB584DD0A4497E4D21CA7356.azw3" "$BASE/fiction/Jeffrey Archer/"
mv "$BASE/fiction/Over My Dead Body by Jeffrey Archer_7A0FABE4EB584DD0A4497E4D21CA7356.sdr" "$BASE/fiction/Jeffrey Archer/"
mv "$BASE/fiction/Shall We Tell the President_ - Jeffrey Archer_F8ABB700E73F4910BA5A35B0796F0A30.azw3" "$BASE/fiction/Jeffrey Archer/"
mv "$BASE/fiction/Shall We Tell the President_ - Jeffrey Archer_F8ABB700E73F4910BA5A35B0796F0A30.sdr" "$BASE/fiction/Jeffrey Archer/"

# fiction/ root Michael Crichton --> fiction/Michael Crichton/
echo "  Consolidating Michael Crichton..."
mv "$BASE/fiction/Next_ roman - Michael Crichton_5739F2D4E8484EE5894B253D35039D6A.azw3" "$BASE/fiction/Michael Crichton/"
mv "$BASE/fiction/Next_ roman - Michael Crichton_5739F2D4E8484EE5894B253D35039D6A.sdr" "$BASE/fiction/Michael Crichton/"
mv "$BASE/fiction/Odds On_ A Novel - Michael Crichton & John Lange_1652A4B7FE454E4E97D645F859710638.azw3" "$BASE/fiction/Michael Crichton/"
mv "$BASE/fiction/Odds On_ A Novel - Michael Crichton & John Lange_1652A4B7FE454E4E97D645F859710638.sdr" "$BASE/fiction/Michael Crichton/"
mv "$BASE/fiction/Scratch One - Michael Crichton_AABABD0CC4EE4CECAEA6B3B51837C593.azw3" "$BASE/fiction/Michael Crichton/"
mv "$BASE/fiction/Scratch One - Michael Crichton_AABABD0CC4EE4CECAEA6B3B51837C593.sdr" "$BASE/fiction/Michael Crichton/"
mv "$BASE/fiction/Westworld - Yul Brynner & James Brolin & Michael Crichton_5129AF5E5FB34A2EB61F0294F0576A0D.azw3" "$BASE/fiction/Michael Crichton/"
mv "$BASE/fiction/Westworld - Yul Brynner & James Brolin & Michael Crichton_5129AF5E5FB34A2EB61F0294F0576A0D.sdr" "$BASE/fiction/Michael Crichton/"

# The Cuckoo's Calling --> fiction/J.K. Rowling/
echo "  Moving Cuckoo's Calling to J.K. Rowling..."
mv "$BASE/fiction/The Cuckoo's Calling_37D0757BB079450CAFF47FD634EBB0F2.kfx" "$BASE/fiction/J.K. Rowling/"
mv "$BASE/fiction/The Cuckoo's Calling_37D0757BB079450CAFF47FD634EBB0F2.sdr" "$BASE/fiction/J.K. Rowling/"

# HP books --> fiction/J.K. Rowling/
echo "  Moving Harry Potter books to J.K. Rowling..."
mv "$BASE/fiction/HP-goblet-of-fire_9AA3C6BD313042229F340EB60776AC6B.azw3" "$BASE/fiction/J.K. Rowling/"
mv "$BASE/fiction/HP-half-blood-prince_DCECF42F9D31420082CDFDFB4941DB8B.azw3" "$BASE/fiction/J.K. Rowling/"
mv "$BASE/fiction/HP-half-blood-prince_DCECF42F9D31420082CDFDFB4941DB8B.sdr" "$BASE/fiction/J.K. Rowling/"
mv "$BASE/fiction/Harry-Potter-Cursed-Child_35088BBE78EF461B9DC81F4353A46DFB.azw3" "$BASE/fiction/J.K. Rowling/"
mv "$BASE/fiction/Harry-Potter-Cursed-Child_35088BBE78EF461B9DC81F4353A46DFB.sdr" "$BASE/fiction/J.K. Rowling/"

# Maybe You Should Talk to Someone --> psychology/psychotherapy/
echo "  Moving 'Maybe You Should Talk to Someone' to psychology..."
mv "$BASE/fiction/Maybe You Should Talk to Someone_ A Therapistapist, and Our Lives Revealed - Lori Gottlieb_EF5F240A200A4B1FB7D4A8930D2EE3A7.azw3" "$BASE/psychology/psychotherapy/"
mv "$BASE/fiction/Maybe You Should Talk to Someone_ A Therapistapist, and Our Lives Revealed - Lori Gottlieb_EF5F240A200A4B1FB7D4A8930D2EE3A7.sdr" "$BASE/psychology/psychotherapy/"

# The Innocent Man - Grisham --> fiction/John Grisham/
echo "  Moving Grisham to fiction/John Grisham/..."
mv "$BASE/fiction/The Innocent Man - Grisham, John_C84C5059BC054BF4A85875B9B47B2FEA.azw3" "$BASE/fiction/John Grisham/"
mv "$BASE/fiction/The Innocent Man - Grisham, John_C84C5059BC054BF4A85875B9B47B2FEA.sdr" "$BASE/fiction/John Grisham/"

# HP-goblet-of-fire.sdr has nested books inside it - extract them
echo "  Extracting nested books from HP-goblet-of-fire.sdr..."
# Fantastic Beasts PDF
if [ -f "$BASE/fiction/HP-goblet-of-fire_9AA3C6BD313042229F340EB60776AC6B.sdr/J.K. Rowling - Fantastic Beasts &amp; Where to Find Them.pdf-cdeKey_9D7CD750916A4BD2944A57F3FE2F3294.pdf" ]; then
  mv "$BASE/fiction/HP-goblet-of-fire_9AA3C6BD313042229F340EB60776AC6B.sdr/J.K. Rowling - Fantastic Beasts &amp; Where to Find Them.pdf-cdeKey_9D7CD750916A4BD2944A57F3FE2F3294.pdf" "$BASE/fiction/J.K. Rowling/" 2>/dev/null || true
  mv "$BASE/fiction/HP-goblet-of-fire_9AA3C6BD313042229F340EB60776AC6B.sdr/J.K. Rowling - Fantastic Beasts &amp; Where to Find Them.pdf-cdeKey_9D7CD750916A4BD2944A57F3FE2F3294.sdr" "$BASE/fiction/J.K. Rowling/" 2>/dev/null || true
fi
# Innocent Man (Grisham) nested inside HP .sdr
if [ -f "$BASE/fiction/HP-goblet-of-fire_9AA3C6BD313042229F340EB60776AC6B.sdr/Innocent Man, The - John Grisham_DC3DD43D610A407F9ED83589AE90961A.azw3" ]; then
  mv "$BASE/fiction/HP-goblet-of-fire_9AA3C6BD313042229F340EB60776AC6B.sdr/Innocent Man, The - John Grisham_DC3DD43D610A407F9ED83589AE90961A.azw3" "$BASE/fiction/John Grisham/" 2>/dev/null || true
  mv "$BASE/fiction/HP-goblet-of-fire_9AA3C6BD313042229F340EB60776AC6B.sdr/Innocent Man, The - John Grisham_DC3DD43D610A407F9ED83589AE90961A.sdr" "$BASE/fiction/John Grisham/" 2>/dev/null || true
fi
# Internal Organs Chi Massage nested inside HP .sdr
if [ -f "$BASE/fiction/HP-goblet-of-fire_9AA3C6BD313042229F340EB60776AC6B.sdr/Internal Organs Chi Massage.pdf-cdeKey_D274B86DA4A945679AD8646AB8774456.pdf" ]; then
  mv "$BASE/fiction/HP-goblet-of-fire_9AA3C6BD313042229F340EB60776AC6B.sdr/Internal Organs Chi Massage.pdf-cdeKey_D274B86DA4A945679AD8646AB8774456.pdf" "$BASE/health/Body-and-Longevity/" 2>/dev/null || true
  mv "$BASE/fiction/HP-goblet-of-fire_9AA3C6BD313042229F340EB60776AC6B.sdr/Internal Organs Chi Massage.pdf-cdeKey_D274B86DA4A945679AD8646AB8774456.sdr" "$BASE/health/Body-and-Longevity/" 2>/dev/null || true
fi
# Now move the HP goblet .sdr itself
mv "$BASE/fiction/HP-goblet-of-fire_9AA3C6BD313042229F340EB60776AC6B.sdr" "$BASE/fiction/J.K. Rowling/" 2>/dev/null || true

# From philosophy/ --> correct folders
echo "  Fixing philosophy/ misplacements..."
mv "$BASE/philosophy/Oxford Hachette French - English Dictionary (French Edition)_B00NM4BNTS.azw" "$BASE/reference/"
mv "$BASE/philosophy/Oxford Hachette French - English Dictionary (French Edition)_B00NM4BNTS.sdr" "$BASE/reference/"
mv "$BASE/philosophy/Originals_ How Non-Conformists Move the World ( PDFDrive ).pdf-cdeKey_548FA5A69BDA4697A3C901456920EBFF.pdf" "$BASE/how to/Business/"
mv "$BASE/philosophy/Originals_ How Non-Conformists Move the World ( PDFDrive ).pdf-cdeKey_548FA5A69BDA4697A3C901456920EBFF.sdr" "$BASE/how to/Business/"

# From Non-Fiction/ --> correct folders
echo "  Fixing Non-Fiction/ misplacements..."
mv "$BASE/Non-Fiction/The Conscious Mind.pdf-cdeKey_1091B7779AA4445D94C687F10C8DFA66.pdf" "$BASE/philosophy/Consciousness/"
mv "$BASE/Non-Fiction/The Conscious Mind.pdf-cdeKey_1091B7779AA4445D94C687F10C8DFA66.sdr" "$BASE/philosophy/Consciousness/" 2>/dev/null || true
mv "$BASE/Non-Fiction/Why We Sleep_ Unlocking the Power of Sleep and Dreams - Matthew Walker_D0D26663CF304B51B35364D1EB572350.azw3" "$BASE/health/Mindfulness-and-Mental-Health/"
mv "$BASE/Non-Fiction/Why We Sleep_ Unlocking the Power of Sleep and Dreams - Matthew Walker_D0D26663CF304B51B35364D1EB572350.sdr" "$BASE/health/Mindfulness-and-Mental-Health/"
mv "$BASE/Non-Fiction/Why We Remember_ The Science of Memory and How It Shapes Us by Charan Ranganath_34F971145D1B43A4A8944319B772B593.kfx" "$BASE/psychology/cognitive-psychology/"
mv "$BASE/Non-Fiction/Why We Remember_ The Science of Memory and How It Shapes Us by Charan Ranganath_34F971145D1B43A4A8944319B772B593.sdr" "$BASE/psychology/cognitive-psychology/"
mv "$BASE/Non-Fiction/islam and the future of tolerance - sam harris and maajid nawaz_4200CE9C3FA0422EB8BA3C8F1688306C.azw3" "$BASE/religion/"
mv "$BASE/Non-Fiction/islam and the future of tolerance - sam harris and maajid nawaz_4200CE9C3FA0422EB8BA3C8F1688306C.sdr" "$BASE/religion/"

echo "=== Step 5: Remove duplicates ==="

# 12 Rules for Life - keep the _06DD (already moved), remove other 2 root copies
echo "  Removing duplicate 12 Rules for Life copies..."
rm -rf "$BASE/12 Rules for Life_ An Antidote to Chaos - Jordan B. Peterson_EE3F22443F104B70B41717ED2294BB83.azw3"
rm -rf "$BASE/12 Rules for Life_ An Antidote to Chaos - Jordan B. Peterson_EE3F22443F104B70B41717ED2294BB83.sdr"
rm -rf "$BASE/12 Rules for Life_ An Antidote to Chaos by Jordan Peterson_B4184BF828DE46749DB75D27CBCFBBF8.azw3"
rm -rf "$BASE/12 Rules for Life_ An Antidote to Chaos by Jordan Peterson_B4184BF828DE46749DB75D27CBCFBBF8.sdr"

# Binary - keep _C078 (already moved), remove _E1CF
echo "  Removing duplicate Binary..."
rm -rf "$BASE/Binary_ A Novel - Michael Crichton & John Lange_E1CF41BE9A554AD99C54D969A652C890.azw3"
rm -rf "$BASE/Binary_ A Novel - Michael Crichton & John Lange_E1CF41BE9A554AD99C54D969A652C890.sdr"

# Drug of Choice - keep _25ED (already moved), remove _C97C
echo "  Removing duplicate Drug of Choice..."
rm -rf "$BASE/Drug of Choice - Michael Crichton_C97CD31F0F7D45BABD07851FE0D863D9.azw3"
rm -rf "$BASE/Drug of Choice - Michael Crichton_C97CD31F0F7D45BABD07851FE0D863D9.sdr"

# Good to Great - keep _0299 (already moved), remove _FAC9
echo "  Removing duplicate Good to Great..."
rm -rf "$BASE/Good to Great_ Why Some Companies Make the Leap...and Others Don't by Jim Collins_FAC9B3C070A54D0698563D5A6EC1F413.azw3"
rm -rf "$BASE/Good to Great_ Why Some Companies Make the Leap...and Others Don't by Jim Collins_FAC9B3C070A54D0698563D5A6EC1F413.sdr"

# Moonwalking With Einstein - keep _49C6 (already moved), remove _6D57
echo "  Removing duplicate Moonwalking With Einstein..."
rm -rf "$BASE/Moonwalking With Einstein (Joshua Foer)_6D5762708F9648749ABB2F2508C20664.azw3"
rm -rf "$BASE/Moonwalking With Einstein (Joshua Foer)_6D5762708F9648749ABB2F2508C20664.sdr"

# Scratch One - keep _AABA (already moved to fiction/Michael Crichton), remove _AEDE
echo "  Removing duplicate Scratch One..."
rm -rf "$BASE/fiction/Scratch One - Michael Crichton_AEDE60921DD540EA8250B80A33B86128.azw3"
rm -rf "$BASE/fiction/Scratch One - Michael Crichton_AEDE60921DD540EA8250B80A33B86128.sdr"

# The-Bodies-of-God (2nd copy at root) - remove it
echo "  Removing duplicate Bodies of God..."
rm -rf "$BASE/The-Bodies-of-God-the-World-of-Ancient-Israel-1_7E504371CD5840F4A505E27730C299AC.azw3"
rm -rf "$BASE/The-Bodies-of-God-the-World-of-Ancient-Israel-1_7E504371CD5840F4A505E27730C299AC.sdr"

# How to Know a Person - root copy is duplicate of how to/Psychology-and-Wellness copy
echo "  Removing duplicate How to Know a Person..."
rm -rf "$BASE/How_to_Know_a_Person_The_Art_of_Seeing_Others_Deeply_3BE74707D47E4233A6C837D50A97483B.kfx"
rm -rf "$BASE/How_to_Know_a_Person_The_Art_of_Seeing_Others_Deeply_3BE74707D47E4233A6C837D50A97483B.sdr"

echo "=== Step 6: Clean up untitled folder ==="
rmdir "$BASE/untitled folder" 2>/dev/null || true

echo ""
echo "=== DONE! Reorganization complete. ==="
echo ""
echo "Final top-level structure:"
ls -1 "$BASE" | grep -v '\.sdr$' | grep -v '^\.'
