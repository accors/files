#!usr/bin/env bash
##版本: v20210208
sed -i 's,http://jd.turinglabs.net,http://jdhz.eachell.com,g' ${JD_DIR}/scripts/jd_dreamFactory.js
sed -i 's,https://gitee.com/lxk0301/updateTeam/raw/master/jd_updateFactoryTuanId.json,http://jdhz.eachell.com/api/v1${JD_DIR}/tuanid/read/5,g' ${JD_DIR}/scripts/jd_dreamFactory.js
sed -i 's,https://gitee.com/shylocks/updateTeam/raw/main/jd_updateFactoryTuanId.json,http://jdhz.eachell.com/api/v1${JD_DIR}/tuanid/read/5,g' ${JD_DIR}/scripts/jd_dreamFactory.js
sed -i 's,https://raw.githubusercontent.com/LXK9301/updateTeam/master/jd_updateFactoryTuanId.json,http://jdhz.eachell.com/api/v1${JD_DIR}/tuanid/read/5,g' ${JD_DIR}/scripts/jd_dreamFactory.js
sed -i '/$.newShareCodes = inviteCodes.*;/a\\$.newShareCodes = [];' ${JD_DIR}/scripts/jd_dreamFactory.js
sed -i '/if (process.env.DREAM_FACTORY_SHARE_CODES) {/i\\shareCodes = [];' ${JD_DIR}/scripts/jdDreamFactoryShareCodes.js
sed -i 's,http://jd.turinglabs.net,http://jdhz.eachell.com,g' ${JD_DIR}/scripts/jd_fruit.js
sed -i '/newShareCodes = shareCodes.*;/a\\newShareCodes = [];' ${JD_DIR}/scripts/jd_fruit.js
sed -i '/if (process.env.FRUITSHARECODES) {/i\\FruitShareCodes = [];' ${JD_DIR}/scripts/jdFruitShareCodes.js
sed -i 's,http://jd.turinglabs.net,http://jdhz.eachell.com,g' ${JD_DIR}/scripts/jd_jdfactory.js
sed -i 's,http://jd.turinglabs.net,http://jdhz.eachell.com,g' ${JD_DIR}/scripts/jd_pet.js
sed -i 's,http://jd.turinglabs.net,http://jdhz.eachell.com,g' ${JD_DIR}/scripts/jd_plantBean.js
sed -i 's,https://code.chiang.fun,http://jdhz.eachell.com,g' ${JD_DIR}/scripts/jd_jdzz.js
#sed -i 's,https://code.chiang.fun,http://jdhz.eachell.com,g' ${JD_DIR}/scripts/jd_nian.js
#sed -i 's,http://jd.turinglabs.net,http://jdhz.eachell.com,g' ${JD_DIR}/scripts/jd_nian.js
sed -i 's,http://jd.turinglabs.net,http://jdhz.eachell.com,g' ${JD_DIR}/scripts/jd_sgmh.js
#sed -i 's,http://jd.turinglabs.net,http://jdhz.eachell.com,g' ${JD_DIR}/scripts/jd_immortal.js
sed -i 's,https://code.chiang.fun,http://jdhz.eachell.com,g' ${JD_DIR}/scripts/jd_cash.js
sed -i 's,https://code.chiang.fun,http://jdhz.eachell.com,g' ${JD_DIR}/scripts/jd_newYearMoney.js
sed -i '/const readShareCodeRes = await readShareCode();/i\\$.newShareCodes = [];' ${JD_DIR}/scripts/jd_newYearMoney.js
